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
        // 状态2=待领养、5=退养回流，均可申请
        if (pet.getAdoptStatus() != 2 && pet.getAdoptStatus() != 5) {
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
        Adoption adoption = adoptionMapper.selectAdoptionById(adoptId);
        if (adoption == null || adoption.getStatus() == null || adoption.getStatus() != 1) {
            return false;
        }

        adoptionMapper.auditAdoption(adoptId, status, auditOpinion, adminId);

        if (status == 2) {
            // 审核通过：宠物变为已被领养，并自动拒绝该宠物其他待审核申请
            petMapper.updateStatus(adoption.getPetId(), 4);
            adoptionMapper.rejectOtherPending(adoption.getPetId(), adoptId, adminId);
        } else if (status == 3) {
            // 审核不通过：仅在该宠物没有已通过申请时，才恢复为待领养
            if (adoptionMapper.countApprovedByPet(adoption.getPetId()) == 0) {
                petMapper.updateStatus(adoption.getPetId(), 2);
            }
        }

        return true;
    }
}
