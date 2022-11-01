package com.logislink.order.dao;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.DrvLocVO;
import com.logislink.order.vo.OrderStopVO;
import com.logislink.order.vo.OrderVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("orderDao")
public class OrderDao extends EgovAbstractMapper {
	
	public List<OrderVO> getOrderList(Map<String, Object> map){
		return selectList("orderDataNS.selectOrderArrange", map);
	}
	
	public Map<String,Object> getCnt(Map<String, Object> map) {
		return selectOne("orderDataNS.selectOrderCnt", map);
	}
	
	public OrderVO getOrderDetail(Map<String, Object> map) {
		return selectOne("orderDataNS.selectOrderDetail", map);
	}
	
	public List<OrderStopVO> getOrderStop(Map<String, Object> map) {
		return selectList("orderDataNS.selectOrderStop", map);
	}
	
	public List<DrvLocVO> getOrderLbs(Map<String, Object> map) {
		return selectList("orderDataNS.selectOrderLBS", map);
	}
	
	public void orderWrite(Map<String, Object> map) {
		update("orderDataNS.orderWrite", map);		
	}
	public void insertOrderStop(Map<String, Object> map) {
		insert("orderDataNS.insertOrderStop", map);
	}

	public void updateOrderStopFinish(Map<String, Object> map) {
		update("orderDataNS.updateOrderStopFinish", map);
	}
	
	public void updateOrderState(Map<String, Object> map) {
		update("orderDataNS.updateOrderState", map);
	}
	
	public void updateOrderAlloc(Map<String, Object> map) {
		update("orderDataNS.updateOrderAlloc", map);
	}
	
	public void updateAllocState(Map<String, Object> map) {
		update("orderDataNS.updateAllocState", map);
	}
	
	public int getAvgFare(Map<String, Object> map) {
		String avgFare = selectOne("orderDataNS.getAvgFare", map);
		return Integer.valueOf(avgFare);
	}
	
	public void linkWrite(Map<String, Object> map) {
		update("orderDataNS.linkWrite", map);		
	}
	
	public List<Map<String, Object>> getLinkList(Map<String, Object> map) {
		return selectList("orderDataNS.getLinkList", map);
	}
	
	public Map<String, Object> selectAllocCharge(Map<String, Object> map) {
		return selectOne("orderDataNS.selectAllocCharge", map);
	}
	
	public BigInteger getCharge(Map<String, Object> map) {
		return selectOne("orderDataNS.getCharge", map);
	}
	
	public HashMap<String, Object> linkCarTypeChk(Map<String, Object> map) {
		HashMap<String, Object> ret = selectOne("orderDataNS.linkCarTypeChk", map);
		return ret;
	}

	public HashMap<String, Object> linkCarTonChk(Map<String, Object> map) {
		HashMap<String, Object> ret = selectOne("orderDataNS.linkCarTonChk", map);
		return ret;
	}

	public HashMap<String, Object> linkDateChk(Map<String, Object> map) {
		HashMap<String, Object> ret = selectOne("orderDataNS.linkDateChk", map);
		return ret;
	}

	public void linkDriverChange(Map<String, Object> map) {
		update("orderDataNS.linkDriverChange", map);
	}

	public void multOrderAllocAddInsert(Map<String, Object> map) {
		insert("orderDataNS.multOrderAllocAddInsert", map);
	}

	public void linkCancelOrder(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("orderDataNS.linkCancelOrder", map);
	}
	
	public void insertAllocAddToCalc(Map<String, Object> map) {
		update("orderDataNS.insertAllocAddToCalc", map);
	}

	public void linkSettle(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("orderDataNS.linkSettle", map);
	}

	public List<Map<String,Object>> getDriverOrderHistoryList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectList("orderDataNS.getDriverOrderHistoryList", map);
	}

	public int getDriverOrderHistoryCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String cnt = selectOne("orderDataNS.getDriverOrderHistoryCnt", map);
		return Integer.valueOf(cnt);
	}

	public int getLinkCnt(Map<String, Object> map) {
		String cnt = selectOne("orderDataNS.getLinkListCnt",map);
		return Integer.valueOf(cnt);
	}

	public Object updateLinkDriver(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return update("orderDataNS.updateLinkDriver", map);
	}

	public Map<String, Object> priceDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectOne("orderDataNS.priceDetail", map);
	}

	public List<OrderVO> getOrderSituation(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectList("orderDataNS.getOrderSituation", map);
	}
	
	public void insertOrderWeather(Map<String, String> map) {
		insert("orderDataNS.insertOrderWeather", map);
	}

	public List<Map<String, Object>> getOrderHistory(Map<String, Object> map) {
		return selectList("orderDataNS.getOrderHistory", map);
	}

	public int getOrderHistoryCnt(Map<String, Object> map) {
		String cnt = selectOne("orderDataNS.getOrderHistoryCnt", map);
		return Integer.valueOf(cnt);
	}

	public List<OrderVO> getFreightControlList(Map<String, Object> map) {
		return selectList("orderDataNS.getFreightControlList", map);
	}

	public void multOrderAllocUpdate(Map<String, Object> map) {
		update("orderDataNS.multOrderAllocUpdate", map);
	}

	public int getFreightControlCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String cnt = selectOne("orderDataNS.getFreightControlCnt",map);
		return Integer.valueOf(cnt);
	}
	public Map<String, Object> getBasicFare(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return selectOne("orderDataNS.getBasicFare", map);
	}
}
