package com.salmon.pet.mapper;

import com.salmon.pet.entity.VolunteerCert;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 志愿者认证 Mapper 接口
 */
public interface VolunteerCertMapper {

    /** 查询志愿者认证列表（可按状态筛选） */
    List<VolunteerCert> selectList(@Param("status") Integer status);

    /** 根据 ID 查询志愿者认证 */
    VolunteerCert selectById(@Param("certId") Integer certId);

    /** 查询用户自己的志愿者认证 */
    VolunteerCert selectByUserId(@Param("userId") Integer userId);

    /** 新增志愿者认证申请 */
    int insert(VolunteerCert cert);

    /** 重新提交被驳回/撤销的申请 */
    int updateApply(VolunteerCert cert);

    /** 审核志愿者认证 */
    int audit(@Param("certId") Integer certId,
              @Param("status") Integer status,
              @Param("auditAdmin") Integer auditAdmin,
              @Param("auditOpinion") String auditOpinion);

    /** 待认证的志愿者数量 */
    int countPending();
}
