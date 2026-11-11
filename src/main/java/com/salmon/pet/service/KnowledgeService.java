package com.salmon.pet.service;

import com.salmon.pet.entity.Knowledge;
import com.salmon.pet.entity.KnowledgeCategory;

import java.util.List;

public interface KnowledgeService {

    List<KnowledgeCategory> getAllCategory();

    List<Knowledge> getPublicList(Integer categoryId);

    Knowledge getById(Integer articleId);

    List<Knowledge> getAdminList(Integer categoryId);

    boolean save(Knowledge knowledge);
}
