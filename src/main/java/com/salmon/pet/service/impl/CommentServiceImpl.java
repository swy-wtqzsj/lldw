package com.salmon.pet.service.impl;

import com.salmon.pet.entity.Comment;
import com.salmon.pet.mapper.CommentMapper;
import com.salmon.pet.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 评论 Service 实现类
 */
@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Override
    public boolean addComment(Comment comment) {
        return commentMapper.insertComment(comment) > 0;
    }

    @Override
    public List<Comment> getListByTarget(Integer targetType, Integer targetId) {
        return commentMapper.selectListByTarget(targetType, targetId);
    }

    @Override
    public List<Comment> getAllList() {
        return commentMapper.selectAllList();
    }

    @Override
    public boolean deleteComment(Integer commentId) {
        return commentMapper.deleteComment(commentId) > 0;
    }

    @Override
    public boolean updateStatus(Integer commentId, Integer status) {
        return commentMapper.updateStatus(commentId, status) > 0;
    }
}
