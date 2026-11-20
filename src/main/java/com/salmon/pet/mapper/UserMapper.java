package com.salmon.pet.mapper;

import com.salmon.pet.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户 Mapper（合并版）
 */
public interface UserMapper {

    User selectByUsername(@Param("username") String username);
    User selectByPhone(@Param("phone") String phone);
    int insert(User user);
    User selectById(@Param("userId") Integer userId);
    int updateById(User user);
    int updatePassword(@Param("userId") Integer userId, @Param("password") String password);

    // 本地第五批
    List<User> selectAdminList(@Param("keyword") String keyword);
    int updateStatus(@Param("userId") Integer userId, @Param("status") Integer status);
    int updateRole(@Param("userId") Integer userId, @Param("role") Integer role);

    // A组
    List<User> selectUserList(@Param("keyword") String keyword, @Param("role") Integer role);
    User selectByEmail(@Param("email") String email);
    int updateAdmin(@Param("userId") Integer userId,
                    @Param("role") Integer role,
                    @Param("status") Integer status,
                    @Param("adoptStatus") Integer adoptStatus,
                    @Param("creditScore") Integer creditScore);
    int deleteById(@Param("userId") Integer userId);
    int countUsers();
    List<User> selectAdmins();
    int insertAdmin(User user);
}
