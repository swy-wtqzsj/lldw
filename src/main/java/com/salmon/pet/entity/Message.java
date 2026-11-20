package com.salmon.pet.entity;

import java.util.Date;

/**
 * 消息实体 (A组) - PET-1.14 消息中心
 * 对应表 message
 */
public class Message {
    private Integer messageId;
    private Integer receiverId;
    private Integer senderType;     // 1系统 2管理员
    private Integer senderId;
    private String title;
    private String content;
    private Date sendTime;
    private Integer isRead;         // 0未读 1已读

    public Integer getMessageId() { return messageId; }
    public void setMessageId(Integer messageId) { this.messageId = messageId; }
    public Integer getReceiverId() { return receiverId; }
    public void setReceiverId(Integer receiverId) { this.receiverId = receiverId; }
    public Integer getSenderType() { return senderType; }
    public void setSenderType(Integer senderType) { this.senderType = senderType; }
    public Integer getSenderId() { return senderId; }
    public void setSenderId(Integer senderId) { this.senderId = senderId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Date getSendTime() { return sendTime; }
    public void setSendTime(Date sendTime) { this.sendTime = sendTime; }
    public Integer getIsRead() { return isRead; }
    public void setIsRead(Integer isRead) { this.isRead = isRead; }

    public String getSenderTypeName() {
        if (senderType == null) return "";
        return senderType == 1 ? "系统" : "管理员";
    }
}
