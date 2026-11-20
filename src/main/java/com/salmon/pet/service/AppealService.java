package com.salmon.pet.service;

import com.salmon.pet.entity.Appeal;

import java.util.List;

/**
 * 处罚申诉 Service 接口
 */
public interface AppealService {

    /** 我的申诉列表 */
    List<Appeal> getMyList(Integer userId);

    /** 后台申诉列表 */
    List<Appeal> getList(Integer status);

    /** 申诉详情 */
    Appeal getById(Integer appealId);

    /** 提交申诉，返回错误提示；成功返回 null */
    String apply(Integer punishId, Integer userId, String content, String evidence);

    /** 复核申诉 */
    boolean review(Integer appealId, Integer status, Integer reviewAdmin, String reviewOpinion);
}
