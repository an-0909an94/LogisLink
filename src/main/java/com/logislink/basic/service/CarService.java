package com.logislink.basic.service;

import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.CarVO;

public interface CarService {
	
	public List<CarVO> getCarList(Map<String, Object> map);
	
	public int getCnt(Map<String, Object> map);

	public List<CarVO> getSearchCar(Map<String, Object> map);
	
	public int getSearchCarCnt(Map<String, Object> map) ;
	
	public void insertCar(Map<String, Object> map);
	
	public List<Map<String, Object>> getSendPushDriverList(Map<String, Object> map);
	
	public List<Map<String, Object>> getSendTalkDriverList(Map<String, Object> map);

	public void updateCarSctnCode(Map<String, Object> map);
}
