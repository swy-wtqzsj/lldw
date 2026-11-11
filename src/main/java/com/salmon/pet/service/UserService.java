package com.salmon.pet.service;

import com.salmon.pet.entity.User;

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
}
