package com.salmon.pet.entity;

import java.util.Date;

/**
 * 宠物实体类
 */
public class Pet {
    private Integer petId;          // 宠物ID
    private String petNo;           // 宠物编号
    private String petName;         // 宠物名
    private Integer species;        // 种类:1猫2狗
    private String breed;           // 品种
    private Integer gender;         // 性别:0未知1公2母
    private Integer ageStage;       // 年龄段:1幼年2成年3老年
    private Date birthday;          // 生日
    private String photo;           // 封面照片路径
    private String photos;          // 多图路径(逗号分隔)
    private String description;     // 详细介绍
    private Integer adoptStatus;    // 领养状态:1待审核2待领养3审核中4已被领养5退养回流6暂停展示7已归档8已回归主人
    private Integer isNeutered;     // 是否绝育:0否1是
    private Integer isVaccinated;   // 是否疫苗:0否1是
    private String healthStatus;    // 健康状况描述
    private Date createTime;        // 录入时间
    private Date updateTime;        // 更新时间

    // Getter and Setter
    public Integer getPetId() { return petId; }
    public void setPetId(Integer petId) { this.petId = petId; }
    public String getPetNo() { return petNo; }
    public void setPetNo(String petNo) { this.petNo = petNo; }
    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }
    public Integer getSpecies() { return species; }
    public void setSpecies(Integer species) { this.species = species; }
    public String getBreed() { return breed; }
    public void setBreed(String breed) { this.breed = breed; }
    public Integer getGender() { return gender; }
    public void setGender(Integer gender) { this.gender = gender; }
    public Integer getAgeStage() { return ageStage; }
    public void setAgeStage(Integer ageStage) { this.ageStage = ageStage; }
    public Date getBirthday() { return birthday; }
    public void setBirthday(Date birthday) { this.birthday = birthday; }
    public String getPhoto() { return photo; }
    public void setPhoto(String photo) { this.photo = photo; }
    public String getPhotos() { return photos; }
    public void setPhotos(String photos) { this.photos = photos; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Integer getAdoptStatus() { return adoptStatus; }
    public void setAdoptStatus(Integer adoptStatus) { this.adoptStatus = adoptStatus; }
    public Integer getIsNeutered() { return isNeutered; }
    public void setIsNeutered(Integer isNeutered) { this.isNeutered = isNeutered; }
    public Integer getIsVaccinated() { return isVaccinated; }
    public void setIsVaccinated(Integer isVaccinated) { this.isVaccinated = isVaccinated; }
    public String getHealthStatus() { return healthStatus; }
    public void setHealthStatus(String healthStatus) { this.healthStatus = healthStatus; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }

    // 辅助字段（用于前端显示）
    public String getSpeciesText() {
        if (species == null) return "";
        return species == 1 ? "猫" : "狗";
    }
    public String getGenderText() {
        if (gender == null) return "";
        switch (gender) {
            case 1: return "公";
            case 2: return "母";
            default: return "未知";
        }
    }
    public String getAgeStageText() {
        if (ageStage == null) return "";
        switch (ageStage) {
            case 1: return "幼年";
            case 2: return "成年";
            case 3: return "老年";
            default: return "";
        }
    }
    public String getAdoptStatusText() {
        if (adoptStatus == null) return "";
        switch (adoptStatus) {
            case 1: return "待审核";
            case 2: return "待领养";
            case 3: return "审核中";
            case 4: return "已被领养";
            case 5: return "退养回流";
            case 6: return "暂停展示";
            case 7: return "已归档";
            case 8: return "已回归主人";
            default: return "";
        }
    }
    public String getNeuteredText() {
        return isNeutered != null && isNeutered == 1 ? "已绝育" : "未绝育";
    }
    public String getVaccinatedText() {
        return isVaccinated != null && isVaccinated == 1 ? "已疫苗" : "未疫苗";
    }
}
