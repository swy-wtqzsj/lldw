package com.salmon.pet.controller;

import com.salmon.pet.service.VolunteerSignService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * 后台志愿签到 / 工时统计控制器（C 组）
 * /admin/** 由 LoginInterceptor 统一拦截，仅管理员可访问
 */
@Controller
@RequestMapping("/admin/sign")
public class AdminVolunteerSignController {

    @Autowired
    private VolunteerSignService volunteerSignService;

    /** 签到记录列表 */
    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer userId,
                       @RequestParam(required = false) Integer status,
                       @RequestParam(required = false) Integer auditStatus,
                       @RequestParam(required = false) String keyword,
                       Model model) {
        model.addAttribute("list", volunteerSignService.getAdminList(userId, status,
                auditStatus, keyword));
        model.addAttribute("userId", userId);
        model.addAttribute("status", status);
        model.addAttribute("auditStatus", auditStatus);
        model.addAttribute("keyword", keyword);
        return "admin/sign_list";
    }

    /** 工时审核 */
    @PostMapping("/audit")
    public String audit(@RequestParam Integer signId,
                        @RequestParam Integer auditStatus,
                        @RequestParam(required = false) String auditRemark,
                        HttpSession session) {
        boolean ok = volunteerSignService.audit(signId, auditStatus, auditRemark);
        session.setAttribute("adminSignMsg", ok ? "工时审核已提交" : "审核失败，记录不存在");
        return "redirect:/admin/sign/list";
    }

    /** 工时统计看板 */
    @RequestMapping("/stats")
    public String stats(Model model) {
        model.addAttribute("summary", volunteerSignService.getSummary());
        model.addAttribute("rank", volunteerSignService.getWorkHourRank());
        model.addAttribute("today", volunteerSignService.countToday());
        return "admin/sign_stats";
    }
}
