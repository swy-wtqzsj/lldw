package com.salmon.pet.entity;

import java.util.Date;

/**
 * 志愿者认证实体类
 */
public class VolunteerCert {
    private Integer certId;          // 认证ID
    private Integer userId;          // 用户ID
    private String realName;         // 真实姓名
    private String idCard;           // 身份证号
    private String phone;            // 联系电话
    private String emergencyContact; // 紧急联系人
    private String serviceArea;      // 可服务区域
    private String skillTags;        // 技能标签
    private Integer status;          // 状态:1待认证2已认证3已驳回4已撤销
    private Date applyTime;          // 申请时间
    private Date expireTime;         // 认证到期日
    private Integer auditAdmin;      // 审核管理员ID
    private String auditOpinion;     // 审核意见

    // 关联字段
    private String username;         // 申请人账号
    private String adminName;        // 审核管理员账号

    // Getter and Setter
    public Integer getCertId() { return certId; }
    public void setCertId(Integer certId) { this.certId = certId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public String getRealName() { return realName; }
    public void setRealName(String realName) { this.realName = realName; }
    public String getIdCard() { return idCard; }
    public void setIdCard(String idCard) { this.idCard = idCard; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEmergencyContact() { return emergencyContact; }
    public void setEmergencyContact(String emergencyContact) { this.emergencyContact = emergencyContact; }
    public String getServiceArea() { return serviceArea; }
    public void setServiceArea(String serviceArea) { this.serviceArea = serviceArea; }
    public String getSkillTags() { return skillTags; }
    public void setSkillTags(String skillTags) { this.skillTags = skillTags; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getApplyTime() { return applyTime; }
    public void setApplyTime(Date applyTime) { this.applyTime = applyTime; }
    public Date getExpireTime() { return expireTime; }
    public void setExpireTime(Date expireTime) { this.expireTime = expireTime; }
    public Integer getAuditAdmin() { return auditAdmin; }
    public void setAuditAdmin(Integer auditAdmin) { this.auditAdmin = auditAdmin; }
    public String getAuditOpinion() { return auditOpinion; }
    public void setAuditOpinion(String auditOpinion) { this.auditOpinion = auditOpinion; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getAdminName() { return adminName; }
    public void setAdminName(String adminName) { this.adminName = adminName; }

    // 辅助方法
    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 1: return "待认证";
            case 2: return "已认证";
            case 3: return "已驳回";
            case 4: return "已撤销";
            default: return "";
        }
    }
}
