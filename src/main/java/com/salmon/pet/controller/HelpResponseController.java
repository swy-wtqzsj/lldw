package com.salmon.pet.controller;

import com.salmon.pet.entity.User;
import com.salmon.pet.service.HelpResponseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * 前台求助响应控制器
 */
@Controller
@RequestMapping("/help/response")
public class HelpResponseController {

    @Autowired
    private HelpResponseService helpResponseService;

    /**
     * 提交响应
     */
    @PostMapping("/save")
    public String save(@RequestParam Integer helpId,
                       @RequestParam String content,
                       HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        String error = helpResponseService.respond(helpId, loginUser.getUserId(), content);
        if (error == null) {
            session.setAttribute("helpRespMsg", "响应已提交，请等待发布人联系");
        } else {
            session.setAttribute("helpRespMsg", error);
        }
        return "redirect:/help/detail/" + helpId;
    }

    /**
     * 我的响应
     */
    @RequestMapping("/my")
    public String my(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("list", helpResponseService.getMyResponses(loginUser.getUserId()));
        return "help/my_response";
    }
}
