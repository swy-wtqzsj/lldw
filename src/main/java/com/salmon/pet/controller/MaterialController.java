package com.salmon.pet.controller;

import com.salmon.pet.entity.User;
import com.salmon.pet.service.MaterialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * 前台物资捐赠控制器（C 组）
 * 路由前缀 /material，与 /admin/material 不冲突
 */
@Controller
@RequestMapping("/material")
public class MaterialController {

    @Autowired
    private MaterialService materialService;

    /** 物资捐赠页：库存列表 + 捐赠表单 + 我的捐赠 */
    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer category,
                       HttpSession session, Model model) {
        model.addAttribute("list", materialService.getList(category, null));
        model.addAttribute("category", category);
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser != null) {
            model.addAttribute("myDonations",
                    materialService.getDonationsByOperator(loginUser.getUsername()));
        }
        return "material/list";
    }

    /** 提交捐赠 */
    @PostMapping("/donate")
    public String donate(@RequestParam(required = false) Integer materialId,
                         @RequestParam(required = false) String name,
                         @RequestParam(required = false) Integer category,
                         @RequestParam(required = false) Integer quantity,
                         @RequestParam(required = false) String unit,
                         HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        String donor = loginUser.getNickname() == null || loginUser.getNickname().trim().isEmpty()
                ? loginUser.getUsername() : loginUser.getNickname();
        String msg = materialService.donate(materialId, name, category, quantity,
                unit, donor, loginUser.getUsername());
        session.setAttribute("materialMsg", msg == null ? "捐赠成功，感谢您的爱心！" : msg);
        return "redirect:/material/list";
    }
}
