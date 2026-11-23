package com.salmon.pet.controller;

import com.google.code.kaptcha.Constants;
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

    /** 登录失败锁定参数：连续失败 5 次锁定 15 分钟（按 session 计数） */
    private static final int LOGIN_MAX_FAIL = 5;
    private static final long LOGIN_LOCK_MS = 15L * 60 * 1000;
    private static final String LOGIN_FAIL_COUNT = "loginFailCount";
    private static final String LOGIN_LOCK_UNTIL = "loginLockUntil";

    @PostMapping("/login")
    public String doLogin(String username, String password, HttpSession session, Model model) {
        // 锁定检查：锁定期内直接拒绝，避免暴力破解
        Long lockUntil = (Long) session.getAttribute(LOGIN_LOCK_UNTIL);
        if (lockUntil != null && lockUntil > System.currentTimeMillis()) {
            long minutes = (lockUntil - System.currentTimeMillis()) / 60000 + 1;
            model.addAttribute("error", "登录失败次数过多，账号已临时锁定，请 " + minutes + " 分钟后再试");
            model.addAttribute("username", username);
            return "user/login";
        }
        // 锁定已过期，重置计数
        if (lockUntil != null) {
            session.removeAttribute(LOGIN_LOCK_UNTIL);
            session.removeAttribute(LOGIN_FAIL_COUNT);
        }

        User user = userService.login(username, password);
        if (user == null) {
            Integer failCount = (Integer) session.getAttribute(LOGIN_FAIL_COUNT);
            int count = (failCount == null ? 0 : failCount) + 1;
            session.setAttribute(LOGIN_FAIL_COUNT, count);
            if (count >= LOGIN_MAX_FAIL) {
                session.setAttribute(LOGIN_LOCK_UNTIL, System.currentTimeMillis() + LOGIN_LOCK_MS);
                model.addAttribute("error", "连续 " + count + " 次登录失败，账号已锁定 15 分钟");
            } else {
                model.addAttribute("error", "账号或密码错误（还可尝试 " + (LOGIN_MAX_FAIL - count) + " 次）");
            }
            model.addAttribute("username", username);
            return "user/login";
        }
        // 登录成功，清除失败计数
        session.removeAttribute(LOGIN_FAIL_COUNT);
        session.removeAttribute(LOGIN_LOCK_UNTIL);
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

    // ========== A组：找回密码 ==========
    @GetMapping("/forgot")
    public String forgotPage() {
        return "user/forgot";
    }

    @PostMapping("/forgot/reset")
    public String resetPassword(String username, String email, String newPassword,
                                String confirmPassword, String captcha,
                                HttpSession session, Model model) {
        // 图形验证码校验：一次性使用，取出后立即销毁，防止重放
        String expected = (String) session.getAttribute(Constants.KAPTCHA_SESSION_KEY);
        session.removeAttribute(Constants.KAPTCHA_SESSION_KEY);
        if (expected == null || captcha == null || !expected.equalsIgnoreCase(captcha.trim())) {
            model.addAttribute("error", "验证码错误或已失效，请重新输入");
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "user/forgot";
        }
        String error = userService.resetPassword(username, email, newPassword, confirmPassword);
        if (error != null) {
            model.addAttribute("error", error);
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "user/forgot";
        }
        model.addAttribute("msg", "密码重置成功，请重新登录");
        return "redirect:/login";
    }

    // ========== A组：注销账号 ==========
    @PostMapping("/profile/cancel")
    public String cancelAccount(String password, HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        String error = userService.cancelAccount(loginUser.getUserId(), password);
        if (error != null) {
            model.addAttribute("error", error);
            User dbUser = userService.getById(loginUser.getUserId());
            model.addAttribute("user", dbUser);
            return "user/profile";
        }
        session.invalidate();
        return "redirect:/login";
    }
}
