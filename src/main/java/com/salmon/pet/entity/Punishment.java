package com.salmon.pet.entity;

import java.util.Date;

/**
 * 处罚记录实体类
 */
public class Punishment {
    private Integer punishId;        // 处罚ID
    private Integer userId;          // 被处罚用户ID
    private Integer type;            // 类型:1警告2禁言3封禁
    private String reason;           // 处罚原因
    private Date startTime;          // 开始时间
    private Date endTime;            // 结束时间(永久为NULL)
    private Integer status;          // 状态:1生效中2已解除3已到期
    private Integer adminId;         // 操作管理员ID

    // 关联字段
    private String username;         // 被处罚用户账号
    private String nickname;         // 被处罚用户昵称
    private String adminName;        // 操作管理员账号

    // Getter and Setter
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
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
    public String getAdminName() { return adminName; }
    public void setAdminName(String adminName) { this.adminName = adminName; }

    // 辅助方法
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
}
