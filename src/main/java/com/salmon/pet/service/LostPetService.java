package com.salmon.pet.service;

import com.salmon.pet.entity.LostPet;

import java.util.List;

/**
 * 寻宠启事 Service 接口
 */
public interface LostPetService {

    /** 前台已发布启事列表 */
    List<LostPet> getPublishedList();

    /** 后台启事列表 */
    List<LostPet> getList(Integer status);

    /** 我的启事列表 */
    List<LostPet> getMyList(Integer userId);

    /** 启事详情 */
    LostPet getById(Integer lostId);

    /** 发布启事（进入待审核） */
    boolean publish(LostPet lostPet);

    /** 更新启事状态 */
    boolean updateStatus(Integer lostId, Integer status);
}
