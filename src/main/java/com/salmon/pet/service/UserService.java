package com.salmon.pet.service;

import com.salmon.pet.entity.User;

import java.util.List;

public interface UserService {

    /** 注册，返回错误信息；成功返回 null */
    String register(String username, String password, String confirmPassword, String phone);

    /** 登录，返回用户对象；失败返回 null */
    User login(String username, String password);

    /** 根据 ID 查询 */
    User getById(Integer userId);

    /** 更新个人信息 */
    boolean updateInfo(User user);

    /** 修改密码，返回错误信息；成功返回 null */
    String changePassword(Integer userId, String oldPassword, String newPassword, String confirmPassword);

    // ==================== A组新增 ====================

    /** 注销账号(转黑名单/禁用)，返回错误信息；成功返回 null */
    String cancelAccount(Integer userId, String password);

    /** 找回密码：校验邮箱，返回错误信息；成功返回 null */
    String resetPassword(String username, String email, String newPassword, String confirmPassword);

    /** 后台用户列表 */
    List<User> listUsers(String keyword, Integer role);

    /** 后台更新用户角色/状态 */
    boolean adminUpdateUser(Integer userId, Integer role, Integer status, Integer adoptStatus, Integer creditScore);

    /** 后台删除用户 */
    boolean deleteUser(Integer userId);

    /** 新增管理员(仅root) */
    String addAdmin(String username, String password, String nickname, String realName);

    /** 管理员列表 */
    List<User> listAdmins();

    /** 统计用户数 */
    int countUsers();
}
