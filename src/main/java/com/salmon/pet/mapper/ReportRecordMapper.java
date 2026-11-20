package com.salmon.pet.mapper;

import com.salmon.pet.entity.ReportRecord;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 举报记录数据访问 (A组)
 */
public interface ReportRecordMapper {

    /** 提交举报 */
    int insert(ReportRecord report);

    /** 我提交的举报列表 */
    List<ReportRecord> selectByReporter(@Param("reporterId") Integer reporterId);

    /** 后台举报列表(按状态筛选) */
    List<ReportRecord> selectList(@Param("status") Integer status);

    /** 根据ID查询 */
    ReportRecord selectById(@Param("reportId") Integer reportId);

    /** 处理举报(通过/驳回) */
    int handle(@Param("reportId") Integer reportId,
               @Param("status") Integer status,
               @Param("handleResult") String handleResult,
               @Param("adminId") Integer adminId);

    /** 统计各状态数量 */
    int countByStatus(@Param("status") Integer status);
}
