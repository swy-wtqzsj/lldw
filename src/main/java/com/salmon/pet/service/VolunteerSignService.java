package com.salmon.pet.service;

import com.salmon.pet.entity.VolunteerSign;

import java.util.List;
import java.util.Map;

/**
 * 志愿签到 / 工时统计 Service（C 组）
 */
public interface VolunteerSignService {

    /** 签到，成功返回 null，失败返回提示语 */
    String signIn(Integer userId, Integer activityId, Integer serviceType, String content);

    /** 签退并结算工时，成功返回 null */
    String signOut(Integer signId, Integer userId);

    /** 我的签到记录 */
    List<VolunteerSign> getMyList(Integer userId);

    /** 个人工时汇总 */
    Map<String, Object> getMyStats(Integer userId);

    /** 后台签到记录列表 */
    List<VolunteerSign> getAdminList(Integer userId, Integer status,
                                     Integer auditStatus, String keyword);

    /**
     * 工时审核：auditStatus 2 通过 / 3 驳回。
     * 仅"已签退(status=2)且待审核(audit_status=1)"的记录可审核。
     * @return null 表示成功；非 null 为失败原因或提示信息
     */
    String audit(Integer signId, Integer auditStatus, String auditRemark);

    /** 工时排行 */
    List<Map<String, Object>> getWorkHourRank();

    /** 全局工时汇总 */
    Map<String, Object> getSummary();

    /** 今日签到数 */
    int countToday();
}
