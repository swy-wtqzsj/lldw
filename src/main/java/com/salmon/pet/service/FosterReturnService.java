package com.salmon.pet.service;

import com.salmon.pet.entity.FosterReturn;
import com.salmon.pet.mapper.FosterReturnMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FosterReturnService {

    @Autowired
    private FosterReturnMapper fosterReturnMapper;

    public boolean add(FosterReturn fosterReturn) {
        return fosterReturnMapper.insert(fosterReturn) > 0;
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

    public boolean audit(Integer returnId, Integer status, String auditOpinion, Integer auditAdmin) {
        return fosterReturnMapper.audit(returnId, status, auditOpinion, auditAdmin) > 0;
    }
}
