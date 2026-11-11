package com.salmon.pet.controller;

import com.salmon.pet.entity.Activity;
import com.salmon.pet.entity.User;
import com.salmon.pet.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/activity")
public class ActivityController {

    @Autowired
    private ActivityService activityService;

    @RequestMapping("/list")
    public String list(Model model) {
        List<Activity> list = activityService.getPublicList();
        model.addAttribute("list", list);
        return "activity/list";
    }

    @RequestMapping("/detail/{activityId}")
    public String detail(@PathVariable Integer activityId, Model model, HttpSession session) {
        Activity activity = activityService.getById(activityId);
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser != null) {
            Integer count = activityService.getMySignupList(loginUser.getUserId()).size();
            // 简化：直接传 activityId，页面判断
        }
        model.addAttribute("activity", activity);
        return "activity/detail";
    }

    @RequestMapping("/signup")
    public String signup(Integer activityId, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        activityService.signup(activityId, loginUser.getUserId());
        return "redirect:/activity/detail/" + activityId;
    }

    @RequestMapping("/cancel")
    public String cancel(Integer activityId, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        activityService.cancelSignup(activityId, loginUser.getUserId());
        return "redirect:/activity/detail/" + activityId;
    }

    @RequestMapping("/my")
    public String myList(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        List<Activity> list = activityService.getMySignupList(loginUser.getUserId());
        model.addAttribute("list", list);
        return "activity/my_list";
    }
}
