package com.salmon.pet.entity;

import java.util.Date;

/**
 * 团队认证实体类
 */
public class TeamCert {
    private Integer teamId;          // 团队ID
    private Integer leaderId;        // 负责人用户ID
    private String teamName;         // 机构名称
    private String creditCode;       // 统一社会信用代码
    private String leaderName;       // 负责人姓名
    private String description;      // 机构简介
    private String serviceScope;     // 服务范围
    private Integer status;          // 状态:1待认证2已认证3已驳回4已撤销
    private Date applyTime;          // 申请时间
    private Integer auditAdmin;      // 审核管理员ID

    // 关联字段
    private String username;         // 申请人账号
    private String adminName;        // 审核管理员账号

    // Getter and Setter
    public Integer getTeamId() { return teamId; }
    public void setTeamId(Integer teamId) { this.teamId = teamId; }
    public Integer getLeaderId() { return leaderId; }
    public void setLeaderId(Integer leaderId) { this.leaderId = leaderId; }
    public String getTeamName() { return teamName; }
    public void setTeamName(String teamName) { this.teamName = teamName; }
    public String getCreditCode() { return creditCode; }
    public void setCreditCode(String creditCode) { this.creditCode = creditCode; }
    public String getLeaderName() { return leaderName; }
    public void setLeaderName(String leaderName) { this.leaderName = leaderName; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getServiceScope() { return serviceScope; }
    public void setServiceScope(String serviceScope) { this.serviceScope = serviceScope; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getApplyTime() { return applyTime; }
    public void setApplyTime(Date applyTime) { this.applyTime = applyTime; }
    public Integer getAuditAdmin() { return auditAdmin; }
    public void setAuditAdmin(Integer auditAdmin) { this.auditAdmin = auditAdmin; }
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
