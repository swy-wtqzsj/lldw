package com.salmon.pet.controller;

import com.salmon.pet.entity.Knowledge;
import com.salmon.pet.service.KnowledgeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/knowledge")
public class KnowledgeController {

    @Autowired
    private KnowledgeService knowledgeService;

    @RequestMapping("/list")
    public String list(@RequestParam(required = false) Integer categoryId, Model model) {
        model.addAttribute("categories", knowledgeService.getAllCategory());
        List<Knowledge> list = knowledgeService.getPublicList(categoryId);
        model.addAttribute("list", list);
        model.addAttribute("categoryId", categoryId);
        return "knowledge/list";
    }

    @RequestMapping("/detail/{articleId}")
    public String detail(@PathVariable Integer articleId, Model model) {
        Knowledge knowledge = knowledgeService.getById(articleId);
        model.addAttribute("knowledge", knowledge);
        return "knowledge/detail";
    }
}
