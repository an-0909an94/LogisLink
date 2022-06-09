package com.logislink.omsUser.Controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.logislink.basic.vo.UserOptionVO;
import com.logislink.login.vo.LoginVO;
import com.logislink.omsUser.service.OmsUserService;

@Controller
public class OmsUserController {
	
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name="omsUserService")
	private OmsUserService omsUserService;
	
	@PostMapping(value="/oms/user/data/getUserOption.do")
	public String getUserOption(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		LoginVO loginUserInfo = ((LoginVO) session.getAttribute("userInfo"));
		param.put("loginCustId", loginUserInfo.getCustId());
		param.put("loginDeptId", loginUserInfo.getDeptId());
		param.put("loginId", loginUserInfo.getUserId());
		
		UserOptionVO data = omsUserService.getUserOption(param);

		map.put("result", Boolean.TRUE);
		map.put("data", data);
		map.put("msg", "");

		return "jsonView";
		
	}
	
	@PostMapping(value="/oms/user/data/insertUserOption.do")
	public String insertUserOption(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		LoginVO loginUserInfo = ((LoginVO) session.getAttribute("userInfo"));
		param.put("loginCustId", loginUserInfo.getCustId());
		param.put("loginDeptId", loginUserInfo.getDeptId());
		param.put("loginId", loginUserInfo.getUserId());
		
		omsUserService.insertUserOption(param);

		map.put("result", Boolean.TRUE);
		map.put("data", param);
		map.put("msg", param.get("retMsg"));

		return "jsonView";
		
	}
}
