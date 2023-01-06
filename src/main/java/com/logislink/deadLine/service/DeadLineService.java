package com.logislink.deadLine.service;

import com.logislink.deadLine.vo.DeadLineVO;

import java.util.List;
import java.util.Map;

public interface DeadLineService {

    public List<DeadLineVO> getBuyCalcList(Map<String, Object> map);

    public Map<String, Object> getBuyCalcListCnt(Map<String, Object> map);
}
