package com.logislink.cmm.service.impl;

import com.logislink.cmm.dao.TermsDao;
import com.logislink.cmm.service.TermsService;
import com.logislink.cmm.vo.TermsAgreeVO;
import com.logislink.cmm.vo.TermsVO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

@Service("termsService")
public class TermsServiceImpl implements TermsService {

    @Resource(name="termsDao")
    private TermsDao termsDao;

    @Override
    public List<TermsVO> getTermsValueList(Map<String, Object> map) {
        return termsDao.getTermsList(map);
    }

    @Override
    public TermsAgreeVO getTermsUserAgree(Map<String, Object> map) {
        return termsDao.getTermsUserAgree(map);
    }

    @Override
    public TermsAgreeVO getTermsTelAgree(Map<String, Object> map) {
        return termsDao.getTermsTelAgree(map);
    }

    @Override
    public int insertTermsAgree(Map<String, Object> map) {
        return termsDao.insertTermsAgree(map);
    }

    @Override
    public int updateTermsAgree(Map<String, Object> map) {
        int value = termsDao.updateTermsAgree(map);
        return value;
    }
}