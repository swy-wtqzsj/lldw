package com.salmon.pet.entity;

import java.util.Date;

/**
 * 处罚记录实体（合并版：基础字段 + A组申诉字段）
 */
public class Punishment {
    private Integer punishId;
    private Integer userId;
    private Integer type;           // 1警告 2禁言 3封禁
    private String reason;
    private Date startTime;
    private Date endTime;
    private Integer status;         // 1生效中 2已解除 3已到期
    private Integer adminId;

    // A组申诉扩展字段
    private Integer appealStatus;   // 0未申诉 1待复核 2申诉通过 3申诉驳回
    private String appealReason;
    private Date appealTime;
    private String appealResult;

    // 关联查询字段
    private String username;
    private String nickname;
    private String adminName;

    public Integer getPunishId() { return punishId; }
    public void setPunishId(Integer punishId) { this.punishId = punishId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getType() { return type; }
    public void setType(Integer type) { this.type = type; }
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
    public Date getStartTime() { return startTime; }
    public void setStartTime(Date startTime) { this.startTime = startTime; }
    public Date getEndTime() { return endTime; }
    public void setEndTime(Date endTime) { this.endTime = endTime; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Integer getAdminId() { return adminId; }
    public void setAdminId(Integer adminId) { this.adminId = adminId; }
    public Integer getAppealStatus() { return appealStatus; }
    public void setAppealStatus(Integer appealStatus) { this.appealStatus = appealStatus; }
    public String getAppealReason() { return appealReason; }
    public void setAppealReason(String appealReason) { this.appealReason = appealReason; }
    public Date getAppealTime() { return appealTime; }
    public void setAppealTime(Date appealTime) { this.appealTime = appealTime; }
    public String getAppealResult() { return appealResult; }
    public void setAppealResult(String appealResult) { this.appealResult = appealResult; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
    public String getAdminName() { return adminName; }
    public void setAdminName(String adminName) { this.adminName = adminName; }

    public String getTypeText() {
        if (type == null) return "";
        switch (type) {
            case 1: return "警告";
            case 2: return "禁言";
            case 3: return "封禁";
            default: return "";
        }
    }

    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 1: return "生效中";
            case 2: return "已解除";
            case 3: return "已到期";
            default: return "";
        }
    }

    public String getTypeName() { return getTypeText(); }
    public String getStatusName() { return getStatusText(); }

    public String getAppealStatusName() {
        if (appealStatus == null || appealStatus == 0) return "未申诉";
        switch (appealStatus) {
            case 1: return "待复核";
            case 2: return "申诉通过";
            case 3: return "申诉驳回";
            default: return "未知";
        }
    }
}
