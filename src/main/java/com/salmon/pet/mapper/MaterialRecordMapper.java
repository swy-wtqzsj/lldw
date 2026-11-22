package com.salmon.pet.mapper;

import com.salmon.pet.entity.MaterialRecord;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 物资出入库流水 Mapper 接口
 */
public interface MaterialRecordMapper {

    /** 查询指定物资的出入库流水 */
    List<MaterialRecord> selectByMaterial(@Param("materialId") Integer materialId);

    /** 查询最近的出入库流水 */
    List<MaterialRecord> selectRecent(@Param("limit") Integer limit);

    /** 查询某用户的捐赠流水（前台「我的捐赠」） */
    List<MaterialRecord> selectDonationsByOperator(@Param("operator") String operator,
                                                   @Param("limit") Integer limit);

    /** 新增流水 */
    int insert(MaterialRecord record);

    /** 指定物资的流水条数 */
    int countByMaterial(@Param("materialId") Integer materialId);
}
