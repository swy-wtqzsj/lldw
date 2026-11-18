package com.salmon.pet.mapper;

import com.salmon.pet.entity.TeamCert;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 团队认证 Mapper 接口
 */
public interface TeamCertMapper {

    /** 查询团队认证列表（可按状态筛选） */
    List<TeamCert> selectList(@Param("status") Integer status);

    /** 查询负责人最近一次团队认证申请 */
    TeamCert selectByLeader(@Param("leaderId") Integer leaderId);

    /** 新增团队认证申请 */
    int insert(TeamCert cert);

    /** 审核团队认证 */
    int audit(@Param("teamId") Integer teamId,
              @Param("status") Integer status,
              @Param("auditAdmin") Integer auditAdmin);

    /** 待认证的团队数量 */
    int countPending();
}
