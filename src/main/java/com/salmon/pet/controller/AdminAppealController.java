package com.salmon.pet.controller;

import com.salmon.pet.entity.User;
import com.salmon.pet.service.AppealService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * 后台处罚申诉复核控制器
 */
@Controller
@RequestMapping("/admin/appeal")
public class AdminAppealController {

    @Autowired
    private AppealService appealService;

    /**
     * 申诉列表
     */
    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer status, Model model) {
        model.addAttribute("list", appealService.getList(status));
        model.addAttribute("status", status);
        return "admin/appeal_list";
    }

    /**
     * 复核申诉
     */
    @RequestMapping("/review")
    public String review(@RequestParam Integer appealId,
                         @RequestParam Integer status,
                         @RequestParam(required = false) String reviewOpinion,
                         HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        Integer adminId = loginUser == null ? null : loginUser.getUserId();

        if (appealService.review(appealId, status, adminId, reviewOpinion)) {
            session.setAttribute("adminAppealMsg", "申诉已复核");
        } else {
            session.setAttribute("adminAppealMsg", "复核失败，该申诉可能已处理");
        }
        return "redirect:/admin/appeal/list";
    }
}
