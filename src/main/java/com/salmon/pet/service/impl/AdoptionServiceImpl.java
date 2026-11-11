package com.salmon.pet.service.impl;

import com.salmon.pet.entity.Adoption;
import com.salmon.pet.entity.Pet;
import com.salmon.pet.mapper.AdoptionMapper;
import com.salmon.pet.mapper.PetMapper;
import com.salmon.pet.service.AdoptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 领养申请 Service 实现类
 */
@Service
public class AdoptionServiceImpl implements AdoptionService {

    @Autowired
    private AdoptionMapper adoptionMapper;

    @Autowired
    private PetMapper petMapper;

    @Override
    public String applyAdoption(Adoption adoption) {
        // 1. 检查宠物是否存在且可领养
        Pet pet = petMapper.selectPetById(adoption.getPetId());
        if (pet == null) {
            return "宠物不存在";
        }
        if (pet.getAdoptStatus() != 2) {
            return "该宠物当前不可领养";
        }

        // 2. 检查是否已经申请过
        Adoption exist = adoptionMapper.selectUserPetApply(adoption.getUserId(), adoption.getPetId());
        if (exist != null) {
            return "您已提交过该宠物的领养申请，请等待审核";
        }

        // 3. 保存申请
        adoptionMapper.insertAdoption(adoption);

        // 4. 更新宠物状态为"审核中"
        petMapper.updateStatus(adoption.getPetId(), 3);

        return "success";
    }

    @Override
    public List<Adoption> getMyAdoptionList(Integer userId) {
        return adoptionMapper.selectMyAdoptionList(userId);
    }

    @Override
    public Adoption getAdoptionById(Integer adoptId) {
        return adoptionMapper.selectAdoptionById(adoptId);
    }

    @Override
    public List<Adoption> getAdminAdoptionList(Integer status) {
        return adoptionMapper.selectAdminAdoptionList(status);
    }

    @Override
    @Transactional
    public boolean auditAdoption(Integer adoptId, Integer status, String auditOpinion, Integer adminId) {
        // 1. 更新申请状态
        adoptionMapper.auditAdoption(adoptId, status, auditOpinion, adminId);

        // 2. 如果审核通过，更新宠物状态为"已被领养"
        Adoption adoption = adoptionMapper.selectAdoptionById(adoptId);
        if (adoption != null && status == 2) {
            petMapper.updateStatus(adoption.getPetId(), 4);
        } else if (adoption != null && status == 3) {
            // 审核不通过，宠物回到"待领养"
            petMapper.updateStatus(adoption.getPetId(), 2);
        }

        return true;
    }
}
