package com.salmon.pet.controller;

import com.salmon.pet.entity.Comment;
import com.salmon.pet.entity.User;
import com.salmon.pet.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * 通用评论控制器：宠物/活动/知识/求助
 */
@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @PostMapping("/add")
    public String add(@RequestParam Integer targetType,
                      @RequestParam Integer targetId,
                      @RequestParam String content,
                      HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        if (targetType == null || targetType < 1 || targetType > 4 || targetId == null) {
            return "redirect:/";
        }
        if (content == null || content.trim().isEmpty()) {
            return "redirect:" + targetUrl(targetType, targetId);
        }

        Comment comment = new Comment();
        comment.setUserId(loginUser.getUserId());
        comment.setTargetType(targetType);
        comment.setTargetId(targetId);
        comment.setContent(content.trim().length() > 500 ? content.trim().substring(0, 500) : content.trim());
        commentService.addComment(comment);

        return "redirect:" + targetUrl(targetType, targetId);
    }

    private String targetUrl(Integer targetType, Integer targetId) {
        switch (targetType) {
            case 1:
                return "/pet/detail/" + targetId;
            case 2:
                return "/activity/detail/" + targetId;
            case 3:
                return "/knowledge/detail/" + targetId;
            case 4:
                return "/help/detail/" + targetId;
            default:
                return "/";
        }
    }
}
