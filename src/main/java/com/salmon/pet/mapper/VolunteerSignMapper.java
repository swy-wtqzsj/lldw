package com.salmon.pet.mapper;

import com.salmon.pet.entity.VolunteerSign;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 志愿签到 / 工时统计 Mapper（C 组）
 */
public interface VolunteerSignMapper {

    /** 我的签到记录 */
    List<VolunteerSign> selectByUser(@Param("userId") Integer userId);

    /** 按主键查询 */
    VolunteerSign selectById(@Param("signId") Integer signId);

    /** 签到 */
    int insert(VolunteerSign sign);

    /** 签退，写入工时 */
    int signOut(@Param("signId") Integer signId,
                @Param("workHours") BigDecimal workHours);

    /** 未签退记录数（防止重复签到） */
    int countOpenSign(@Param("userId") Integer userId);

    /** 后台签到记录列表 */
    List<VolunteerSign> selectAdminList(@Param("userId") Integer userId,
                                        @Param("status") Integer status,
                                        @Param("auditStatus") Integer auditStatus,
                                        @Param("keyword") String keyword);

    /** 工时审核 */
    int updateAudit(@Param("signId") Integer signId,
                    @Param("auditStatus") Integer auditStatus,
                    @Param("auditRemark") String auditRemark);

    /** 工时排行（统计查询） */
    List<Map<String, Object>> selectWorkHourRank();

    /** 全局工时汇总（统计查询） */
    Map<String, Object> selectSummary();

    /** 个人工时汇总 */
    Map<String, Object> selectMyStats(@Param("userId") Integer userId);

    /** 今日签到数 */
    int countToday();

    /** 记录所属用户 */
    Integer selectUserId(@Param("signId") Integer signId);

    /** 审核通过后，把累计工时同步回志愿者档案 */
    int syncVolunteerWorkHours(@Param("userId") Integer userId);
}
