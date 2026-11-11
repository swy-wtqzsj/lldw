package com.salmon.pet.service;

import com.salmon.pet.entity.HelpRequest;

import java.util.List;

/**
 * 求助信息 Service 接口
 */
public interface HelpRequestService {

    /**
     * 发布求助
     */
    boolean publish(HelpRequest helpRequest);

    /**
     * 查询前台求助列表
     */
    List<HelpRequest> getPublicList(Integer type, Integer handleStatus);

    /**
     * 查询求助详情
     */
    HelpRequest getById(Integer helpId);

    /**
     * 查询我的求助列表
     */
    List<HelpRequest> getMyList(Integer userId);

    /**
     * 后台查询求助列表
     */
    List<HelpRequest> getAdminList(Integer auditStatus);

    /**
     * 审核求助
     */
    boolean audit(Integer helpId, Integer auditStatus, String auditOpinion);

    /**
     * 更新处理状态
     */
    boolean updateHandleStatus(Integer helpId, Integer handleStatus);
}
