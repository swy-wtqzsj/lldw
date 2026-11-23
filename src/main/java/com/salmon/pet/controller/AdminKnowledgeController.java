package com.salmon.pet.controller;

import com.salmon.pet.entity.Knowledge;
import com.salmon.pet.entity.KnowledgeCategory;
import com.salmon.pet.service.KnowledgeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin/knowledge")
public class AdminKnowledgeController {

    @Autowired
    private KnowledgeService knowledgeService;

    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer categoryId, Model model) {
        model.addAttribute("categories", knowledgeService.getAllCategory());
        model.addAttribute("list", knowledgeService.getAdminList(categoryId));
        model.addAttribute("categoryId", categoryId);
        return "admin/knowledge_list";
    }

    @RequestMapping("/add")
    public String addPage(Model model) {
        model.addAttribute("categories", knowledgeService.getAllCategory());
        return "admin/knowledge_form";
    }

    @RequestMapping("/edit/{articleId}")
    public String editPage(@org.springframework.web.bind.annotation.PathVariable Integer articleId, Model model) {
        model.addAttribute("categories", knowledgeService.getAllCategory());
        model.addAttribute("knowledge", knowledgeService.getForEdit(articleId));
        return "admin/knowledge_form";
    }

    @RequestMapping("/save")
    public String save(Knowledge knowledge, Model model) {
        String error = validate(knowledge);
        if (error == null) {
            knowledge.setTitle(knowledge.getTitle().trim());
            knowledgeService.save(knowledge);
            return "redirect:/admin/knowledge/list";
        }
        // 校验失败回到表单，保留用户已填内容
        model.addAttribute("error", error);
        model.addAttribute("knowledge", knowledge);
        model.addAttribute("categories", knowledgeService.getAllCategory());
        return "admin/knowledge_form";
    }

    /**
     * 表单校验：避免必填项为空时直接落库触发 SQL 异常（被包装成 500）
     */
    private String validate(Knowledge knowledge) {
        if (knowledge.getTitle() == null || knowledge.getTitle().trim().isEmpty()) {
            return "文章标题不能为空";
        }
        if (knowledge.getTitle().trim().length() > 100) {
            return "文章标题不能超过 100 个字";
        }
        if (knowledge.getContent() == null || knowledge.getContent().trim().isEmpty()) {
            return "正文内容不能为空";
        }
        if (knowledge.getCategoryId() == null) {
            return "请选择文章分类";
        }
        boolean categoryExists = false;
        for (KnowledgeCategory category : knowledgeService.getAllCategory()) {
            if (knowledge.getCategoryId().equals(category.getCategoryId())) {
                categoryExists = true;
                break;
            }
        }
        if (!categoryExists) {
            return "所选文章分类不存在，请重新选择";
        }
        return null;
    }
}
