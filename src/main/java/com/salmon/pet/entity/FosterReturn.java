package com.salmon.pet.entity;

import java.util.Date;

/**
 * 退养申请实体类
 */
public class FosterReturn {
    private Integer returnId;        // 退养ID
    private Integer adoptId;         // 领养记录ID
    private Integer userId;          // 申请用户ID
    private Integer petId;           // 宠物ID
    private String reason;           // 退养原因
    private String description;      // 详细描述
    private String photo;            // 照片
    private Integer status;          // 状态:1待审核2已通过3已拒绝
    private Date applyTime;          // 申请时间
    private Integer auditAdmin;      // 审核管理员
    private String auditOpinion;     // 审核意见
    private Date auditTime;          // 审核时间

    // 关联字段
    private String petName;          // 宠物名
    private String username;         // 申请人

    // Getter and Setter
    public Integer getReturnId() { return returnId; }
    public void setReturnId(Integer returnId) { this.returnId = returnId; }
    public Integer getAdoptId() { return adoptId; }
    public void setAdoptId(Integer adoptId) { this.adoptId = adoptId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getPetId() { return petId; }
    public void setPetId(Integer petId) { this.petId = petId; }
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getPhoto() { return photo; }
    public void setPhoto(String photo) { this.photo = photo; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getApplyTime() { return applyTime; }
    public void setApplyTime(Date applyTime) { this.applyTime = applyTime; }
    public Integer getAuditAdmin() { return auditAdmin; }
    public void setAuditAdmin(Integer auditAdmin) { this.auditAdmin = auditAdmin; }
    public String getAuditOpinion() { return auditOpinion; }
    public void setAuditOpinion(String auditOpinion) { this.auditOpinion = auditOpinion; }
    public Date getAuditTime() { return auditTime; }
    public void setAuditTime(Date auditTime) { this.auditTime = auditTime; }
    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 1: return "待审核";
            case 2: return "已通过";
            case 3: return "已拒绝";
            default: return "";
        }
    }
}
