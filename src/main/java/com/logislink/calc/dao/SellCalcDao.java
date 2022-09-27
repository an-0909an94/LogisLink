package com.logislink.calc.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.calc.vo.SellCalcVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("sellCalcDao")
public class SellCalcDao extends EgovAbstractMapper{

	public List<SellCalcVO> getSellCalcList(Map<String, Object> map) {
		List<SellCalcVO> sellCalcList = selectList("sellCalcDataNS.selectSellCalcList", map);
		return sellCalcList;
	}
	
	public Map<String, Object> getSellCalcListCnt(Map<String, Object> map) {
		Map<String, Object> sellCalcListCnt = selectOne("sellCalcDataNS.selectSellCalcListCnt", map);
		return sellCalcListCnt;
	}
	
	public Map<String, Object> selectTaxBizInfo(Map<String, Object> map) {
		Map<String, Object> taxBizInfo = selectOne("sellCalcDataNS.selectTaxBizInfo", map);
		return taxBizInfo;
	}
	
	public Map<String, Object> selectSupplierTaxBizInfo(Map<String, Object> map) {
		Map<String, Object> supplierTaxBizInfo = selectOne("sellCalcDataNS.selectSupplierTaxBizInfo", map);
		return supplierTaxBizInfo;
	}
	
	public Map<String, Object> selectBuyerTaxBizInfo(Map<String, Object> map) {
		Map<String, Object> buyerTaxBizInfo = selectOne("sellCalcDataNS.selectBuyerTaxBizInfo", map);
		return buyerTaxBizInfo;
	}
	
	public Map<String, Object> selectSupplierTaxDriverInfo(Map<String, Object> map) {
		Map<String, Object> supplierTaxDriverInfo = selectOne("sellCalcDataNS.selectSupplierTaxDriverInfo", map);
		return supplierTaxDriverInfo;
	}
	
	public int updatePostSendYn(Map<String, Object> map) {
		int resultCnt = update("sellCalcDataNS.updatePostSendYn", map);
		return resultCnt;
	}
	
	public int updateDeleteYn(Map<String, Object> map) {
		int resultCnt = update("sellCalcDataNS.updateDeleteYn", map);
		return resultCnt;
	}
	
	public void updateSellChangeReq(Map<String, Object> map) {
		update("sellCalcDataNS.updateSellChangeReq", map);
	}
	
	public void upsertCalcCharge(Map<String, Object> map) {
		insert("sellCalcDataNS.upsertCalcCharge", map);
	}
	
	public int updateAllocCharge(Map<String, Object> map) {
		int resultCnt = update("sellCalcDataNS.updateAllocCharge", map);
		return resultCnt;
	}
	
	public void updateSellCalcFinish(Map<String, Object> map) {
		update("sellCalcDataNS.sellCalcFinish", map);
	}
	
	public void updateSellCalcPayFinish(Map<String, Object> map) {
		update("sellCalcDataNS.sellCalcPayFinish", map);
	}
}
