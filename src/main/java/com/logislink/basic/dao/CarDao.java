package com.logislink.basic.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.CarVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("carDao")
public class CarDao extends EgovAbstractMapper{
	
	public List<CarVO> getCarList(Map<String, Object> map) {
		return selectList("carDataNS.selectCarList", map);
	}

	public int getCnt(Map<String, Object> map) {
		String cnt = selectOne("carDataNS.selectCarCnt",map);
		return Integer.valueOf(cnt);
	}
	
	public List<CarVO> getSearchCar(Map<String, Object> map) {
		return selectList("carDataNS.selectSearchCar", map);
	}
	
	public int getSearchCarCnt(Map<String, Object> map) {
		String cnt = selectOne("carDataNS.selectSearchCarCnt",map);
		return Integer.valueOf(cnt);
	}
	
	public void insertCar(Map<String, Object> map) {
		update("carDataNS.insertCar", map);		
	} 
	public List<Map<String, Object>> getSendPushDriverList(Map<String, Object> map) {
		return selectList("carDataNS.selectSendPushDriverList", map);
	}
	public List<Map<String, Object>> getSendTalkDriverList(Map<String, Object> map) {
		return selectList("carDataNS.selectSendTalkDriverList", map);
	}
	public void updateCarSctnCode(Map<String, Object> map) {
		// TODO Auto-generated method stub
		update("carDataNS.updateCarSctnCode", map);
	}
}
