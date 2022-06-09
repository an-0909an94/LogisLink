package com.logislink.omsClac.controller;

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

import com.logislink.calc.vo.CalcVO;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;
import com.logislink.omsClac.controller.service.CalcService;

@Controller
public class OmsCalcController {
	private String calcMenuCode = "Z5410";

	@Resource(name="omsCalcService")
	private CalcService omsCalcService;
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@GetMapping(value="/oms/calc/calcList.do")
	public String getCalcList(HttpServletRequest request, HttpSession session, ModelMap model
									, @RequestParam Map<String, Object> param) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, calcMenuCode);
		model.put("menuAuth", loginMenu);
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			model.put("masterYn", "N");
		}else {
			model.put("masterYn", "Y");
		}
		
		return "oms/calc/calcList";
	}
	
	@PostMapping(value="/oms/calc/data/calcList.do")
	public String CalcList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("deptId", login.getDeptId());
		}
		List<CalcVO> calcList = omsCalcService.getCalcList(param);  
		int count = omsCalcService.getCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", calcList);
		map.put("total", count);
		
		return "jsonView";
	}
	
	@PostMapping(value="/oms/calc/data/custFinishCalc.do")
	public String custFinishCalc(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if(!EtcUtil.checkAuth(request, calcMenuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		omsCalcService.custFinishCalc(param);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", "정산 내역이 마감되었습니다.");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/oms/calc/data/multiFinishCalc.do")
	public String multiFinishCalc(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if(!EtcUtil.checkAuth(request, calcMenuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		List<String> calcIdList = Arrays.asList(((String)param.get("calcIdArr")).split(","));
		param.put("calcIdList", calcIdList);
		omsCalcService.multiFinishCalc(param);
		
		map.put("result", Boolean.TRUE);
		if("Y".equals(param.get("mode"))) {
			map.put("msg", "정산 내역이 마감되었습니다.");
		}else {
			map.put("msg", "정산 내역이 취소되었습니다.");
		}
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/oms/calc/data/newCalcCharge.do")
	public String newCalcCharge(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		if(!EtcUtil.checkAuth(request, calcMenuCode, "W")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		param.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		
		omsCalcService.newCalcCharge(param);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", (String) param.get("retMsg"));
		
		return "jsonView";
		
	}
	
	@GetMapping(value="/oms/calc/view/orderFile.do")
	public String getOrderFile(HttpServletRequest request, Model model, HttpSession httpSession, ModelMap map, 
			@RequestParam Map<String, Object> param) throws Exception {
		
		map.put("orderId", param.get("orderId"));
		return "contents/calc/view/orderFile";
	}
	@PostMapping(value="/oms/calc/data/multiDeleteCalc.do")
	public String multiDeleteCalc(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if(!EtcUtil.checkAuth(request, calcMenuCode, "D")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		
		List<String> calcIdList = Arrays.asList(((String)param.get("calcIdArr")).split(","));
		param.put("calcIdList", calcIdList);
		omsCalcService.multiDeleteCalc(param);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", "정산내역을 삭제했습니다.");
		
		return "jsonView";
		
	}
	
}
