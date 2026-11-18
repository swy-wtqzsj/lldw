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

    @RequestMapping("/add")
    public String addPage() {
        return "admin/activity_form";
    }

    @RequestMapping("/edit/{activityId}")
    public String editPage(@org.springframework.web.bind.annotation.PathVariable Integer activityId, Model model) {
        model.addAttribute("activity", activityService.getById(activityId));
        return "admin/activity_form";
    }

    @RequestMapping("/save")
    public String save(Activity activity) {
        activityService.save(activity);
        return "redirect:/admin/activity/list";
    }
}
