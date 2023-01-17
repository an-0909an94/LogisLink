package com.logislink.login.controller;

import java.text.SimpleDateFormat;
import java.util.*;

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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

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
		//사용자 IP param 추가
		param.put("userIp", getUserIp());
		
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

	@PostMapping(value="/loginTalk.do")
	public String loginTalk(HttpServletRequest request, HttpServletResponse response, Model model,
						ModelMap map, @RequestParam Map<String, Object> param) throws Exception{

		String Browser = getBrowserNm(request);

		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm");
		SimpleDateFormat format2 = new SimpleDateFormat ( "MM월dd일 HH시mm분");

		Date time = new Date(); String time1 = format1.format(time);
		String loginTime = format2.format(time);

		param.put("loginBrowser", Browser);
		param.put("loginTime", loginTime);

		loginService.insertLoginTalk(param);

		return "jsonView";
	}

	public static String getBrowserNm(HttpServletRequest request) {

		String userAgent = request.getHeader("User-Agent");
		String accessBr = null;
		if (userAgent.indexOf("Trident") > -1 || userAgent.indexOf("MSIE") > -1) { // IE
			accessBr = "IE";
		} else if (userAgent.indexOf("Edge") > -1||userAgent.indexOf("Edg") > -1) { // Edge
			accessBr = "Edge";
		} else if (userAgent.indexOf("Whale") > -1) { // Naver Whale
			accessBr = "Naver Whale";
		} else if (userAgent.indexOf("Opera") > -1 || userAgent.indexOf("OPR") > -1) { // Opera
			accessBr = "Opera";
		} else if (userAgent.indexOf("Firefox") > -1) { // Firefox
			accessBr = "FireFox";
		} else if (userAgent.indexOf("Safari") > -1 && userAgent.indexOf("Chrome") == -1) { // Safari
			accessBr = "Safari";
		} else if (userAgent.indexOf("Chrome") > -1) { // Chrome
			accessBr = "Chrome";
		} else if (userAgent.indexOf("iPhone") > -1 || userAgent.indexOf("iPad") > -1 || userAgent.indexOf("iPod") > -1) {
			accessBr = "iPhone Web";
		} else if (userAgent.indexOf("Android") > -1) {
			accessBr = "Android Web";
		}


		return accessBr;
	}

	public static String getUserIp() throws Exception {

		String ip = null;
		HttpServletRequest request =
				((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

		ip = request.getHeader("X-Forwarded-For");

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Real-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-RealIP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("REMOTE_ADDR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}

		return ip;
	}
}
