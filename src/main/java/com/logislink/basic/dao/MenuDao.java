package com.logislink.basic.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.logislink.basic.vo.MenuVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("menuDao")
public class MenuDao extends EgovAbstractMapper{

	public List<MenuVO> getMenu(Map<String, Object> map) {
		return selectList("menuDataNS.selectMenuList", map);
	}
	
	public void insert(Map<String, Object> map) {
		insert("menuDataNS.insertMenu", map);		
	} 
	
	public void updateSort(Map<String, Object> map) {
		update("menuDataNS.updateMenuSort", map);
	}
	
	public void updateMenuGuide(Map<String, Object> map) {
		update("menuDataNS.updateMenuGuide", map);
	}
	public void insertEventLog(Map<String, Object> map) {
		insert("menuDataNS.insertEventLog", map);
	}

	public List<Map<String, Object>> getMenuException(Map<String, Object> map) {
		return selectList("menuDataNS.getMenuException", map);
	}
}
