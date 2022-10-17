package com.logislink.basic.dao;

import java.util.Map;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("postDao")
public class PostDao extends EgovAbstractMapper{

    public String getNiceDnbToken(Map<String, String> map){
        return selectOne("userDataNS.getNiceDnbToken",map);
    }

    public void updateNiceDnbToken(Map<String, String> map){
        update("userDataNS.updateNiceDnbToken", map);
    }

}
