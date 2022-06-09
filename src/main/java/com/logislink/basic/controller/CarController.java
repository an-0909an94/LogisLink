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

import com.logislink.basic.service.CarService;
import com.logislink.basic.vo.CarVO;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;

@Controller
public class CarController {

	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "A1410";
	
	@Resource(name="carService")
	private CarService carService;
	
	@GetMapping(value="/contents/basic/carList.do")
	public String getCarList(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);
		model.put("menuAuth", loginMenu);
		
		return "contents/basic/carList";
	}
	
	@PostMapping(value="/contents/basic/data/carList.do")
	public String CarListData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("deptId", login.getDeptId());
		}
		
/*		if("search".equals(param.get("gbn"))) {
			param.put("deptId", login.getDeptId());
		}*/
		
		List<CarVO> list = carService.getCarList(param);
		int count = carService.getCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}

	@PostMapping(value="/contents/basic/data/carSearchList.do")
	public String CarSearchList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {

		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		if("N".equals(login.getMasterYn())) {
			param.put("deptId", login.getDeptId());
		}
		
		List<CarVO> list = carService.getSearchCar(param);
		int count = carService.getSearchCarCnt(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/insertCar.do")
	public String insertCar(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		String resMsg = "";
		if("E".equals(param.get("mode"))) {			
			if(!EtcUtil.checkAuth(request, menuCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}			
		} else if("N".equals(param.get("mode"))) {
			if(!EtcUtil.checkAuth(request, menuCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}			
		}
		
		carService.insertCar(param);
		
		if ("00".equals(param.get("retCode"))) {
			map.put("result", Boolean.TRUE);
		} else {
			map.put("result", Boolean.FALSE);	
		}
		map.put("msg", param.get("retMsg"));
		
		return "jsonView";
	}
}
