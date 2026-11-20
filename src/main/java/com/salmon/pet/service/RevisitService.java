package com.salmon.pet.service;

import com.salmon.pet.entity.Adoption;
import com.salmon.pet.entity.Revisit;
import com.salmon.pet.mapper.AdoptionMapper;
import com.salmon.pet.mapper.RevisitMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RevisitService {

    @Autowired
    private RevisitMapper revisitMapper;
    @Autowired
    private AdoptionMapper adoptionMapper;

    /**
     * 提交回访（含归属、状态校验）
     */
    public String add(Revisit revisit, Integer userId) {
        Adoption adoption = adoptionMapper.selectAdoptionById(revisit.getAdoptId());
        if (adoption == null) {
            return "领养记录不存在";
        }
        if (adoption.getUserId() == null || !adoption.getUserId().equals(userId)) {
            return "只能对自己的领养记录提交回访";
        }
        if (adoption.getStatus() == null || adoption.getStatus() != 2) {
            return "该领养记录当前不可提交回访";
        }
        return revisitMapper.insert(revisit) > 0 ? "success" : "提交失败，请重试";
    }

    public List<Revisit> getAdminList(Integer status) {
        return revisitMapper.selectAdminList(status);
    }

    public Revisit getById(Integer revisitId) {
        return revisitMapper.selectById(revisitId);
    }

    public boolean updateStatus(Integer revisitId, Integer status, String adminRemark) {
        return revisitMapper.updateStatus(revisitId, status, adminRemark) > 0;
    }

    public List<Revisit> getByAdoptId(Integer adoptId) {
        return revisitMapper.selectByAdoptId(adoptId);
    }
}
