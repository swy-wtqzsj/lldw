package com.salmon.pet.service;

import com.salmon.pet.entity.Adoption;

import java.util.List;

/**
 * 领养申请 Service 接口
 */
public interface AdoptionService {

    /**
     * 用户提交领养申请
     */
    String applyAdoption(Adoption adoption);

    /**
     * 查询用户的领养申请列表
     */
    List<Adoption> getMyAdoptionList(Integer userId);

    /**
     * 根据ID查询领养申请
     */
    Adoption getAdoptionById(Integer adoptId);

    /**
     * 后台查询领养申请列表
     */
    List<Adoption> getAdminAdoptionList(Integer status);

    /**
     * 审核领养申请
     */
    boolean auditAdoption(Integer adoptId, Integer status, String auditOpinion, Integer adminId);
}
