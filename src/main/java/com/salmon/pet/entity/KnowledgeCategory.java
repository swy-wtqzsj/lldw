package com.salmon.pet.entity;

/**
 * 知识分类实体类
 */
public class KnowledgeCategory {
    private Integer categoryId;      // 分类ID
    private String categoryName;     // 分类名称
    private String icon;             // 分类图标
    private Integer sortOrder;       // 排序号
    private Integer status;          // 状态:1启用0禁用

    // Getter and Setter
    public Integer getCategoryId() { return categoryId; }
    public void setCategoryId(Integer categoryId) { this.categoryId = categoryId; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
}
