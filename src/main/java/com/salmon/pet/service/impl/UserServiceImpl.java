package com.salmon.pet.service.impl;

import com.salmon.pet.entity.User;
import com.salmon.pet.mapper.UserMapper;
import com.salmon.pet.service.UserService;
import com.salmon.pet.utils.PasswordUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public String register(String username, String password, String confirmPassword, String phone) {
        if (username == null || username.length() < 4 || username.length() > 20) {
            return "用户名长度需4-20位";
        }
        if (!password.equals(confirmPassword)) {
            return "两次密码输入不一致";
        }
        if (password == null || password.length() < 6 || password.length() > 20) {
            return "密码长度需6-20位";
        }
        if (userMapper.selectByUsername(username) != null) {
            return "用户名已存在，请更换";
        }
        if (phone != null && !phone.isEmpty() && userMapper.selectByPhone(phone) != null) {
            return "该手机号已被注册";
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(PasswordUtils.encode(password));
        user.setPhone(phone);
        user.setNickname(username);
        user.setRole(1);
        user.setStatus(1);
        user.setAdoptStatus(1);
        user.setCreditScore(100);
        userMapper.insert(user);
        return null;
    }

    @Override
    public User login(String username, String password) {
        User user = userMapper.selectByUsername(username);
        if (user == null) {
            return null;
        }
        if (!PasswordUtils.matches(password, user.getPassword())) {
            return null;
        }
        if (user.getStatus() == 0) {
            return null;
        }
        // 平滑迁移：旧版无盐 MD5 校验通过后自动升级为 PBKDF2 加盐哈希
        if (PasswordUtils.needsUpgrade(user.getPassword())) {
            String newHash = PasswordUtils.encode(password);
            userMapper.updatePassword(user.getUserId(), newHash);
            user.setPassword(newHash);
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
        if (!PasswordUtils.matches(oldPassword, user.getPassword())) {
            return "原密码错误";
        }
        if (!newPassword.equals(confirmPassword)) {
            return "两次新密码不一致";
        }
        if (newPassword.length() < 6 || newPassword.length() > 20) {
            return "新密码长度需6-20位";
        }
        userMapper.updatePassword(userId, PasswordUtils.encode(newPassword));
        return null;
    }

    // ==================== 本地第五批 ====================

    @Override
    public List<User> getAdminList(String keyword) {
        return userMapper.selectAdminList(keyword);
    }

    @Override
    public boolean updateStatus(Integer userId, Integer status) {
        if (userId == null || status == null || (status != 0 && status != 1)) {
            return false;
        }
        return userMapper.updateStatus(userId, status) > 0;
    }

    // ==================== A组 ====================

    @Override
    public String cancelAccount(Integer userId, String password) {
        User user = userMapper.selectById(userId);
        if (user == null) {
            return "用户不存在";
        }
        if (!PasswordUtils.matches(password, user.getPassword())) {
            return "密码错误，注销失败";
        }
        userMapper.updateAdmin(userId, user.getRole(), 0, 3, user.getCreditScore());
        return null;
    }

    @Override
    public String resetPassword(String username, String email, String newPassword, String confirmPassword) {
        if (username == null || email == null || email.trim().isEmpty()) {
            return "用户名和邮箱不能为空";
        }
        User user = userMapper.selectByUsername(username);
        if (user == null) {
            return "用户名不存在";
        }
        if (user.getEmail() == null || !user.getEmail().equalsIgnoreCase(email.trim())) {
            return "邮箱与账号绑定邮箱不一致";
        }
        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            return "两次新密码不一致";
        }
        if (newPassword.length() < 6 || newPassword.length() > 20) {
            return "新密码长度需6-20位";
        }
        userMapper.updatePassword(user.getUserId(), PasswordUtils.encode(newPassword));
        return null;
    }

    @Override
    public List<User> listUsers(String keyword, Integer role) {
        return userMapper.selectUserList(keyword, role);
    }

    @Override
    public boolean adminUpdateUser(Integer userId, Integer role, Integer status, Integer adoptStatus, Integer creditScore) {
        return userMapper.updateAdmin(userId, role, status, adoptStatus, creditScore) > 0;
    }

    @Override
    public boolean deleteUser(Integer userId) {
        return userMapper.deleteById(userId) > 0;
    }

    @Override
    public String addAdmin(String username, String password, String nickname, String realName) {
        if (username == null || username.length() < 4 || username.length() > 20) {
            return "用户名长度需4-20位";
        }
        if (userMapper.selectByUsername(username) != null) {
            return "用户名已存在";
        }
        if (password == null || password.length() < 6) {
            return "密码长度不能少于6位";
        }
        User admin = new User();
        admin.setUsername(username);
        admin.setPassword(PasswordUtils.encode(password));
        admin.setNickname(nickname != null ? nickname : username);
        admin.setRealName(realName);
        admin.setRole(3);
        userMapper.insertAdmin(admin);
        return null;
    }

    @Override
    public List<User> listAdmins() {
        return userMapper.selectAdmins();
    }

    @Override
    public int countUsers() {
        return userMapper.countUsers();
    }
}
