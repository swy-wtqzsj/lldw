package com.salmon.pet.service;

import com.salmon.pet.entity.Comment;

import java.util.List;

/**
 * 评论 Service 接口
 */
public interface CommentService {

    /**
     * 发表评论
     */
    boolean addComment(Comment comment);

    /**
     * 查询某对象的评论列表
     */
    List<Comment> getListByTarget(Integer targetType, Integer targetId);

    /**
     * 后台查询所有评论
     */
    List<Comment> getAllList();

    /**
     * 删除评论
     */
    boolean deleteComment(Integer commentId);

    /**
     * 隐藏/显示评论
     */
    boolean updateStatus(Integer commentId, Integer status);
}
