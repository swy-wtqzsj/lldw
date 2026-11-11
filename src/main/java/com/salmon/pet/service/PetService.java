package com.salmon.pet.service;

import com.salmon.pet.entity.Pet;

import java.util.List;

/**
 * 宠物 Service 接口
 */
public interface PetService {

    /**
     * 分页查询宠物列表（前台）
     */
    List<Pet> getPetList(Integer species, String breed, Integer gender, Integer ageStage,
                         Integer isNeutered, Integer isVaccinated);

    /**
     * 查询宠物详情
     */
    Pet getPetById(Integer petId);

    /**
     * 新增宠物
     */
    boolean addPet(Pet pet);

    /**
     * 更新宠物
     */
    boolean updatePet(Pet pet);

    /**
     * 更新宠物状态
     */
    boolean updatePetStatus(Integer petId, Integer status);

    /**
     * 后台查询所有宠物
     */
    List<Pet> getAllPetList();

    /**
     * 删除宠物
     */
    boolean deletePet(Integer petId);
}
