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
	
	// 22.07.09 이건욱 T1 > J5, J6 배차관리 기능개선 (거래처명 조회)
	@Override
	public List<Map<String, Object>> getCustName(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderBundleDao.selectCustName(map);
	}

	// 22.07.09 이건욱 T1 > J5, J6 배차관리 기능개선 (부서명 조회)
	@Override
	public List<Map<String, Object>> getDeptName(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderBundleDao.selectDeptName(map);
	}
	
	// 22.07.11 이건욱 T1 > J5, J6 배차관리 기능개선 (코드 명으로 코드 아이디 조회)
	@Override
	public List<Map<String, Object>> getCodeId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderBundleDao.selectCodeId(map);
	}
	
	// 22.7.12 이건욱 T1 > J6 배차일괄등록 편의성 개선 (차량번호로 차량조회)
	@Override
	public List<Map<String, Object>> getVehicInfo(Map<String, String> map) {
		return orderBundleDao.selectVehicInfo(map);
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
