package com.salmon.pet.mapper;

import com.salmon.pet.entity.FosterReturn;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FosterReturnMapper {

    int insert(FosterReturn fosterReturn);

    List<FosterReturn> selectAdminList(@Param("status") Integer status);

    List<FosterReturn> selectMyList(@Param("userId") Integer userId);

    FosterReturn selectById(@Param("returnId") Integer returnId);

    int audit(@Param("returnId") Integer returnId,
              @Param("status") Integer status,
              @Param("auditOpinion") String auditOpinion,
              @Param("auditAdmin") Integer auditAdmin);

    /** 查询某宠物是否存在进行中的退养申请（状态1待审核/2已通过） */
    FosterReturn selectActiveByPet(@Param("petId") Integer petId);

    /** 该用户是否已有同一领养记录的退养申请 */
    FosterReturn selectByAdoptAndUser(@Param("adoptId") Integer adoptId, @Param("userId") Integer userId);
}
