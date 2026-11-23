package com.salmon.pet.controller;

import com.salmon.pet.entity.User;
import com.salmon.pet.service.ActivityService;
import com.salmon.pet.service.VolunteerSignService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * 前台志愿签到控制器（C 组）
 * 路由前缀 /sign，与 A/B/C 已占用前缀均不冲突
 */
@Controller
@RequestMapping("/sign")
public class VolunteerSignController {

    @Autowired
    private VolunteerSignService volunteerSignService;

    @Autowired
    private ActivityService activityService;

    /** 我的签到与工时 */
    @RequestMapping("/list")
    public String list(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("list", volunteerSignService.getMyList(loginUser.getUserId()));
        model.addAttribute("myStats", volunteerSignService.getMyStats(loginUser.getUserId()));
        model.addAttribute("activities", activityService.getPublicList());
        return "sign/list";
    }

    /** 签到 */
    @PostMapping("/in")
    public String signIn(Integer activityId, Integer serviceType, String content,
                         HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        String msg = volunteerSignService.signIn(loginUser.getUserId(), activityId,
                serviceType, content);
        session.setAttribute("signMsg", msg == null ? "签到成功，服务结束后请记得签退" : msg);
        return "redirect:/sign/list";
    }

    /** 签退 */
    @PostMapping("/out")
    public String signOut(Integer signId, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        String msg = volunteerSignService.signOut(signId, loginUser.getUserId());
        session.setAttribute("signMsg", msg == null ? "签退成功，工时已提交审核" : msg);
        return "redirect:/sign/list";
    }
}
