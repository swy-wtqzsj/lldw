package com.salmon.pet.service;

import com.salmon.pet.entity.Message;

import java.util.List;

/**
 * 消息服务 (A组) - PET-1.14 消息中心
 */
public interface MessageService {

    /** 我的消息列表(isRead传null查全部) */
    List<Message> listMyMessages(Integer userId, Integer isRead);

    /** 未读消息数 */
    int countUnread(Integer userId);

    /** 标记已读 */
    void markRead(Integer messageId, Integer userId);

    /** 全部标记已读 */
    void markAllRead(Integer userId);

    /** 发送消息 */
    void send(Integer receiverId, Integer senderType, Integer senderId, String title, String content);
}
