package com.salmon.pet.service.impl;

import com.salmon.pet.entity.HelpRequest;
import com.salmon.pet.mapper.HelpRequestMapper;
import com.salmon.pet.service.HelpRequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 求助信息 Service 实现类
 */
@Service
public class HelpRequestServiceImpl implements HelpRequestService {

    @Autowired
    private HelpRequestMapper helpRequestMapper;

    @Override
    public boolean publish(HelpRequest helpRequest) {
        return helpRequestMapper.insertHelpRequest(helpRequest) > 0;
    }

    @Override
    public List<HelpRequest> getPublicList(Integer type, Integer handleStatus) {
        return helpRequestMapper.selectPublicList(type, handleStatus);
    }

    @Override
    public HelpRequest getById(Integer helpId) {
        return helpRequestMapper.selectById(helpId);
    }

    @Override
    public List<HelpRequest> getMyList(Integer userId) {
        return helpRequestMapper.selectMyList(userId);
    }

    @Override
    public List<HelpRequest> getAdminList(Integer auditStatus) {
        return helpRequestMapper.selectAdminList(auditStatus);
    }

    @Override
    public boolean audit(Integer helpId, Integer auditStatus, String auditOpinion) {
        return helpRequestMapper.auditHelpRequest(helpId, auditStatus, auditOpinion) > 0;
    }

    @Override
    public boolean updateHandleStatus(Integer helpId, Integer handleStatus) {
        return helpRequestMapper.updateHandleStatus(helpId, handleStatus) > 0;
    }
}
