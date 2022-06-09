package com.logislink.cmm.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.logislink.cmm.service.RestService;

@Controller
public class CmmRestController {

	@Autowired
	private RestService restService;

	@PostMapping(value="/cmm/getRoute.do")
	public String getRoute(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
							@RequestParam Map<String, Object> param) throws Exception {

		Map<String, String> res = restService.sendRouteApi(param);
		
		double time = Integer.valueOf(res.get("Time")) * 1.3;
		res.put("Time", String.valueOf((int)time));
		
		map.put("result", Boolean.TRUE);
		map.put("data", res);
		
		return "jsonView";
	}
	
	@PostMapping(value="/cmm/weatherInfo.do", consumes="application/x-www-form-urlencoded")
	public String weatherInfo(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param) throws Exception {
		
		Map<String, String> data = restService.sendWeatherApi(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", data);

		return "jsonView";
	}
	
	@PostMapping(value="/cmm/opinetInfo.do", consumes="application/x-www-form-urlencoded")
	public String opinetInfo(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param) throws Exception {
		
		Map<String, Object> data = restService.sendOpinetApi(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", data);

		return "jsonView";
	}
}
