package com.salmon.pet.controller;

import com.salmon.pet.service.LostPetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * 后台寻宠启事管理控制器
 */
@Controller
@RequestMapping("/admin/lost")
public class AdminLostPetController {

    @Autowired
    private LostPetService lostPetService;

    /**
     * 启事列表
     */
    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer status, Model model) {
        model.addAttribute("list", lostPetService.getList(status));
        model.addAttribute("status", status);
        return "admin/lost_list";
    }

    /**
     * 更新启事状态（发布/已找回/下架）
     */
    @RequestMapping("/status")
    public String updateStatus(@RequestParam Integer lostId,
                               @RequestParam Integer status,
                               HttpSession session) {
        if (lostPetService.updateStatus(lostId, status)) {
            session.setAttribute("adminLostMsg", "启事状态已更新");
        } else {
            session.setAttribute("adminLostMsg", "更新失败，请检查状态值");
        }
        return "redirect:/admin/lost/list";
    }
}
