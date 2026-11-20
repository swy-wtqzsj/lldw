package com.salmon.pet.entity;

import java.util.Date;

/**
 * 举报记录实体 (A组)
 * 对应表 report_record，PET-1.9 / PET-2.11
 */
public class ReportRecord {
    private Integer reportId;
    private Integer reporterId;
    private Integer targetType;     // 1用户 2宠物 3求助 4评论 5活动
    private Integer targetId;
    private String reason;
    private String description;
    private String evidence;
    private Integer status;         // 1待处理 2已处理 3已驳回
    private String handleResult;
    private Integer adminId;
    private Date reportTime;
    private Date handleTime;

    // 关联查询字段(非表字段)
    private String reporterName;

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
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getEvidence() { return evidence; }
    public void setEvidence(String evidence) { this.evidence = evidence; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getHandleResult() { return handleResult; }
    public void setHandleResult(String handleResult) { this.handleResult = handleResult; }
    public Integer getAdminId() { return adminId; }
    public void setAdminId(Integer adminId) { this.adminId = adminId; }
    public Date getReportTime() { return reportTime; }
    public void setReportTime(Date reportTime) { this.reportTime = reportTime; }
    public Date getHandleTime() { return handleTime; }
    public void setHandleTime(Date handleTime) { this.handleTime = handleTime; }
    public String getReporterName() { return reporterName; }
    public void setReporterName(String reporterName) { this.reporterName = reporterName; }

    /** 目标类型中文名(JSP展示用) */
    public String getTargetTypeName() {
        if (targetType == null) return "";
        switch (targetType) {
            case 1: return "用户";
            case 2: return "宠物";
            case 3: return "求助";
            case 4: return "评论";
            case 5: return "活动";
            default: return "其他";
        }
    }

    /** 处理状态中文名 */
    public String getStatusName() {
        if (status == null) return "";
        switch (status) {
            case 1: return "待处理";
            case 2: return "已处理";
            case 3: return "已驳回";
            default: return "未知";
        }
    }
}
