package com.salmon.pet.service.impl;

import com.salmon.pet.entity.VolunteerSign;
import com.salmon.pet.mapper.ActivityMapper;
import com.salmon.pet.mapper.VolunteerSignMapper;
import com.salmon.pet.service.VolunteerSignService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Map;

/**
 * 志愿签到 / 工时统计 Service 实现（C 组）
 */
@Service
public class VolunteerSignServiceImpl implements VolunteerSignService {

    @Autowired
    private VolunteerSignMapper volunteerSignMapper;

    @Autowired
    private ActivityMapper activityMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String signIn(Integer userId, Integer activityId, Integer serviceType, String content) {
        if (userId == null) {
            return "请先登录后再签到";
        }
        if (serviceType == null || serviceType < 1 || serviceType > 4) {
            serviceType = 4;
        }
        if (content != null && content.trim().length() > 255) {
            content = content.trim().substring(0, 255);
        }
        // 关联活动必须真实存在，防止写入任意/不存在的活动 ID
        if (activityId != null && activityMapper.selectById(activityId) == null) {
            return "所选活动不存在，请刷新页面后重新选择";
        }
        // 同一用户不允许同时存在多条未签退记录
        if (volunteerSignMapper.countOpenSign(userId) > 0) {
            return "您还有未签退的签到记录，请先完成签退";
        }
        VolunteerSign sign = new VolunteerSign();
        sign.setUserId(userId);
        sign.setActivityId(activityId);
        sign.setServiceType(serviceType);
        sign.setContent(content);
        try {
            return volunteerSignMapper.insert(sign) > 0 ? null : "签到失败，请稍后重试";
        } catch (DuplicateKeyException e) {
            // 并发场景由 uk_user_open 唯一索引兜底（user_id + 未签退标记）
            return "您还有未签退的签到记录，请先完成签退";
        } catch (Exception e) {
            return "签到失败，请稍后重试";
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String signOut(Integer signId, Integer userId) {
        if (signId == null) {
            return "签到记录不存在";
        }
        VolunteerSign sign = volunteerSignMapper.selectById(signId);
        if (sign == null) {
            return "签到记录不存在";
        }
        if (!sign.getUserId().equals(userId)) {
            return "只能签退本人的签到记录";
        }
        if (sign.getStatus() == null || sign.getStatus() != 1) {
            return "该记录已签退，请勿重复操作";
        }
        if (sign.getSignInTime() == null) {
            return "签到时间异常，无法结算工时";
        }

        long millis = System.currentTimeMillis() - sign.getSignInTime().getTime();
        BigDecimal hours = BigDecimal.valueOf(millis)
                .divide(BigDecimal.valueOf(3600000L), 1, RoundingMode.HALF_UP);
        if (hours.compareTo(new BigDecimal("0.1")) < 0) {
            hours = new BigDecimal("0.1");
        }
        if (hours.compareTo(new BigDecimal("24")) > 0) {
            hours = new BigDecimal("24");
        }
        return volunteerSignMapper.signOut(signId, hours) > 0 ? null : "签退失败，请刷新后重试";
    }

    @Override
    public List<VolunteerSign> getMyList(Integer userId) {
        return volunteerSignMapper.selectByUser(userId);
    }

    @Override
    public Map<String, Object> getMyStats(Integer userId) {
        return volunteerSignMapper.selectMyStats(userId);
    }

    @Override
    public List<VolunteerSign> getAdminList(Integer userId, Integer status,
                                            Integer auditStatus, String keyword) {
        return volunteerSignMapper.selectAdminList(userId, status, auditStatus, keyword);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String audit(Integer signId, Integer auditStatus, String auditRemark) {
        if (signId == null) {
            return "签到记录不存在";
        }
        // 审核动作只允许「通过(2)/驳回(3)」，1 为初始待审核状态不可直接写回
        if (auditStatus == null || auditStatus < 2 || auditStatus > 3) {
            return "审核状态不合法";
        }
        VolunteerSign sign = volunteerSignMapper.selectById(signId);
        if (sign == null) {
            return "签到记录不存在";
        }
        // 只有已签退的记录才有工时可审，防止对"服务中"记录提前审核绕过流程
        if (sign.getStatus() == null || sign.getStatus() != 2) {
            return "该记录尚未签退，不能审核工时";
        }
        // 只允许审核一次，防止已审记录被反复翻转且无留痕
        if (sign.getAuditStatus() == null || sign.getAuditStatus() != 1) {
            return "该记录已审核，请勿重复操作";
        }
        if (auditRemark != null && auditRemark.length() > 255) {
            auditRemark = auditRemark.substring(0, 255);
        }
        // UPDATE 带 status=2 AND audit_status=1 条件，并发下已被处理则影响行数为 0
        if (volunteerSignMapper.updateAudit(signId, auditStatus, auditRemark) == 0) {
            return "该记录状态已变化，请刷新后重试";
        }
        // 仅审核通过时把累计工时同步回志愿者档案
        if (auditStatus == 2) {
            int synced = volunteerSignMapper.syncVolunteerWorkHours(sign.getUserId());
            if (synced == 0) {
                // 审核本身已成功，但该用户无已通过的志愿者档案，工时无法归档
                return "工时审核已通过，但该用户尚未通过志愿者认证，工时未同步到档案";
            }
        }
        return null;
    }

    @Override
    public List<Map<String, Object>> getWorkHourRank() {
        return volunteerSignMapper.selectWorkHourRank();
    }

    @Override
    public Map<String, Object> getSummary() {
        return volunteerSignMapper.selectSummary();
    }

    @Override
    public int countToday() {
        return volunteerSignMapper.countToday();
    }
}
