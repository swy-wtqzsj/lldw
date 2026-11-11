package com.salmon.pet.mapper;

import com.salmon.pet.entity.Comment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 评论 Mapper 接口
 */
public interface CommentMapper {

    /**
     * 发表评论
     */
    int insertComment(Comment comment);

    /**
     * 查询某对象的评论列表
     */
    List<Comment> selectListByTarget(@Param("targetType") Integer targetType,
                                     @Param("targetId") Integer targetId);

    /**
     * 后台查询所有评论
     */
    List<Comment> selectAllList();

    /**
     * 删除评论
     */
    int deleteComment(@Param("commentId") Integer commentId);

    /**
     * 隐藏/显示评论
     */
    int updateStatus(@Param("commentId") Integer commentId, @Param("status") Integer status);
}
