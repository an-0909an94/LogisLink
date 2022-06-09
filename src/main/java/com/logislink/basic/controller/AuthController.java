package com.logislink.basic.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.logislink.basic.service.AuthService;
import com.logislink.basic.service.CompService;
import com.logislink.basic.vo.AuthVO;
import com.logislink.basic.vo.CompVO;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class AuthController {
	
	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "E5110";

	@Resource(name="authService")
	private AuthService authService;
	
	@Resource(name="compService")
	private CompService compService;
	
	@GetMapping(value="/contents/basic/authList.do")
	public String authList(HttpServletRequest request, Model model, HttpSession session, ModelMap map) throws Exception {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);
		map.put("menuAuth", loginMenu);
		
		return "contents/basic/authList";
	}
	
	@PostMapping(value="/contents/basic/data/authUserList.do")
	public String authUserList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<AuthVO> list = authService.selectUserList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/authList.do")
	public String authList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<AuthVO> list = authService.selectAuthList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/userAuthList.do")
	public String userAuthList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		param.put("loginAuthSeq", ((LoginVO) session.getAttribute("userInfo")).getAuthSeq());
		
		int custAuthSeq = 0;
		
		if(!"".equals(param.get("custId"))) {
			CompVO compInfo = compService.getComp(param);
			
			String custTypeCode = compInfo.getCustTypeCode();
			
			if("01".equals(custTypeCode)) {
				custAuthSeq =  230;
			} else if("02".equals(custTypeCode)) {
				custAuthSeq =  220;
			} else if("03".equals(custTypeCode)) {
				custAuthSeq =  240;
			} else if("04".equals(custTypeCode)) {
				custAuthSeq =  210;
			}
		}
		
		param.put("custAuthSeq", custAuthSeq);
		
		List<AuthVO> list = authService.selectUserAuthList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/allAuthList.do")
	public String allAuthList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
	
		List<AuthVO> list = authService.selectAllAuthList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/authWrite.do")
	public String authWriteData(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		if(!EtcUtil.checkAuth(request, menuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");

			return "jsonView";
		} 
		
		String jsonParam = String.valueOf(param.get("gridData"));
		
		//json String Type의 파라미터를 List 로 변환한다.
		ObjectMapper objectMapper = new ObjectMapper();		
		List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});
		
		String authType = "";
		for(Map<String, Object> data : readValue) {
			authType = "";
			authType += ("Y".equals(data.get("readYn"))) ? "R," : "";  
			authType += ("Y".equals(data.get("writeYn"))) ? "W," : "";  
			authType += ("Y".equals(data.get("editYn"))) ? "E," : "";  
			authType += ("Y".equals(data.get("deleteYn"))) ? "D," : "";  
			authType += ("Y".equals(data.get("printYn"))) ? "P," : "";
			
			if (!"".equals(authType)) authType = authType.substring(0, authType.length()-1);
			
			data.put("authType", authType);
		}
		
		param.put("list", readValue);
		
		authService.insert(param);
		
		map.put("result", Boolean.TRUE);
		map.put("msg", "권한을 생성했습니다.");
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/authInsert.do")
	public String authCopyData(HttpServletRequest request, Model model, HttpSession session,
							   ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		if(!EtcUtil.checkAuth(request, menuCode, "W")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");

			return "jsonView";
		} 
		
		HashMap<String, Object> ret = authService.checkAuthSeq(param);
		
		if("00".equals(ret.get("retCode"))) {
			authService.insertAuth(param);
			map.put("result", Boolean.TRUE);
			map.put("msg", "권한을 생성했습니다.");
		} else if("99".equals(ret.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", ret.get("retMsg"));
		}
		
		return "jsonView";
	}
	@PostMapping(value="/contents/basic/data/authDelete.do")
	public String authDelete(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param ) throws Exception {

		if(!EtcUtil.checkAuth(request, menuCode, "D")) {

			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");

			return "jsonView";
		}
		
		authService.delete(param);
			
		map.put("result", Boolean.TRUE);
		map.put("msg", "권한을 삭제했습니다.");
		
		return "jsonView";
	}
}
