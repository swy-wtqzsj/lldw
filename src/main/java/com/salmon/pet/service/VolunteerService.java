package com.salmon.pet.service;

import com.salmon.pet.entity.Volunteer;

import java.util.List;

/**
 * 志愿者服务 (A组)
 */
public interface VolunteerService {

    /** 提交认证申请，返回错误信息；成功返回 null */
    String apply(Volunteer volunteer);

    /** 查询我的认证记录 */
    Volunteer getByUserId(Integer userId);

    /** 后台审核列表 */
    List<Volunteer> listForAdmin(Integer status, String keyword);

    /** 审核(通过/拒绝) */
    boolean audit(Integer volunteerId, Integer auditStatus, String auditOpinion, Integer adminId);

    /** 更新工时/积分/等级 */
    boolean updateScore(Integer volunteerId, Integer workHours, Integer points, Integer level);

    /** 统计各状态数量 */
    int countByStatus(Integer status);
}
