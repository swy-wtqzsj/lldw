package com.salmon.pet.service.impl;

import com.salmon.pet.entity.VolunteerSign;
import com.salmon.pet.mapper.VolunteerSignMapper;
import com.salmon.pet.service.VolunteerSignService;
import org.springframework.beans.factory.annotation.Autowired;
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
        // 同一用户不允许同时存在多条未签退记录
        if (volunteerSignMapper.countOpenSign(userId) > 0) {
            return "您还有未签退的签到记录，请先完成签退";
        }
        VolunteerSign sign = new VolunteerSign();
        sign.setUserId(userId);
        sign.setActivityId(activityId);
        sign.setServiceType(serviceType);
        sign.setContent(content);
        return volunteerSignMapper.insert(sign) > 0 ? null : "签到失败，请稍后重试";
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
    public boolean audit(Integer signId, Integer auditStatus, String auditRemark) {
        if (signId == null || auditStatus == null || auditStatus < 1 || auditStatus > 3) {
            return false;
        }
        Integer userId = volunteerSignMapper.selectUserId(signId);
        if (userId == null) {
            return false;
        }
        if (auditRemark != null && auditRemark.length() > 255) {
            auditRemark = auditRemark.substring(0, 255);
        }
        if (volunteerSignMapper.updateAudit(signId, auditStatus, auditRemark) == 0) {
            return false;
        }
        // 审核通过后，累计工时同步回志愿者档案（A 组 volunteer.work_hours）
        volunteerSignMapper.syncVolunteerWorkHours(userId);
        return true;
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
