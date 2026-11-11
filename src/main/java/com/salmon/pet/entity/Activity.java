package com.salmon.pet.entity;

import java.util.Date;

/**
 * 活动实体类
 */
public class Activity {
    private Integer activityId;      // 活动ID
    private String title;            // 活动标题
    private String content;           // 活动内容
    private Date startTime;          // 开始时间
    private Date endTime;            // 结束时间
    private String location;         // 活动地点
    private Integer maxPeople;       // 人数上限
    private String coverImage;       // 封面图
    private Integer status;          // 状态:1草稿2发布中3已结束
    private Date createTime;         // 创建时间

    // 关联字段
    private Integer signupCount;     // 已报名人数
    private Integer userSignup;      // 当前用户是否已报名 0否1是

    // Getter and Setter
    public Integer getActivityId() { return activityId; }
    public void setActivityId(Integer activityId) { this.activityId = activityId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Date getStartTime() { return startTime; }
    public void setStartTime(Date startTime) { this.startTime = startTime; }
    public Date getEndTime() { return endTime; }
    public void setEndTime(Date endTime) { this.endTime = endTime; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public Integer getMaxPeople() { return maxPeople; }
    public void setMaxPeople(Integer maxPeople) { this.maxPeople = maxPeople; }
    public String getCoverImage() { return coverImage; }
    public void setCoverImage(String coverImage) { this.coverImage = coverImage; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Integer getSignupCount() { return signupCount; }
    public void setSignupCount(Integer signupCount) { this.signupCount = signupCount; }
    public Integer getUserSignup() { return userSignup; }
    public void setUserSignup(Integer userSignup) { this.userSignup = userSignup; }

    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 1: return "草稿";
            case 2: return "发布中";
            case 3: return "已结束";
            default: return "";
        }
    }
}
