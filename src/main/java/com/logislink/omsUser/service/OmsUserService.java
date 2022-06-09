package com.logislink.omsUser.service;

import java.util.Map;

import com.logislink.basic.vo.UserOptionVO;

public interface OmsUserService {

	public UserOptionVO getUserOption(Map<String, Object> map);

	public void insertUserOption(Map<String, Object> map);

}
