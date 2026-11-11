package com.salmon.pet.entity;

import java.util.Date;

/**
 * 活动报名表实体类
 */
public class ActivitySignup {
    private Integer signupId;         // 报名ID
    private Integer activityId;       // 活动ID
    private Integer userId;           // 用户ID
    private Date signupTime;          // 报名时间
    private Date checkinTime;         // 签到时间
    private Date checkoutTime;        // 签退时间
    private Integer status;           // 状态:1已报名2已参加3已取消

    // 关联字段
    private String username;          // 报名人用户名
    private String activityTitle;     // 活动标题

    // Getter and Setter
    public Integer getSignupId() { return signupId; }
    public void setSignupId(Integer signupId) { this.signupId = signupId; }
    public Integer getActivityId() { return activityId; }
    public void setActivityId(Integer activityId) { this.activityId = activityId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Date getSignupTime() { return signupTime; }
    public void setSignupTime(Date signupTime) { this.signupTime = signupTime; }
    public Date getCheckinTime() { return checkinTime; }
    public void setCheckinTime(Date checkinTime) { this.checkinTime = checkinTime; }
    public Date getCheckoutTime() { return checkoutTime; }
    public void setCheckoutTime(Date checkoutTime) { this.checkoutTime = checkoutTime; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getActivityTitle() { return activityTitle; }
    public void setActivityTitle(String activityTitle) { this.activityTitle = activityTitle; }

    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 1: return "已报名";
            case 2: return "已参加";
            case 3: return "已取消";
            default: return "";
        }
    }
}
