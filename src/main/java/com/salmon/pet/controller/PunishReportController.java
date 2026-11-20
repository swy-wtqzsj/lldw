package com.salmon.pet.controller;

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
        return "redirect:/report_record/my";
    }

    /** 我的举报(查看举报结果) */
    @GetMapping("/report_record/my")
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

    @GetMapping("/admin/report_record/list")
    public String adminReports(@RequestParam(required = false) Integer status, Model model) {
        model.addAttribute("reports", punishReportService.listReports(status));
        model.addAttribute("status", status);
        model.addAttribute("pendingCount", punishReportService.countPendingReports());
        return "admin/report_list";
    }

    @PostMapping("/admin/report_record/handle")
    public String handleReport(Integer reportId, Integer status, String handleResult, HttpSession session) {
        User admin = (User) session.getAttribute("loginUser");
        punishReportService.handleReport(reportId, status, handleResult, admin.getUserId());
        return "redirect:/admin/report_record/list";
    }

    // ==================== 后台：处罚管理 ====================
    // 处罚列表与新增由 AdminPunishmentController 提供；此处保留 A组扩展的解除与申诉复核入口。

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
