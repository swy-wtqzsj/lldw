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
 * 前台宠物控制器
 */
@Controller
@RequestMapping("/pet")
public class PetController {

    @Autowired
    private PetService petService;

    @Autowired
    private AdoptionService adoptionService;

    /**
     * 宠物列表页
     */
    @RequestMapping("/list")
    public String petList(@RequestParam(required = false) Integer species,
                          @RequestParam(required = false) String breed,
                          @RequestParam(required = false) Integer gender,
                          @RequestParam(required = false) Integer ageStage,
                          @RequestParam(required = false) Integer isNeutered,
                          @RequestParam(required = false) Integer isVaccinated,
                          @RequestParam(defaultValue = "1") Integer pageNum,
                          Model model) {

        PageHelper.startPage(pageNum, 9);
        List<Pet> petList = petService.getPetList(species, breed, gender, ageStage, isNeutered, isVaccinated);
        PageInfo<Pet> pageInfo = new PageInfo<>(petList);

        model.addAttribute("petList", petList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("species", species);
        model.addAttribute("breed", breed);
        model.addAttribute("gender", gender);
        model.addAttribute("ageStage", ageStage);
        model.addAttribute("isNeutered", isNeutered);
        model.addAttribute("isVaccinated", isVaccinated);

        return "pet/list";
    }

    /**
     * 宠物详情页
     */
    @RequestMapping("/detail/{petId}")
    public String petDetail(@PathVariable Integer petId, Model model) {
        Pet pet = petService.getPetById(petId);
        model.addAttribute("pet", pet);
        return "pet/detail";
    }

    /**
     * 提交领养申请
     */
    @PostMapping("/apply")
    public String applyAdoption(Adoption adoption, HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }

        adoption.setUserId(loginUser.getUserId());
        String result = adoptionService.applyAdoption(adoption);

        if ("success".equals(result)) {
            model.addAttribute("msg", "领养申请提交成功，请等待管理员审核");
        } else {
            model.addAttribute("msg", result);
        }

        return "pet/apply_result";
    }

    /**
     * 我的领养列表
     */
    @RequestMapping("/my")
    public String myAdoption(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }

        List<Adoption> list = adoptionService.getMyAdoptionList(loginUser.getUserId());
        model.addAttribute("list", list);
        return "pet/my_adoption";
    }
}
