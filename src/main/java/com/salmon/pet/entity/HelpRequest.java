package com.salmon.pet.entity;

import java.util.Date;

/**
 * 求助信息实体类
 */
public class HelpRequest {
    private Integer helpId;          // 求助ID
    private Integer userId;         // 求助者ID
    private String title;            // 求助标题
    private Integer type;           // 类型:1发现流浪动物2动物受伤3寻找失主4其他
    private String content;          // 求助内容
    private String location;        // 位置信息
    private String contact;          // 联系方式
    private String photo;            // 照片路径
    private Date publishTime;        // 发布时间
    private Integer auditStatus;     // 审核状态:1待审核2已通过3已拒绝
    private Integer handleStatus;    // 处理状态:1待响应2已响应3处理中4已完成5已关闭
    private String auditOpinion;     // 审核意见

    // 关联字段
    private String username;         // 求助者用户名

    // Getter and Setter
    public Integer getHelpId() { return helpId; }
    public void setHelpId(Integer helpId) { this.helpId = helpId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public Integer getType() { return type; }
    public void setType(Integer type) { this.type = type; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
    public String getPhoto() { return photo; }
    public void setPhoto(String photo) { this.photo = photo; }
    public Date getPublishTime() { return publishTime; }
    public void setPublishTime(Date publishTime) { this.publishTime = publishTime; }
    public Integer getAuditStatus() { return auditStatus; }
    public void setAuditStatus(Integer auditStatus) { this.auditStatus = auditStatus; }
    public Integer getHandleStatus() { return handleStatus; }
    public void setHandleStatus(Integer handleStatus) { this.handleStatus = handleStatus; }
    public String getAuditOpinion() { return auditOpinion; }
    public void setAuditOpinion(String auditOpinion) { this.auditOpinion = auditOpinion; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    // 辅助方法
    public String getTypeText() {
        if (type == null) return "";
        switch (type) {
            case 1: return "发现流浪动物";
            case 2: return "动物受伤";
            case 3: return "寻找失主";
            case 4: return "其他";
            default: return "";
        }
    }
    public String getAuditStatusText() {
        if (auditStatus == null) return "";
        switch (auditStatus) {
            case 1: return "待审核";
            case 2: return "已通过";
            case 3: return "已拒绝";
            default: return "";
        }
    }
    public String getHandleStatusText() {
        if (handleStatus == null) return "";
        switch (handleStatus) {
            case 1: return "待响应";
            case 2: return "已响应";
            case 3: return "处理中";
            case 4: return "已完成";
            case 5: return "已关闭";
            default: return "";
        }
    }
}
