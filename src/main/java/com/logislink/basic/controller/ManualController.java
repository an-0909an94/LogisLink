package com.logislink.basic.controller;

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

import com.logislink.basic.service.ManualService;
import com.logislink.basic.vo.ManualVO;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.cmm.util.FileUtil;
import com.logislink.cmm.vo.FileVO;
import com.logislink.login.vo.LoginMenuVO;

@Controller
public class ManualController {
	
	private Logger log = Logger.getLogger(this.getClass());
	private String manualCode = "E5410";

	@Resource(name="manualService")
	private ManualService manualService;

	@Value("#{globalProperties['Globals.filepath']}")
	private String filepath;
	
	@GetMapping(value="/contents/basic/manualList.do")
	public String ManualList(HttpServletRequest request, Model model, HttpSession session, ModelMap map) throws Exception {

		LoginMenuVO userMenu = EtcUtil.checkAuth(request, manualCode);
		
		map.put("menuAuth", userMenu);
		return "contents/basic/manualList";
	}
    
	@PostMapping(value="/contents/basic/data/manualGroupList.do")
	public String manualGroupList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<ManualVO> manualGroupList = manualService.getManualGroupList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", manualGroupList);
		map.put("msg", "");
		
		return "jsonView";
	}
    
	@PostMapping(value="/contents/basic/data/manualList.do")
	public String manualList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param ) throws Exception {
		
		List<ManualVO> manualList = manualService.getManualList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", manualList);
		map.put("msg", "");
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/manualGroupInsert.do") 
	public String manualGroupInsert(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		if(param.get("manualCode") != null && !"".equals(param.get("manualCode"))) {
			if(!EtcUtil.checkAuth(request, manualCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
		} else {
			if(!EtcUtil.checkAuth(request, manualCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
		}
		
		manualService.insertManualGroup(param);

		map.put("result", param.get("retCode"));
		map.put("msg", param.get("retMsg"));
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/manualInsert.do") 
	public String manualInsert(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		if(param.get("manualSeq") != null && !"".equals(param.get("manualSeq"))) {
			if(!EtcUtil.checkAuth(request, manualCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
		} else {
			if(!EtcUtil.checkAuth(request, manualCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
		}

		manualService.insertManual(param);
		map.put("outManualSeq", param.get("outManualSeq"));
		map.put("result", param.get("retCode"));
		map.put("msg", param.get("retMsg"));
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/basic/data/manualFileInsert.do") 
	public String manualFileInsert(HttpServletRequest request, Model model, HttpSession session,
								ModelMap map, @RequestParam Map<String, Object> param, MultipartHttpServletRequest multipart) {

		//첨부된 파일이 있으면 파일을 업로드한다.		
		FileUtil fileUtil = new FileUtil();
		String realFilePath = filepath + "manual/";
			
		MultipartFile uploadFile = null;
		FileVO file = null;
		uploadFile = multipart.getFile("manualUrl");
		if(uploadFile != null && !uploadFile.isEmpty()) {
			file = fileUtil.fileUpload(uploadFile, realFilePath, 0, 0, "", 0, "manual");
				
			param.put("manualUrl", file.getfPath() + file.getfName());
		}
		
		manualService.insertManualFile(param);

		map.put("result", param.get("retCode"));
		map.put("msg", param.get("retMsg"));
		
		return "jsonView";
	}
}
