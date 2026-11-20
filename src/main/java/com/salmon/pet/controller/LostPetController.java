package com.salmon.pet.controller;

import com.salmon.pet.entity.LostPet;
import com.salmon.pet.entity.User;
import com.salmon.pet.service.LostPetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 前台寻宠启事控制器
 */
@Controller
@RequestMapping("/lost")
public class LostPetController {

    private static final List<String> ALLOWED_EXT =
            Arrays.asList("jpg", "jpeg", "png", "gif", "webp");

    @Autowired
    private LostPetService lostPetService;

    /**
     * 寻宠启事列表
     */
    @RequestMapping("/list")
    public String list(Model model) {
        model.addAttribute("list", lostPetService.getPublishedList());
        return "lost/list";
    }

    /**
     * 启事详情（发布中，或本人发布的其他状态）
     */
    @RequestMapping("/detail/{lostId}")
    public String detail(@PathVariable Integer lostId, HttpSession session, Model model) {
        LostPet lostPet = lostPetService.getById(lostId);
        if (lostPet == null) {
            return "redirect:/lost/list";
        }
        if (lostPet.getStatus() == null || lostPet.getStatus() != 2) {
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null || !loginUser.getUserId().equals(lostPet.getUserId())) {
                return "redirect:/lost/list";
            }
        }
        model.addAttribute("lostPet", lostPet);
        return "lost/detail";
    }

    /**
     * 发布启事页面
     */
    @RequestMapping("/publish")
    public String publishPage(HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        return "lost/form";
    }

    /**
     * 提交发布启事
     */
    @RequestMapping("/save")
    public String save(@RequestParam(required = false) String petName,
                       @RequestParam(required = false) Integer species,
                       @RequestParam(required = false) String breed,
                       @RequestParam(required = false) Integer gender,
                       @RequestParam(required = false) String features,
                       @RequestParam(required = false) String lostTime,
                       @RequestParam(required = false) String lostLocation,
                       @RequestParam String contact,
                       @RequestParam(required = false) String reward,
                       @RequestParam(value = "photoFile", required = false) MultipartFile photoFile,
                       HttpSession session,
                       HttpServletRequest request) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        if (contact == null || contact.trim().isEmpty()) {
            session.setAttribute("lostMsg", "请填写联系方式");
            return "redirect:/lost/publish";
        }

        LostPet lostPet = new LostPet();
        lostPet.setUserId(loginUser.getUserId());
        lostPet.setPetName(trimToNull(petName));
        lostPet.setSpecies(species);
        lostPet.setBreed(trimToNull(breed));
        lostPet.setGender(gender == null ? 0 : gender);
        lostPet.setFeatures(trimToNull(features));
        lostPet.setLostLocation(trimToNull(lostLocation));
        lostPet.setLostTime(parseLostTime(lostTime));
        lostPet.setContact(contact.trim());
        lostPet.setReward(parseReward(reward));

        if (photoFile != null && !photoFile.isEmpty()) {
            String photo = savePhoto(photoFile, request);
            if (photo == null) {
                session.setAttribute("lostMsg", "照片格式不支持，仅限 jpg/jpeg/png/gif/webp");
                return "redirect:/lost/publish";
            }
            lostPet.setPhoto(photo);
        }

        lostPetService.publish(lostPet);
        session.setAttribute("lostMsg", "启事已提交，等待管理员审核后发布");
        return "redirect:/lost/my";
    }

    /**
     * 我的启事
     */
    @RequestMapping("/my")
    public String my(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("list", lostPetService.getMyList(loginUser.getUserId()));
        return "lost/my";
    }

    /**
     * 撤回启事
     */
    @RequestMapping("/withdraw")
    public String withdraw(@RequestParam Integer lostId, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        LostPet lostPet = lostPetService.getById(lostId);
        if (lostPet == null || !loginUser.getUserId().equals(lostPet.getUserId())) {
            session.setAttribute("lostMsg", "只能撤回自己发布的启事");
            return "redirect:/lost/my";
        }
        if (lostPet.getStatus() == null
                || (lostPet.getStatus() != 1 && lostPet.getStatus() != 2)) {
            session.setAttribute("lostMsg", "当前状态不可撤回");
            return "redirect:/lost/my";
        }
        lostPetService.updateStatus(lostId, 4);
        session.setAttribute("lostMsg", "启事已撤回");
        return "redirect:/lost/my";
    }

    private String trimToNull(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return value.trim();
    }

    private Date parseLostTime(String lostTime) {
        if (lostTime == null || lostTime.trim().isEmpty()) {
            return null;
        }
        String value = lostTime.trim();
        try {
            return new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(value);
        } catch (Exception e) {
            try {
                return new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(value);
            } catch (Exception ex) {
                return null;
            }
        }
    }

    private BigDecimal parseReward(String reward) {
        if (reward == null || reward.trim().isEmpty()) {
            return BigDecimal.ZERO;
        }
        try {
            BigDecimal value = new BigDecimal(reward.trim());
            return value.compareTo(BigDecimal.ZERO) < 0 ? BigDecimal.ZERO : value;
        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }

    /**
     * 保存照片，返回相对路径；格式不合法返回 null
     */
    private String savePhoto(MultipartFile file, HttpServletRequest request) {
        String original = file.getOriginalFilename();
        String ext = "";
        if (original != null && original.contains(".")) {
            ext = original.substring(original.lastIndexOf('.') + 1).toLowerCase();
        }
        if (!ALLOWED_EXT.contains(ext)) {
            return null;
        }
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return null;
        }
        try {
            String relativeDir = "/static/uploads";
            String realDir = request.getServletContext().getRealPath(relativeDir);
            File dir = new File(realDir);
            if (!dir.exists() && !dir.mkdirs()) {
                return null;
            }
            String fileName = "lost_" + UUID.randomUUID().toString().replace("-", "") + "." + ext;
            file.transferTo(new File(dir, fileName));
            return relativeDir + "/" + fileName;
        } catch (Exception e) {
            return null;
        }
    }
}
