package com.salmon.pet.service.impl;

import com.salmon.pet.entity.Pet;
import com.salmon.pet.mapper.PetMapper;
import com.salmon.pet.service.PetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 宠物 Service 实现类
 */
@Service
public class PetServiceImpl implements PetService {

    @Autowired
    private PetMapper petMapper;

    @Override
    public List<Pet> getPetList(Integer species, String breed, Integer gender, Integer ageStage,
                                 Integer isNeutered, Integer isVaccinated) {
        return petMapper.selectPetList(species, breed, gender, ageStage, isNeutered, isVaccinated);
    }

    @Override
    public Pet getPetById(Integer petId) {
        return petMapper.selectPetById(petId);
    }

    @Override
    public boolean addPet(Pet pet) {
        // 生成宠物编号：PET + 时间戳
        pet.setPetNo("PET" + System.currentTimeMillis());
        // 默认状态：待审核
        if (pet.getAdoptStatus() == null) {
            pet.setAdoptStatus(1);
        }
        return petMapper.insertPet(pet) > 0;
    }

    @Override
    public boolean updatePet(Pet pet) {
        return petMapper.updatePet(pet) > 0;
    }

    @Override
    public boolean updatePetStatus(Integer petId, Integer status) {
        return petMapper.updateStatus(petId, status) > 0;
    }

    @Override
    public List<Pet> getAllPetList() {
        return petMapper.selectAllPetList();
    }

    @Override
    public boolean deletePet(Integer petId) {
        return petMapper.deletePet(petId) > 0;
    }
}
