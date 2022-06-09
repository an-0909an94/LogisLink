package com.logislink.basic.service;

import java.util.List;
import java.util.Map;

import com.logislink.basic.vo.ManualVO;

public interface ManualService {

	List<ManualVO> getManualGroupList(Map<String, Object> map);

	List<ManualVO> getManualList(Map<String, Object> map);

	void insertManualGroup(Map<String, Object> map);

	void insertManual(Map<String, Object> map);

	void insertManualFile(Map<String, Object> map);

}
