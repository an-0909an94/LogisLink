package com.logislink.omsIndicators.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.omsIndicators.service.OmsIndicatorService;

@Controller
public class OmsIndicatorsController {

	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "Z5910";
	
	@Resource(name="omsIndicatorService")
	private OmsIndicatorService omsIndicatorService;
	
	@GetMapping(value="/oms/indicators/indicatorsGroup.do")
	public String indicatorsGroup(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);
		model.put("menuAuth", loginMenu);
		
		return "oms/indicators/indicatorsGroup";
	}
	
	@GetMapping(value="/oms/indicators/kpiDay.do")
	public String kpiDay(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "oms/indicators/view/kpiDay";
	}
	
	@GetMapping(value="/oms/indicators/kpiMonth.do")
	public String kpiMonth(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "oms/indicators/view/kpiMonth";
	}
	
	@GetMapping(value="/oms/indicators/chargeDay.do")
	public String chargeDay(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "oms/indicators/view/chargeDay";
	}
	
	@GetMapping(value="/oms/indicators/chargeMonth.do")
	public String chargeMonth(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "oms/indicators/view/chargeMonth";
	}

	@PostMapping(value="/oms/indicators/data/kpiDay.do")
	public String kpiDayData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
							@RequestParam Map<String, Object> param ) throws Exception {
		
		if(param.get("orderStates") != null && !"".equals(param.get("orderStates"))) {
			List<String> tmpList = Arrays.asList(((String)param.get("orderStates")).split(","));
			List<String> stateList = new ArrayList<String>();
			for(int i=0; i<tmpList.size(); i++) {
				stateList.add(tmpList.get(i));
				if("01".equals(tmpList.get(i))) {
					stateList.add("04");
					stateList.add("12");
				}
			}
			param.put("stateList", stateList);
		}
		
		List<Map<String, Object>> data = omsIndicatorService.getKpiDaily(param);
		
		map.put("resutl", Boolean.TRUE);
		map.put("data", data);
		
		return "jsonView";
	}

	@PostMapping(value="/oms/indicators/data/kpiMonth.do")
	public String kpiMonthData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
							@RequestParam Map<String, Object> param ) throws Exception {
		
		if(param.get("orderStates") != null && !"".equals(param.get("orderStates"))) {
			List<String> tmpList = Arrays.asList(((String)param.get("orderStates")).split(","));
			List<String> stateList = new ArrayList<String>();
			for(int i=0; i<tmpList.size(); i++) {
				stateList.add(tmpList.get(i));
				if("01".equals(tmpList.get(i))) {
					stateList.add("04");
					stateList.add("12");
				}
			}
			param.put("stateList", stateList);
		}
		
		List<Map<String, Object>> data = omsIndicatorService.getKpiMonthly(param);
		
		map.put("resutl", Boolean.TRUE);
		map.put("data", data);
		
		return "jsonView";
	}

	@PostMapping(value="/oms/indicators/data/chargeDay.do")
	public String chargeDayData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
							@RequestParam Map<String, Object> param ) throws Exception {
		
		if(param.get("orderStates") != null && !"".equals(param.get("orderStates"))) {
			List<String> tmpList = Arrays.asList(((String)param.get("orderStates")).split(","));
			List<String> stateList = new ArrayList<String>();
			for(int i=0; i<tmpList.size(); i++) {
				stateList.add(tmpList.get(i));
				if("01".equals(tmpList.get(i))) {
					stateList.add("04");
					stateList.add("12");
				}
			}
			param.put("stateList", stateList);
		}
		
		List<Map<String, Object>> data = omsIndicatorService.getChargeDaily(param);
		
		map.put("resutl", Boolean.TRUE);
		map.put("data", data);
		
		return "jsonView";
	}

	@PostMapping(value="/oms/indicators/data/chargeMonth.do")
	public String chargMonthData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
							@RequestParam Map<String, Object> param ) throws Exception {
		
		if(param.get("orderStates") != null && !"".equals(param.get("orderStates"))) {
			List<String> tmpList = Arrays.asList(((String)param.get("orderStates")).split(","));
			List<String> stateList = new ArrayList<String>();
			for(int i=0; i<tmpList.size(); i++) {
				stateList.add(tmpList.get(i));
				if("01".equals(tmpList.get(i))) {
					stateList.add("04");
					stateList.add("12");
				}
			}
			param.put("stateList", stateList);
		}
		
		List<Map<String, Object>> data = omsIndicatorService.getChargeMonthly(param);
		
		map.put("resutl", Boolean.TRUE);
		map.put("data", data);
		
		return "jsonView";
	}
}
