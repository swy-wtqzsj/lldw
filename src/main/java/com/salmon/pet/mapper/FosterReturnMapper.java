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
}
