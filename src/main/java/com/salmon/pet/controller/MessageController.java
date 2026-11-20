package com.salmon.pet.controller;

import com.salmon.pet.entity.User;
import com.salmon.pet.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

/**
 * 消息中心控制器 (A组) - PET-1.14
 */
@Controller
@RequestMapping("/message")
public class MessageController {

    @Autowired
    private MessageService messageService;

    /** 消息列表 */
    @GetMapping("/list")
    public String list(@RequestParam(required = false) Integer isRead,
                       HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        model.addAttribute("messages", messageService.listMyMessages(loginUser.getUserId(), isRead));
        model.addAttribute("unread", messageService.countUnread(loginUser.getUserId()));
        model.addAttribute("isRead", isRead);
        return "user/message_list";
    }

    /** 标记已读 */
    @GetMapping("/read/{messageId}")
    public String read(@PathVariable Integer messageId, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        messageService.markRead(messageId, loginUser.getUserId());
        return "redirect:/message/list";
    }

    /** 全部标记已读 */
    @GetMapping("/readAll")
    public String readAll(HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        messageService.markAllRead(loginUser.getUserId());
        return "redirect:/message/list";
    }
}
