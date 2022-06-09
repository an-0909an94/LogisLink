package com.logislink.basic.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.logislink.basic.service.MenuService;
import com.logislink.basic.vo.MenuVO;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.cmm.util.FileUtil;
import com.logislink.cmm.vo.FileVO;
import com.logislink.login.vo.LoginMenuVO;

@Controller
public class MenuController {
	
	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "E5310";

	@Resource(name="menuService")
	private MenuService menuService;

	@Value("#{globalProperties['Globals.filepath']}")
	private String filepath;
	
	@GetMapping(value="/contents/basic/menuList.do")
	public String menuList(HttpServletRequest request, Model model, HttpSession session, ModelMap map) throws Exception {

		LoginMenuVO userMenu = EtcUtil.checkAuth(request, menuCode);

		map.put("menuAuth", userMenu);
		return "contents/basic/menuList";
	}
	
	@PostMapping(value="/contents/basic/data/menuList.do")
	public String menuListData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param) throws Exception {
		
		List<MenuVO> list = menuService.selectMenuList(param);

		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("msg", "");
		
		return "jsonView";
		
	}
	
	@PostMapping(value="/contents/basic/data/menuWrite.do") 
	public String menuWriteData(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		if("N".equals(param.get("mode"))) {
			if(!EtcUtil.checkAuth(request, menuCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");

				return "jsonView";
			} 
		}else if("E".equals(param.get("mode"))) {
			if(!EtcUtil.checkAuth(request, menuCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");

				return "jsonView";
			} 
		}else if("D".equals(param.get("mode"))) {
			if(!EtcUtil.checkAuth(request, menuCode, "D")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");

				return "jsonView";
			} 
		}
		
		menuService.insertMenu(param);

		map.put("result", param.get("retCode"));
		map.put("msg", param.get("retMsg"));
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/menuSortEdit.do") 
	public String menuSortUpdateData(HttpServletRequest request, Model model, HttpSession session,
									ModelMap map, @RequestParam Map<String, Object> param) throws Exception {

		if(!EtcUtil.checkAuth(request, menuCode, "E")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
		} else {
			menuService.updateSort(param);
			
			if("00".equals(param.get("retCode"))) {
				map.put("result", Boolean.TRUE);
				map.put("msg", param.get("retMsg"));
			} else {
				map.put("result", Boolean.FALSE);
				map.put("msg", param.get("retMsg"));
			}
		}
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/menuGuideEdit.do")
	public String menuHelpUpdateData(HttpServletRequest request, Model model, HttpSession session,
			ModelMap map, @RequestParam Map<String, Object> param, MultipartHttpServletRequest multipart) {

		FileUtil fileUtil = new FileUtil();
		String realFilePath = filepath + "guide/";

		//첨부된 파일이 있으면 파일을 업로드한다.
		MultipartFile uploadFile = null;
		
		for(int i=1; i<=3; i++) {
			FileVO file = null;
			uploadFile = multipart.getFile("manual" + i + "Url");
			if(uploadFile != null && !uploadFile.isEmpty()) {
				file = fileUtil.fileUpload(uploadFile, realFilePath, 0, 0, "", 0, "guide");
				
				param.put("manual" + i + "Url", file.getfPath() + file.getfName());
			}
		}

		for(int i=1; i<=3; i++) {
			FileVO file = null;
			uploadFile = multipart.getFile("tutorial" + i + "Url");
			if(uploadFile != null && !uploadFile.isEmpty()) {
				file = fileUtil.fileUpload(uploadFile, filepath, 0, 0, "", 0, "guide");
				
				param.put("tutorial" + i + "Url", file.getfPath() + file.getfName());
			}
		}
		
		menuService.updateMenuGuide(param);
		

		map.put("result", Boolean.TRUE);
		map.put("msg", "등록되었습니다.");
		
		return "jsonView";
	}
}
