package com.salmon.pet.mapper;

import com.salmon.pet.entity.Revisit;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RevisitMapper {

    int insert(Revisit revisit);

    List<Revisit> selectAdminList(@Param("status") Integer status);

    Revisit selectById(@Param("revisitId") Integer revisitId);

    int updateStatus(@Param("revisitId") Integer revisitId,
                     @Param("status") Integer status,
                     @Param("adminRemark") String adminRemark);

    List<Revisit> selectByAdoptId(@Param("adoptId") Integer adoptId);
}
