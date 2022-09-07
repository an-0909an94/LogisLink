package com.logislink.calc.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.calc.dao.BuyCalcDao;
import com.logislink.calc.service.BuyCalcService;
import com.logislink.calc.vo.BuyCalcVO;

@Service("buyCalcService")
public class BuyCalcServiceImpl implements BuyCalcService {
	@Resource(name="buyCalcDao")
	private BuyCalcDao buyCalcDao;

	@Override
	public List<BuyCalcVO> getBuyCalcList(Map<String, Object> map) {
		return buyCalcDao.getBuyCalcList(map);
	}
	
	@Override
	public Map<String, Object> getBuyCalcListCnt(Map<String, Object> map) {
		return buyCalcDao.getBuyCalcListCnt(map);
	}
	
	@Override
	public Map<String, Object> selectTaxinv(Map<String, Object> map) {
		return buyCalcDao.selectTaxinv(map);
	}
	
	@Override
	public List<Map<String, Object>> selectTaxinvDetailList(Map<String, Object> map) {
		return buyCalcDao.selectTaxinvDetailList(map);
	}
	
	@Override
	public int updateReceiptSub(Map<String, Object> map) {
		return buyCalcDao.updateReceiptSub(map);
	}

	@Override
	public int updateTaxinvSub(Map<String, Object> map) {
		return buyCalcDao.updateTaxinvSub(map);
	}
	
	@Override
	public int updateDeleteYn(Map<String, Object> map) {
		return buyCalcDao.updateDeleteYn(map);
	}
	
	@Override
	public void upsertCalcCharge(Map<String, Object> map) {
		buyCalcDao.upsertCalcCharge(map);
	}
	
	@Override
	public void updateBuyCalcFinish(Map<String, Object> map) {
		buyCalcDao.updateBuyCalcFinish(map);
	}
}
