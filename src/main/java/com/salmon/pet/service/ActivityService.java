package com.salmon.pet.service;

import com.salmon.pet.entity.Activity;

import java.util.List;

/**
 * 活动 Service 接口
 */
public interface ActivityService {

    List<Activity> getPublicList();

    Activity getById(Integer activityId);

    boolean signup(Integer activityId, Integer userId);

    boolean cancelSignup(Integer activityId, Integer userId);

    List<Activity> getMySignupList(Integer userId);

    List<Activity> getAdminList(Integer status);

    boolean save(Activity activity);
}
