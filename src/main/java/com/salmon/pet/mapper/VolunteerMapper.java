package com.salmon.pet.mapper;

import com.salmon.pet.entity.Volunteer;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 志愿者认证数据访问 (A组)
 */
public interface VolunteerMapper {

    /** 新增认证申请 */
    int insert(Volunteer volunteer);

    /** 根据用户ID查询认证记录 */
    Volunteer selectByUserId(@Param("userId") Integer userId);

    /** 根据ID查询 */
    Volunteer selectById(@Param("volunteerId") Integer volunteerId);

    /** 后台审核列表(按状态筛选) */
    List<Volunteer> selectList(@Param("status") Integer status, @Param("keyword") String keyword);

    /** 审核(通过/拒绝) */
    int audit(@Param("volunteerId") Integer volunteerId,
              @Param("auditStatus") Integer auditStatus,
              @Param("auditOpinion") String auditOpinion,
              @Param("auditAdminId") Integer auditAdminId);

    /** 更新工时/积分/等级 */
    int updateScore(@Param("volunteerId") Integer volunteerId,
                    @Param("workHours") Integer workHours,
                    @Param("points") Integer points,
                    @Param("level") Integer level);

    /** 统计各状态数量 */
    int countByStatus(@Param("status") Integer status);
}
