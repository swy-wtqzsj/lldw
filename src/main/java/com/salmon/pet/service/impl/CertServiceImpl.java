package com.salmon.pet.service.impl;

import com.salmon.pet.entity.TeamCert;
import com.salmon.pet.entity.VolunteerCert;
import com.salmon.pet.mapper.TeamCertMapper;
import com.salmon.pet.mapper.UserMapper;
import com.salmon.pet.mapper.VolunteerCertMapper;
import com.salmon.pet.service.CertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 证书认证管理 Service 实现类
 */
@Service
public class CertServiceImpl implements CertService {

    @Autowired
    private TeamCertMapper teamCertMapper;

    @Autowired
    private VolunteerCertMapper volunteerCertMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<TeamCert> getTeamList(Integer status) {
        return teamCertMapper.selectList(status);
    }

    @Override
    public List<VolunteerCert> getVolunteerList(Integer status) {
        return volunteerCertMapper.selectList(status);
    }

    @Override
    public VolunteerCert getVolunteerByUser(Integer userId) {
        return volunteerCertMapper.selectByUserId(userId);
    }

    @Override
    public TeamCert getTeamByLeader(Integer leaderId) {
        return teamCertMapper.selectByLeader(leaderId);
    }

    @Override
    public String applyVolunteer(VolunteerCert cert, Integer userId) {
        cert.setUserId(userId);
        VolunteerCert existing = volunteerCertMapper.selectByUserId(userId);
        if (existing == null) {
            volunteerCertMapper.insert(cert);
            return null;
        }
        if (existing.getStatus() != null && (existing.getStatus() == 1 || existing.getStatus() == 2)) {
            return "您已提交志愿者认证申请或已通过认证，请勿重复提交";
        }
        // 已驳回或已撤销的申请允许重新提交
        volunteerCertMapper.updateApply(cert);
        return null;
    }

    @Override
    public String applyTeam(TeamCert cert, Integer leaderId) {
        cert.setLeaderId(leaderId);
        TeamCert existing = teamCertMapper.selectByLeader(leaderId);
        if (existing != null && existing.getStatus() != null
                && (existing.getStatus() == 1 || existing.getStatus() == 2)) {
            return "您已有认证中的团队申请，请勿重复提交";
        }
        teamCertMapper.insert(cert);
        return null;
    }

    @Override
    public boolean auditTeam(Integer teamId, Integer status, Integer auditAdmin) {
        if (teamId == null || status == null || status == 1) {
            return false;
        }
        return teamCertMapper.audit(teamId, status, auditAdmin) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean auditVolunteer(Integer certId, Integer status, Integer auditAdmin, String auditOpinion) {
        if (certId == null || status == null || status == 1) {
            return false;
        }
        if (volunteerCertMapper.audit(certId, status, auditAdmin, auditOpinion) == 0) {
            return false;
        }
        // 认证通过后将用户升级为志愿者
        if (status == 2) {
            VolunteerCert cert = volunteerCertMapper.selectById(certId);
            if (cert != null) {
                userMapper.updateRole(cert.getUserId(), 2);
            }
        }
        return true;
    }
}
