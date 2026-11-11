package com.salmon.pet.entity;

import java.util.Date;

/**
 * 领养申请实体类
 */
public class Adoption {
    private Integer adoptId;        // 申请ID
    private Integer userId;         // 申请人ID
    private Integer petId;          // 宠物ID
    private String adopterName;     // 领养人姓名
    private String phone;           // 联系电话
    private String economicStatus;  // 经济状况
    private String reason;          // 申请理由
    private Integer status;         // 状态:1待审核2同意3不同意
    private Date applyTime;         // 申请时间
    private String auditOpinion;     // 审核意见
    private Integer auditAdminId;    // 审核管理员ID
    private Date auditTime;         // 审核时间

    // 关联对象（用于联表查询）
    private String username;        // 申请人用户名
    private String petName;         // 宠物名
    private String petPhoto;        // 宠物照片
    private Integer petSpecies;     // 宠物种类
    private String petBreed;        // 宠物品种

    // Getter and Setter
    public Integer getAdoptId() { return adoptId; }
    public void setAdoptId(Integer adoptId) { this.adoptId = adoptId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getPetId() { return petId; }
    public void setPetId(Integer petId) { this.petId = petId; }
    public String getAdopterName() { return adopterName; }
    public void setAdopterName(String adopterName) { this.adopterName = adopterName; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEconomicStatus() { return economicStatus; }
    public void setEconomicStatus(String economicStatus) { this.economicStatus = economicStatus; }
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getApplyTime() { return applyTime; }
    public void setApplyTime(Date applyTime) { this.applyTime = applyTime; }
    public String getAuditOpinion() { return auditOpinion; }
    public void setAuditOpinion(String auditOpinion) { this.auditOpinion = auditOpinion; }
    public Integer getAuditAdminId() { return auditAdminId; }
    public void setAuditAdminId(Integer auditAdminId) { this.auditAdminId = auditAdminId; }
    public Date getAuditTime() { return auditTime; }
    public void setAuditTime(Date auditTime) { this.auditTime = auditTime; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }
    public String getPetPhoto() { return petPhoto; }
    public void setPetPhoto(String petPhoto) { this.petPhoto = petPhoto; }
    public Integer getPetSpecies() { return petSpecies; }
    public void setPetSpecies(Integer petSpecies) { this.petSpecies = petSpecies; }
    public String getPetBreed() { return petBreed; }
    public void setPetBreed(String petBreed) { this.petBreed = petBreed; }

    // 辅助方法
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
