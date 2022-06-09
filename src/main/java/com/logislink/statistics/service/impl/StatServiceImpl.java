package com.logislink.statistics.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.logislink.statistics.dao.StatDao;
import com.logislink.statistics.service.StatService;
import com.logislink.statistics.vo.StatVO;

@Service("statService")
public class StatServiceImpl implements StatService {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="statDao")
	private StatDao statDao;

	@Override
	public List<StatVO> getStatDispatch(Map<String, Object> map) {
		return statDao.getStatDispatch(map);
	}
	
	@Override
	public List<StatVO> getStatDispatchGrid(Map<String, Object> map) {
		return statDao.getStatDispatchGrid(map);
	}

	@Override
	public int getStatDispatchGridCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return statDao.getStatDispatchGridCount(map);
	}
	
	@Override
	public List<StatVO> getStatAllocation(Map<String, Object> map) {
		return statDao.getStatAllocation(map);
	}
	
	@Override
	public List<StatVO> getStatAllocationGrid(Map<String, Object> map) {
		return statDao.getStatAllocationGrid(map);
	}
	
	@Override
	public int getStatAllocationGridCount(Map<String, Object> map) {
		return statDao.getStatAllocationGridCount(map);
	}
	
	@Override
	public List<StatVO> getStatUrgent(Map<String, Object> map) {
		return statDao.getStatUrgent(map);
	}
	
	@Override
	public List<StatVO> getStatUrgentGrid(Map<String, Object> map) {
		return statDao.getStatUrgentGrid(map);
	}
	
	@Override
	public int getStatUrgentGridCount(Map<String, Object> map) {
		return statDao.getStatUrgentGridCount(map);
	}
	
	@Override
	public List<StatVO> getStatEnter(Map<String, Object> map) {
		return statDao.getStatEnter(map);
	}
	
	@Override
	public List<StatVO> getStatEnterGrid(Map<String, Object> map) {
		return statDao.getStatEnterGrid(map);
	}
	
	@Override
	public int getStatEnterGridCount(Map<String, Object> map) {
		return statDao.getStatEnterGridCount(map);
	}
	
	@Override
	public List<StatVO> getStatArrival(Map<String, Object> map) {
		return statDao.getStatArrival(map);
	}
	
	@Override
	public List<StatVO> getStatArrivalGrid(Map<String, Object> map) {
		return statDao.getStatArrivalGrid(map);
	}
	
	@Override
	public int getStatArrivalGridCount(Map<String, Object> map) {
		return statDao.getStatArrivalGridCount(map);
	}
	
	@Override
	public List<StatVO> getStatLoad(Map<String, Object> map) {
		return statDao.getStatLoad(map);
	}
	
	@Override
	public List<StatVO> getStatLoadGrid(Map<String, Object> map) {
		return statDao.getStatLoadGrid(map);
	}
	
	@Override
	public int getStatLoadGridCount(Map<String, Object> map) {
		return statDao.getStatLoadGridCount(map);
	}
	
	@Override
	public List<StatVO> getStatCharge(Map<String, Object> map) {
		return statDao.getStatCharge(map);
	}
	
	@Override
	public List<StatVO> getStatChargeGrid(Map<String, Object> map) {
		return statDao.getStatChargeGrid(map);
	}
	
	@Override
	public int getStatChargeGridCount(Map<String, Object> map) {
		return statDao.getStatChargeGridCount(map);
	}
	
	@Override
	public List<StatVO> getStatTonCharge(Map<String, Object> map) {
		return statDao.getStatTonCharge(map);
	}
	
	@Override
	public List<StatVO> getStatTonChargeGrid(Map<String, Object> map) {
		return statDao.getStatTonChargeGrid(map);
	}
	
	@Override
	public int getStatTonChargeGridCount(Map<String, Object> map) {
		return statDao.getStatTonChargeGridCount(map);
	}
}
