package com.salmon.pet.entity;

import java.util.Date;

/**
 * 求助响应实体类
 */
public class HelpResponse {
    private Integer respId;          // 响应ID
    private Integer helpId;          // 求助ID
    private Integer responderId;     // 响应者ID
    private String content;          // 响应内容
    private Date respTime;           // 响应时间
    private Integer status;          // 状态:1待沟通2已接受3已完成

    // 关联字段
    private String responderName;    // 响应者账号
    private String helpTitle;        // 求助标题

    // Getter and Setter
    public Integer getRespId() { return respId; }
    public void setRespId(Integer respId) { this.respId = respId; }
    public Integer getHelpId() { return helpId; }
    public void setHelpId(Integer helpId) { this.helpId = helpId; }
    public Integer getResponderId() { return responderId; }
    public void setResponderId(Integer responderId) { this.responderId = responderId; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Date getRespTime() { return respTime; }
    public void setRespTime(Date respTime) { this.respTime = respTime; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getResponderName() { return responderName; }
    public void setResponderName(String responderName) { this.responderName = responderName; }
    public String getHelpTitle() { return helpTitle; }
    public void setHelpTitle(String helpTitle) { this.helpTitle = helpTitle; }

    // 辅助方法
    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 1: return "待沟通";
            case 2: return "已接受";
            case 3: return "已完成";
            default: return "";
        }
    }
}
