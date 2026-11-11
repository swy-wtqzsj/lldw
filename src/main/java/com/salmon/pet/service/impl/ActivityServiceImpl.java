package com.salmon.pet.service.impl;

import com.salmon.pet.entity.Activity;
import com.salmon.pet.mapper.ActivityMapper;
import com.salmon.pet.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    @Override
    public List<Activity> getPublicList() {
        List<Activity> list = activityMapper.selectPublicList();
        for (Activity a : list) {
            a.setSignupCount(activityMapper.selectSignupCount(a.getActivityId()));
        }
        return list;
    }

    @Override
    public Activity getById(Integer activityId) {
        Activity a = activityMapper.selectById(activityId);
        if (a != null) {
            a.setSignupCount(activityMapper.selectSignupCount(activityId));
        }
        return a;
    }

    @Override
    public boolean signup(Integer activityId, Integer userId) {
        return activityMapper.insertSignup(activityId, userId) > 0;
    }

    @Override
    public boolean cancelSignup(Integer activityId, Integer userId) {
        return activityMapper.cancelSignup(activityId, userId) > 0;
    }

    @Override
    public List<Activity> getMySignupList(Integer userId) {
        return activityMapper.selectMySignupList(userId);
    }

    @Override
    public List<Activity> getAdminList(Integer status) {
        return activityMapper.selectAdminList(status);
    }

    @Override
    public boolean save(Activity activity) {
        if (activity.getActivityId() == null) {
            return activityMapper.insertActivity(activity) > 0;
        } else {
            return activityMapper.updateActivity(activity) > 0;
        }
    }
}
