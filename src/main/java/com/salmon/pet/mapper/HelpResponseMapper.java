package com.salmon.pet.mapper;

import com.salmon.pet.entity.HelpResponse;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 求助响应 Mapper 接口
 */
public interface HelpResponseMapper {

    /** 查询某条求助的响应列表 */
    List<HelpResponse> selectByHelp(@Param("helpId") Integer helpId);

    /** 后台查询响应列表（可按状态筛选） */
    List<HelpResponse> selectList(@Param("status") Integer status);

    /** 查询我提交的响应 */
    List<HelpResponse> selectByResponder(@Param("responderId") Integer responderId);

    /** 查询某用户对某求助是否已响应 */
    HelpResponse selectExisting(@Param("helpId") Integer helpId,
                               @Param("responderId") Integer responderId);

    /** 新增响应 */
    int insert(HelpResponse helpResponse);

    /** 更新响应状态 */
    int updateStatus(@Param("respId") Integer respId,
                     @Param("status") Integer status);
}
