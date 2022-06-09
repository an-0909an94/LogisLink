package com.logislink.cmm.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.logislink.basic.vo.CodeVO;
import com.logislink.basic.vo.CompDeptVO;
import com.logislink.cmm.service.MainSerivce;
import com.logislink.cmm.util.EncUtil;

@Controller
public class MainController {

	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name="mainService")
	private MainSerivce mainService;

	@GetMapping(value="/index.do")
	public String getMainPage(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) {
		//https 로 리다이렉트
		/*if(session.getAttribute("userInfo") != null) {
			return "redirect:/contents/order";
		}*/
/*		String url = request.getRequestURL().toString();
		System.out.println("url : " + url);
		System.out.println("startsWith : " + url.startsWith("http://"));
		System.out.println("indexOf : " + url.startsWith("http://"));
		if(url.startsWith("http://") && url.indexOf("logis-link.co.kr") > 0 ) {
			url = url.replaceAll("http://", "https://");
			try {
				response.sendRedirect(url);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		*/
		return "main/index";
	}
	
	@GetMapping(value="/join.do")
	public String getJoinPage(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "main/join";
	}
	
	@GetMapping(value="/left.do")
	public String getLeft(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "layout/left";
	}
	
	@GetMapping(value="/findUserInfo.do")
	public String orderCar(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "main/findUserInfo";
	}	
	
	@GetMapping(value="/terms/service.do")
	public String getTermsServicePage(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) {
		
		return "main/terms/service";
	}

	@GetMapping(value="/terms/lbs.do")
	public String getTermsLbsPage(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) {
		
		return "main/terms/lbs";
	}

	@GetMapping(value="/terms/privacy.do")
	public String getTermsPrivacyPage(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) {
		
		return "main/terms/privacy";
	}
	
	@PostMapping(value="/checkBizNum.do")
	public String checkBizNum(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		HashMap<String, Object> data = mainService.checkBizNum(param);
		
		if("00".equals(data.get("retCode"))) {
			map.put("result", Boolean.TRUE);
			map.put("msg", data.get("retMsg"));
			map.put("data", data);
		} else if("99".equals(data.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", data.get("retMsg"));
		}
		
		
		return "jsonView";
	}
	
	@PostMapping(value="/checkUserId.do")
	public String checkUserId(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		HashMap<String, Object> data = mainService.checkUserId(param);
		
		if("00".equals(data.get("retCode"))) {
			map.put("result", Boolean.TRUE);
			map.put("msg", data.get("retMsg"));
		} else if("99".equals(data.get("retCode"))) {
			map.put("result", Boolean.FALSE);
			map.put("msg", data.get("retMsg"));
		}
		
		
		return "jsonView";
	}
	
	@PostMapping(value="/signUp.do")
	public String signUp(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {

		if(!"".equals(param.get("passwd")) && param.get("passwd") != null ) {

			String passwd = String.valueOf(param.get("passwd"));
			passwd = EncUtil.sha256(passwd);
			
			param.put("passwd", passwd);
		}
		
		if(param.get("custTypeCode") == "01") {
			param.put("authSeq", 230);
		}else if(param.get("custTypeCode") == "02"){
			param.put("authSeq", 220);
		}else if(param.get("custTypeCode") == "03") {
			param.put("authSeq", 240);
		}else {
			param.put("authSeq", 210);
		}
		
		mainService.signUp(param);

		map.put("result", Boolean.TRUE);
		map.put("data", param);
		map.put("msg", param.get("retMsg"));
		
		return "jsonView";
	}
	
	@PostMapping(value="/codeList.do")
	public String cmmCodeList(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<CodeVO> codeList = mainService.getCmmCode(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", codeList);
		
		return "jsonView";
	}
	
	@PostMapping(value="/deptList.do")
	public String deptList(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<CompDeptVO> compDeptList = mainService.getCompDeptList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", compDeptList);
		map.put("msg", "");
		
		return "jsonView";
	}
	
	@PostMapping(value="/findUserData.do")
	public String findUserData(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		String resMsg = "";
		
		if("pw".equals(param.get("mode"))) {
			Random rand = new Random();
			String numStr = ""; //난수가 저장될 변수
			
			for(int i=0;i<6;i++) {
				//0~9 까지 난수 생성
				String ran = Integer.toString(rand.nextInt(10));
				if(!numStr.contains(ran)) {
					//중복된 값이 없으면 numStr에 append
					numStr += ran;
				}else {
					//생성된 난수가 중복되면 루틴을 다시 실행한다
					i-=1;
				}
			}
			param.put("passWord", numStr);
			String passwd = numStr;
			passwd = EncUtil.sha256(passwd);
			param.put("shaPassWord", passwd);
		}
		
		mainService.getUserData(param);
		
		if("99".equals(param.get("retCode"))) {
			map.put("result", Boolean.FALSE);
		}else {
			map.put("result", Boolean.TRUE);
		}
		resMsg = (String) param.get("retMsg");
		
		map.put("msg", resMsg);
		
		return "jsonView";
	}
}
