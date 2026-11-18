package com.salmon.pet.controller;

import com.salmon.pet.entity.User;
import com.salmon.pet.entity.Volunteer;
import com.salmon.pet.service.VolunteerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

/**
 * 志愿者认证控制器 (A组)
 * 前台 PET-1.11 / 后台 PET-2.9
 */
@Controller
public class VolunteerController {

    @Autowired
    private VolunteerService volunteerService;

    // ==================== 前台 ====================

    /** 认证申请页面 */
    @GetMapping("/volunteer/apply")
    public String applyPage(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        Volunteer exist = volunteerService.getByUserId(loginUser.getUserId());
        model.addAttribute("volunteer", exist != null ? exist : new Volunteer());
        return "volunteer/apply";
    }

    /** 提交认证申请 */
    @PostMapping("/volunteer/apply")
    public String doApply(Volunteer volunteer, HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        volunteer.setUserId(loginUser.getUserId());
        String error = volunteerService.apply(volunteer);
        if (error != null) {
            model.addAttribute("error", error);
            model.addAttribute("volunteer", volunteer);
            return "volunteer/apply";
        }
        model.addAttribute("msg", "申请已提交，请等待管理员审核");
        Volunteer fresh = volunteerService.getByUserId(loginUser.getUserId());
        model.addAttribute("volunteer", fresh);
        return "volunteer/apply";
    }

    // ==================== 后台 ====================

    /** 后台审核列表 */
    @GetMapping("/admin/volunteer/list")
    public String adminList(@RequestParam(required = false) Integer status,
                            @RequestParam(required = false) String keyword,
                            Model model) {
        model.addAttribute("list", volunteerService.listForAdmin(status, keyword));
        model.addAttribute("status", status);
        model.addAttribute("keyword", keyword);
        model.addAttribute("pendingCount", volunteerService.countByStatus(1));
        return "admin/volunteer_list";
    }

    /** 审核(通过/拒绝) */
    @PostMapping("/admin/volunteer/audit")
    public String audit(Integer volunteerId, Integer auditStatus, String auditOpinion, HttpSession session) {
        User admin = (User) session.getAttribute("loginUser");
        volunteerService.audit(volunteerId, auditStatus, auditOpinion, admin.getUserId());
        return "redirect:/admin/volunteer/list";
    }

    /** 更新工时/积分/等级 */
    @PostMapping("/admin/volunteer/score")
    public String updateScore(Integer volunteerId, Integer workHours, Integer points, Integer level) {
        volunteerService.updateScore(volunteerId, workHours, points, level);
        return "redirect:/admin/volunteer/list";
    }
}
