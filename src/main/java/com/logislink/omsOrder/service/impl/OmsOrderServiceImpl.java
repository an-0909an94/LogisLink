package com.logislink.omsOrder.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.omsOrder.dao.OmsOrderDao;
import com.logislink.omsOrder.service.OmsOrderService;
import com.logislink.omsOrder.vo.OmsOrderVO;

@Service("omsOrderService")
public class OmsOrderServiceImpl implements OmsOrderService {
	
	@Resource(name="omsOrderDao")
	private OmsOrderDao omsOrderDao;
	
	@Override
	public List<OmsOrderVO> getOmsOrderList(Map<String, Object> map) {
		return omsOrderDao.getOmsOrderList(map);
	}

	@Override
	public int getCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return omsOrderDao.getCnt(map);
	}

	@Override
	public List<Map<String, Object>> getCustId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return omsOrderDao.selectCustId(map);
	}

	@Override
	public void insertOrderBundle(Map<String, Object> map) {
		// TODO Auto-generated method stub
		omsOrderDao.insertOrderBundle(map);
	}

	@Override
	public List<OmsOrderVO> getOmsOrderLocationList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return omsOrderDao.getOmsOrderLocationList(map);
	}

	@Override
	public int getOmsOrderLocationCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return omsOrderDao.getOmsOrderLocationCnt(map);
	}

	@Override
	public Map<String, Object> getOmsOrderSummary(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return omsOrderDao.getOmsOrderSummary(map);
	}

	@Override
	public void orderWrite(Map<String, Object> map) {
		// TODO Auto-generated method stub
		omsOrderDao.orderWrite(map);
	}

}
