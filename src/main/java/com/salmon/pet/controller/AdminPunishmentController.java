package com.salmon.pet.controller;

import com.salmon.pet.entity.Punishment;
import com.salmon.pet.entity.User;
import com.salmon.pet.service.PunishmentService;
import com.salmon.pet.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 后台处罚管理控制器
 */
@Controller
@RequestMapping("/admin/punishment")
public class AdminPunishmentController {

    @Autowired
    private PunishmentService punishmentService;

    @Autowired
    private UserService userService;

    /**
     * 处罚列表
     */
    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer status,
                       @RequestParam(required = false) Integer userId,
                       Model model) {
        model.addAttribute("list", punishmentService.getList(status, userId));
        model.addAttribute("status", status);
        model.addAttribute("userId", userId);
        model.addAttribute("users", userService.getAdminList(null));
        return "admin/punishment_list";
    }

    /**
     * 新增处罚
     */
    @RequestMapping("/add")
    public String add(@RequestParam Integer userId,
                      @RequestParam Integer type,
                      @RequestParam String reason,
                      @RequestParam(required = false) String endTime,
                      HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");

        Punishment punishment = new Punishment();
        punishment.setUserId(userId);
        punishment.setType(type);
        punishment.setReason(reason);
        punishment.setEndTime(parseEndTime(endTime));
        punishment.setAdminId(loginUser == null ? null : loginUser.getUserId());

        if (punishmentService.add(punishment)) {
            session.setAttribute("adminPunishMsg", "处罚已记录");
        } else {
            session.setAttribute("adminPunishMsg", "处罚记录失败");
        }
        return "redirect:/admin/punishment/list";
    }

    /**
     * 解除处罚
     */
    @RequestMapping("/lift")
    public String lift(@RequestParam Integer punishId, HttpSession session) {
        if (punishmentService.lift(punishId)) {
            session.setAttribute("adminPunishMsg", "处罚已解除");
        } else {
            session.setAttribute("adminPunishMsg", "该处罚已不是生效状态");
        }
        return "redirect:/admin/punishment/list";
    }

    /**
     * 解析前端 datetime-local 传入的结束时间，为空表示永久
     */
    private Date parseEndTime(String endTime) {
        if (endTime == null || endTime.trim().isEmpty()) {
            return null;
        }
        try {
            return new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(endTime.trim());
        } catch (Exception e) {
            return null;
        }
    }
}
