package com.logislink.cmm.service;

import com.logislink.cmm.vo.TermsAgreeVO;
import com.logislink.cmm.vo.TermsVO;
import java.util.List;
import java.util.Map;

public interface TermsService {
    public List<TermsVO> getTermsValueList(Map<String, Object> map);

    public TermsAgreeVO getTermsUserAgree(Map<String, Object> map);

    public TermsAgreeVO getTermsTelAgree(Map<String, Object> map);

    public int insertTermsAgree(Map<String, Object> map);

    public int updateTermsAgree(Map<String, Object> map);

}
