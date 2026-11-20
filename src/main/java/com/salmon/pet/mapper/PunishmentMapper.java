package com.salmon.pet.mapper;

import com.salmon.pet.entity.Punishment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 处罚记录数据访问 (A组)
 */
public interface PunishmentMapper {

    /** 新增处罚 */
    int insert(Punishment punishment);

    /** 我的处罚记录(前台查看处罚状态) */
    List<Punishment> selectByUser(@Param("userId") Integer userId);

    /** 查询用户当前生效的处罚(登录风控用) */
    List<Punishment> selectActiveByUser(@Param("userId") Integer userId);

    /** 后台处罚列表 */
    List<Punishment> selectList(@Param("status") Integer status, @Param("username") String username);

    /** 根据ID查询 */
    Punishment selectById(@Param("punishId") Integer punishId);

    /** 解除处罚 */
    int release(@Param("punishId") Integer punishId);

    /** 提交申诉 */
    int submitAppeal(@Param("punishId") Integer punishId, @Param("appealReason") String appealReason);

    /** 复核申诉(通过则解除处罚) */
    int handleAppeal(@Param("punishId") Integer punishId,
                     @Param("appealStatus") Integer appealStatus,
                     @Param("appealResult") String appealResult);

    /** 到期自动解除(定时任务/登录时调用) */
    int autoExpire();

    /** 统计待复核申诉数 */
    int countPendingAppeals();
}
