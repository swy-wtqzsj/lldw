package com.salmon.pet.controller;

import com.salmon.pet.entity.TeamCert;
import com.salmon.pet.entity.User;
import com.salmon.pet.entity.VolunteerCert;
import com.salmon.pet.service.CertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * 前台认证申请控制器
 */
@Controller
@RequestMapping("/cert")
public class CertController {

    @Autowired
    private CertService certService;

    /**
     * 认证申请页
     */
    @RequestMapping("/apply")
    public String apply(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("volunteerCert", certService.getVolunteerByUser(loginUser.getUserId()));
        model.addAttribute("teamCert", certService.getTeamByLeader(loginUser.getUserId()));
        return "cert/apply";
    }

    /**
     * 提交志愿者认证申请
     */
    @RequestMapping("/volunteer/save")
    public String applyVolunteer(@RequestParam String realName,
                                 @RequestParam String idCard,
                                 @RequestParam String phone,
                                 @RequestParam(required = false) String emergencyContact,
                                 @RequestParam(required = false) String serviceArea,
                                 @RequestParam(required = false) String skillTags,
                                 HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        if (realName.trim().isEmpty() || idCard.trim().isEmpty() || phone.trim().isEmpty()) {
            session.setAttribute("certMsg", "真实姓名、身份证号、联系电话不能为空");
            return "redirect:/cert/apply";
        }

        VolunteerCert cert = new VolunteerCert();
        cert.setRealName(realName.trim());
        cert.setIdCard(idCard.trim());
        cert.setPhone(phone.trim());
        cert.setEmergencyContact(emergencyContact);
        cert.setServiceArea(serviceArea);
        cert.setSkillTags(skillTags);

        String error = certService.applyVolunteer(cert, loginUser.getUserId());
        session.setAttribute("certMsg", error == null ? "志愿者认证申请已提交，请等待审核" : error);
        return "redirect:/cert/apply";
    }

    /**
     * 提交团队认证申请
     */
    @RequestMapping("/team/save")
    public String applyTeam(@RequestParam String teamName,
                            @RequestParam String leaderName,
                            @RequestParam(required = false) String creditCode,
                            @RequestParam(required = false) String description,
                            @RequestParam(required = false) String serviceScope,
                            HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        if (teamName.trim().isEmpty() || leaderName.trim().isEmpty()) {
            session.setAttribute("certMsg", "机构名称与负责人姓名不能为空");
            return "redirect:/cert/apply";
        }

        TeamCert cert = new TeamCert();
        cert.setTeamName(teamName.trim());
        cert.setLeaderName(leaderName.trim());
        cert.setCreditCode(creditCode);
        cert.setDescription(description);
        cert.setServiceScope(serviceScope);

        String error = certService.applyTeam(cert, loginUser.getUserId());
        session.setAttribute("certMsg", error == null ? "团队认证申请已提交，请等待审核" : error);
        return "redirect:/cert/apply";
    }
}
