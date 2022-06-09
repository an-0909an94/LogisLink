package com.logislink.omsOrder.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.omsOrder.vo.OmsOrderVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("omsOrderDao")
public class OmsOrderDao  extends EgovAbstractMapper {
	
	public List<OmsOrderVO> getOmsOrderList(Map<String, Object> map){
		return selectList("omsOrderDataNS.selectOmsOrderList", map);
	}
	
	public int getCnt(Map<String, Object> map) {
		String cnt = selectOne("omsOrderDataNS.selectOmsOrderCnt", map);
		return Integer.valueOf(cnt);
	}

	public List<Map<String, Object>> selectCustId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectList("omsOrderDataNS.selectCustId", map);
	}

	public void insertOrderBundle(Map<String, Object> map) {
		// TODO Auto-generated method stub
		insert("omsOrderDataNS.insertOrderBundle", map);
		insert("omsOrderDataNS.insertOrderAllocBundle", map);
	}

	public List<OmsOrderVO> getOmsOrderLocationList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectList("omsOrderDataNS.selectOmsOrderLocationList", map);
	}

	public int getOmsOrderLocationCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String cnt = selectOne("omsOrderDataNS.selectOmsOrderLocationCnt", map);
		return Integer.valueOf(cnt);
	}

	public Map<String, Object> getOmsOrderSummary(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectOne("omsOrderDataNS.getOmsOrderSummary", map);
	}

	public void orderWrite(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("omsOrderDataNS.orderWrite", map);
	}
}
