package com.salmon.pet.mapper;

import java.util.Map;

/**
 * 后台数据看板统计 Mapper
 */
public interface DashboardMapper {

    /**
     * 查询看板统计数据
     */
    Map<String, Object> selectCounts();
}
