package com.salmon.pet.service.impl;

import com.salmon.pet.entity.Report;
import com.salmon.pet.mapper.ReportMapper;
import com.salmon.pet.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 举报管理 Service 实现类
 */
@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private ReportMapper reportMapper;

    @Override
    public List<Report> getList(Integer status, Integer targetType) {
        return reportMapper.selectList(status, targetType);
    }

    @Override
    public Report getById(Integer reportId) {
        return reportMapper.selectById(reportId);
    }

    @Override
    public boolean submit(Report report) {
        return reportMapper.insert(report) > 0;
    }

    @Override
    public List<Report> getMyList(Integer reporterId) {
        return reportMapper.selectByReporter(reporterId);
    }

    @Override
    public boolean handle(Integer reportId, Integer status, Integer handleAdmin, String handleOpinion) {
        if (reportId == null || status == null || status == 0 || status == 1) {
            return false;
        }
        return reportMapper.handle(reportId, status, handleAdmin, handleOpinion) > 0;
    }
}
