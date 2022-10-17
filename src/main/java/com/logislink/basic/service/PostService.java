package com.logislink.basic.service;

import java.util.Map;

public interface PostService {
	
	public String selectNDToken(Map<String, String> map);

	public void updateNDToken(Map<String, String> map);

}
