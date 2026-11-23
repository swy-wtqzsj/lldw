package com.salmon.pet.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 志愿签到 / 工时记录实体（C 组，对应表 volunteer_sign）
 * 状态 status:        1 已签到 2 已签退 3 已作废
 * 审核 auditStatus:   1 待审核 2 已通过 3 已驳回
 * 服务 serviceType:   1 活动服务 2 日常照护 3 物资整理 4 其他
 */
public class VolunteerSign {

    private Integer signId;
    private Integer userId;
    private Integer activityId;
    private Date signDate;
    private Date signInTime;
    private Date signOutTime;
    private BigDecimal workHours;
    private Integer serviceType;
    private String content;
    private Integer status;
    private Integer auditStatus;
    private String auditRemark;
    private Date createTime;

    // 关联字段（列表展示用，不入库）
    private String username;
    private String nickname;
    private String activityTitle;

    public Integer getSignId() { return signId; }
    public void setSignId(Integer signId) { this.signId = signId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getActivityId() { return activityId; }
    public void setActivityId(Integer activityId) { this.activityId = activityId; }
    public Date getSignDate() { return signDate; }
    public void setSignDate(Date signDate) { this.signDate = signDate; }
    public Date getSignInTime() { return signInTime; }
    public void setSignInTime(Date signInTime) { this.signInTime = signInTime; }
    public Date getSignOutTime() { return signOutTime; }
    public void setSignOutTime(Date signOutTime) { this.signOutTime = signOutTime; }
    public BigDecimal getWorkHours() { return workHours; }
    public void setWorkHours(BigDecimal workHours) { this.workHours = workHours; }
    public Integer getServiceType() { return serviceType; }
    public void setServiceType(Integer serviceType) { this.serviceType = serviceType; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Integer getAuditStatus() { return auditStatus; }
    public void setAuditStatus(Integer auditStatus) { this.auditStatus = auditStatus; }
    public String getAuditRemark() { return auditRemark; }
    public void setAuditRemark(String auditRemark) { this.auditRemark = auditRemark; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
    public String getActivityTitle() { return activityTitle; }
    public void setActivityTitle(String activityTitle) { this.activityTitle = activityTitle; }

    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 1: return "服务中";
            case 2: return "已签退";
            case 3: return "已作废";
            default: return "";
        }
    }

    public String getAuditStatusText() {
        if (auditStatus == null) return "";
        switch (auditStatus) {
            case 1: return "待审核";
            case 2: return "已通过";
            case 3: return "已驳回";
            default: return "";
        }
    }

    public String getServiceTypeText() {
        if (serviceType == null) return "";
        switch (serviceType) {
            case 1: return "活动服务";
            case 2: return "日常照护";
            case 3: return "物资整理";
            case 4: return "其他";
            default: return "";
        }
    }
}
