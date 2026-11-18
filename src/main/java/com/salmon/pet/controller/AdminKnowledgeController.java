package com.salmon.pet.controller;

import com.salmon.pet.entity.Knowledge;
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
    public String save(Knowledge knowledge) {
        knowledgeService.save(knowledge);
        return "redirect:/admin/knowledge/list";
    }
}
