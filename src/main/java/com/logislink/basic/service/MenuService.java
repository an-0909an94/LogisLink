package com.logislink.basic.service;

import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.MenuVO;

public interface MenuService {

	public List<MenuVO> selectMenuList(Map<String, Object> map);
	
	public void insertMenu(Map<String, Object> map);
	
	public void updateSort(Map<String, Object> map);
	
	public void updateMenuGuide(Map<String, Object> map);
}
