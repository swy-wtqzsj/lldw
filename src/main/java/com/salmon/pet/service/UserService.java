package com.salmon.pet.service;

import com.salmon.pet.entity.User;

import java.util.List;

public interface UserService {

    String register(String username, String password, String confirmPassword, String phone);
    User login(String username, String password);
    User getById(Integer userId);
    boolean updateInfo(User user);
    String changePassword(Integer userId, String oldPassword, String newPassword, String confirmPassword);

    // 本地第五批
    List<User> getAdminList(String keyword);
    boolean updateStatus(Integer userId, Integer status);

    // A组
    String cancelAccount(Integer userId, String password);
    String resetPassword(String username, String email, String newPassword, String confirmPassword);
    List<User> listUsers(String keyword, Integer role);
    boolean adminUpdateUser(Integer userId, Integer role, Integer status, Integer adoptStatus, Integer creditScore);
    boolean deleteUser(Integer userId);
    String addAdmin(String username, String password, String nickname, String realName);
    List<User> listAdmins();
    int countUsers();
}
