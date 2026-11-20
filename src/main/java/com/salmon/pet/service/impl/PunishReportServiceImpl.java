package com.salmon.pet.service.impl;

import com.salmon.pet.entity.Punishment;
import com.salmon.pet.entity.ReportRecord;
import com.salmon.pet.mapper.PunishmentMapper;
import com.salmon.pet.mapper.ReportRecordMapper;
import com.salmon.pet.service.PunishReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PunishReportServiceImpl implements PunishReportService {

    @Autowired
    private ReportRecordMapper reportMapper;

    @Autowired
    private PunishmentMapper punishmentMapper;

    // ==================== 举报 ====================

    @Override
    public String submitReport(ReportRecord report) {
        if (report.getReporterId() == null) {
            return "请先登录再举报";
        }
        if (report.getTargetType() == null || report.getTargetId() == null) {
            return "举报对象无效";
        }
        if (report.getReason() == null || report.getReason().trim().isEmpty()) {
            return "请填写举报原因";
        }
        // 不能重复举报同一对象(待处理状态下)
        List<ReportRecord> myList = reportMapper.selectByReporter(report.getReporterId());
        for (ReportRecord r : myList) {
            if (r.getStatus() == 1 && r.getTargetType().equals(report.getTargetType())
                    && r.getTargetId().equals(report.getTargetId())) {
                return "您已举报过该对象，请等待处理";
            }
        }
        reportMapper.insert(report);
        return null;
    }

    @Override
    public List<ReportRecord> myReports(Integer userId) {
        return reportMapper.selectByReporter(userId);
    }

    @Override
    public List<ReportRecord> listReports(Integer status) {
        return reportMapper.selectList(status);
    }

    @Override
    @Transactional
    public boolean handleReport(Integer reportId, Integer status, String handleResult, Integer adminId) {
        return reportMapper.handle(reportId, status, handleResult, adminId) > 0;
    }

    // ==================== 处罚 ====================

    @Override
    public String addPunishment(Punishment punishment) {
        if (punishment.getUserId() == null) {
            return "被处罚用户不能为空";
        }
        if (punishment.getType() == null) {
            return "请选择处罚类型";
        }
        if (punishment.getReason() == null || punishment.getReason().trim().isEmpty()) {
            return "请填写处罚原因";
        }
        punishmentMapper.insert(punishment);
        return null;
    }

    @Override
    public List<Punishment> myPunishments(Integer userId) {
        // 查询时先执行到期自动解除
        punishmentMapper.autoExpire();
        return punishmentMapper.selectByUser(userId);
    }

    @Override
    public List<Punishment> listPunishments(Integer status, String username) {
        punishmentMapper.autoExpire();
        return punishmentMapper.selectList(status, username);
    }

    @Override
    public boolean releasePunishment(Integer punishId) {
        return punishmentMapper.release(punishId) > 0;
    }

    @Override
    public String submitAppeal(Integer punishId, Integer userId, String appealReason) {
        Punishment p = punishmentMapper.selectById(punishId);
        if (p == null) {
            return "处罚记录不存在";
        }
        if (!p.getUserId().equals(userId)) {
            return "无权申诉他人的处罚";
        }
        if (p.getAppealStatus() != null && p.getAppealStatus() == 1) {
            return "申诉已提交，请等待复核";
        }
        if (appealReason == null || appealReason.trim().isEmpty()) {
            return "请填写申诉理由";
        }
        punishmentMapper.submitAppeal(punishId, appealReason);
        return null;
    }

    @Override
    public boolean handleAppeal(Integer punishId, Integer appealStatus, String appealResult) {
        return punishmentMapper.handleAppeal(punishId, appealStatus, appealResult) > 0;
    }

    @Override
    public void autoExpire() {
        punishmentMapper.autoExpire();
    }

    @Override
    public int countPendingReports() {
        return reportMapper.countByStatus(1);
    }

    @Override
    public int countPendingAppeals() {
        return punishmentMapper.countPendingAppeals();
    }
}
