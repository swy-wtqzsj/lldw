package com.salmon.pet.entity;

import java.util.Date;

/**
 * 评论实体类
 */
public class Comment {
    private Integer commentId;       // 评论ID
    private Integer userId;          // 评论者ID
    private Integer targetType;      // 对象类型:1宠物2活动3知识4求助
    private Integer targetId;        // 对象ID
    private String content;          // 评论内容
    private Date commentTime;        // 评论时间
    private Integer status;          // 状态:1正常0隐藏

    // 关联字段
    private String username;         // 评论者用户名
    private String avatar;           // 评论者头像

    // Getter and Setter
    public Integer getCommentId() { return commentId; }
    public void setCommentId(Integer commentId) { this.commentId = commentId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getTargetType() { return targetType; }
    public void setTargetType(Integer targetType) { this.targetType = targetType; }
    public Integer getTargetId() { return targetId; }
    public void setTargetId(Integer targetId) { this.targetId = targetId; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Date getCommentTime() { return commentTime; }
    public void setCommentTime(Date commentTime) { this.commentTime = commentTime; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }
}
