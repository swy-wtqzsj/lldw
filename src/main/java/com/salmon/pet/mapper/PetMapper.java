package com.salmon.pet.mapper;

import com.salmon.pet.entity.Pet;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 宠物 Mapper 接口
 */
public interface PetMapper {

    /**
     * 分页查询宠物列表（前台展示，只显示待领养的）
     */
    List<Pet> selectPetList(@Param("species") Integer species,
                            @Param("breed") String breed,
                            @Param("gender") Integer gender,
                            @Param("ageStage") Integer ageStage,
                            @Param("isNeutered") Integer isNeutered,
                            @Param("isVaccinated") Integer isVaccinated);

    /**
     * 根据ID查询宠物详情
     */
    Pet selectPetById(@Param("petId") Integer petId);

    /**
     * 新增宠物
     */
    int insertPet(Pet pet);

    /**
     * 更新宠物
     */
    int updatePet(Pet pet);

    /**
     * 更新宠物状态
     */
    int updateStatus(@Param("petId") Integer petId, @Param("status") Integer status);

    /**
     * 后台查询所有宠物（分页）
     */
    List<Pet> selectAllPetList();

    /**
     * 删除宠物（逻辑删除）
     */
    int deletePet(@Param("petId") Integer petId);
}
