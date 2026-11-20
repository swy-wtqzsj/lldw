package com.salmon.pet.controller;

import com.salmon.pet.entity.Punishment;
import com.salmon.pet.entity.User;
import com.salmon.pet.service.AppealService;
import com.salmon.pet.service.PunishmentService;
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
 * 前台处罚申诉控制器
 */
@Controller
@RequestMapping("/appeal")
public class AppealController {

    private static final List<String> ALLOWED_EXT =
            Arrays.asList("jpg", "jpeg", "png", "gif", "webp");

    @Autowired
    private AppealService appealService;

    @Autowired
    private PunishmentService punishmentService;

    /**
     * 我的处罚与申诉
     */
    @RequestMapping("/my")
    public String my(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("punishments",
                punishmentService.getList(null, loginUser.getUserId()));
        model.addAttribute("list", appealService.getMyList(loginUser.getUserId()));
        return "appeal/my";
    }

    /**
     * 发起申诉页面
     */
    @RequestMapping("/apply")
    public String apply(@RequestParam Integer punishId,
                        HttpSession session,
                        Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        Punishment punishment = punishmentService.getById(punishId);
        if (punishment == null || !loginUser.getUserId().equals(punishment.getUserId())) {
            session.setAttribute("appealMsg", "只能对自己的处罚发起申诉");
            return "redirect:/appeal/my";
        }
        if (punishment.getStatus() == null || punishment.getStatus() != 1) {
            session.setAttribute("appealMsg", "该处罚已不是生效状态，无需申诉");
            return "redirect:/appeal/my";
        }
        model.addAttribute("punishment", punishment);
        return "appeal/form";
    }

    /**
     * 提交申诉
     */
    @RequestMapping("/save")
    public String save(@RequestParam Integer punishId,
                       @RequestParam String content,
                       @RequestParam(value = "evidenceFile", required = false) MultipartFile evidenceFile,
                       HttpSession session,
                       HttpServletRequest request) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }

        String evidence = null;
        if (evidenceFile != null && !evidenceFile.isEmpty()) {
            evidence = saveEvidence(evidenceFile, request);
            if (evidence == null) {
                session.setAttribute("appealMsg", "佐证图片格式不支持，仅限 jpg/jpeg/png/gif/webp");
                return "redirect:/appeal/apply?punishId=" + punishId;
            }
        }

        String error = appealService.apply(punishId, loginUser.getUserId(), content, evidence);
        if (error == null) {
            session.setAttribute("appealMsg", "申诉已提交，请等待管理员复核");
        } else {
            session.setAttribute("appealMsg", error);
        }
        return "redirect:/appeal/my";
    }

    /**
     * 保存佐证图片，返回相对路径；格式不合法返回 null
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
            String fileName = "appeal_" + UUID.randomUUID().toString().replace("-", "") + "." + ext;
            file.transferTo(new File(dir, fileName));
            return relativeDir + "/" + fileName;
        } catch (Exception e) {
            return null;
        }
    }
}
