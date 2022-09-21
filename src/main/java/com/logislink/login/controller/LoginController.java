package com.logislink.login.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.logislink.cmm.util.EncUtil;
import com.logislink.login.service.LoginService;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class LoginController {
	
	private Logger logger = LogManager.getLogger();
	
	@Resource(name="loginService")
	private LoginService loginService;
	
	@PostMapping(value="/login.do")
	public String login(HttpServletRequest request, HttpServletResponse response, Model model,
						ModelMap map, @RequestParam Map<String, Object> param) throws Exception{
	
		String passwd = String.valueOf(param.get("passwd"));
		passwd = EncUtil.sha256(passwd);
		
		param.put("passwd", passwd);
		
		LoginVO login = loginService.getUser(param);
		
		if(login == null) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "사용자 정보가 없습니다.");
		} else {
			
			//메뉴 정보를 가져와 json 형태로 파싱한다.
			ObjectMapper mapper = new ObjectMapper();
			String menuJson = mapper.writeValueAsString(menuList(login.getAuthSeq())); 

			//마지막 로그인 날짜를 저장한다.
			loginService.updateLastLogin(param);
			
			//사용자 로그인 정보 저장
			request.getSession().setAttribute("userInfo", login);
			//사용자 별 메뉴 정보 저장
			request.getSession().setAttribute("MenuList", menuJson);

			map.put("result", Boolean.TRUE);
			map.put("login", login);
			map.put("msg", "로그인 성공.");
			
		}
		
		return "jsonView";
	}

	@GetMapping(value="/logout.do")
	public String logout(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("userInfo", null);

		return "redirect:/index.do";

	}

	/**
	 * 사용자 별 메뉴 정보
	 * @param adminSeq
	 * @param serviceSeq
	 * @return
	 */
	private Map<String, Object> menuList(int authSeq){
		Map<String, Object> param = new HashMap<>();
		
		param.put("authSeq", authSeq);
		Map<String, Object> result = new HashMap<>();
		List<LoginMenuVO> menuList = new ArrayList();
		try {
			menuList = loginService.getLoginMenu(param);
			result.put("menu", menuList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}
