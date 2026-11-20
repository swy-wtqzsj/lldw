package com.salmon.pet.service;

import com.salmon.pet.entity.Punishment;

import java.util.List;

/**
 * 处罚管理 Service 接口
 */
public interface PunishmentService {

    /** 查询处罚列表 */
    List<Punishment> getList(Integer status, Integer userId);

    /** 查询处罚详情 */
    Punishment getById(Integer punishId);

    /** 新增处罚 */
    boolean add(Punishment punishment);

    /** 解除处罚 */
    boolean lift(Integer punishId);
}
