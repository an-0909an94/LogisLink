package com.logislink.basic.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.logislink.basic.dao.MenuDao;
import com.logislink.basic.service.MenuService;
import com.logislink.basic.vo.MenuVO;

@Service("menuService")
public class MenuServiceImpl implements MenuService {
	
	@Resource(name="menuDao")
	private MenuDao menuDao;

	@Override
	public List<MenuVO> selectMenuList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return menuDao.getMenu(map);
	}

	@Override
	public void insertMenu(Map<String, Object> map) {
		// TODO Auto-generated method stub
		menuDao.insert(map);
	}

	@Override
	public void updateSort(Map<String, Object> map) {
		// TODO Auto-generated method stub
		menuDao.updateSort(map);
	}

	@Override
	public void updateMenuGuide(Map<String, Object> map) {
		// TODO Auto-generated method stub
		menuDao.updateMenuGuide(map);
	}

}
