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
        if (material.getQuantity() == null) {
            material.setQuantity(0);
        }
        int rows = materialMapper.insert(material);
        if (rows > 0 && material.getQuantity() > 0) {
            MaterialRecord record = new MaterialRecord();
            record.setMaterialId(material.getMaterialId());
            record.setType(1);
            record.setQuantity(material.getQuantity());
            record.setUsageDesc("初始入库");
            record.setOperator("系统");
            materialRecordMapper.insert(record);
        }
        return rows > 0;
    }

    @Override
    public boolean update(Material material) {
        return materialMapper.update(material) > 0;
    }

    @Override
    public boolean delete(Integer materialId) {
        // 有出入库流水的物资不允许删除，避免丢失历史记录
        if (materialRecordMapper.countByMaterial(materialId) > 0) {
            return false;
        }
        return materialMapper.delete(materialId) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean stockIn(Integer materialId, Integer quantity, String operator) {
        if (materialId == null || quantity == null || quantity <= 0) {
            return false;
        }
        if (materialMapper.selectById(materialId) == null) {
            return false;
        }
        materialMapper.increaseStock(materialId, quantity);

        MaterialRecord record = new MaterialRecord();
        record.setMaterialId(materialId);
        record.setType(1);
        record.setQuantity(quantity);
        record.setUsageDesc("入库");
        record.setOperator(operator);
        materialRecordMapper.insert(record);
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean stockOut(Integer materialId, Integer quantity, String usageDesc, String operator) {
        if (materialId == null || quantity == null || quantity <= 0) {
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
        record.setUsageDesc(usageDesc);
        record.setOperator(operator);
        materialRecordMapper.insert(record);
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
}
