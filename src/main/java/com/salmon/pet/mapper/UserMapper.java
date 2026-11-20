package com.salmon.pet.mapper;

import com.salmon.pet.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

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

    // ==================== A组新增：后台用户管理 ====================

    /** 后台用户列表(支持按用户名/角色模糊查询) */
    List<User> selectUserList(@Param("keyword") String keyword, @Param("role") Integer role);

    /** 根据邮箱查询 */
    User selectByEmail(@Param("email") String email);

    /** 后台更新用户(角色/状态/领养资格/信用分) */
    int updateAdmin(@Param("userId") Integer userId,
                    @Param("role") Integer role,
                    @Param("status") Integer status,
                    @Param("adoptStatus") Integer adoptStatus,
                    @Param("creditScore") Integer creditScore);

    /** 删除用户 */
    int deleteById(@Param("userId") Integer userId);

    /** 统计用户数 */
    int countUsers();

    /** 查询所有管理员(role>=3) */
    List<User> selectAdmins();

    /** 新增管理员 */
    int insertAdmin(User user);
}
