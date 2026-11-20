package com.salmon.pet.service.impl;

import com.salmon.pet.entity.Punishment;
import com.salmon.pet.mapper.PunishmentMapper;
import com.salmon.pet.service.PunishmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 处罚管理 Service 实现类
 */
@Service
public class PunishmentServiceImpl implements PunishmentService {

    @Autowired
    private PunishmentMapper punishmentMapper;

    @Override
    public List<Punishment> getList(Integer status, Integer userId) {
        return punishmentMapper.selectList(status, userId);
    }

    @Override
    public Punishment getById(Integer punishId) {
        return punishmentMapper.selectById(punishId);
    }

    @Override
    public boolean add(Punishment punishment) {
        return punishmentMapper.insert(punishment) > 0;
    }

    @Override
    public boolean lift(Integer punishId) {
        return punishmentMapper.lift(punishId) > 0;
    }
}
