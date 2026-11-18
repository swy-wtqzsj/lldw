package com.salmon.pet.controller;

import com.salmon.pet.entity.User;
import com.salmon.pet.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 后台用户管理 / 管理员管理控制器 (A组)
 * 对应 PET-2.1 用户管理、PET-2.2 管理员管理
 */
@Controller
@RequestMapping("/admin/user")
public class AdminUserController {

    @Autowired
    private UserService userService;

    /** 用户列表 */
    @GetMapping("/list")
    public String list(@RequestParam(required = false) String keyword,
                       @RequestParam(required = false) Integer role,
                       Model model) {
        List<User> users = userService.listUsers(keyword, role);
        model.addAttribute("users", users);
        model.addAttribute("keyword", keyword);
        model.addAttribute("role", role);
        return "admin/user_list";
    }

    /** 更新用户角色/状态 */
    @PostMapping("/update")
    public String update(Integer userId, Integer role, Integer status,
                         Integer adoptStatus, Integer creditScore) {
        if (role == null) role = 1;
        if (status == null) status = 1;
        if (adoptStatus == null) adoptStatus = 1;
        if (creditScore == null) creditScore = 100;
        userService.adminUpdateUser(userId, role, status, adoptStatus, creditScore);
        return "redirect:/admin/user/list";
    }

    /** 删除用户(禁止删除root) */
    @GetMapping("/delete/{userId}")
    public String delete(@PathVariable Integer userId, HttpSession session) {
        User current = (User) session.getAttribute("loginUser");
        // 不允许删除自己
        if (current != null && current.getUserId().equals(userId)) {
            return "redirect:/admin/user/list?error=不能删除当前登录账号";
        }
        userService.deleteUser(userId);
        return "redirect:/admin/user/list";
    }

    /** 管理员列表(仅root) */
    @GetMapping("/admins")
    public String admins(Model model, HttpSession session) {
        User current = (User) session.getAttribute("loginUser");
        boolean isRoot = current != null && current.getRole() == 9;
        model.addAttribute("isRoot", isRoot);
        model.addAttribute("admins", userService.listAdmins());
        return "admin/admin_list";
    }

    /** 新增管理员(仅root) */
    @PostMapping("/admin/add")
    public String addAdmin(String username, String password, String nickname, String realName,
                           HttpSession session, Model model) {
        User current = (User) session.getAttribute("loginUser");
        if (current == null || current.getRole() != 9) {
            return "redirect:/admin/user/admins";
        }
        String error = userService.addAdmin(username, password, nickname, realName);
        if (error != null) {
            model.addAttribute("error", error);
            model.addAttribute("admins", userService.listAdmins());
            model.addAttribute("isRoot", true);
            return "admin/admin_list";
        }
        return "redirect:/admin/user/admins";
    }
}
