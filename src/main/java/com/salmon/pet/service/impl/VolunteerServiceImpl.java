package com.salmon.pet.service.impl;

import com.salmon.pet.entity.User;
import com.salmon.pet.entity.Volunteer;
import com.salmon.pet.mapper.UserMapper;
import com.salmon.pet.mapper.VolunteerMapper;
import com.salmon.pet.service.VolunteerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class VolunteerServiceImpl implements VolunteerService {

    @Autowired
    private VolunteerMapper volunteerMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public String apply(Volunteer volunteer) {
        if (volunteer.getUserId() == null) {
            return "请先登录";
        }
        if (volunteer.getRealName() == null || volunteer.getRealName().trim().isEmpty()) {
            return "请填写真实姓名";
        }
        if (volunteer.getIdCard() == null || volunteer.getIdCard().trim().isEmpty()) {
            return "请填写身份证号";
        }
        // 是否已有申请记录
        Volunteer exist = volunteerMapper.selectByUserId(volunteer.getUserId());
        if (exist != null && exist.getAuditStatus() == 1) {
            return "您已提交申请，请等待审核";
        }
        // 已是认证志愿者
        if (exist != null && exist.getAuditStatus() == 2) {
            return "您已通过认证，无需重复申请";
        }
        if (volunteer.getCertType() == null) {
            volunteer.setCertType(1);
        }
        volunteerMapper.insert(volunteer);
        return null;
    }

    @Override
    public Volunteer getByUserId(Integer userId) {
        return volunteerMapper.selectByUserId(userId);
    }

    @Override
    public List<Volunteer> listForAdmin(Integer status, String keyword) {
        return volunteerMapper.selectList(status, keyword);
    }

    @Override
    @Transactional
    public boolean audit(Integer volunteerId, Integer auditStatus, String auditOpinion, Integer adminId) {
        int rows = volunteerMapper.audit(volunteerId, auditStatus, auditOpinion, adminId);
        if (rows <= 0) return false;
        // 审核通过：将用户角色升级为志愿者(2)
        if (auditStatus != null && auditStatus == 2) {
            Volunteer v = volunteerMapper.selectById(volunteerId);
            if (v != null) {
                User u = userMapper.selectById(v.getUserId());
                if (u != null && (u.getRole() == null || u.getRole() < 2)) {
                    userMapper.updateAdmin(u.getUserId(), 2, u.getStatus(), u.getAdoptStatus(), u.getCreditScore());
                }
            }
        }
        return true;
    }

    @Override
    public boolean updateScore(Integer volunteerId, Integer workHours, Integer points, Integer level) {
        return volunteerMapper.updateScore(volunteerId, workHours, points, level) > 0;
    }

    @Override
    public int countByStatus(Integer status) {
        return volunteerMapper.countByStatus(status);
    }
}
