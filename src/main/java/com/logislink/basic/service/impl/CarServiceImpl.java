package com.logislink.basic.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.basic.dao.CarDao;
import com.logislink.basic.service.CarService;
import com.logislink.basic.vo.CarVO;

@Service("carService")
public class CarServiceImpl implements CarService {
	
	@Resource(name="carDao")
	private CarDao carDao;

	@Override
	public List<CarVO> getCarList(Map<String, Object> map) {
		return carDao.getCarList(map);
	}

	@Override
	public int getCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return carDao.getCnt(map);
	}

	@Override
	public List<CarVO> getSearchCar(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return carDao.getSearchCar(map);
	}

	@Override
	public int getSearchCarCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return carDao.getSearchCarCnt(map);
	}
	
	@Override
	public void insertCar(Map<String, Object> map) {
		// TODO Auto-generated method stub
		carDao.insertCar(map);
	}

	@Override
	public List<Map<String, Object>> getSendPushDriverList(Map<String, Object> map) {
		return carDao.getSendPushDriverList(map);
	}

	@Override
	public List<Map<String, Object>> getSendTalkDriverList(Map<String, Object> map) {
		return carDao.getSendTalkDriverList(map);
	}
	
	@Override
	public void updateCarSctnCode(Map<String, Object> map) {
		// TODO Auto-generated method stub
		carDao.updateCarSctnCode(map);
	}

}
