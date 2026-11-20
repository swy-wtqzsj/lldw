package com.salmon.pet.service.impl;

import com.salmon.pet.entity.Message;
import com.salmon.pet.mapper.MessageMapper;
import com.salmon.pet.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {

    @Autowired
    private MessageMapper messageMapper;

    @Override
    public List<Message> listMyMessages(Integer userId, Integer isRead) {
        return messageMapper.selectByReceiver(userId, isRead);
    }

    @Override
    public int countUnread(Integer userId) {
        return messageMapper.countUnread(userId);
    }

    @Override
    public void markRead(Integer messageId, Integer userId) {
        messageMapper.markRead(messageId, userId);
    }

    @Override
    public void markAllRead(Integer userId) {
        messageMapper.markAllRead(userId);
    }

    @Override
    public void send(Integer receiverId, Integer senderType, Integer senderId, String title, String content) {
        Message m = new Message();
        m.setReceiverId(receiverId);
        m.setSenderType(senderType);
        m.setSenderId(senderId);
        m.setTitle(title);
        m.setContent(content);
        messageMapper.insert(m);
    }
}
