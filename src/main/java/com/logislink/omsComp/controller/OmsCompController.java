package com.logislink.omsComp.controller;

import java.util.HashMap;
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

import com.logislink.basic.service.CustService;
import com.logislink.basic.service.UserService;
import com.logislink.basic.vo.CompVO;
import com.logislink.basic.vo.UserVO;
import com.logislink.cmm.util.EncUtil;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;
import com.logislink.omsComp.service.CompService;


@Controller
public class OmsCompController {
	
	private Logger log = Logger.getLogger(this.getClass());
	private String compMenuCode = "Z5710";

	@Resource(name="compService")
	private com.logislink.basic.service.CompService compService;

	@Resource(name="custService")
	private CustService custService;

	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="omsCompService")
	private CompService omsCompService;
	
	@GetMapping(value="/oms/comp/omsCompList.do")
	public String getCustList(HttpServletRequest request, HttpSession session, ModelMap model
									, @RequestParam Map<String, Object> param) {
		
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, compMenuCode);
		model.put("menuAuth", loginMenu);
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			model.put("masterYn", "N");
		}else {
			model.put("masterYn", "Y");
		}
		
		return "oms/comp/compList";
	}
	
	@PostMapping(value="/oms/comp/data/omsUserList.do")
	public String getUserList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String custId = login.getCustId();
		String deptId = login.getDeptId();

		param.put("custId", custId);
		param.put("deptId", deptId);
		List<UserVO> userList = omsCompService.getUserList(param);
		int count = omsCompService.getCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", userList);
		map.put("total", count);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/oms/comp/data/compUpdate.do")
	public String updateComp(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		String resMsg = "";
		String mode = "";
	
		if(!EtcUtil.checkAuth(request, compMenuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		param.put("editId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		mode = "update";
		
		if("".equals(param.get("bizNumSub"))) {
			param.put("bizNumSub", "0000");
		}
		
		HashMap<String, Object> ret = custService.checkBizNum(param);
		CompVO compInfo = null;
		
		if("00".equals(ret.get("retCode")) && "create".equals(mode)) {
			resMsg = "이미 존재하는 사업자번호이거나 종사업장번호 입니다.";
		} else {
			compService.updateComp(param);
			resMsg = (String) param.get("retMsg");
			if("".equals(param.get("custId"))) {
				LoginVO login = (LoginVO) session.getAttribute("userInfo");
				param.put("custId", login.getCustId());
			}
			
			compInfo = compService.getComp(param);
		}
		
		map.put("result", Boolean.TRUE);
		map.put("data", compInfo);
		map.put("msg", resMsg);
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/oms/comp/data/insertUser.do")
	public String insertUser(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		String resMsg = "";

		if("N".equals(param.get("mode"))) {
			if(!EtcUtil.checkAuth(request, compMenuCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
			param.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		} else if("E".equals(param.get("mode"))) {
			if(!EtcUtil.checkAuth(request, compMenuCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
			param.put("editId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		}

		if(!"".equals(param.get("passwd")) && param.get("passwd") != null ) {

			String passwd = String.valueOf(param.get("passwd"));
			passwd = EncUtil.sha256(passwd);
			
			param.put("passwd", passwd);
		}
		
		userService.insertUser(param);
		
		resMsg = (String) param.get("retMsg");
		
		map.put("result", Boolean.TRUE);
		map.put("data", param);
		map.put("msg", resMsg);
		
		return "jsonView";
	}
}
