package com.salmon.pet.controller;

import com.salmon.pet.entity.Punishment;
import com.salmon.pet.entity.ReportRecord;
import com.salmon.pet.entity.User;
import com.salmon.pet.service.PunishReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

/**
 * 举报与处罚控制器 (A组) - 对应 6.3.9
 * 前台：举报提交/查看结果、处罚查看/申诉
 * 后台：举报处理、处罚管理、申诉复核
 */
@Controller
public class PunishReportController {

    @Autowired
    private PunishReportService punishReportService;

    // ==================== 前台：举报 ====================

    /** 举报提交页面 */
    @GetMapping("/report/submit")
    public String submitPage(@RequestParam(required = false) Integer targetType,
                             @RequestParam(required = false) Integer targetId,
                             HttpSession session, Model model) {
        if (session.getAttribute("loginUser") == null) return "redirect:/login";
        model.addAttribute("targetType", targetType);
        model.addAttribute("targetId", targetId);
        return "report/submit";
    }

    /** 提交举报 */
    @PostMapping("/report/submit")
    public String doSubmit(ReportRecord report, HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        report.setReporterId(loginUser.getUserId());
        String error = punishReportService.submitReport(report);
        if (error != null) {
            model.addAttribute("error", error);
            return "report/submit";
        }
        return "redirect:/report/my";
    }

    /** 我的举报(查看举报结果) */
    @GetMapping("/report/my")
    public String myReports(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        model.addAttribute("reports", punishReportService.myReports(loginUser.getUserId()));
        return "report/my_list";
    }

    // ==================== 前台：处罚查看与申诉 ====================

    /** 我的处罚记录 */
    @GetMapping("/punishment/my")
    public String myPunishments(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        model.addAttribute("punishments", punishReportService.myPunishments(loginUser.getUserId()));
        return "punishment/my_list";
    }

    /** 提交申诉 */
    @PostMapping("/punishment/appeal")
    public String submitAppeal(Integer punishId, String appealReason, HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        String error = punishReportService.submitAppeal(punishId, loginUser.getUserId(), appealReason);
        if (error != null) {
            model.addAttribute("error", error);
            model.addAttribute("punishments", punishReportService.myPunishments(loginUser.getUserId()));
            return "punishment/my_list";
        }
        return "redirect:/punishment/my";
    }

    // ==================== 后台：举报处理 ====================

    @GetMapping("/admin/report/list")
    public String adminReports(@RequestParam(required = false) Integer status, Model model) {
        model.addAttribute("reports", punishReportService.listReports(status));
        model.addAttribute("status", status);
        model.addAttribute("pendingCount", punishReportService.countPendingReports());
        return "admin/report_list";
    }

    @PostMapping("/admin/report/handle")
    public String handleReport(Integer reportId, Integer status, String handleResult, HttpSession session) {
        User admin = (User) session.getAttribute("loginUser");
        punishReportService.handleReport(reportId, status, handleResult, admin.getUserId());
        return "redirect:/admin/report/list";
    }

    // ==================== 后台：处罚管理 ====================

    @GetMapping("/admin/punishment/list")
    public String adminPunishments(@RequestParam(required = false) Integer status,
                                   @RequestParam(required = false) String username,
                                   Model model) {
        model.addAttribute("punishments", punishReportService.listPunishments(status, username));
        model.addAttribute("status", status);
        model.addAttribute("username", username);
        model.addAttribute("appealCount", punishReportService.countPendingAppeals());
        return "admin/punishment_list";
    }

    /** 新增处罚 */
    @PostMapping("/admin/punishment/add")
    public String addPunishment(Punishment punishment, HttpSession session, Model model) {
        User admin = (User) session.getAttribute("loginUser");
        punishment.setAdminId(admin.getUserId());
        String error = punishReportService.addPunishment(punishment);
        if (error != null) {
            model.addAttribute("error", error);
            model.addAttribute("punishments", punishReportService.listPunishments(null, null));
            return "admin/punishment_list";
        }
        return "redirect:/admin/punishment/list";
    }

    /** 解除处罚 */
    @GetMapping("/admin/punishment/release/{punishId}")
    public String release(@PathVariable Integer punishId) {
        punishReportService.releasePunishment(punishId);
        return "redirect:/admin/punishment/list";
    }

    /** 申诉复核 */
    @PostMapping("/admin/punishment/appeal")
    public String handleAppeal(Integer punishId, Integer appealStatus, String appealResult) {
        punishReportService.handleAppeal(punishId, appealStatus, appealResult);
        return "redirect:/admin/punishment/list";
    }
}
