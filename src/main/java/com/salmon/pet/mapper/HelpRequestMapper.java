package com.salmon.pet.mapper;

import com.salmon.pet.entity.HelpRequest;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 求助信息 Mapper 接口
 */
public interface HelpRequestMapper {

    /**
     * 用户发布求助
     */
    int insertHelpRequest(HelpRequest helpRequest);

    /**
     * 查询已审核通过的求助列表（前台展示）
     */
    List<HelpRequest> selectPublicList(@Param("type") Integer type,
                                       @Param("handleStatus") Integer handleStatus);

    /**
     * 查询求助详情
     */
    HelpRequest selectById(@Param("helpId") Integer helpId);

    /**
     * 查询用户自己的求助列表
     */
    List<HelpRequest> selectMyList(@Param("userId") Integer userId);

    /**
     * 后台查询所有求助列表
     */
    List<HelpRequest> selectAdminList(@Param("auditStatus") Integer auditStatus);

    /**
     * 审核求助
     */
    int auditHelpRequest(@Param("helpId") Integer helpId,
                         @Param("auditStatus") Integer auditStatus,
                         @Param("auditOpinion") String auditOpinion);

    /**
     * 更新处理状态
     */
    int updateHandleStatus(@Param("helpId") Integer helpId,
                           @Param("handleStatus") Integer handleStatus);
}
