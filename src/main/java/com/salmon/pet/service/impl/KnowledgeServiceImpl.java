package com.salmon.pet.service.impl;

import com.salmon.pet.entity.Knowledge;
import com.salmon.pet.entity.KnowledgeCategory;
import com.salmon.pet.mapper.KnowledgeMapper;
import com.salmon.pet.service.KnowledgeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class KnowledgeServiceImpl implements KnowledgeService {

    @Autowired
    private KnowledgeMapper knowledgeMapper;

    @Override
    public List<KnowledgeCategory> getAllCategory() {
        return knowledgeMapper.selectAllCategory();
    }

    @Override
    public List<Knowledge> getPublicList(Integer categoryId) {
        return knowledgeMapper.selectPublicList(categoryId);
    }

    @Override
    public Knowledge getById(Integer articleId) {
        knowledgeMapper.increaseViewCount(articleId);
        return knowledgeMapper.selectById(articleId);
    }

    @Override
    public List<Knowledge> getAdminList(Integer categoryId) {
        return knowledgeMapper.selectAdminList(categoryId);
    }

    @Override
    public boolean save(Knowledge knowledge) {
        if (knowledge.getArticleId() == null) {
            return knowledgeMapper.insertKnowledge(knowledge) > 0;
        } else {
            return knowledgeMapper.updateKnowledge(knowledge) > 0;
        }
    }
}
