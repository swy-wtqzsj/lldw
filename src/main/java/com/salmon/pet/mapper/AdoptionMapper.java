package com.salmon.pet.mapper;

import com.salmon.pet.entity.Adoption;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 领养申请 Mapper 接口
 */
public interface AdoptionMapper {

    /**
     * 用户提交领养申请
     */
    int insertAdoption(Adoption adoption);

    /**
     * 查询用户的领养申请列表
     */
    List<Adoption> selectMyAdoptionList(@Param("userId") Integer userId);

    /**
     * 根据ID查询领养申请
     */
    Adoption selectAdoptionById(@Param("adoptId") Integer adoptId);

    /**
     * 后台查询领养申请列表（可按状态筛选）
     */
    List<Adoption> selectAdminAdoptionList(@Param("status") Integer status);

    /**
     * 审核领养申请
     */
    int auditAdoption(@Param("adoptId") Integer adoptId,
                      @Param("status") Integer status,
                      @Param("auditOpinion") String auditOpinion,
                      @Param("auditAdminId") Integer auditAdminId);

    /**
     * 查询用户某只宠物的申请（防止重复申请）
     */
    Adoption selectUserPetApply(@Param("userId") Integer userId, @Param("petId") Integer petId);
}
