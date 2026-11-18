package com.salmon.pet.mapper;

import com.salmon.pet.entity.Message;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 消息数据访问 (A组)
 */
public interface MessageMapper {

    /** 我的消息列表 */
    List<Message> selectByReceiver(@Param("receiverId") Integer receiverId,
                                   @Param("isRead") Integer isRead);

    /** 未读消息数 */
    int countUnread(@Param("receiverId") Integer receiverId);

    /** 标记已读 */
    int markRead(@Param("messageId") Integer messageId, @Param("receiverId") Integer receiverId);

    /** 全部标记已读 */
    int markAllRead(@Param("receiverId") Integer receiverId);

    /** 发送消息(系统/管理员用) */
    int insert(Message message);
}
