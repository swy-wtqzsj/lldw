package com.salmon.pet.mapper;

import com.salmon.pet.entity.Punishment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 处罚记录 Mapper 接口
 */
public interface PunishmentMapper {

    /** 查询处罚列表（可按状态/用户筛选） */
    List<Punishment> selectList(@Param("status") Integer status,
                                @Param("userId") Integer userId);

    /** 新增处罚 */
    int insert(Punishment punishment);

    /** 解除处罚 */
    int lift(@Param("punishId") Integer punishId);

    /** 生效中的处罚数量 */
    int countActive();
}
