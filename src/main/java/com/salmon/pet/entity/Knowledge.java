package com.salmon.pet.entity;

import java.util.Date;

/**
 * 知识文章实体类
 */
public class Knowledge {
    private Integer articleId;        // 文章ID
    private Integer categoryId;      // 分类ID
    private String title;            // 标题
    private String content;          // 正文
    private String coverImage;       // 封面图片
    private Integer status;          // 状态:1草稿2已发布3已下架
    private Integer viewCount;        // 浏览次数
    private Date publishTime;         // 发布时间
    private Date updateTime;          // 更新时间

    // 关联字段
    private String categoryName;     // 分类名称

    // Getter and Setter
    public Integer getArticleId() { return articleId; }
    public void setArticleId(Integer articleId) { this.articleId = articleId; }
    public Integer getCategoryId() { return categoryId; }
    public void setCategoryId(Integer categoryId) { this.categoryId = categoryId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getCoverImage() { return coverImage; }
    public void setCoverImage(String coverImage) { this.coverImage = coverImage; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Integer getViewCount() { return viewCount; }
    public void setViewCount(Integer viewCount) { this.viewCount = viewCount; }
    public Date getPublishTime() { return publishTime; }
    public void setPublishTime(Date publishTime) { this.publishTime = publishTime; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 1: return "草稿";
            case 2: return "已发布";
            case 3: return "已下架";
            default: return "";
        }
    }
}
