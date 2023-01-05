package com.logislink.deadLine.service.Impl;

import com.logislink.deadLine.dao.DeadLineDao;
import com.logislink.deadLine.service.DeadLineService;
import com.logislink.deadLine.vo.DeadLineVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("deadLineService")
public class DeadLineServiceImpl implements DeadLineService {
    @Resource(name="deadLineDao")
    private DeadLineDao deadLineDao;

    @Override
    public List<DeadLineVO> getBuyCalcList(Map<String, Object> map) {
        return deadLineDao.getBuyCalcList(map);
    }

    @Override
    public Map<String, Object> getBuyCalcListCnt(Map<String, Object> map) {
        return deadLineDao.getBuyCalcListCnt(map);
    }
}
