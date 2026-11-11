package com.salmon.pet.service.impl;

import com.salmon.pet.entity.User;
import com.salmon.pet.mapper.UserMapper;
import com.salmon.pet.service.UserService;
import com.salmon.pet.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public String register(String username, String password, String confirmPassword, String phone) {
        // 校验用户名长度
        if (username == null || username.length() < 4 || username.length() > 20) {
            return "用户名长度需4-20位";
        }
        // 两次密码一致
        if (!password.equals(confirmPassword)) {
            return "两次密码输入不一致";
        }
        // 密码格式：6-20位，包含字母和数字
        if (password == null || password.length() < 6 || password.length() > 20) {
            return "密码长度需6-20位";
        }
        // 用户名唯一
        if (userMapper.selectByUsername(username) != null) {
            return "用户名已存在，请更换";
        }
        // 手机号唯一（如果填了）
        if (phone != null && !phone.isEmpty() && userMapper.selectByPhone(phone) != null) {
            return "该手机号已被注册";
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(MD5Utils.md5(password));
        user.setPhone(phone);
        user.setNickname(username);
        user.setRole(1);
        user.setStatus(1);
        user.setAdoptStatus(1);
        user.setCreditScore(100);
        userMapper.insert(user);
        return null; // 成功
    }

    @Override
    public User login(String username, String password) {
        User user = userMapper.selectByUsername(username);
        if (user == null) {
            return null;
        }
        // 校验密码
        if (!user.getPassword().equals(MD5Utils.md5(password))) {
            return null;
        }
        // 账号是否禁用
        if (user.getStatus() == 0) {
            return null;
        }
        return user;
    }

    @Override
    public User getById(Integer userId) {
        return userMapper.selectById(userId);
    }

    @Override
    public boolean updateInfo(User user) {
        return userMapper.updateById(user) > 0;
    }

    @Override
    public String changePassword(Integer userId, String oldPassword, String newPassword, String confirmPassword) {
        User user = userMapper.selectById(userId);
        if (user == null) {
            return "用户不存在";
        }
        // 原密码校验
        if (!user.getPassword().equals(MD5Utils.md5(oldPassword))) {
            return "原密码错误";
        }
        if (!newPassword.equals(confirmPassword)) {
            return "两次新密码不一致";
        }
        if (newPassword.length() < 6 || newPassword.length() > 20) {
            return "新密码长度需6-20位";
        }
        userMapper.updatePassword(userId, MD5Utils.md5(newPassword));
        return null;
    }
}
