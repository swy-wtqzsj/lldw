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
 * 后台用户与管理员管理控制器（合并版）
 */
@Controller
@RequestMapping("/admin/user")
public class AdminUserController {

    @Autowired
    private UserService userService;

    /** 用户列表（支持关键词与角色筛选） */
    @GetMapping("/list")
    public String list(@RequestParam(required = false) String keyword,
                       @RequestParam(required = false) Integer role,
                       Model model) {
        List<User> users = userService.listUsers(keyword, role);
        model.addAttribute("users", users);
        model.addAttribute("list", users);
        model.addAttribute("keyword", keyword);
        model.addAttribute("role", role);
        return "admin/user_list";
    }

    /** 启用/禁用用户（保留本地安全校验） */
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

    /** 更新用户角色/状态/领养资格/信用分（A组） */
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

    /** 删除用户，禁止删除自己（A组） */
    @GetMapping("/delete/{userId}")
    public String delete(@PathVariable Integer userId, HttpSession session) {
        User current = (User) session.getAttribute("loginUser");
        if (current != null && current.getUserId().equals(userId)) {
            return "redirect:/admin/user/list?error=不能删除当前登录账号";
        }
        userService.deleteUser(userId);
        return "redirect:/admin/user/list";
    }

    /** 管理员列表，仅 root（A组） */
    @GetMapping("/admins")
    public String admins(Model model, HttpSession session) {
        User current = (User) session.getAttribute("loginUser");
        boolean isRoot = current != null && current.getRole() == 9;
        model.addAttribute("isRoot", isRoot);
        model.addAttribute("admins", userService.listAdmins());
        return "admin/admin_list";
    }

    /** 新增管理员，仅 root（A组） */
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
