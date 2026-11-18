package com.salmon.pet.controller;

import com.salmon.pet.entity.User;
import com.salmon.pet.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/user")
public class AdminUserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/list")
    public String list(@RequestParam(required = false) String keyword, Model model) {
        model.addAttribute("list", userService.getAdminList(keyword));
        model.addAttribute("keyword", keyword);
        return "admin/user_list";
    }

    @RequestMapping("/status")
    public String updateStatus(@RequestParam Integer userId,
                               @RequestParam Integer status,
                               @RequestParam(required = false) String keyword,
                               HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        User target = userService.getById(userId);

        if (target == null) {
            session.setAttribute("adminUserMsg", "用户不存在");
        } else if (loginUser != null && loginUser.getUserId().equals(userId)) {
            session.setAttribute("adminUserMsg", "不能修改当前登录账号的状态");
        } else if (target.getRole() != null && target.getRole() == 9) {
            session.setAttribute("adminUserMsg", "不能修改超级管理员的状态");
        } else {
            userService.updateStatus(userId, status);
        }
        return "redirect:/admin/user/list" + (keyword == null || keyword.isEmpty() ? "" : "?keyword=" + keyword);
    }
}
