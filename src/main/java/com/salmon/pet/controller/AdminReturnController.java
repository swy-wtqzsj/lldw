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
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * 后台回访与退养管理
 */
@Controller
@RequestMapping("/admin/pet")
public class AdminReturnController {

    @Autowired
    private RevisitService revisitService;

    @Autowired
    private FosterReturnService fosterReturnService;

    /**
     * 回访管理列表
     */
    @RequestMapping("/revisit_list")
    public String revisitList(@RequestParam(required = false) Integer status, Model model) {
        model.addAttribute("list", revisitService.getAdminList(status));
        model.addAttribute("status", status);
        return "admin/revisit_list";
    }

    /**
     * 回访审核
     */
    @RequestMapping("/revisit_audit")
    public String revisitAudit(Integer revisitId, Integer status, String adminRemark) {
        revisitService.updateStatus(revisitId, status, adminRemark);
        return "redirect:/admin/pet/revisit_list";
    }

    /**
     * 退养申请列表
     */
    @RequestMapping("/return_list")
    public String returnList(@RequestParam(required = false) Integer status, Model model) {
        model.addAttribute("list", fosterReturnService.getAdminList(status));
        model.addAttribute("status", status);
        return "admin/return_list";
    }

    /**
     * 退养审核
     */
    @RequestMapping("/return_audit")
    public String returnAudit(Integer returnId, Integer status, String auditOpinion, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        fosterReturnService.audit(returnId, status, auditOpinion, loginUser.getUserId());
        return "redirect:/admin/pet/return_list";
    }
}
