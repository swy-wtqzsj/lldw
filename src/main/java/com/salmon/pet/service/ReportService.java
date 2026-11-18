package com.salmon.pet.service;

import com.salmon.pet.entity.Report;

import java.util.List;

/**
 * 举报管理 Service 接口
 */
public interface ReportService {

    /** 查询举报列表 */
    List<Report> getList(Integer status, Integer targetType);

    /** 查询举报详情 */
    Report getById(Integer reportId);

    /** 用户提交举报 */
    boolean submit(Report report);

    /** 查询用户自己提交的举报 */
    List<Report> getMyList(Integer reporterId);

    /** 处理举报 */
    boolean handle(Integer reportId, Integer status, Integer handleAdmin, String handleOpinion);
}
