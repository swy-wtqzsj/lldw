package com.salmon.pet.entity;

import java.util.Date;

/**
 * 处罚申诉实体类
 */
public class Appeal {
    private Integer appealId;        // 申诉ID
    private Integer punishId;        // 关联处罚ID
    private Integer userId;          // 申诉人ID
    private String content;          // 申诉说明
    private String evidence;         // 佐证材料
    private Integer status;          // 状态:1待复核2维持3减轻4解除
    private Date appealTime;         // 申诉时间
    private Integer reviewAdmin;     // 复核管理员ID
    private String reviewOpinion;    // 复核意见
    private Date reviewTime;         // 复核时间

    // 关联字段
    private String username;         // 申诉人账号
    private String adminName;        // 复核管理员账号
    private Integer punishType;      // 处罚类型
    private String punishReason;     // 处罚原因

    // Getter and Setter
    public Integer getAppealId() { return appealId; }
    public void setAppealId(Integer appealId) { this.appealId = appealId; }
    public Integer getPunishId() { return punishId; }
    public void setPunishId(Integer punishId) { this.punishId = punishId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getEvidence() { return evidence; }
    public void setEvidence(String evidence) { this.evidence = evidence; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getAppealTime() { return appealTime; }
    public void setAppealTime(Date appealTime) { this.appealTime = appealTime; }
    public Integer getReviewAdmin() { return reviewAdmin; }
    public void setReviewAdmin(Integer reviewAdmin) { this.reviewAdmin = reviewAdmin; }
    public String getReviewOpinion() { return reviewOpinion; }
    public void setReviewOpinion(String reviewOpinion) { this.reviewOpinion = reviewOpinion; }
    public Date getReviewTime() { return reviewTime; }
    public void setReviewTime(Date reviewTime) { this.reviewTime = reviewTime; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getAdminName() { return adminName; }
    public void setAdminName(String adminName) { this.adminName = adminName; }
    public Integer getPunishType() { return punishType; }
    public void setPunishType(Integer punishType) { this.punishType = punishType; }
    public String getPunishReason() { return punishReason; }
    public void setPunishReason(String punishReason) { this.punishReason = punishReason; }

    // 辅助方法
    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 1: return "待复核";
            case 2: return "维持原处罚";
            case 3: return "减轻处罚";
            case 4: return "解除处罚";
            default: return "";
        }
    }

    public String getPunishTypeText() {
        if (punishType == null) return "";
        switch (punishType) {
            case 1: return "警告";
            case 2: return "禁言";
            case 3: return "封禁";
            default: return "";
        }
    }
}
