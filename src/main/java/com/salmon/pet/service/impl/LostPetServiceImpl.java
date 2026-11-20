package com.salmon.pet.service.impl;

import com.salmon.pet.entity.LostPet;
import com.salmon.pet.mapper.LostPetMapper;
import com.salmon.pet.service.LostPetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 寻宠启事 Service 实现类
 */
@Service
public class LostPetServiceImpl implements LostPetService {

    @Autowired
    private LostPetMapper lostPetMapper;

    @Override
    public List<LostPet> getPublishedList() {
        return lostPetMapper.selectPublished();
    }

    @Override
    public List<LostPet> getList(Integer status) {
        return lostPetMapper.selectList(status);
    }

    @Override
    public List<LostPet> getMyList(Integer userId) {
        return lostPetMapper.selectByUser(userId);
    }

    @Override
    public LostPet getById(Integer lostId) {
        return lostPetMapper.selectById(lostId);
    }

    @Override
    public boolean publish(LostPet lostPet) {
        if (lostPet == null || lostPet.getUserId() == null) {
            return false;
        }
        if (lostPet.getContact() == null || lostPet.getContact().trim().isEmpty()) {
            return false;
        }
        return lostPetMapper.insert(lostPet) > 0;
    }

    @Override
    public boolean updateStatus(Integer lostId, Integer status) {
        if (lostId == null || status == null || status < 1 || status > 5) {
            return false;
        }
        return lostPetMapper.updateStatus(lostId, status) > 0;
    }
}
