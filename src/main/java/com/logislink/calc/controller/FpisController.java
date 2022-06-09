package com.logislink.calc.controller;

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

import com.logislink.calc.service.FpisService;
import com.logislink.calc.vo.FpisVO;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;

@Controller
public class FpisController {
	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "C3510";

	@Resource(name="fpisService")
	private FpisService fpisService;
	
	@GetMapping(value="/contents/calc/fpisList.do")
	public String fpisList(HttpServletRequest request, HttpSession session, ModelMap map) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);
		map.put("menuAuth", loginMenu);
				
		return "contents/calc/fpisList";
	}
	
	@PostMapping(value="/contents/calc/data/fpisList.do")
	public String fpisListData(HttpServletRequest request, HttpSession session, ModelMap map, Model model,
								@RequestParam Map<String, Object> param) {
		
		List<FpisVO> list = fpisService.getFpisList(param);
		int total = fpisService.getFpisCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("total", total);
		return "jsonView";
	}
	
}
