package com.salmon.pet.controller;

import com.salmon.pet.entity.User;
import com.salmon.pet.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    // ========== 登录 ==========
    @GetMapping("/login")
    public String loginPage() {
        return "user/login";
    }

    @PostMapping("/login")
    public String doLogin(String username, String password, HttpSession session, Model model) {
        User user = userService.login(username, password);
        if (user == null) {
            model.addAttribute("error", "账号或密码错误");
            model.addAttribute("username", username);
            return "user/login";
        }
        session.setAttribute("loginUser", user);
        // 管理员跳后台，普通用户跳首页
        if (user.getRole() == 3 || user.getRole() == 9) {
            return "redirect:/admin/dashboard";
        }
        return "redirect:/";
    }

    // ========== 注册 ==========
    @GetMapping("/register")
    public String registerPage() {
        return "user/register";
    }

    @PostMapping("/register")
    public String doRegister(String username, String password, String confirmPassword, String phone, Model model) {
        String error = userService.register(username, password, confirmPassword, phone);
        if (error != null) {
            model.addAttribute("error", error);
            model.addAttribute("username", username);
            model.addAttribute("phone", phone);
            return "user/register";
        }
        return "redirect:/login";
    }

    // ========== 退出 ==========
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    // ========== 个人中心 ==========
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";
        // 从数据库重新查最新数据
        User dbUser = userService.getById(user.getUserId());
        model.addAttribute("user", dbUser);
        return "user/profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(String nickname, String phone, String email, String address, HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";

        User update = new User();
        update.setUserId(loginUser.getUserId());
        update.setNickname(nickname);
        update.setPhone(phone);
        update.setEmail(email);
        update.setAddress(address);
        userService.updateInfo(update);

        // 更新 session 中的用户
        User fresh = userService.getById(loginUser.getUserId());
        session.setAttribute("loginUser", fresh);
        model.addAttribute("user", fresh);
        model.addAttribute("msg", "修改成功");
        return "user/profile";
    }

    // ========== 修改密码 ==========
    @GetMapping("/password")
    public String passwordPage(HttpSession session) {
        if (session.getAttribute("loginUser") == null) return "redirect:/login";
        return "user/password";
    }

    @PostMapping("/password/change")
    public String changePassword(String oldPassword, String newPassword, String confirmPassword,
                                 HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";

        String error = userService.changePassword(loginUser.getUserId(), oldPassword, newPassword, confirmPassword);
        if (error != null) {
            model.addAttribute("error", error);
            return "user/password";
        }
        // 修改成功后强制重新登录
        session.invalidate();
        return "redirect:/login";
    }
}
