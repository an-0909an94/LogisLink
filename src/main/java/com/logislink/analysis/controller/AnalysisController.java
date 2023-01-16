package com.logislink.analysis.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.logislink.analysis.service.AnalysisService;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class AnalysisController {

	private String freightAnalysisCode = "H8110";
	private String trnasportDBAnalysisCode = "H8210";
	
	@Resource(name="analysisService")
	private AnalysisService analysisService;
	
	@GetMapping(value="/contents/analysis/freight.do")
	public String freightAnalysis(HttpServletRequest request, HttpSession session, ModelMap model) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, freightAnalysisCode);
		model.put("menuAuth", loginMenu);

		return "contents/analysis/freight";
	}

	@PostMapping(value="/contents/analysis/data/freight.do")
	public String freightAnalysisData(HttpServletRequest request, HttpSession session, ModelMap map,
										@RequestParam Map<String, Object> param) {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");

		List<Map<String, Object>> area = analysisService.selectFreightAnalysisEArea(param);
		List<Map<String, Object>> stat = analysisService.selectFreightAnalysisStat(param);
		List<Map<String, Object>> data = new ArrayList<>();		
		if ("mode".equals(param.get("searchType"))) {
			data = analysisService.selectFreightAnalysisMode(param);
		} else if ("modeAll".equals(param.get("searchType"))) {
			data = analysisService.selectFreightAnalysisModeAll(param);
		} else if ("avg".equals(param.get("searchType"))) {
			data = analysisService.selectFreightAnalysisAvg(param);
		} else if ("avgAll".equals(param.get("searchType"))) {
			data = analysisService.selectFreightAnalysisAvgAll(param);
		} else if ("min".equals(param.get("searchType"))) {
			data = analysisService.selectFreightAnalysisMin(param);
		}  else if ("max".equals(param.get("searchType"))) {
			data = analysisService.selectFreightAnalysisMax(param);
		}
		
		map.put("result", Boolean.TRUE);
		map.put("area", area);
		map.put("stat", stat);
		map.put("data", data);
		
		return "jsonView";
	}
	
	@GetMapping(value="/contents/analysis/transportDB.do")
	public String transportDB(HttpServletRequest request, HttpSession session, ModelMap model) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, trnasportDBAnalysisCode);
		model.put("menuAuth", loginMenu);
				
		return "contents/analysis/transportDB";
	}
	
	@PostMapping(value="/contents/analysis/data/transportDB.do")
	public String transportDBData(HttpServletRequest request, HttpSession session, 
								ModelMap map, @RequestParam Map<String, Object> param) {

		List<Map<String, Object>> data = analysisService.selectTransportDB(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", data);
		
		return "jsonView";
	}	

}
