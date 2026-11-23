package com.salmon.pet.service.impl;

import com.salmon.pet.entity.Material;
import com.salmon.pet.entity.MaterialRecord;
import com.salmon.pet.mapper.MaterialMapper;
import com.salmon.pet.mapper.MaterialRecordMapper;
import com.salmon.pet.service.MaterialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 物资管理 Service 实现类
 */
@Service
public class MaterialServiceImpl implements MaterialService {
    private static final int MAX_SINGLE_CHANGE = 1000000;

    @Autowired
    private MaterialMapper materialMapper;

    @Autowired
    private MaterialRecordMapper materialRecordMapper;

    @Override
    public List<Material> getList(Integer category, String keyword) {
        return materialMapper.selectList(category, keyword);
    }

    @Override
    public Material getById(Integer materialId) {
        return materialMapper.selectById(materialId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean add(Material material) {
        if (!validMaterial(material) || material.getQuantity() == null
                || material.getQuantity() < 0 || material.getQuantity() > MAX_SINGLE_CHANGE) {
            return false;
        }
        material.setName(material.getName().trim());
        material.setUnit(material.getUnit().trim());
        int rows = materialMapper.insert(material);
        if (rows > 0 && material.getQuantity() > 0) {
            MaterialRecord record = new MaterialRecord();
            record.setMaterialId(material.getMaterialId());
            record.setType(1);
            record.setQuantity(material.getQuantity());
            record.setUsageDesc("初始入库");
            record.setOperator("系统");
            saveRecord(record);
        }
        return rows > 0;
    }

    @Override
    public boolean update(Material material) {
        if (!validMaterial(material) || material.getMaterialId() == null) {
            return false;
        }
        material.setName(material.getName().trim());
        material.setUnit(material.getUnit().trim());
        return materialMapper.update(material) > 0;
    }

    private boolean validMaterial(Material material) {
        return material != null
                && material.getName() != null && !material.getName().trim().isEmpty()
                && material.getName().trim().length() <= 50
                && material.getCategory() != null && material.getCategory() >= 1 && material.getCategory() <= 3
                && material.getUnit() != null && !material.getUnit().trim().isEmpty()
                && material.getUnit().trim().length() <= 10
                && material.getWarnThreshold() != null && material.getWarnThreshold() >= 0
                && (material.getDonor() == null || material.getDonor().length() <= 50);
    }

    @Override
    public boolean delete(Integer materialId) {
        if (materialId == null) {
            return false;
        }
        // 有出入库流水的物资不允许删除，避免丢失历史记录
        if (materialRecordMapper.countByMaterial(materialId) > 0) {
            return false;
        }
        return materialMapper.delete(materialId) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean stockIn(Integer materialId, Integer quantity, String operator) {
        if (materialId == null || quantity == null || quantity <= 0 || quantity > MAX_SINGLE_CHANGE) {
            return false;
        }
        if (materialMapper.increaseStock(materialId, quantity) == 0) {
            return false;
        }

        MaterialRecord record = new MaterialRecord();
        record.setMaterialId(materialId);
        record.setType(1);
        record.setQuantity(quantity);
        record.setUsageDesc("入库");
        record.setOperator(operator);
        saveRecord(record);
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean stockOut(Integer materialId, Integer quantity, String usageDesc, String operator) {
        if (materialId == null || quantity == null || quantity <= 0 || quantity > MAX_SINGLE_CHANGE) {
            return false;
        }
        if (usageDesc == null || usageDesc.trim().isEmpty() || usageDesc.trim().length() > 255) {
            return false;
        }
        // 库存不足时影响行数为 0
        if (materialMapper.decreaseStock(materialId, quantity) == 0) {
            return false;
        }

        MaterialRecord record = new MaterialRecord();
        record.setMaterialId(materialId);
        record.setType(2);
        record.setQuantity(quantity);
        record.setUsageDesc(usageDesc.trim());
        record.setOperator(operator);
        saveRecord(record);
        return true;
    }

    @Override
    public List<MaterialRecord> getRecords(Integer materialId) {
        return materialRecordMapper.selectByMaterial(materialId);
    }

    @Override
    public List<MaterialRecord> getRecentRecords(Integer limit) {
        return materialRecordMapper.selectRecent(limit == null || limit <= 0 ? 20 : limit);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String donate(Integer materialId, String name, Integer category, Integer quantity,
                         String unit, String donor, String operator) {
        if (quantity == null || quantity <= 0) {
            return "捐赠数量必须大于 0";
        }
        if (quantity > MAX_SINGLE_CHANGE) {
            return "单次捐赠数量过大，请分批提交";
        }
        if (donor == null || donor.trim().isEmpty()) {
            donor = "爱心人士";
        }
        donor = donor.trim();
        if (donor.length() > 50) {
            donor = donor.substring(0, 50);
        }
        if (operator == null || operator.trim().isEmpty()) {
            operator = donor;
        }
        operator = operator.trim();
        // material_record.operator 为 VARCHAR(20)，超长截断避免插入异常
        if (operator.length() > 20) {
            operator = operator.substring(0, 20);
        }

        if (materialId == null) {
            if (name == null || name.trim().isEmpty()) {
                return "请选择已有物资，或填写新物资名称";
            }
            String trimmedName = name.trim();
            // material.name 为 VARCHAR(50)，超长时直接拒绝，避免 MySQL Data too long 500
            if (trimmedName.length() > 50) {
                return "物资名称不能超过 50 个字符";
            }
            String trimmedUnit = unit == null || unit.trim().isEmpty() ? "件" : unit.trim();
            // material.unit 为 VARCHAR(10)
            if (trimmedUnit.length() > 10) {
                return "计量单位不能超过 10 个字符";
            }
            Material exist = materialMapper.selectByName(trimmedName);
            if (exist != null) {
                materialId = exist.getMaterialId();
            } else {
                Material m = new Material();
                m.setName(trimmedName);
                m.setCategory(category == null || category < 1 || category > 3 ? 3 : category);
                m.setQuantity(quantity);
                m.setUnit(trimmedUnit);
                m.setWarnThreshold(5);
                m.setDonor(donor);
                if (materialMapper.insert(m) <= 0 || m.getMaterialId() == null) {
                    return "捐赠失败，请稍后重试";
                }
                materialId = m.getMaterialId();
                insertDonateRecord(materialId, quantity, operator, "物资捐赠(新增)");
                return null;
            }
        } else if (materialMapper.selectById(materialId) == null) {
            return "所选物资不存在，请刷新页面后重试";
        }

        if (materialMapper.increaseStock(materialId, quantity) == 0) {
            return "捐赠失败，物资不存在或库存已达上限";
        }
        materialMapper.updateDonor(materialId, donor);
        insertDonateRecord(materialId, quantity, operator, "物资捐赠");
        return null;
    }

    private void insertDonateRecord(Integer materialId, Integer quantity,
                                    String operator, String usageDesc) {
        MaterialRecord record = new MaterialRecord();
        record.setMaterialId(materialId);
        record.setType(1);
        record.setQuantity(quantity);
        record.setUsageDesc(usageDesc);
        record.setOperator(operator);
        saveRecord(record);
    }

    private void saveRecord(MaterialRecord record) {
        if (materialRecordMapper.insert(record) != 1) {
            throw new IllegalStateException("库存流水写入失败");
        }
    }

    @Override
    public List<MaterialRecord> getDonationsByOperator(String operator) {
        if (operator == null || operator.trim().isEmpty()) {
            return java.util.Collections.emptyList();
        }
        return materialRecordMapper.selectDonationsByOperator(operator, 20);
    }
}
