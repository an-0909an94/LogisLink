package com.logislink.cmm.service;

import java.util.Map;

public interface RestService {

	/**
	 * 유가 정보 API 호출
	 * @param sido
	 * @param sigun
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> sendOpinetApi(Map<String, Object> map) throws Exception;
	/**
	 * 날씨 정도 API 호출
	 * @param lat
	 * @param lon
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> sendWeatherApi(Map<String, Object> map) throws Exception;

	/**
	 * 지센 ROUTER API 호출하여 거리, 시간 반환
	 * @param sLat
	 * @param sLng
	 * @param eLat
	 * @param eLng
	 * @return
	 */
	public Map<String, String> sendRouteApi(Map<String, Object> map);
}
