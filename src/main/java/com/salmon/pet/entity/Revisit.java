package com.salmon.pet.entity;

import java.util.Date;

/**
 * 回访记录实体类
 */
public class Revisit {
    private Integer revisitId;       // 回访ID
    private Integer adoptId;         // 领养记录ID
    private Date revisitDate;        // 回访日期
    private String photo;            // 回访照片
    private String healthDesc;       // 健康描述
    private Integer status;          // 状态:1待审核2已通过3异常
    private String adminRemark;      // 管理员备注

    // 关联字段
    private String petName;          // 宠物名
    private String username;         // 领养人

    // Getter and Setter
    public Integer getRevisitId() { return revisitId; }
    public void setRevisitId(Integer revisitId) { this.revisitId = revisitId; }
    public Integer getAdoptId() { return adoptId; }
    public void setAdoptId(Integer adoptId) { this.adoptId = adoptId; }
    public Date getRevisitDate() { return revisitDate; }
    public void setRevisitDate(Date revisitDate) { this.revisitDate = revisitDate; }
    public String getPhoto() { return photo; }
    public void setPhoto(String photo) { this.photo = photo; }
    public String getHealthDesc() { return healthDesc; }
    public void setHealthDesc(String healthDesc) { this.healthDesc = healthDesc; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getAdminRemark() { return adminRemark; }
    public void setAdminRemark(String adminRemark) { this.adminRemark = adminRemark; }
    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 1: return "待审核";
            case 2: return "正常";
            case 3: return "异常";
            default: return "";
        }
    }
}
