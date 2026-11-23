package com.salmon.pet.controller;

import com.salmon.pet.entity.VolunteerSign;
import com.salmon.pet.service.VolunteerSignService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 后台志愿签到 / 工时统计控制器（C 组）
 * /admin/** 由 LoginInterceptor 统一拦截，仅管理员可访问
 */
@Controller
@RequestMapping("/admin/sign")
public class AdminVolunteerSignController {

    @Autowired
    private VolunteerSignService volunteerSignService;

    /** 签到记录列表（分页 + 多条件筛选） */
    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer userId,
                       @RequestParam(required = false) Integer status,
                       @RequestParam(required = false) Integer auditStatus,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(defaultValue = "1") Integer pageNum,
                       Model model) {
        PageHelper.startPage(pageNum, 15);
        List<VolunteerSign> list = volunteerSignService.getAdminList(userId, status,
                auditStatus, keyword);
        PageInfo<VolunteerSign> pageInfo = new PageInfo<>(list);
        model.addAttribute("list", list);
        model.addAttribute("pageInfo", pageInfo);
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
        String msg = volunteerSignService.audit(signId, auditStatus, auditRemark);
        session.setAttribute("adminSignMsg", msg == null ? "工时审核已提交" : msg);
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
