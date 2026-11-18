package com.salmon.pet.controller;

import com.salmon.pet.mapper.DashboardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

    @Autowired
    private DashboardMapper dashboardMapper;

    @GetMapping("/admin/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("stats", dashboardMapper.selectCounts());
        return "admin/dashboard";
    }
}
