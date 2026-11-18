package com.salmon.pet.service;

import com.salmon.pet.entity.Revisit;
import com.salmon.pet.mapper.RevisitMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RevisitService {

    @Autowired
    private RevisitMapper revisitMapper;

    public boolean add(Revisit revisit) {
        return revisitMapper.insert(revisit) > 0;
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
