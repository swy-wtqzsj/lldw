package com.salmon.pet.entity;

import java.util.Date;

/**
 * 物资库存实体类
 */
public class Material {
    private Integer materialId;      // 物资ID
    private String name;             // 物资名称
    private Integer category;        // 类别:1食物2药品3用品
    private Integer quantity;        // 库存数量
    private String unit;             // 单位
    private Integer warnThreshold;   // 预警阈值
    private String donor;            // 捐赠人
    private Date createTime;         // 入库时间
    private Date updateTime;         // 更新时间

    // Getter and Setter
    public Integer getMaterialId() { return materialId; }
    public void setMaterialId(Integer materialId) { this.materialId = materialId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Integer getCategory() { return category; }
    public void setCategory(Integer category) { this.category = category; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    public Integer getWarnThreshold() { return warnThreshold; }
    public void setWarnThreshold(Integer warnThreshold) { this.warnThreshold = warnThreshold; }
    public String getDonor() { return donor; }
    public void setDonor(String donor) { this.donor = donor; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }

    // 辅助方法
    public String getCategoryText() {
        if (category == null) return "";
        switch (category) {
            case 1: return "食物";
            case 2: return "药品";
            case 3: return "用品";
            default: return "";
        }
    }

    public boolean isLowStock() {
        return quantity != null && warnThreshold != null && quantity <= warnThreshold;
    }
}
