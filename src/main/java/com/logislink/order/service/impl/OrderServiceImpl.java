package com.logislink.order.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import javax.annotation.Resource;

import com.logislink.order.vo.RpaVO;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.ui.jasperreports.JasperReportsUtils;

import com.logislink.basic.vo.DrvLocVO;
import com.logislink.order.dao.OrderDao;
import com.logislink.order.service.OrderService;
import com.logislink.order.vo.OrderStopVO;
import com.logislink.order.vo.OrderVO;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

@Service("orderService")
public class OrderServiceImpl implements OrderService {
	
	private Logger log = Logger.getLogger(this.getClass());
	private final String invoice_template_path = "/jasper/Invoice_template.jrxml";
	
	@Resource(name="orderDao")
	private OrderDao orderDao;

	@Override
	public List<OrderVO> getOrderList(Map<String, Object> map) {
		return orderDao.getOrderList(map);
	}

	@Override
	public Map<String,Object> getCnt(Map<String, Object> map) {
		return orderDao.getCnt(map);
	}

	@Override
	public OrderVO getOrderDetail(Map<String, Object> map) {
		return orderDao.getOrderDetail(map);
	}

	
	@Override
	public List<OrderStopVO> getOrderStop(Map<String, Object> map) {
		return orderDao.getOrderStop(map);
	}

	@Override
	public List<DrvLocVO> getOrderLbs(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.getOrderLbs(map);
	}

	@Override
	public void orderWrite(Map<String, Object> map) {
		orderDao.orderWrite(map);
	}

	@Override
	public void insertOrderStop(Map<String, Object> map) {
		// TODO Auto-generated method stub
		orderDao.insertOrderStop(map);
	}

	@Override
	public void updateOrderStopFinish(Map<String, Object> map) {
		// TODO Auto-generated method stub
		orderDao.updateOrderStopFinish(map);
	}
	
	@Override
	public int getAvgFare(Map<String, Object> map) {
		return orderDao.getAvgFare(map);
	}
	
	@Override
	public void linkWrite(Map<String, Object> map) {
		orderDao.linkWrite(map);
	}
	
	@Override
	public List<Map<String, Object>> getLinkList(Map<String, Object> map) {
		return orderDao.getLinkList(map);
	}  

	@Override
	public Map<String, Object> getAllocCharge(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.selectAllocCharge(map);
	}
	
	@Override
	public BigInteger getCharge(Map<String,Object> map) {
		return orderDao.getCharge(map);
	}

	@Override
	public void updateOrderState(Map<String, Object> map) {
		// TODO Auto-generated method stub
		orderDao.updateOrderState(map);
	}

	@Override
	public void updateOrderAlloc(Map<String, Object> map) {
		orderDao.updateOrderAlloc(map);
	}
	
	@Override
	public void updateAllocState(Map<String, Object> map) {
		// TODO Auto-generated method stub
		orderDao.updateAllocState(map);
	}

	@Override
	public HashMap<String, Object> linkCarTypeChk(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.linkCarTypeChk(map);
	}

	@Override
	public HashMap<String, Object> linkCarTonChk(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.linkCarTonChk(map);
	}

	@Override
	public HashMap<String, Object> linkDateChk(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.linkDateChk(map);
	}

	@Override
	public void linkDriverChange(Map<String, Object> map) {
		// TODO Auto-generated method stub
		orderDao.linkDriverChange(map);
	}

	@Override
	public void multOrderAllocAddInsert(Map<String, Object> map) {
		orderDao.multOrderAllocAddInsert(map);
	}

	@Override
	public void linkCancelOrder(Map<String, Object> map) {
		// TODO Auto-generated method stub
		orderDao.linkCancelOrder(map);
	}

	@Override
	public void insertAllocAddToCalc(Map<String, Object> map) {
		// TODO Auto-generated method stub
		orderDao.insertAllocAddToCalc(map);
	}

	@Override
	public void linkSettle(Map<String, Object> map) {
		// TODO Auto-generated method stub
		orderDao.linkSettle(map);
	}

	@Override
	public List<Map<String,Object>> getDriverOrderHistoryList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.getDriverOrderHistoryList(map);
	}

	@Override
	public int getDriverOrderHistoryCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.getDriverOrderHistoryCnt(map);
	}

	@Override
	public int getLinkCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.getLinkCnt(map);
	}

	@Override
	public void updateLinkDriver(Map<String, Object> map) {
		// TODO Auto-generated method stub
		orderDao.updateLinkDriver(map);
	}

	@Override
	public Map<String, Object> priceDetail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.priceDetail(map);
	}

	@Override
	public List<OrderVO> getOrderSituation(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.getOrderSituation(map);
	}

	@Override
	public List<Map<String, Object>> getOrderHistory(Map<String, Object> map) {
		return orderDao.getOrderHistory(map);
	}

	@Override
	public int getOrderHistoryCnt(Map<String, Object> map) {
		return orderDao.getOrderHistoryCnt(map);
	}

	@Override
	public List<OrderVO> getFreightControlList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.getFreightControlList(map);
	}

	@Override
	public void multOrderAllocUpdate(Map<String, Object> map) {
		// TODO Auto-generated method stub
		orderDao.multOrderAllocUpdate(map);
	}

	@Override
	public int getFreightControlCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.getFreightControlCnt(map);
	}
	@Override
	public Map<String, Object> getBasicFare(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDao.getBasicFare(map);
	}

	@Override
	public void insertRpaInfo(Map<String, Object> listMapInsert) {
		// TODO Auto-generated method stub
		orderDao.insertRpaInfo(listMapInsert);
	}
	public List<Map<String, Object>> getLinkRpaJob(Map<String, Object> map) {
		return orderDao.getLinkRpaJob(map);
	}
	@Override
	public List<RpaVO> getRpaList(Map<String, Object> param) {
		return orderDao.getRpaList(param);
	}
	@Override
	public Map<String, Object> getRpaCnt(Map<String, Object> param) {
		return orderDao.getRpaCnt(param);
	}
	public List<Map<String, Object>> getNewRunCar(Map<String, Object> map) {
		return orderDao.getNewRunCar(map);
	}
	
	public void updateNewRunOrderAlloc(Map<String, Object> map) {
		 orderDao.updateNewRunOrderAlloc(map);
	}
	
	public void updateNewRunCalc(Map<String, Object> map) {
		 orderDao.updateNewRunCalc(map);
	}
	@Override
	public List<OrderVO> getOrderAuthList(Map<String, Object> map) {
		return orderDao.getOrderAuthList(map);
	}

	@Override
	public Map<String,Object> getAuthCnt(Map<String, Object> map) {
		return orderDao.getAuthCnt(map);
	}

}
