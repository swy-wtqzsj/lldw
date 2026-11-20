package com.salmon.pet.controller;

import com.salmon.pet.service.HelpResponseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * 后台求助响应管理控制器
 */
@Controller
@RequestMapping("/admin/help-response")
public class AdminHelpResponseController {

    @Autowired
    private HelpResponseService helpResponseService;

    /**
     * 响应列表
     */
    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer status, Model model) {
        model.addAttribute("list", helpResponseService.getList(status));
        model.addAttribute("status", status);
        return "admin/help_response_list";
    }

    /**
     * 更新响应状态
     */
    @RequestMapping("/status")
    public String updateStatus(@RequestParam Integer respId,
                               @RequestParam Integer status,
                               HttpSession session) {
        if (helpResponseService.updateStatus(respId, status)) {
            session.setAttribute("adminHelpRespMsg", "响应状态已更新");
        } else {
            session.setAttribute("adminHelpRespMsg", "更新失败，请检查状态值");
        }
        return "redirect:/admin/help-response/list";
    }
}
