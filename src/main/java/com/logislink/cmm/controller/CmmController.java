package com.logislink.cmm.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

import org.json.simple.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.logislink.basic.vo.CodeVO;
import com.logislink.cmm.helper.RestApiHelper;
import com.logislink.cmm.service.CmmService;
import com.logislink.cmm.util.ExcelUtil;
import com.logislink.cmm.util.FileUtil;
import com.logislink.cmm.vo.AreaVO;
import com.logislink.cmm.vo.FileVO;
import com.logislink.notice.vo.BoardFileVO;

@Controller
public class CmmController {

	private static RestApiHelper apiHelper = new RestApiHelper();
	
	public static HashMap<String, ArrayList<CodeVO>> codeMap;
	
	@Resource(name="cmmService")
	private CmmService cmmService;
	
	@Resource(name="globalProperties")
	private Properties globalProperties;
	
	/**
	 * 공통코드 
	 * @param request
	 * @param response
	 * @param model
	 * @param map
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/cmm/codeList.do")
	public String cmmCodeList(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<CodeVO> codeList = cmmService.getCmmCode(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", codeList);
		
		return "jsonView";
	}	

    /**
     *  Kendo UI GRID : Export to Excel
     * @param fileName
     * @param base64
     * @param contentType
     * @param response
     * @throws IOException
     */
    @RequestMapping(value="/cmm/saveGrid.do")
    @ResponseBody
    public void saveGrid(String fileName, String base64, String contentType,
    				HttpServletResponse response) throws IOException{
    	
    	response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
    	response.setContentType(contentType);
    	
    	byte[] data =DatatypeConverter.parseBase64Binary(base64);
    	
    	response.setContentLength(data.length);
    	response.getOutputStream().write(data);
    	response.flushBuffer();
    }
    
	/**
	 * 엑셀 파일 업로드 하여 업로드 된 파일명 반환
	 * @param multipart
	 * @param model
	 * @param map
	 * @param param
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/cmm/excelUpload.do")
	public String excelUpload(MultipartHttpServletRequest multipart, Model model, ModelMap map, 
								@RequestParam Map<String, Object> param, HttpSession session) throws Exception {
		
		FileUtil fileUtil = new FileUtil();
		
		String filePath = globalProperties.getProperty("Globals.filepath");
		String realFilePath = filePath + "temp/";
		
		MultipartFile uploadFile = multipart.getFile("uploadFile");
		
		FileVO file = null;
		if(uploadFile != null && !uploadFile.isEmpty()) {
			file = fileUtil.fileUpload(uploadFile, realFilePath, 0, 0, "", 0, "");
		}
		
		map.put("result", Boolean.TRUE);
		map.put("uploadFile", file.getfName());
		
		return "jsonView";
	}
	
	/**
	 * 업로드 된 엑셀 파일의 내용을 JSON 형식으로 반환
	 * @param request
	 * @param response
	 * @param model
	 * @param map
	 * @param param
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/cmm/excelToJson.do")
	public String excelToJson(HttpServletRequest request, HttpServletResponse response, Model model, ModelMap map,
								@RequestParam Map<String, Object> param, HttpSession session) throws Exception {
		FileUtil fileUtil = new FileUtil();
		
		String filePath = globalProperties.getProperty("Globals.filepath");
		String fileName = String.valueOf(param.get("fileName"));
		String fileFullPath = filePath + "temp/" + fileName;
		
		/**
		 * 22.07.08 이건욱
		 * 	- 매개변수 "className"에 따라 Call function 다르게 설정.
		 * 	- 결과값 반환 시 추가 정보 설정
		 * 	- View단에서 상태값에 따라 사용자 메시지 처리.
		 */
		map.put("sender", this.getClass().getSimpleName());
		
		JSONArray excelData = null;
		try {
			String className = String.valueOf(param.get("className"));
			if (className.equals("orderBundle"))
				excelData = ExcelUtil.getOrderBundleExcelData(fileFullPath);
			else
				excelData = ExcelUtil.getExcelData(fileFullPath);
			
			map.put("status", 0);
			map.put("dataType", "json");
		} catch(Exception e) {
			map.put("status", -1);
			map.put("message", e.getMessage());
			map.put("detailMessage", e.getStackTrace().toString());
		} finally {
			map.put("data", excelData);
		}
		
		// 22.07.08 이건욱 임시파일 제거에 실패시 별도의 에러메시지 출력하지 않음.
		try {
			fileUtil.DelFile(fileFullPath);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
	}
	
	@GetMapping(value="/contents/cmm/view/searchMember.do")
	public String searchMember(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		return "contents/cmm/view/searchMember";
	}
	
	@GetMapping(value="/contents/cmm/view/fileUpload.do")
	public String fileUpload(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		return "contents/cmm/view/fileUpload";
	}
	
	/**
	 * 유가정보 저장 
	 * @param request
	 * @param response
	 * @param model
	 * @param map
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/cmm/insertOpiInfo.do")
	public String insertOpiInfo(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		cmmService.insertOpiInfo(param);
		
		map.put("result", Boolean.TRUE);
		
		return "jsonView";
	}	
	
	/**
	 * 유가정보 저장 
	 * @param request
	 * @param response
	 * @param model
	 * @param map
	 * @param param
	 * @return
	 * @throws Exception
	 */
/*	@PostMapping(value="/cmm/insertWeatherInfo.do")
	public String insertWeatherInfo(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		cmmService.insertWeatherInfo(param);
		
		map.put("result", Boolean.TRUE);
		
		return "jsonView";
	}	*/
	
	@PostMapping(value="/cmm/getAreaCodeList.do")
	public String insertWeatherInfo(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		List<AreaVO> gunguList = cmmService.getAreaCodeList(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", gunguList);
		
		return "jsonView";
	}
}
