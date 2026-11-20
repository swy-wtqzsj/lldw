package com.salmon.pet.controller;

import com.salmon.pet.entity.Report;
import com.salmon.pet.entity.User;
import com.salmon.pet.service.ReportService;
import com.salmon.pet.service.PunishReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

/**
 * 前台举报控制器
 */
@Controller
@RequestMapping("/report")
public class ReportController {

    private static final List<String> ALLOWED_EXT =
            Arrays.asList("jpg", "jpeg", "png", "gif", "webp");

    @Autowired
    private ReportService reportService;

    @Autowired
    private PunishReportService punishReportService;

    /**
     * 举报提交页
     */
    @RequestMapping("/publish")
    public String publish(@RequestParam Integer targetType,
                          @RequestParam Integer targetId,
                          HttpSession session,
                          Model model) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        if (targetType < 1 || targetType > 4) {
            return "redirect:/";
        }
        model.addAttribute("targetType", targetType);
        model.addAttribute("targetId", targetId);
        model.addAttribute("targetTypeText", targetTypeText(targetType));
        return "report/publish";
    }

    /**
     * 提交举报
     */
    @RequestMapping("/save")
    public String save(@RequestParam Integer targetType,
                       @RequestParam Integer targetId,
                       @RequestParam String reason,
                       @RequestParam(value = "evidenceFile", required = false) MultipartFile evidenceFile,
                       HttpSession session,
                       HttpServletRequest request) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        if (targetType < 1 || targetType > 4) {
            return "redirect:/";
        }
        if (reason == null || reason.trim().isEmpty()) {
            session.setAttribute("reportMsg", "请填写举报原因");
            return "redirect:/report/publish?targetType=" + targetType + "&targetId=" + targetId;
        }

        String evidence = null;
        if (evidenceFile != null && !evidenceFile.isEmpty()) {
            evidence = saveEvidence(evidenceFile, request);
            if (evidence == null) {
                session.setAttribute("reportMsg", "证据图片格式不支持，仅限 jpg/jpeg/png/gif/webp");
                return "redirect:/report/publish?targetType=" + targetType + "&targetId=" + targetId;
            }
        }

        Report report = new Report();
        report.setReporterId(loginUser.getUserId());
        report.setTargetType(targetType);
        report.setTargetId(targetId);
        report.setReason(reason.trim());
        report.setEvidence(evidence);
        reportService.submit(report);

        session.setAttribute("reportMsg", "举报已提交，请等待管理员处理");
        return "redirect:/report/my";
    }

    /**
     * 我的举报
     */
    @RequestMapping("/my")
    public String myList(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("list", reportService.getMyList(loginUser.getUserId()));
        model.addAttribute("reports", punishReportService.myReports(loginUser.getUserId()));
        return "report/my_list";
    }

    private String targetTypeText(Integer targetType) {
        if (targetType == null) return "";
        switch (targetType) {
            case 1: return "评论";
            case 2: return "求助信息";
            case 3: return "用户";
            case 4: return "活动";
            default: return "";
        }
    }

    /**
     * 保存证据图片，返回相对路径；格式不合法返回 null
     */
    private String saveEvidence(MultipartFile file, HttpServletRequest request) {
        String original = file.getOriginalFilename();
        String ext = "";
        if (original != null && original.contains(".")) {
            ext = original.substring(original.lastIndexOf('.') + 1).toLowerCase();
        }
        if (!ALLOWED_EXT.contains(ext)) {
            return null;
        }
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return null;
        }
        try {
            String relativeDir = "/static/uploads";
            String realDir = request.getServletContext().getRealPath(relativeDir);
            File dir = new File(realDir);
            if (!dir.exists() && !dir.mkdirs()) {
                return null;
            }
            String fileName = "report_" + UUID.randomUUID().toString().replace("-", "") + "." + ext;
            file.transferTo(new File(dir, fileName));
            return relativeDir + "/" + fileName;
        } catch (Exception e) {
            return null;
        }
    }
}
