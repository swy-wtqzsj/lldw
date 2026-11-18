package com.salmon.pet.controller;

import com.salmon.pet.entity.FosterReturn;
import com.salmon.pet.entity.Revisit;
import com.salmon.pet.entity.User;
import com.salmon.pet.service.FosterReturnService;
import com.salmon.pet.service.RevisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * 前台回访与退养
 */
@Controller
@RequestMapping("/pet")
public class ReturnController {

    @Autowired
    private RevisitService revisitService;

    @Autowired
    private FosterReturnService fosterReturnService;

    /**
     * 提交回访页面
     */
    @RequestMapping("/revisit_form")
    public String revisitForm(Integer adoptId, Model model, HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        model.addAttribute("adoptId", adoptId);
        return "pet/revisit_form";
    }

    /**
     * 提交回访
     */
    @RequestMapping("/revisit_save")
    public String revisitSave(Integer adoptId, String healthDesc, String photo, HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        Revisit revisit = new Revisit();
        revisit.setAdoptId(adoptId);
        revisit.setHealthDesc(healthDesc);
        revisit.setPhoto(photo);
        revisitService.add(revisit);
        return "redirect:/pet/my";
    }

    /**
     * 退养申请页面
     */
    @RequestMapping("/return_form")
    public String returnForm(Integer adoptId, Integer petId, Model model, HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        model.addAttribute("adoptId", adoptId);
        model.addAttribute("petId", petId);
        return "pet/return_form";
    }

    /**
     * 提交退养申请
     */
    @RequestMapping("/return_save")
    public String returnSave(Integer adoptId, Integer petId, String reason, String description, String photo, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        FosterReturn fr = new FosterReturn();
        fr.setAdoptId(adoptId);
        fr.setUserId(loginUser.getUserId());
        fr.setPetId(petId);
        fr.setReason(reason);
        fr.setDescription(description);
        fr.setPhoto(photo);
        fosterReturnService.add(fr);
        return "redirect:/pet/my_return";
    }

    /**
     * 我的退养申请列表
     */
    @RequestMapping("/my_return")
    public String myReturnList(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("list", fosterReturnService.getMyList(loginUser.getUserId()));
        return "pet/my_return";
    }
}
