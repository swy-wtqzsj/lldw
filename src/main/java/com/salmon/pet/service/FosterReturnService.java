package com.salmon.pet.service;

import com.salmon.pet.entity.Adoption;
import com.salmon.pet.entity.FosterReturn;
import com.salmon.pet.entity.Pet;
import com.salmon.pet.mapper.AdoptionMapper;
import com.salmon.pet.mapper.FosterReturnMapper;
import com.salmon.pet.mapper.PetMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class FosterReturnService {

    @Autowired
    private FosterReturnMapper fosterReturnMapper;
    @Autowired
    private AdoptionMapper adoptionMapper;
    @Autowired
    private PetMapper petMapper;

    /**
     * 提交退养申请（含归属、状态、重复校验）
     */
    public String add(FosterReturn fosterReturn) {
        // 1. 领养记录必须存在
        Adoption adoption = adoptionMapper.selectAdoptionById(fosterReturn.getAdoptId());
        if (adoption == null) {
            return "领养记录不存在";
        }
        // 2. 归属校验：必须是本人领养记录
        if (adoption.getUserId() == null || !adoption.getUserId().equals(fosterReturn.getUserId())) {
            return "只能对自己的领养记录申请退养";
        }
        // 3. 状态校验：仅已通过(2)的领养可申请退养
        if (adoption.getStatus() == null || adoption.getStatus() != 2) {
            return "该领养记录当前不可申请退养";
        }
        // 4. 重复校验：该领养记录是否已提交过退养（不限状态）
        if (fosterReturnMapper.selectByAdoptAndUser(fosterReturn.getAdoptId(), fosterReturn.getUserId()) != null) {
            return "您已提交过该领养记录的退养申请";
        }
        // 5. 重复校验：该宠物是否已有进行中的退养（待审核/已通过未完成回流）
        if (fosterReturnMapper.selectActiveByPet(fosterReturn.getPetId()) != null) {
            return "该宠物已有进行中的退养申请，请耐心等待处理";
        }
        return fosterReturnMapper.insert(fosterReturn) > 0 ? "success" : "提交失败，请重试";
    }

    public List<FosterReturn> getAdminList(Integer status) {
        return fosterReturnMapper.selectAdminList(status);
    }

    public List<FosterReturn> getMyList(Integer userId) {
        return fosterReturnMapper.selectMyList(userId);
    }

    public FosterReturn getById(Integer returnId) {
        return fosterReturnMapper.selectById(returnId);
    }

    /**
     * 退养审核：同意时联动宠物回流(状态5) + 领养记录终止(状态4)，事务保证原子性
     */
    @Transactional
    public boolean audit(Integer returnId, Integer status, String auditOpinion, Integer auditAdmin) {
        FosterReturn fr = fosterReturnMapper.selectById(returnId);
        if (fr == null) {
            return false;
        }
        // 仅待审核(1)的记录可操作，避免重复审核
        if (fr.getStatus() == null || fr.getStatus() != 1) {
            return false;
        }

        if (status != null && status == 2) {
            // 同意退养：退养记录置为已回流(4)
            fosterReturnMapper.audit(returnId, 4, auditOpinion, auditAdmin);
            // 宠物回到可领养池(5 退养回流)
            petMapper.updateStatus(fr.getPetId(), 5);
            // 领养记录终止(4)
            adoptionMapper.terminateByReturn(fr.getAdoptId());
        } else {
            // 拒绝(3)或其它：仅更新退养记录状态
            fosterReturnMapper.audit(returnId, status, auditOpinion, auditAdmin);
        }
        return true;
    }
}
