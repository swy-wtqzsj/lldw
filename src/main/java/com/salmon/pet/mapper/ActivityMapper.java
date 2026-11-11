package com.salmon.pet.mapper;

import com.salmon.pet.entity.Activity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 活动 Mapper 接口
 */
public interface ActivityMapper {

    /**
     * 查询发布中的活动列表（前台）
     */
    List<Activity> selectPublicList();

    /**
     * 查询活动详情
     */
    Activity selectById(@Param("activityId") Integer activityId);

    /**
     * 查询用户是否已报名
     */
    Integer selectUserSignup(@Param("activityId") Integer activityId,
                             @Param("userId") Integer userId);

    /**
     * 查询活动报名人数
     */
    Integer selectSignupCount(@Param("activityId") Integer activityId);

    /**
     * 报名活动
     */
    int insertSignup(@Param("activityId") Integer activityId,
                     @Param("userId") Integer userId);

    /**
     * 取消报名
     */
    int cancelSignup(@Param("activityId") Integer activityId,
                     @Param("userId") Integer userId);

    /**
     * 查询用户报名的活动列表
     */
    List<Activity> selectMySignupList(@Param("userId") Integer userId);

    /**
     * 后台查询所有活动
     */
    List<Activity> selectAdminList(@Param("status") Integer status);

    /**
     * 新增活动
     */
    int insertActivity(Activity activity);

    /**
     * 更新活动
     */
    int updateActivity(Activity activity);
}
