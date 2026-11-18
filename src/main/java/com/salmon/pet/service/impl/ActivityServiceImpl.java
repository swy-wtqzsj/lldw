package com.salmon.pet.service.impl;

import com.salmon.pet.entity.Activity;
import com.salmon.pet.mapper.ActivityMapper;
import com.salmon.pet.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
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
    public String signup(Integer activityId, Integer userId) {
        Activity activity = activityMapper.selectById(activityId);
        if (activity == null || activity.getStatus() == null || activity.getStatus() != 2) {
            return "活动不存在或未开放报名";
        }
        if (activity.getStartTime() != null && activity.getStartTime().before(new Date())) {
            return "活动已开始，无法报名";
        }
        if (isSignedUp(activityId, userId)) {
            return "你已报名该活动，请勿重复报名";
        }
        int quota = activity.getMaxPeople() == null ? 0 : activity.getMaxPeople();
        if (quota > 0 && activityMapper.selectSignupCount(activityId) >= quota) {
            return "报名人数已满";
        }
        return activityMapper.insertSignup(activityId, userId) > 0 ? null : "报名失败，请稍后重试";
    }

    @Override
    public String cancelSignup(Integer activityId, Integer userId) {
        if (!isSignedUp(activityId, userId)) {
            return "你尚未报名该活动";
        }
        return activityMapper.cancelSignup(activityId, userId) > 0 ? null : "取消失败，请稍后重试";
    }

    @Override
    public boolean isSignedUp(Integer activityId, Integer userId) {
        Integer count = activityMapper.selectUserSignup(activityId, userId);
        return count != null && count > 0;
    }

    @Override
    public List<Activity> getMySignupList(Integer userId) {
        return activityMapper.selectMySignupList(userId);
    }

    @Override
    public List<Activity> getAdminList(Integer status) {
        List<Activity> list = activityMapper.selectAdminList(status);
        for (Activity a : list) {
            a.setSignupCount(activityMapper.selectSignupCount(a.getActivityId()));
        }
        return list;
    }

    @Override
    public boolean save(Activity activity) {
        if (activity.getStatus() == null) {
            activity.setStatus(2);
        }
        if (activity.getActivityId() == null) {
            return activityMapper.insertActivity(activity) > 0;
        } else {
            return activityMapper.updateActivity(activity) > 0;
        }
    }
}
