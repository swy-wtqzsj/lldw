package com.salmon.pet.interceptor;

import com.salmon.pet.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 登录拦截器：后台 /admin/** 必须登录且角色为管理员
 */
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loginUser");

        // 未登录
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        // 不是管理员/root，禁止访问后台
        if (user.getRole() != 3 && user.getRole() != 9) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        return true;
    }
}
