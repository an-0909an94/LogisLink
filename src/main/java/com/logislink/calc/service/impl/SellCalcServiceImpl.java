package com.logislink.calc.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.calc.dao.SellCalcDao;
import com.logislink.calc.service.SellCalcService;
import com.logislink.calc.vo.SellCalcVO;

@Service("sellCalcService")
public class SellCalcServiceImpl implements SellCalcService {
	@Resource(name="sellCalcDao")
	private SellCalcDao sellCalcDao;

	@Override
	public List<SellCalcVO> getSellCalcList(Map<String, Object> map) {
		return sellCalcDao.getSellCalcList(map);
	}
	
	@Override
	public int getSellCalcListCnt(Map<String, Object> map) {
		return sellCalcDao.getSellCalcListCnt(map);
	}
	
	@Override
	public int updatePostSendYn(Map<String, Object> map) {
		return sellCalcDao.updatePostSendYn(map);
	}
	
	@Override
	public int updateDeleteYn(Map<String, Object> map) {
		return sellCalcDao.updateDeleteYn(map);
	}
	
	@Override
	public void updateSellChangeReq(Map<String, Object> map) {
		sellCalcDao.updateSellChangeReq(map);
	}

	@Override
	public void upsertCalcCharge(Map<String, Object> map) {
		sellCalcDao.upsertCalcCharge(map);
	}
}
