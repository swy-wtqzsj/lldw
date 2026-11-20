package com.salmon.pet.mapper;

import com.salmon.pet.entity.Punishment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 处罚记录 Mapper（合并版：本地后台管理 + A组申诉/风控）
 */
public interface PunishmentMapper {

    /** A组：后台列表（按状态、用户名筛选） */
    List<Punishment> selectList(@Param("status") Integer status,
                                @Param("username") String username);

    /** 本地：后台列表（按状态、用户ID筛选） */
    List<Punishment> selectListByUser(@Param("status") Integer status,
                                      @Param("userId") Integer userId);

    /** A组：我的处罚记录 */
    List<Punishment> selectByUser(@Param("userId") Integer userId);

    /** A组：查询用户当前生效的处罚 */
    List<Punishment> selectActiveByUser(@Param("userId") Integer userId);

    /** 处罚详情 */
    Punishment selectById(@Param("punishId") Integer punishId);

    /** 新增处罚 */
    int insert(Punishment punishment);

    /** 本地：解除处罚（仅生效中） */
    int lift(@Param("punishId") Integer punishId);

    /** A组：解除处罚 */
    int release(@Param("punishId") Integer punishId);

    /** 本地：生效中的处罚数量 */
    int countActive();

    /** A组：提交申诉 */
    int submitAppeal(@Param("punishId") Integer punishId,
                     @Param("appealReason") String appealReason);

    /** A组：复核申诉 */
    int handleAppeal(@Param("punishId") Integer punishId,
                     @Param("appealStatus") Integer appealStatus,
                     @Param("appealResult") String appealResult);

    /** A组：到期自动解除 */
    int autoExpire();

    /** A组：统计待复核申诉数 */
    int countPendingAppeals();
}
