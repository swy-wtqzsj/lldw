package com.salmon.pet.controller;

import com.salmon.pet.entity.User;
import com.salmon.pet.service.ReportService;
import com.salmon.pet.service.PunishReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * 后台举报处理控制器
 */
@Controller
@RequestMapping("/admin/report")
public class AdminReportController {

    @Autowired
    private ReportService reportService;

    @Autowired
    private PunishReportService punishReportService;

    /**
     * 举报列表
     */
    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer status,
                       @RequestParam(required = false) Integer targetType,
                       Model model) {
        model.addAttribute("list", reportService.getList(status, targetType));
        model.addAttribute("reports", punishReportService.listReports(status));
        model.addAttribute("pendingCount", punishReportService.countPendingReports());
        model.addAttribute("status", status);
        model.addAttribute("targetType", targetType);
        return "admin/report_list";
    }

    /**
     * 处理举报
     */
    @RequestMapping("/handle")
    public String handle(@RequestParam Integer reportId,
                         @RequestParam Integer status,
                         @RequestParam(required = false) String handleOpinion,
                         HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        Integer adminId = loginUser == null ? null : loginUser.getUserId();

        if (reportService.handle(reportId, status, adminId, handleOpinion)) {
            session.setAttribute("adminReportMsg", "举报已处理");
        } else {
            session.setAttribute("adminReportMsg", "处理失败，请选择成立或不成立");
        }
        return "redirect:/admin/report/list";
    }
}
