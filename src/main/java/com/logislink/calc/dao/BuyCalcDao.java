package com.logislink.calc.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.calc.vo.BuyCalcVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("buyCalcDao")
public class BuyCalcDao extends EgovAbstractMapper{

	public List<BuyCalcVO> getBuyCalcList(Map<String, Object> map) {
		List<BuyCalcVO> buyCalcList = selectList("buyCalcDataNS.selectBuyCalcList", map);
		return buyCalcList;
	}
	
	public Map<String, Object> getBuyCalcListCnt(Map<String, Object> map) {
		Map<String, Object> buyCalcListCnt = selectOne("buyCalcDataNS.selectBuyCalcListCnt", map);
		return buyCalcListCnt;
	}
	
	public Map<String, Object> selectTaxinv(Map<String, Object> map) {
		Map<String, Object> taxinv = selectOne("buyCalcDataNS.selectTaxinv", map);
		return taxinv;
	}
	
	public List<Map<String, Object>> selectTaxinvDetailList(Map<String, Object> map) {
		List<Map<String, Object>> taxinvDetailList = selectList("buyCalcDataNS.selectTaxinvDetailList", map);
		return taxinvDetailList;
	}
	
	public int updateReceiptSub(Map<String, Object> map) {
		int resultCnt = update("buyCalcDataNS.updateReceiptSub", map);
		return resultCnt;
	}
	
	public int updateTaxinvSub(Map<String, Object> map) {
		int resultCnt = update("buyCalcDataNS.updateTaxinvSub", map);
		return resultCnt;
	}
	
	public int updateDeleteYn(Map<String, Object> map) {
		int resultCnt = update("buyCalcDataNS.updateDeleteYn", map);
		return resultCnt;
	}
	
	public void upsertCalcCharge(Map<String, Object> map) {
		insert("buyCalcDataNS.upsertCalcCharge", map);
	}
	
	public void updateBuyCalcFinish(Map<String, Object> map) {
		update("buyCalcDataNS.updateBuyCalcFinish", map);
	}
}
