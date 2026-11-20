package com.salmon.pet.service.impl;

import com.salmon.pet.entity.HelpRequest;
import com.salmon.pet.entity.HelpResponse;
import com.salmon.pet.mapper.HelpRequestMapper;
import com.salmon.pet.mapper.HelpResponseMapper;
import com.salmon.pet.service.HelpResponseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 求助响应 Service 实现类
 */
@Service
public class HelpResponseServiceImpl implements HelpResponseService {

    @Autowired
    private HelpResponseMapper helpResponseMapper;

    @Autowired
    private HelpRequestMapper helpRequestMapper;

    @Override
    public List<HelpResponse> getByHelp(Integer helpId) {
        return helpResponseMapper.selectByHelp(helpId);
    }

    @Override
    public List<HelpResponse> getList(Integer status) {
        return helpResponseMapper.selectList(status);
    }

    @Override
    public List<HelpResponse> getMyResponses(Integer responderId) {
        return helpResponseMapper.selectByResponder(responderId);
    }

    @Override
    public String respond(Integer helpId, Integer responderId, String content) {
        if (helpId == null || responderId == null) {
            return "参数不完整";
        }
        if (content == null || content.trim().isEmpty()) {
            return "请填写响应内容";
        }
        HelpRequest help = helpRequestMapper.selectById(helpId);
        if (help == null) {
            return "求助信息不存在";
        }
        if (help.getAuditStatus() == null || help.getAuditStatus() != 2) {
            return "该求助尚未通过审核，暂不能响应";
        }
        if (help.getHandleStatus() != null
                && (help.getHandleStatus() == 4 || help.getHandleStatus() == 5)) {
            return "该求助已结束，暂不能响应";
        }
        if (help.getUserId() != null && help.getUserId().equals(responderId)) {
            return "不能响应自己发布的求助";
        }
        if (helpResponseMapper.selectExisting(helpId, responderId) != null) {
            return "你已响应过该求助";
        }

        HelpResponse response = new HelpResponse();
        response.setHelpId(helpId);
        response.setResponderId(responderId);
        response.setContent(content.trim());
        return helpResponseMapper.insert(response) > 0 ? null : "响应提交失败";
    }

    @Override
    public boolean updateStatus(Integer respId, Integer status) {
        if (respId == null || status == null || status < 1 || status > 3) {
            return false;
        }
        return helpResponseMapper.updateStatus(respId, status) > 0;
    }
}
