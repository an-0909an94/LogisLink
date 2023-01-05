package com.logislink.deadLine.dao;

import com.logislink.deadLine.vo.DeadLineVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("deadLineDao")
public class DeadLineDao extends EgovAbstractMapper {
    public List<DeadLineVO> getBuyCalcList(Map<String, Object> map) {
        List<DeadLineVO> buyCalcList = selectList("deadLineDataNS.deadLineList", map);
        return buyCalcList;
    }

    public Map<String, Object> getBuyCalcListCnt(Map<String, Object> map) {
        Map<String, Object> buyCalcListCnt = selectOne("deadLineDataNS.deadLineListCnt", map);
        return buyCalcListCnt;
    }
}
