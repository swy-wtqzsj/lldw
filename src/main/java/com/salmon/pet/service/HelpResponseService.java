package com.salmon.pet.service;

import com.salmon.pet.entity.HelpResponse;

import java.util.List;

/**
 * 求助响应 Service 接口
 */
public interface HelpResponseService {

    /** 查询某条求助的响应列表 */
    List<HelpResponse> getByHelp(Integer helpId);

    /** 后台查询响应列表 */
    List<HelpResponse> getList(Integer status);

    /** 查询我提交的响应 */
    List<HelpResponse> getMyResponses(Integer responderId);

    /** 提交响应，返回错误提示；成功返回 null */
    String respond(Integer helpId, Integer responderId, String content);

    /** 更新响应状态 */
    boolean updateStatus(Integer respId, Integer status);
}
