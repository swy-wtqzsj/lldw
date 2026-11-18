package com.salmon.pet.mapper;

import com.salmon.pet.entity.Material;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 物资库存 Mapper 接口
 */
public interface MaterialMapper {

    /** 查询物资列表（可按类别/名称筛选） */
    List<Material> selectList(@Param("category") Integer category,
                              @Param("keyword") String keyword);

    /** 查询物资详情 */
    Material selectById(@Param("materialId") Integer materialId);

    /** 新增物资 */
    int insert(Material material);

    /** 更新物资基础信息 */
    int update(Material material);

    /** 删除物资 */
    int delete(@Param("materialId") Integer materialId);

    /** 入库，增加库存 */
    int increaseStock(@Param("materialId") Integer materialId,
                      @Param("quantity") Integer quantity);

    /** 出库，减少库存（数量不足时影响行数为 0） */
    int decreaseStock(@Param("materialId") Integer materialId,
                      @Param("quantity") Integer quantity);

    /** 低库存物资数量 */
    int countLowStock();

    /** 物资总数 */
    int countTotal();
}
