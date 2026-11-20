package com.salmon.pet.controller;

import com.salmon.pet.entity.Comment;
import com.salmon.pet.entity.HelpRequest;
import com.salmon.pet.entity.HelpResponse;
import com.salmon.pet.entity.User;
import com.salmon.pet.service.CommentService;
import com.salmon.pet.service.HelpRequestService;
import com.salmon.pet.service.HelpResponseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 前台求助控制器
 */
@Controller
@RequestMapping("/help")
public class HelpController {

    @Autowired
    private HelpRequestService helpRequestService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private HelpResponseService helpResponseService;

    /**
     * 求助列表页
     */
    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer type,
                       @RequestParam(required = false) Integer handleStatus,
                       Model model) {
        List<HelpRequest> list = helpRequestService.getPublicList(type, handleStatus);
        model.addAttribute("list", list);
        model.addAttribute("type", type);
        model.addAttribute("handleStatus", handleStatus);
        return "help/list";
    }

    /**
     * 求助详情页
     */
    @RequestMapping("/detail/{helpId}")
    public String detail(@PathVariable Integer helpId, HttpSession session, Model model) {
        HelpRequest help = helpRequestService.getById(helpId);
        // 查评论（target_type=4 表示求助）
        List<Comment> comments = commentService.getListByTarget(4, helpId);
        model.addAttribute("help", help);
        model.addAttribute("comments", comments);

        // 查响应及当前用户是否可响应
        List<HelpResponse> responses = helpResponseService.getByHelp(helpId);
        User loginUser = (User) session.getAttribute("loginUser");
        boolean responded = false;
        if (loginUser != null) {
            for (HelpResponse response : responses) {
                if (loginUser.getUserId().equals(response.getResponderId())) {
                    responded = true;
                    break;
                }
            }
        }
        boolean canRespond = loginUser != null && help != null
                && !loginUser.getUserId().equals(help.getUserId())
                && !responded
                && help.getAuditStatus() != null && help.getAuditStatus() == 2
                && (help.getHandleStatus() == null
                || (help.getHandleStatus() != 4 && help.getHandleStatus() != 5));
        model.addAttribute("responses", responses);
        model.addAttribute("canRespond", canRespond);
        return "help/detail";
    }

    /**
     * 发布求助页面
     */
    @RequestMapping("/publish")
    public String publishPage() {
        return "help/publish";
    }

    /**
     * 提交发布求助
     */
    @PostMapping("/save")
    public String save(HelpRequest helpRequest, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        helpRequest.setUserId(loginUser.getUserId());
        helpRequestService.publish(helpRequest);
        return "redirect:/help/my";
    }

    /**
     * 我的求助列表
     */
    @RequestMapping("/my")
    public String myList(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        List<HelpRequest> list = helpRequestService.getMyList(loginUser.getUserId());
        model.addAttribute("list", list);
        return "help/my_list";
    }

    /**
     * 发表评论（AJAX）
     */
    @PostMapping("/comment")
    public String addComment(Integer targetId, String content, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        Comment comment = new Comment();
        comment.setUserId(loginUser.getUserId());
        comment.setTargetType(4); // 求助
        comment.setTargetId(targetId);
        comment.setContent(content);
        commentService.addComment(comment);
        return "redirect:/help/detail/" + targetId;
    }
}
