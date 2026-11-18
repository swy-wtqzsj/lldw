package com.salmon.pet.service;

import com.salmon.pet.entity.TeamCert;
import com.salmon.pet.entity.VolunteerCert;

import java.util.List;

/**
 * 证书认证管理 Service 接口
 */
public interface CertService {

    /** 查询团队认证列表 */
    List<TeamCert> getTeamList(Integer status);

    /** 查询志愿者认证列表 */
    List<VolunteerCert> getVolunteerList(Integer status);

    /** 查询用户自己的志愿者认证 */
    VolunteerCert getVolunteerByUser(Integer userId);

    /** 查询负责人最近一次团队认证 */
    TeamCert getTeamByLeader(Integer leaderId);

    /** 用户提交志愿者认证申请，返回错误信息；成功返回 null */
    String applyVolunteer(VolunteerCert cert, Integer userId);

    /** 用户提交团队认证申请，返回错误信息；成功返回 null */
    String applyTeam(TeamCert cert, Integer leaderId);

    /** 审核团队认证 */
    boolean auditTeam(Integer teamId, Integer status, Integer auditAdmin);

    /** 审核志愿者认证 */
    boolean auditVolunteer(Integer certId, Integer status, Integer auditAdmin, String auditOpinion);
}
