package com.salmon.pet.mapper;

import com.salmon.pet.entity.Appeal;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 处罚申诉 Mapper 接口
 */
public interface AppealMapper {

    /** 查询用户提交的申诉 */
    List<Appeal> selectByUser(@Param("userId") Integer userId);

    /** 后台查询申诉列表（可按状态筛选） */
    List<Appeal> selectList(@Param("status") Integer status);

    /** 查询申诉详情 */
    Appeal selectById(@Param("appealId") Integer appealId);

    /** 某处罚下待复核申诉数量 */
    int countPendingByPunish(@Param("punishId") Integer punishId);

    /** 新增申诉 */
    int insert(Appeal appeal);

    /** 复核申诉 */
    int review(@Param("appealId") Integer appealId,
               @Param("status") Integer status,
               @Param("reviewAdmin") Integer reviewAdmin,
               @Param("reviewOpinion") String reviewOpinion);
}
