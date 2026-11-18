package com.salmon.pet.service;

import com.salmon.pet.entity.Material;
import com.salmon.pet.entity.MaterialRecord;

import java.util.List;

/**
 * 物资管理 Service 接口
 */
public interface MaterialService {

    /** 查询物资列表 */
    List<Material> getList(Integer category, String keyword);

    /** 查询物资详情 */
    Material getById(Integer materialId);

    /** 新增物资 */
    boolean add(Material material);

    /** 修改物资 */
    boolean update(Material material);

    /** 删除物资 */
    boolean delete(Integer materialId);

    /** 入库 */
    boolean stockIn(Integer materialId, Integer quantity, String operator);

    /** 出库 */
    boolean stockOut(Integer materialId, Integer quantity, String usageDesc, String operator);

    /** 查询指定物资的流水 */
    List<MaterialRecord> getRecords(Integer materialId);

    /** 查询最近的流水 */
    List<MaterialRecord> getRecentRecords(Integer limit);
}
