package com.salmon.pet.service.impl;

import com.salmon.pet.entity.Appeal;
import com.salmon.pet.entity.Punishment;
import com.salmon.pet.mapper.AppealMapper;
import com.salmon.pet.mapper.PunishmentMapper;
import com.salmon.pet.service.AppealService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 处罚申诉 Service 实现类
 */
@Service
public class AppealServiceImpl implements AppealService {

    @Autowired
    private AppealMapper appealMapper;

    @Autowired
    private PunishmentMapper punishmentMapper;

    @Override
    public List<Appeal> getMyList(Integer userId) {
        return appealMapper.selectByUser(userId);
    }

    @Override
    public List<Appeal> getList(Integer status) {
        return appealMapper.selectList(status);
    }

    @Override
    public Appeal getById(Integer appealId) {
        return appealMapper.selectById(appealId);
    }

    @Override
    public String apply(Integer punishId, Integer userId, String content, String evidence) {
        if (punishId == null || userId == null) {
            return "参数不完整";
        }
        if (content == null || content.trim().isEmpty()) {
            return "请填写申诉说明";
        }
        Punishment punishment = punishmentMapper.selectById(punishId);
        if (punishment == null) {
            return "处罚记录不存在";
        }
        if (punishment.getUserId() == null || !punishment.getUserId().equals(userId)) {
            return "只能对自己的处罚发起申诉";
        }
        if (punishment.getStatus() == null || punishment.getStatus() != 1) {
            return "该处罚已不是生效状态，无需申诉";
        }
        if (appealMapper.countPendingByPunish(punishId) > 0) {
            return "该处罚已有待复核的申诉，请耐心等待";
        }

        Appeal appeal = new Appeal();
        appeal.setPunishId(punishId);
        appeal.setUserId(userId);
        appeal.setContent(content.trim());
        appeal.setEvidence(evidence);
        return appealMapper.insert(appeal) > 0 ? null : "申诉提交失败";
    }

    @Override
    @Transactional
    public boolean review(Integer appealId, Integer status, Integer reviewAdmin, String reviewOpinion) {
        if (appealId == null || status == null || status < 2 || status > 4) {
            return false;
        }
        Appeal appeal = appealMapper.selectById(appealId);
        if (appeal == null || appeal.getStatus() == null || appeal.getStatus() != 1) {
            return false;
        }
        if (appealMapper.review(appealId, status, reviewAdmin, reviewOpinion) <= 0) {
            return false;
        }
        if (status == 4) {
            punishmentMapper.lift(appeal.getPunishId());
        }
        return true;
    }
}
