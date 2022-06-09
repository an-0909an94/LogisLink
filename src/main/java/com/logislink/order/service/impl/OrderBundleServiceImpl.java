package com.logislink.order.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.logislink.order.dao.OrderBundleDao;
import com.logislink.order.service.OrderBundleService;

@Service("orderBundleService")
public class OrderBundleServiceImpl implements OrderBundleService {

	private Logger log = Logger.getLogger(this.getClass());
	private final String invoice_template_path = "/jasper/Invoice_template.jrxml";
	
	@Resource(name="orderBundleDao")
	private OrderBundleDao orderBundleDao;

	
	@Override
	public List<Map<String, Object>> getCustId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderBundleDao.selectCustId(map);
	}

	@Override
	public List<Map<String, Object>> getVehicId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderBundleDao.selectVehicId(map);
	}

	@Override
	public void insertOrderBundle(Map<String, Object> map) {
		// TODO Auto-generated method stub
		orderBundleDao.insertOrderBundle(map);
	}

	@Override
	public void insertCalc(Map<String, Object> map) {
		// TODO Auto-generated method stub
		orderBundleDao.insertCalc(map);
	}
}
