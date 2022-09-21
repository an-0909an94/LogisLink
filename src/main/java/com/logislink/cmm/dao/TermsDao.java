package com.logislink.cmm.dao;

import com.logislink.cmm.vo.TermsAgreeVO;
import com.logislink.cmm.vo.TermsVO;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("termsDao")
public class TermsDao extends EgovAbstractMapper {

    public List<TermsVO> getTermsList(Map<String, Object> map){
        List<TermsVO> list = selectList("termsNS.termsRead",map);
        return list;
    }

    public TermsAgreeVO getTermsUserAgree(Map<String, Object> map){
        TermsAgreeVO data = selectOne("termsNS.termsUserSearch",map);
        return data;
    }

    public TermsAgreeVO getTermsTelAgree(Map<String, Object>map){
        TermsAgreeVO data = selectOne("termsNS.termsTelSearch",map);
        return data;
    }

    public int insertTermsAgree(Map<String, Object> map){
        int data = insert("termsNS.insertTermsAgree",map);
        return data;

    }

    public int updateTermsAgree(Map<String, Object> map){
        int value = update("termsNS.updateTermsAgree",map);
        return value;
    }

}