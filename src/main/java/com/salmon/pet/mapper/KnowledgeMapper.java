package com.salmon.pet.mapper;

import com.salmon.pet.entity.Knowledge;
import com.salmon.pet.entity.KnowledgeCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 知识 Mapper 接口
 */
public interface KnowledgeMapper {

    /**
     * 查询所有分类（前台）
     */
    List<KnowledgeCategory> selectAllCategory();

    /**
     * 查询已发布的知识列表
     */
    List<Knowledge> selectPublicList(@Param("categoryId") Integer categoryId);

    /**
     * 查询知识详情
     */
    Knowledge selectById(@Param("articleId") Integer articleId);

    /**
     * 增加浏览次数
     */
    int increaseViewCount(@Param("articleId") Integer articleId);

    /**
     * 后台查询所有知识
     */
    List<Knowledge> selectAdminList(@Param("categoryId") Integer categoryId);

    /**
     * 新增知识
     */
    int insertKnowledge(Knowledge knowledge);

    /**
     * 更新知识
     */
    int updateKnowledge(Knowledge knowledge);
}
