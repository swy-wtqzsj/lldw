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
    public String save(Activity activity, Model model) {
        String error = validate(activity);
        if (error != null) {
            model.addAttribute("error", error);
            model.addAttribute("activity", activity);
            return "admin/activity_form";
        }
        activity.setTitle(activity.getTitle().trim());
        activityService.save(activity);
        return "redirect:/admin/activity/list";
    }

    /**
     * 表单校验：避免必填项为空时直接落库触发 SQL 异常（被包装成 500）
     */
    private String validate(Activity activity) {
        if (activity.getTitle() == null || activity.getTitle().trim().isEmpty()) {
            return "活动标题不能为空";
        }
        if (activity.getTitle().trim().length() > 100) {
            return "活动标题不能超过 100 个字";
        }
        if (activity.getStartTime() == null || activity.getEndTime() == null) {
            return "请填写活动的开始时间和结束时间";
        }
        if (!activity.getEndTime().after(activity.getStartTime())) {
            return "结束时间必须晚于开始时间";
        }
        if (activity.getMaxPeople() != null && activity.getMaxPeople() < 0) {
            return "人数上限不能为负数";
        }
        if (activity.getLocation() != null && activity.getLocation().length() > 128) {
            return "活动地点不能超过 128 个字";
        }
        return null;
    }
}
