package com.salmon.pet.entity;

import java.util.Date;

/**
 * 志愿者认证实体 (A组)
 * 对应表 volunteer，PET-1.11 / PET-2.9
 */
public class Volunteer {
    private Integer volunteerId;
    private Integer userId;
    private String realName;
    private String idCard;
    private String phone;
    private String orgName;
    private Integer certType;       // 1个人实名 2团队/机构
    private String certFile;
    private String intro;
    private Integer workHours;
    private Integer points;
    private Integer level;
    private Integer auditStatus;    // 1待审核 2已通过 3已拒绝
    private String auditOpinion;
    private Integer auditAdminId;
    private Date applyTime;
    private Date auditTime;

    // 关联查询字段(非表字段)
    private String username;
    private String nickname;

    public Integer getVolunteerId() { return volunteerId; }
    public void setVolunteerId(Integer volunteerId) { this.volunteerId = volunteerId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public String getRealName() { return realName; }
    public void setRealName(String realName) { this.realName = realName; }
    public String getIdCard() { return idCard; }
    public void setIdCard(String idCard) { this.idCard = idCard; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getOrgName() { return orgName; }
    public void setOrgName(String orgName) { this.orgName = orgName; }
    public Integer getCertType() { return certType; }
    public void setCertType(Integer certType) { this.certType = certType; }
    public String getCertFile() { return certFile; }
    public void setCertFile(String certFile) { this.certFile = certFile; }
    public String getIntro() { return intro; }
    public void setIntro(String intro) { this.intro = intro; }
    public Integer getWorkHours() { return workHours; }
    public void setWorkHours(Integer workHours) { this.workHours = workHours; }
    public Integer getPoints() { return points; }
    public void setPoints(Integer points) { this.points = points; }
    public Integer getLevel() { return level; }
    public void setLevel(Integer level) { this.level = level; }
    public Integer getAuditStatus() { return auditStatus; }
    public void setAuditStatus(Integer auditStatus) { this.auditStatus = auditStatus; }
    public String getAuditOpinion() { return auditOpinion; }
    public void setAuditOpinion(String auditOpinion) { this.auditOpinion = auditOpinion; }
    public Integer getAuditAdminId() { return auditAdminId; }
    public void setAuditAdminId(Integer auditAdminId) { this.auditAdminId = auditAdminId; }
    public Date getApplyTime() { return applyTime; }
    public void setApplyTime(Date applyTime) { this.applyTime = applyTime; }
    public Date getAuditTime() { return auditTime; }
    public void setAuditTime(Date auditTime) { this.auditTime = auditTime; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
}
