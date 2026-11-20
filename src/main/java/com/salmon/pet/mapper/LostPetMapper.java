package com.salmon.pet.mapper;

import com.salmon.pet.entity.LostPet;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 寻宠启事 Mapper 接口
 */
public interface LostPetMapper {

    /** 前台展示的已发布启事 */
    List<LostPet> selectPublished();

    /** 后台查询启事列表（可按状态筛选） */
    List<LostPet> selectList(@Param("status") Integer status);

    /** 查询启事详情 */
    LostPet selectById(@Param("lostId") Integer lostId);

    /** 查询用户发布的启事 */
    List<LostPet> selectByUser(@Param("userId") Integer userId);

    /** 新增启事（待审核） */
    int insert(LostPet lostPet);

    /** 更新启事状态 */
    int updateStatus(@Param("lostId") Integer lostId,
                     @Param("status") Integer status);
}
