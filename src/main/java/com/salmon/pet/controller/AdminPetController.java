package com.salmon.pet.controller;

import com.salmon.pet.entity.Adoption;
import com.salmon.pet.entity.Pet;
import com.salmon.pet.entity.User;
import com.salmon.pet.service.AdoptionService;
import com.salmon.pet.service.PetService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 后台宠物管理控制器
 */
@Controller
@RequestMapping("/admin/pet")
public class AdminPetController {

    @Autowired
    private PetService petService;

    @Autowired
    private AdoptionService adoptionService;

    /**
     * 宠物列表（后台）
     */
    @RequestMapping("/list")
    public String list(@RequestParam(defaultValue = "1") Integer pageNum, Model model) {
        PageHelper.startPage(pageNum, 10);
        List<Pet> petList = petService.getAllPetList();
        PageInfo<Pet> pageInfo = new PageInfo<>(petList);

        model.addAttribute("petList", petList);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/pet_list";
    }

    /**
     * 新增宠物页面
     */
    @RequestMapping("/add")
    public String addPage() {
        return "admin/pet_form";
    }

    /**
     * 保存新增宠物
     */
    @PostMapping("/save")
    public String save(Pet pet) {
        petService.addPet(pet);
        return "redirect:/admin/pet/list";
    }

    /**
     * 编辑宠物页面
     */
    @RequestMapping("/edit/{petId}")
    public String editPage(@PathVariable Integer petId, Model model) {
        Pet pet = petService.getPetById(petId);
        model.addAttribute("pet", pet);
        return "admin/pet_form";
    }

    /**
     * 更新宠物
     */
    @PostMapping("/update")
    public String update(Pet pet) {
        petService.updatePet(pet);
        return "redirect:/admin/pet/list";
    }

    /**
     * 删除宠物
     */
    @RequestMapping("/delete/{petId}")
    public String delete(@PathVariable Integer petId) {
        petService.deletePet(petId);
        return "redirect:/admin/pet/list";
    }

    // ==================== 领养审核 ====================

    /**
     * 领养申请列表
     */
    @RequestMapping("/adoption_list")
    public String adoptionList(@RequestParam(required = false) Integer status, Model model) {
        List<Adoption> list = adoptionService.getAdminAdoptionList(status);
        model.addAttribute("list", list);
        model.addAttribute("status", status);
        return "admin/adoption_list";
    }

    /**
     * 审核领养申请
     */
    @PostMapping("/audit")
    public String audit(Integer adoptId, Integer status, String auditOpinion, HttpSession session) {
        User admin = (User) session.getAttribute("loginUser");
        adoptionService.auditAdoption(adoptId, status, auditOpinion, admin.getUserId());
        return "redirect:/admin/pet/adoption_list";
    }
}
