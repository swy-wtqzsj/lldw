package com.salmon.pet.entity;

import java.util.Date;

/**
 * 物资出入库流水实体类
 */
public class MaterialRecord {
    private Integer recordId;        // 流水ID
    private Integer materialId;      // 物资ID
    private Integer type;            // 类型:1入库2出库
    private Integer quantity;        // 数量
    private String usageDesc;        // 出库用途
    private String operator;         // 操作人
    private Date recordTime;         // 操作时间

    // 关联字段
    private String materialName;     // 物资名称

    // Getter and Setter
    public Integer getRecordId() { return recordId; }
    public void setRecordId(Integer recordId) { this.recordId = recordId; }
    public Integer getMaterialId() { return materialId; }
    public void setMaterialId(Integer materialId) { this.materialId = materialId; }
    public Integer getType() { return type; }
    public void setType(Integer type) { this.type = type; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public String getUsageDesc() { return usageDesc; }
    public void setUsageDesc(String usageDesc) { this.usageDesc = usageDesc; }
    public String getOperator() { return operator; }
    public void setOperator(String operator) { this.operator = operator; }
    public Date getRecordTime() { return recordTime; }
    public void setRecordTime(Date recordTime) { this.recordTime = recordTime; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }

    // 辅助方法
    public String getTypeText() {
        if (type == null) return "";
        switch (type) {
            case 1: return "入库";
            case 2: return "出库";
            default: return "";
        }
    }
}
