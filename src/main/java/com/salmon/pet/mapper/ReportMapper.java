package com.salmon.pet.mapper;

import com.salmon.pet.entity.Report;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 举报记录 Mapper 接口
 */
public interface ReportMapper {

    /** 查询举报列表（可按状态/对象类型筛选） */
    List<Report> selectList(@Param("status") Integer status,
                            @Param("targetType") Integer targetType);

    /** 查询举报详情 */
    Report selectById(@Param("reportId") Integer reportId);

    /** 新增举报 */
    int insert(Report report);

    /** 查询用户自己提交的举报 */
    List<Report> selectByReporter(@Param("reporterId") Integer reporterId);

    /** 处理举报 */
    int handle(@Param("reportId") Integer reportId,
               @Param("status") Integer status,
               @Param("handleAdmin") Integer handleAdmin,
               @Param("handleOpinion") String handleOpinion);

    /** 待处理举报数量 */
    int countPending();
}
