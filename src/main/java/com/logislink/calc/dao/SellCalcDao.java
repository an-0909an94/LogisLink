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
	
	public int getSellCalcListCnt(Map<String, Object> map) {
		String sellCalcListCnt = selectOne("sellCalcDataNS.selectSellCalcListCnt", map);
		return Integer.valueOf(sellCalcListCnt);
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
}
