package com.logislink.basic.controller;

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

import com.logislink.basic.service.CodeService;
import com.logislink.basic.vo.CodeVO;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;

@Controller
public class CodeController {
	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "E5210";
	
	@Resource(name="codeService")
	private CodeService codeService;

	@GetMapping(value="/contents/basic/codeList.do")
	public String codeList(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);		
		model.put("menuAuth", loginMenu);
		
		return "contents/basic/codeList";
	}
    
	@PostMapping(value="/contents/basic/data/codeGroupList.do")
	public String codeGroupList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<CodeVO> codeGroupList = codeService.getCodeGroupList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", codeGroupList);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/codeList.do")
	public String getCodeList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<CodeVO> codeList = codeService.getCodeList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", codeList);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/codeGroupInsert.do")
	public String codeGroupInsert(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		if(param.get("codeSeq") != null && !"".equals(param.get("codeSeq"))) {
			if(!EtcUtil.checkAuth(request, menuCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
		} else {
			if(!EtcUtil.checkAuth(request, menuCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
			
		}
		codeService.insertCodeGroup(param);
		
		map.put("result", Boolean.TRUE);
//		map.put("data", codeList);
		map.put("msg", param.get("retMsg"));
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/codeInsert.do")
	public String codeInsert(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		if(param.get("codeSeq") != null && !"".equals(param.get("codeSeq"))) {
			if(!EtcUtil.checkAuth(request, menuCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
		} else {
			if(!EtcUtil.checkAuth(request, menuCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
			
		}
		codeService.insertCode(param);
		
		map.put("result", Boolean.TRUE);
//		map.put("data", codeList);
		map.put("msg", param.get("retMsg"));
		
		return "jsonView";
		
	}
}
