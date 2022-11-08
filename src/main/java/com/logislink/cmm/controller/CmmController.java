package com.logislink.cmm.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

import com.logislink.basic.vo.AddrVO;
import com.logislink.order.controller.OrderBundleController;

import org.apache.log4j.Logger;
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

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.logislink.basic.vo.CodeVO;
import com.logislink.cmm.helper.RestApiHelper;
import com.logislink.cmm.service.CmmService;
import com.logislink.cmm.util.ExcelUtil;
import com.logislink.cmm.util.FileUtil;
import com.logislink.cmm.vo.AreaVO;
import com.logislink.cmm.vo.FileVO;

@Controller
public class CmmController {
	private Logger logger = Logger.getLogger(this.getClass());

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
	
	/**
	 * 22.07.15 이건욱 그리드 개인화 설정 -> 화면, 사용자별 개인화 설정 컬럼 정보 조회 (공통 사용)
	 */
	@PostMapping(value="/cmm/getPrivateColList.do")
	public String privateColList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param ) throws Exception {

		List<Map<String, Object>> list = cmmService.getPrivateColInfo(param);
		map.put("result", Boolean.TRUE);
		map.put("colInfo", list);
		
		return "jsonView";
	}
	
	/**
	 * 22.07.15 이건욱 그리드 개인화 설정 -> 화면, 사용자별 개인화 설정 컬럼 정보 일괄 저장 (공통 사용)
	 */
	@PostMapping(value="/cmm/savePrivateColList.do")
	public String savePrivateColList(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		String jsonParam = String.valueOf(param.get("list"));
		
		ObjectMapper objectMapper = new ObjectMapper(); 
		List<Map<String, Object>> readValue = objectMapper.readValue(jsonParam, new TypeReference<List<Map<String, Object>>>(){});
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("list", readValue);
		inMap.put("userId", readValue.get(0).get("userId"));
		cmmService.savePrivateColList(inMap);
		
		param.put("userId", readValue.get(0).get("userId"));
		param.put("pageId", readValue.get(0).get("menuCode"));
		param.put("gridId", readValue.get(0).get("gridId"));
		List<Map<String, Object>> list = cmmService.getPrivateColInfo(param);
		map.put("result", Boolean.TRUE);
		map.put("colInfo", list);
		
		return "jsonView";
	}	
	
	/**
	 * 22.07.15 이건욱 그리드 개인화 설정 -> 화면 그리드별 개인화 설정 사용여부 정보 조회 (공통 사용)
	 */
	@PostMapping(value="/cmm/getPrivateTblList.do")
	public String privateTblList(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param ) throws Exception {

		List<Map<String, Object>> list = cmmService.getPrivateTblInfo(param);
		map.put("result", Boolean.TRUE);
		map.put("tblInfo", list);
		
		return "jsonView";
	}
	
	/**
	 * 22.07.15 이건욱 그리드 개인화 설정 -> 화면 그리드별 개인별 페이징 카운트 조회 (공통 사용)
	 */
	@PostMapping(value="/cmm/getPrivateTblCnt.do")
	public String getPrivateTblCnt(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
			@RequestParam Map<String, Object> param ) throws Exception {

		List<Map<String, Object>> list = cmmService.getPrivateTblCnt(param);
		map.put("result", Boolean.TRUE);
		map.put("tblInfo", list);
		
		return "jsonView";
	}
	
	/**
	 * 22.07.15 이건욱 그리드 개인화 설정 -> 화면, 사용자별 개인화 설정 컬럼 정보 초기화 (공통 사용)
	 */
	@PostMapping(value="/cmm/savePrivateColReset.do")
	public String savePrivateColReset(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		cmmService.savePrivateColReset(param);
		
		List<Map<String, Object>> list = cmmService.getPrivateColInfo(param);
		map.put("result", Boolean.TRUE);
		map.put("colInfo", list);
		
		return "jsonView";
	}	
	
	/**
	 * 22.07.15 이건욱 그리드 개인화 설정 -> (화면, 사용자별 페이징 카운트 변경 시 저장 (공통 사용)
	 */
	@PostMapping(value="/cmm/savePrivateTblCnt.do")
	public String savePrivateTblCnt(HttpServletRequest request, HttpServletResponse response, Model model,
								ModelMap map, @RequestParam Map<String, Object> param) throws Exception {
		
		cmmService.savePrivateTblCnt(param);
		
		map.put("result", Boolean.TRUE);
		
		return "jsonView";
	}

	/**
	 * 22-10-11 지번 주소 가져오기
	 */
	@PostMapping(value="/cmm/jibunAddrList.do")
	public String jibunAddrList(HttpServletRequest request, HttpServletResponse response, Model model,
							  ModelMap map, @RequestParam Map<String, Object> param) throws Exception {

			List<AddrVO> jibunList = cmmService.getJibunAddr(param);
			int count = cmmService.getAddrCnt(param);

			map.put("result", Boolean.TRUE);
			map.put("data", jibunList);
			map.put("total", count);

		return "jsonView";
	}
	
	/**
	 * 예금주 조회
	 * 은행코드와 계좌번호로 예금주 조회
	 * @param request
	 * @param model
	 * @param map
	 * @param session
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/cmm/accountCheck.do")
	public String accountCheck(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {
		// 예금주(계좌확인) 조회를 위해 세틀뱅크 테이블 데이터 삽입
		cmmService.insertVacsSendAccountCheck(param);
		
		// 세틀뱅크가 업데이트하는 동안 n초 대기
		Thread.sleep(3000);
		
		// 세틀뱅크 테이블 업데이트 상태 조회
		map.put("trNo", param.get("keyId").toString());
		Map<String, Object> accountCheckResult = null;
		accountCheckResult = cmmService.selectVacsSendAccountCheck(map);
		
		if (accountCheckResult != null && accountCheckResult.size() > 0) {
			String resultCode = accountCheckResult.get("inpCd").toString();
			if (resultCode != null && resultCode != "") {
				if (resultCode.equals("0000")) {
					// 있는 계좌
					String bankCode = accountCheckResult.get("iBankCd").toString();
					String bankCnnm = accountCheckResult.get("iAcctNm").toString();
					String bankAccount = accountCheckResult.get("iAcctNo").toString();
					
					map.put("bankCode", bankCode);
					map.put("bankCnnm", bankCnnm);
					map.put("bankAccount", bankAccount);
					map.put("result", Boolean.TRUE);
					map.put("msg", "사용 가능한 계좌입니다.\n계좌 정보를 저장하려면 '수정' 또는 '저장' 버튼을 눌러주세요.");
				} else {
					// 없는 계좌
					map.put("result", Boolean.FALSE);
					map.put("msg", "사용 하실 수 없는 계좌입니다.\n은행과 계좌번호를 올바르게 입력하세요.");
				}
			} else {
				// 계좌 정보 조회 실패
				map.put("result", Boolean.FALSE);
				map.put("msg", "예금주 조회에 실패했습니다.");
			}
		}
		
		return "jsonView";
	}

	@PostMapping(value="/cmm/setAccountCheck.do")
	public String setDriverAccountCheck(HttpServletRequest request, Model model, ModelMap map, HttpSession session, @RequestParam Map<String, Object> param) throws Exception {
		int result = cmmService.updateDriverAccountCheck(param);
		
		if (result > 0) {
			map.put("result", Boolean.TRUE);
		} else {
			map.put("result", Boolean.FALSE);
		}
		
		return "jsonView";
	}
}
