package com.salmon.pet.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 寻宠启事实体类
 */
public class LostPet {
    private Integer lostId;          // 寻宠ID
    private Integer userId;          // 发布人ID
    private String petName;          // 宠物名
    private Integer species;         // 种类:1猫2狗
    private String breed;            // 品种
    private Integer gender;          // 性别:0未知1公2母
    private String features;         // 身体特征
    private String photo;            // 照片
    private Date lostTime;           // 走失时间
    private String lostLocation;     // 走失地点
    private String contact;          // 联系方式
    private BigDecimal reward;       // 悬赏金额
    private Integer status;          // 状态:1待审核2发布中3已找回4已撤回5已下架
    private Date publishTime;        // 发布时间

    // 关联字段
    private String username;         // 发布人账号

    // Getter and Setter
    public Integer getLostId() { return lostId; }
    public void setLostId(Integer lostId) { this.lostId = lostId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }
    public Integer getSpecies() { return species; }
    public void setSpecies(Integer species) { this.species = species; }
    public String getBreed() { return breed; }
    public void setBreed(String breed) { this.breed = breed; }
    public Integer getGender() { return gender; }
    public void setGender(Integer gender) { this.gender = gender; }
    public String getFeatures() { return features; }
    public void setFeatures(String features) { this.features = features; }
    public String getPhoto() { return photo; }
    public void setPhoto(String photo) { this.photo = photo; }
    public Date getLostTime() { return lostTime; }
    public void setLostTime(Date lostTime) { this.lostTime = lostTime; }
    public String getLostLocation() { return lostLocation; }
    public void setLostLocation(String lostLocation) { this.lostLocation = lostLocation; }
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
    public BigDecimal getReward() { return reward; }
    public void setReward(BigDecimal reward) { this.reward = reward; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getPublishTime() { return publishTime; }
    public void setPublishTime(Date publishTime) { this.publishTime = publishTime; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    // 辅助方法
    public String getSpeciesText() {
        if (species == null) return "";
        switch (species) {
            case 1: return "猫";
            case 2: return "狗";
            default: return "";
        }
    }

    public String getGenderText() {
        if (gender == null) return "未知";
        switch (gender) {
            case 1: return "公";
            case 2: return "母";
            default: return "未知";
        }
    }

    public String getStatusText() {
        if (status == null) return "";
        switch (status) {
            case 1: return "待审核";
            case 2: return "发布中";
            case 3: return "已找回";
            case 4: return "已撤回";
            case 5: return "已下架";
            default: return "";
        }
    }
}
