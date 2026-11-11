package com.salmon.pet.controller;

import com.salmon.pet.entity.Activity;
import com.salmon.pet.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin/activity")
public class AdminActivityController {

    @Autowired
    private ActivityService activityService;

    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer status, Model model) {
        model.addAttribute("list", activityService.getAdminList(status));
        model.addAttribute("status", status);
        return "admin/activity_list";
    }

    @RequestMapping("/save")
    public String save(Activity activity) {
        activityService.save(activity);
        return "redirect:/admin/activity/list";
    }
}
