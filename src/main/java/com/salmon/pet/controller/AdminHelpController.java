package com.salmon.pet.controller;

import com.salmon.pet.service.CommentService;
import com.salmon.pet.service.HelpRequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 后台求助管理控制器
 */
@Controller
@RequestMapping("/admin/help")
public class AdminHelpController {

    @Autowired
    private HelpRequestService helpRequestService;

    @Autowired
    private CommentService commentService;

    /**
     * 求助列表
     */
    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer auditStatus, Model model) {
        model.addAttribute("list", helpRequestService.getAdminList(auditStatus));
        model.addAttribute("auditStatus", auditStatus);
        return "admin/help_list";
    }

    /**
     * 审核求助
     */
    @RequestMapping("/audit")
    public String audit(Integer helpId, Integer auditStatus, String auditOpinion) {
        helpRequestService.audit(helpId, auditStatus, auditOpinion);
        return "redirect:/admin/help/list";
    }

    /**
     * 更新处理状态
     */
    @RequestMapping("/status")
    public String updateStatus(Integer helpId, Integer handleStatus) {
        helpRequestService.updateHandleStatus(helpId, handleStatus);
        return "redirect:/admin/help/list";
    }

    /**
     * 评论管理列表
     */
    @RequestMapping("/comments")
    public String commentList(Model model) {
        model.addAttribute("list", commentService.getAllList());
        return "admin/comment_list";
    }

    /**
     * 删除评论
     */
    @RequestMapping("/comment_delete")
    public String deleteComment(Integer commentId) {
        commentService.deleteComment(commentId);
        return "redirect:/admin/help/comments";
    }
}
