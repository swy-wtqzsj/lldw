package com.salmon.pet.mapper;

import com.salmon.pet.entity.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {

    /** 根据用户名查询用户（登录用） */
    User selectByUsername(@Param("username") String username);

    /** 根据手机号查询 */
    User selectByPhone(@Param("phone") String phone);

    /** 新增用户（注册用） */
    int insert(User user);

    /** 根据 ID 查询 */
    User selectById(@Param("userId") Integer userId);

    /** 更新用户信息 */
    int updateById(User user);

    /** 更新密码 */
    int updatePassword(@Param("userId") Integer userId, @Param("password") String password);
}
