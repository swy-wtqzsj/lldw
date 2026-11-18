package com.salmon.pet.entity;

import java.util.Date;

/**
 * 举报记录实体类
 */
public class Report {
    private Integer reportId;        // 举报ID
    private Integer reporterId;      // 举报人ID
    private Integer targetType;      // 被举报对象类型:1评论2求助3用户4活动
    private Integer targetId;        // 被举报对象ID
    private String reason;           // 举报原因
    private String evidence;         // 证据截图
    private Integer status;          // 状态:1待处理2已成立3不成立
    private Date reportTime;         // 举报时间
    private Integer handleAdmin;     // 处理管理员ID
    private Date handleTime;         // 处理时间
    private String handleOpinion;    // 处理意见

    // 关联字段
    private String reporterName;     // 举报人账号
    private String handlerName;      // 处理管理员账号

    // Getter and Setter
    public Integer getReportId() { return reportId; }
    public void setReportId(Integer reportId) { this.reportId = reportId; }
    public Integer getReporterId() { return reporterId; }
    public void setReporterId(Integer reporterId) { this.reporterId = reporterId; }
    public Integer getTargetType() { return targetType; }
    public void setTargetType(Integer targetType) { this.targetType = targetType; }
    public Integer getTargetId() { return targetId; }
    public void setTargetId(Integer targetId) { this.targetId = targetId; }
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
    public String getEvidence() { return evidence; }
    public void setEvidence(String evidence) { this.evidence = evidence; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getReportTime() { return reportTime; }
    public void setReportTime(Date reportTime) { this.reportTime = reportTime; }
    public Integer getHandleAdmin() { return handleAdmin; }
    public void setHandleAdmin(Integer handleAdmin) { this.handleAdmin = handleAdmin; }
    public Date getHandleTime() { return handleTime; }
    public void setHandleTime(Date handleTime) { this.handleTime = handleTime; }
    public String getHandleOpinion() { return handleOpinion; }
    public void setHandleOpinion(String handleOpinion) { this.handleOpinion = handleOpinion; }
    public String getReporterName() { return reporterName; }
    public void setReporterName(String reporterName) { this.reporterName = reporterName; }
    public String getHandlerName() { return handlerName; }
    public void setHandlerName(String handlerName) { this.handlerName = handlerName; }

    // 辅助方法
    public String getTargetTypeText() {
        if (targetType == null) return "";
        switch (targetType) {
            case 1: return "评论";
            case 2: return "求助";
            case 3: return "用户";
            case 4: return "活动";
            default: return "";
        }
    }

    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 1: return "待处理";
            case 2: return "已成立";
            case 3: return "不成立";
            default: return "";
        }
    }
}
