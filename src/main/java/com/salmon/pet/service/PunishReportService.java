package com.salmon.pet.service;

import com.salmon.pet.entity.Punishment;
import com.salmon.pet.entity.ReportRecord;

import java.util.List;

/**
 * 举报与处罚服务 (A组) - 对应 6.3.9 举报与处罚控制层
 */
public interface PunishReportService {

    // ========== 举报 ==========

    /** 提交举报，返回错误信息；成功返回 null */
    String submitReport(ReportRecord report);

    /** 我提交的举报 */
    List<ReportRecord> myReports(Integer userId);

    /** 后台举报列表 */
    List<ReportRecord> listReports(Integer status);

    /** 处理举报 */
    boolean handleReport(Integer reportId, Integer status, String handleResult, Integer adminId);

    // ========== 处罚 ==========

    /** 新增处罚(后台) */
    String addPunishment(Punishment punishment);

    /** 我的处罚记录 */
    List<Punishment> myPunishments(Integer userId);

    /** 后台处罚列表 */
    List<Punishment> listPunishments(Integer status, String username);

    /** 解除处罚 */
    boolean releasePunishment(Integer punishId);

    /** 提交申诉，返回错误信息；成功返回 null */
    String submitAppeal(Integer punishId, Integer userId, String appealReason);

    /** 复核申诉 */
    boolean handleAppeal(Integer punishId, Integer appealStatus, String appealResult);

    /** 到期自动解除 */
    void autoExpire();

    /** 统计待处理举报数 */
    int countPendingReports();

    /** 统计待复核申诉数 */
    int countPendingAppeals();
}
