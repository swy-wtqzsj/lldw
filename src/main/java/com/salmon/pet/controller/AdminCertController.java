package com.salmon.pet.controller;

import com.salmon.pet.entity.User;
import com.salmon.pet.service.CertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * 后台证书认证管理控制器
 */
@Controller
@RequestMapping("/admin/cert")
public class AdminCertController {

    @Autowired
    private CertService certService;

    /**
     * 证书认证列表（团队 + 志愿者）
     */
    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer teamStatus,
                       @RequestParam(required = false) Integer volunteerStatus,
                       Model model) {
        model.addAttribute("teamList", certService.getTeamList(teamStatus));
        model.addAttribute("volunteerList", certService.getVolunteerList(volunteerStatus));
        model.addAttribute("teamStatus", teamStatus);
        model.addAttribute("volunteerStatus", volunteerStatus);
        return "admin/cert_list";
    }

    /**
     * 审核团队认证
     */
    @RequestMapping("/team/audit")
    public String auditTeam(@RequestParam Integer teamId,
                            @RequestParam Integer status,
                            HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        Integer adminId = loginUser == null ? null : loginUser.getUserId();

        if (certService.auditTeam(teamId, status, adminId)) {
            session.setAttribute("adminCertMsg", "团队认证已处理");
        } else {
            session.setAttribute("adminCertMsg", "团队认证处理失败");
        }
        return "redirect:/admin/cert/list";
    }

    /**
     * 审核志愿者认证
     */
    @RequestMapping("/volunteer/audit")
    public String auditVolunteer(@RequestParam Integer certId,
                                 @RequestParam Integer status,
                                 @RequestParam(required = false) String auditOpinion,
                                 HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        Integer adminId = loginUser == null ? null : loginUser.getUserId();

        if (certService.auditVolunteer(certId, status, adminId, auditOpinion)) {
            session.setAttribute("adminCertMsg", "志愿者认证已处理");
        } else {
            session.setAttribute("adminCertMsg", "志愿者认证处理失败");
        }
        return "redirect:/admin/cert/list";
    }
}
