package com.logislink.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.logislink.cmm.LinkMessage;
import com.logislink.cmm.LinkMessageData;
import com.logislink.cmm.helper.RestApiHelper;
import com.logislink.cmm.service.RestService;
import com.logislink.cmm.util.DateUtil;
import com.logislink.cmm.util.EtcUtil;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.order.service.OrderBundleService;
import com.logislink.order.vo.OrderBundleErrorVo;

@Controller
public class OrderBundleController {

	private Logger log = Logger.getLogger(this.getClass());
	private String bundleWriteCode = "B2310";
	private static RestApiHelper apiHelper = new RestApiHelper();
	
	@Value("#{globalProperties['Globals.kakaoKey']}")
	private String kakaoKey;
		
	@Resource(name="orderBundleService")
	private OrderBundleService orderBundleService;
	
	@Resource(name="restService")
	private RestService restService;

	@GetMapping(value="/contents/order/orderBundle.do")
	public String getOrderBundle(HttpServletRequest request, HttpSession session, ModelMap model) {
		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, bundleWriteCode);
		model.put("menuAuth", loginMenu);
		
		return "contents/order/orderBundle";
	}
	
	/**
	 * 22.07.09 이건욱 T1 > J5, J6 배차관리 기능개선
	 * 	- Insert전 유효성 체크하여 반환 (거래처정보, 차량정보, 필수값)
	 * @param request
	 * @param session
	 * @param model
	 * @param map
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/contents/order/data/orderBundleWrite.do")
	public String orderBundleWrite(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
									@RequestParam Map<String, Object> param) throws Exception {
		// 처리할 데이터 변환
		String data = String.valueOf(param.get("data"));
		ObjectMapper objectMapper = new ObjectMapper();
		List<Map<String, Object>> orderList = objectMapper.readValue(data, new TypeReference<List<Map<String, Object>>>(){});
		
		// 배차 완료된 오더의 경우 정산 리스트에 추가
		List<String> calcOrderList = new ArrayList<>();
		// 유효성 체크 및 추가 데이터
		List<OrderBundleErrorVo> errorList = new ArrayList<>();
		
		boolean dataValidation = dataValidation(orderList, calcOrderList, errorList);
		if (dataValidation) {
			/**
			 * 정상 처리
			 */
			
			// 오더 등록
			//mssql 최대 요청 가능 파라미터 갯수 2100개. 이슈로 인해 30개씩 끊어서 저장 -> 코리아로지스
			try {
				int chunkSize = 30;
				for (int i = 0; i < orderList.size(); i += chunkSize) {
					List<Map<String, Object>> insertList = orderList.subList(i, Math.min(orderList.size(), i + chunkSize));
					
					Map<String, Object> orderParam = new HashMap<>();
					orderParam.put("orderList", insertList);
					orderBundleService.insertOrderBundle(orderParam);
				}
				
				// 배차 완료된 오더의 경우 정산에도 등록
				for (int i = 0; i < calcOrderList.size(); i += chunkSize) {
					List<String> insertList = calcOrderList.subList(i, Math.min(calcOrderList.size(), i + chunkSize));
					
					Map<String, Object> calcOrderParam = new HashMap<>();
					calcOrderParam.put("calcOrderList", insertList);
					orderBundleService.insertCalc(calcOrderParam);
				}
				
				LinkMessage linkMessage = new LinkMessage();
				linkMessage.setSender(this.getClass().getName());
				linkMessage.setStatus(0);
				linkMessage.setMessage("등록되었습니다.");
				
				map.clear();
				map.put("linkMessage", linkMessage);
			} catch (Exception e) {
				// 에러처리
				LinkMessage linkMessage = new LinkMessage();
				linkMessage.setSender(this.getClass().getName());
				linkMessage.setStatus(-1);
				linkMessage.setMessage("배차일괄등록에 실패했습니다.\n시스템 관리자에게 문의하세요.");
				linkMessage.setDetailMessage(e.getMessage());
				
				map.clear();
				map.put("linkMessage", linkMessage);
			}
		} else {
			// 에러 처리
			LinkMessage linkMessage = new LinkMessage();
			linkMessage.setSender(this.getClass().getName());
			linkMessage.setStatus(1);
			linkMessage.setMessage("유효성 체크에 실패했습니다.\n유효성 문제를 해결해야 배차일괄 등록이 가능합니다.");
			
			LinkMessageData linkMessageData = new LinkMessageData();
			linkMessageData.setDataType("Object");
			linkMessageData.setData(errorList);
			linkMessage.setData(linkMessageData);
			
			map.clear();
			map.put("linkMessage", linkMessage);
		}
		
		return "jsonView";
	}
	
	/**
	 * 22.07.12 이건욱 데이터 검증 메소드 추가
	 * 	데이터 검증 + 추가 필드 입력
	 * @param checkList
	 * @return
	 */
	private boolean dataValidation(List<Map<String, Object>> orderList, List<String> calcOrderList, List<OrderBundleErrorVo> errorList) {
		// 카카오 지도 API 키 -> 해정구역상 주소지 검색에 사용.
		apiHelper.setAdminKey(kakaoKey);
		
		// 오더 아이디 & 배차 아이디 생성시 사용.
		int idIndex = 0;
		
		for(Iterator<Map<String, Object>> rows = orderList.iterator(); rows.hasNext();) {
			Map<String, Object> row = rows.next();
			int rowNum = (int)row.get("no");
			
			/**
			 * 유효성 체크
			 * 	- 필수 입력항목 (화주거래처명, 화주담당부서, 상차지명, 상차지주소, 상차일자, 하차지명, 하차지주소, 하차일자, 수출입구분, 운송유형, 요청차종, 요청톤수, 중량, 청구운임, 상차방법, 하차방법, 운임구분)
			 * 	- 로그인한 조직과 부서로 관리되는 등록된 거래처 (화주거래처명)
			 * 	- 거래처에 명시된 담당부서 (화주담당부서)
			 * 	- 로그인한 조직에 등록된 차량 (차량번호, 차주명, 차주연락처)
			 * 	- 유효한 주소 (카카오 API를 활용한 행정구역상 주소 인증)
			 * 	- 그 외 예외는 처리하지 않음. (해당 Row는 그대로 반환)
			 * 
			 * 추가입력
			 * 	- 오더 아이디
			 * 	- 배차 아이디
			 * 	- 오더 상태
			 * 	- 출발지와 도착지 거리 및 예상 시간
			 * 	- 출발요청시간 및 도착시간
			 * 	- 배차 완료된 오더의 경우 정산 대상에 포함
			 */
			try {
				String custId = "";
				
				// 화주거래처명
				if (row.get("reqCustName") != null && row.get("reqCustName") != "") {
					// 유효한 거래처명인지 체크
					String custName = String.valueOf(row.get("reqCustName"));
					try {
						Map<String, Object> custParam = new HashMap<>();
						custParam.put("custName", custName);
						List<Map<String, Object>> custList = orderBundleService.getCustName(custParam);
						
						if (custList.size() == 1) {
							Map<String, Object> custInfo = custList.get(0);
							custId = String.valueOf(custInfo.get("custId"));
							String managerId = String.valueOf(custInfo.get("manager"));
							
							// 추가 필드 입력
							row.put("reqCustId", custId);
							row.put("buyStaffId", managerId);
						} else {
							// 화주거래처명이 1건이상 또는 1건미만으로 조회됐을 경우
							String message = "";
							if (custList.size() > 1)
								message = "화주거래명이 두건 이상 조회되었습니다.\n정확한 화주거래처명을 입력하세요.";
							else
								message = "등록된 화주거래처가 없습니다.\n정확한 화주거래처명을 입력하세요.";
							
							OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
							errorDetail.setRowNum(rowNum);
							errorDetail.setColName("화주거래처명");
							errorDetail.setColValue(custName);
							errorDetail.setMessage(message);
							errorList.add(errorDetail);
						}
					} catch (Exception e) {
						OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
						errorDetail.setRowNum(rowNum);
						errorDetail.setColName("화주거래처명");
						errorDetail.setColValue(custName);
						errorDetail.setMessage("알수 없는 오류가 발생했습니다.\n올바른 값인지 확인 후 다시 시도해주세요.");
						errorList.add(errorDetail);
					}
				} else {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("화주거래처명");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 화주담당부서명
				if (row.get("reqDeptName") != null && row.get("reqDeptName") != "") {
					// 유효한 담당부서명인지 체크
					String deptName = String.valueOf(row.get("reqDeptName"));
					try {
						Map<String, Object> deptParam = new HashMap<>();
						deptParam.put("custId", custId);
						deptParam.put("deptName", deptName);
						List<Map<String, Object>> deptList = orderBundleService.getDeptName(deptParam);
						
						if (deptList.size() == 1) {
							Map<String, Object> deptInfo = deptList.get(0);
							String deptId = String.valueOf(deptInfo.get("deptId"));
							
							// 추가 필드 입력
							row.put("reqDeptId", deptId);
						} else {
							// 화주담당부서명이 1건이상 또는 1건미만으로 조회됐을 경우
							String message = "";
							if (deptList.size() > 1)
								message = "화주담당부서명이 두건 이상 조회되었습니다.\\n정확한 화주담당부서명을 입력하세요.";
							else
								message = "등록된 화주담당부서가 없습니다.\n정확한 화주담당부서명을 입력하세요.";
							
							OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
							errorDetail.setRowNum(rowNum);
							errorDetail.setColName("화주담당부서명");
							errorDetail.setColValue(deptName);
							errorDetail.setMessage(message);
							errorList.add(errorDetail);
						}
					} catch (Exception e) {
						OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
						errorDetail.setRowNum(rowNum);
						errorDetail.setColName("화주거래처명");
						errorDetail.setColValue(deptName);
						errorDetail.setMessage("알수 없는 오류가 발생했습니다.\n올바른 값인지 확인 후 다시 시도해주세요.");
						errorList.add(errorDetail);
					}
				} else {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("화주거래처명");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 상차지명
				if (row.get("sComName") == null && row.get("sComName") == "") {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("상차지명");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 상차지주소
				if (row.get("sAddr") != null && row.get("sAddr") != "") {
					String sAddr = String.valueOf(row.get("sAddr"));
					try {
						Map<String, String> sData = getGeo(sAddr);
						if (sData != null) {
							// 추가 필드 입력
							row.put("sLat", sData.get("lat"));
							row.put("sLon", sData.get("lon"));
							row.put("sSido", sData.get("sido"));
							row.put("sGungu", sData.get("gungu"));
							row.put("sDong", sData.get("dong"));
						} else {
							// 유효하지 않은 주소
							OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
							errorDetail.setRowNum(rowNum);
							errorDetail.setColName("상차지주소");
							errorDetail.setColValue(sAddr);
							errorDetail.setMessage("유효하지 않은 주소입니다.\n행정구역상 주소를 명확히 입력하세요.");
							errorList.add(errorDetail);
						}
					} catch (Exception e) {
						OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
						errorDetail.setRowNum(rowNum);
						errorDetail.setColName("상차지주소");
						errorDetail.setColValue(sAddr);
						errorDetail.setMessage("알수 없는 오류가 발생했습니다.\n올바른 값인지 확인 후 다시 시도해주세요.");
						errorList.add(errorDetail);
					}
				} else {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("상차지주소");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 상차일자
				if (row.get("sDate") != null && row.get("sDate") != "") {
					// 유효한 날짜 포맷인지 확인
					String sDate = String.valueOf(row.get("sDate"));
					if (!DateUtil.checkDate(sDate, "yyyy-MM-dd")) {
						OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
						errorDetail.setRowNum(rowNum);
						errorDetail.setColName("상차일자");
						errorDetail.setColValue(sDate);
						errorDetail.setMessage("유효하지 않은 날짜 포맷입니다.\n정확한 포맷으로 입력해주세요.");
						errorList.add(errorDetail);
					}
				} else {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("상차일자");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 상차시간
				if (row.get("sTime") != null && row.get("sTime") != "") {
					// 유효한 날짜 포맷인지 확인
					String sTime = String.valueOf(row.get("sTime"));
					if (!DateUtil.checkDate(sTime, "HH:mm")) {
						OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
						errorDetail.setRowNum(rowNum);
						errorDetail.setColName("상차시간");
						errorDetail.setColValue(sTime);
						errorDetail.setMessage("유효하지 않은 시간 포맷입니다.\n정확한 포맷으로 입력해주세요.");
						errorList.add(errorDetail);
					}
				} else {
					row.put("sTime", "00:00");
				}
				
				// 상차지연락처
				if (row.get("sTel") != null && row.get("sTel") != "") {
					// 숫자만 빼고 전부 제거
					String temp = String.valueOf(row.get("sTel"));
					temp = temp.replaceAll("[^0-9]", "");
					row.put("sTel", temp);
				}
				
				// 하차지명
				if (row.get("eComName") == null && row.get("eComName") == "") {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("하차지명");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 하차지주소
				if (row.get("eAddr") != null && row.get("eAddr") != "") {
					String eAddr = String.valueOf(row.get("eAddr"));
					try {
						Map<String, String> eData = getGeo(eAddr);
						if (eData != null) {
							// 추가 필드 입력
							row.put("eLat", eData.get("lat"));
							row.put("eLon", eData.get("lon"));
							row.put("eSido", eData.get("sido"));
							row.put("eGungu", eData.get("gungu"));
							row.put("eDong", eData.get("dong"));
						} else {
							// 유효하지 않은 주소
							OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
							errorDetail.setRowNum(rowNum);
							errorDetail.setColName("하차지주소");
							errorDetail.setColValue(eAddr);
							errorDetail.setMessage("유효하지 않은 주소입니다.\n행정구역상 주소를 명확히 입력하세요.");
							errorList.add(errorDetail);
						}
					} catch (Exception e) {
						OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
						errorDetail.setRowNum(rowNum);
						errorDetail.setColName("상차지주소");
						errorDetail.setColValue(eAddr);
						errorDetail.setMessage("알수 없는 오류가 발생했습니다.\n올바른 값인지 확인 후 다시 시도해주세요.");
						errorList.add(errorDetail);
					}
				} else {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("상차지주소");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 하차일자
				if (row.get("eDate") != null && row.get("eDate") != "") {
					// 유효한 날짜 포맷인지 확인
					String eDate = (String)row.get("eDate");
					if (!DateUtil.checkDate(eDate, "yyyy-MM-dd")) {
						OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
						errorDetail.setRowNum(rowNum);
						errorDetail.setColName("하차일자");
						errorDetail.setColValue(eDate);
						errorDetail.setMessage("유효하지 않은 날짜 포맷입니다.\n정확한 포맷으로 입력해주세요.");
						errorList.add(errorDetail);
					}
				} else {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("하차일자");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 하차시간
				if (row.get("eTime") != null && row.get("eTime") != "") {
					// 유효한 시간 포맷인지 확인
					String eTime = (String)row.get("eTime");
					if (!DateUtil.checkDate(eTime, "HH:mm")) {
						OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
						errorDetail.setRowNum(rowNum);
						errorDetail.setColName("상차시간");
						errorDetail.setColValue(eTime);
						errorDetail.setMessage("유효하지 않은 시간 포맷입니다.\n정확한 포맷으로 입력해주세요.");
						errorList.add(errorDetail);
					}
				} else {
					row.put("eTime", "00:00");
				}
				
				// 하차지연락처
				if (row.get("eTel") != null && row.get("eTel") != "") {
					// 숫자만 빼고 전부 제거
					String temp = String.valueOf(row.get("eTel"));
					temp = temp.replaceAll("[^0-9]", "");
					row.put("eTel", temp);
				}
				
				// 수출입구분
				if (row.get("inOutSctn") == null && row.get("inOutSctn") == "") {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("수출입구분");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 운송유형
				if (row.get("truckTypeName") == null && row.get("truckTypeName") == "") {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("운송유형");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 요청차종
				if (row.get("carTypeName") == null && row.get("carTypeName") == "") {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("요청차종");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 요청톤수
				if (row.get("carTonName") == null && row.get("carTonName") == "") {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("요청톤수");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 중량
				if (row.get("goodsWeight") == null && row.get("goodsWeight") == "") {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("중량");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 청구운임
				if (row.get("allocCharge") == null && row.get("allocCharge") == "") {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("청구운임");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 차량번호
				if (row.get("carNum") != null && row.get("carNum") != "") {
					String carNum = String.valueOf(row.get("carNum"));
					String driverName = "";
					String driverTel = "";
					
					// 차주명 필드값 확인
					if (row.get("driverName") != null && row.get("driverName") != "") {
						driverName = String.valueOf(row.get("driverName"));
					} else {
						OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
						errorDetail.setRowNum(rowNum);
						errorDetail.setColName("차주명");
						errorDetail.setColValue("");
						errorDetail.setMessage("차주명이 입력되지 않았습니다.\n차주명을 입력하거나 차량번호를 비워야 합니다.");
						errorList.add(errorDetail);
					}
					
					// 차주연락처 필드값 확인
					if (row.get("driverTel") != null && row.get("driverTel") != "") {
						driverTel = String.valueOf(row.get("driverTel"));
						// 숫자만 빼고 전부 제거
						driverTel = driverTel.replaceAll("[^0-9]", "");
						row.put("driverTel", driverTel);
					} else {
						OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
						errorDetail.setRowNum(rowNum);
						errorDetail.setColName("차주연락처");
						errorDetail.setColValue("");
						errorDetail.setMessage("차주연락처가 입력되지 않았습니다.\n차주연락처를 입력하거나 차량번호를 비워야 합니다.");
						errorList.add(errorDetail);
					}
					
					if (driverName != "" && driverTel != "") {
						try {
							// 등록된 차량인지 조회
							Map<String, String> vehicParam = new HashMap<>();
							vehicParam.put("carNum", carNum);
							vehicParam.put("driverName", driverName);
							vehicParam.put("driverTel", driverTel);
							List<Map<String, Object>> vehicList = orderBundleService.getVehicInfo(vehicParam);
							if (vehicList.size() == 1) {
								Map<String, Object> vehicInfo = vehicList.get(0);
								String vehicId = String.valueOf(vehicInfo.get("vehicId"));
								String driverId = String.valueOf(vehicInfo.get("driverId"));
								String driverCarTonCode = String.valueOf(vehicInfo.get("carTonCode"));
								String driverCarTypeCode = String.valueOf(vehicInfo.get("carTypeCode"));
								
								row.put("vehicId", vehicId);
								row.put("driverId", driverId);
								row.put("driverCarTonCode", driverCarTonCode);
								row.put("driverCarTypeCode", driverCarTypeCode);
							} else {
								OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
								errorDetail.setRowNum(rowNum);
								errorDetail.setColName("차량정보");
								errorDetail.setColValue(String.valueOf("차량번호: " + carNum + ", 차주명: " + driverName + ", 차주연락처: " + driverTel));
								errorDetail.setMessage("등록된 차량이 없습니다.\n등록된 차량번호, 차주명, 차주연락처를 입력해야 합니다.");
								errorList.add(errorDetail);
							}
						} catch (Exception e) {
							OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
							errorDetail.setRowNum(rowNum);
							errorDetail.setColName("차량정보");
							errorDetail.setColValue(e.getMessage());
							errorDetail.setMessage("알수 없는 오류가 발생했습니다.\n올바른 값인지 확인 후 다시 시도해주세요.");
							errorList.add(errorDetail);
						}
					}
				} else {
					// 차주명 필드값 확인
					if (row.get("driverName") != null && row.get("driverName") != "") {
						String driverName = String.valueOf(row.get("driverName"));
						OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
						errorDetail.setRowNum(rowNum);
						errorDetail.setColName("차주명");
						errorDetail.setColValue(driverName);
						errorDetail.setMessage("차량번호가 입력되지 않았습니다.\n차량번호를 입력하거나 차주명을 비워야 합니다.");
						errorList.add(errorDetail);
					}
					
					// 차주연락처 필드값 확인
					if (row.get("driverTel") != null && row.get("driverTel") != "") {
						String driverTel = String.valueOf(row.get("driverTel"));
						OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
						errorDetail.setRowNum(rowNum);
						errorDetail.setColName("차주연락처");
						errorDetail.setColValue(driverTel);
						errorDetail.setMessage("차량번호가 입력되지 않았습니다.\n차량번호를 입력하거나 차주연락처를 비워야 합니다.");
						errorList.add(errorDetail);
					}
				}
				
				// 상차방법
				if (row.get("sWayName") == null && row.get("sWayName") == "") {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("상차방법");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 하차방법
				if (row.get("eWayName") == null && row.get("eWayName") == "") {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("하차방법");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
				
				// 운임구분
				if (row.get("chargeType") == null && row.get("chargeType") == "") {
					// 필수 입력 필드
					OrderBundleErrorVo errorDetail = new OrderBundleErrorVo();
					errorDetail.setRowNum(rowNum);
					errorDetail.setColName("운임구분");
					errorDetail.setColValue("");
					errorDetail.setMessage("필수 입력항목 입니다.");
					errorList.add(errorDetail);
				}
			} catch (Exception e) {
				String message = rowNum + "번째 열을 처리하던 중 오류가 발생했습니다.";
				System.out.println(message);
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
			
			/**
			 * 추가 정보 입력
			 */
			// 오더 아이디 & 배차 아이디
			// 아이디는 yyyyMMddHHmmss + seq 포맷
			String orderId = "E" + DateUtil.getDate("") + DateUtil.getHHmmss().replace(":", "");
			String allocId = "B" + DateUtil.getDate("") + DateUtil.getHHmmss().replace(":", "");
			String buyAllocId = allocId;
			
			String seq = "00" + idIndex++;
			orderId += "00" + seq.substring(seq.length()-3, seq.length());
			allocId += "00" + seq.substring(seq.length()-3, seq.length());
			seq = "00" + idIndex++;
			buyAllocId += "00" + seq.substring(seq.length()-3, seq.length());
			
			row.put("orderId", orderId);
			row.put("allocId", allocId);
			row.put("buyAllocId", buyAllocId);
			
			// 출발지와 도착지 거리 및 예상 도착시간 입력
			if ((row.get("sLat") != null && row.get("sLat") != "") 	&& (row.get("sLon") != null && row.get("sLon") != "") &&
				(row.get("eLat") != null && row.get("eLat") != "") 	&& (row.get("eLon") != null && row.get("eLon") != "")) {
				Map<String, Object> routeMap = new HashMap<>();
				routeMap.put("sLat", row.get("sLat"));
				routeMap.put("sLng", row.get("sLon"));
				routeMap.put("eLat", row.get("eLat"));
				routeMap.put("eLng", row.get("eLon"));
				
				Map<String, String> routeRlt = restService.sendRouteApi(routeMap);
				row.put("time", routeRlt.get("Time"));
				row.put("distance", routeRlt.get("Distance"));
			}
			
			// 출발요청시간과 도착요청시간 입력
			row.put("sDate", row.get("sDate") + " " + row.get("sTime"));
			row.put("eDate", row.get("eDate") + " " + row.get("eTime"));
			
			// 배차 완료된 오더의 경우 정산에도 등록
			if ((row.get("vehicId") != null && row.get("vehicId") != "") &&
				(row.get("driverId") != null && row.get("driverId") != "")) {
				calcOrderList.add(orderId);
				
				// 오더 상태
				row.put("orderState", "01");
				row.put("buyAllocState", "01");
			}
		}
		
		apiHelper.setAdminKey("");
		
		return errorList.isEmpty();
	}
	
	// 22.07.14 이건욱 예외를 호출자에서 처리하도록 변경
	private Map<String, String> getGeo(String addr) throws Exception {
		Map<String, String> result = new HashMap<>();

		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("query", addr);
		
		Map<String, String> res = apiHelper.getLatLon(paramMap);

		if (res == null) {
			return null;
		} else {
			String data = res.get("result");
			JSONParser parser = new JSONParser(); 
			JSONObject jsonObject = new JSONObject();
			String lat = "";
			String lon = "";
			String sido = "";
			String gungu = "";
			String dong = "";
			
			jsonObject = (JSONObject)parser.parse(data);
			JSONArray jsonArray = (JSONArray) jsonObject.get("documents");
			
			if(jsonArray.isEmpty()) {
				return null;
			}
			
			JSONObject tmpObj = (JSONObject) jsonArray.get(0);
							
			JSONObject tmpAddress = null;
			if("ROAD".equals(tmpObj.get("address_type"))) {
				tmpAddress = (JSONObject) tmpObj.get("road_address");
			} else {
				tmpAddress = (JSONObject) tmpObj.get("address");
			}
			
			lon = String.valueOf(tmpObj.get("x"));
			lat = String.valueOf(tmpObj.get("y"));
			sido = String.valueOf(tmpAddress.get("region_1depth_name"));
			gungu = String.valueOf(tmpAddress.get("region_2depth_name"));
			dong = String.valueOf(tmpAddress.get("region_3depth_name"));
			
			result.put("lat", lat);
			result.put("lon", lon);
			result.put("sido", sido);
			result.put("gungu", gungu);
			result.put("dong", dong);
			
			return result;
		}
	}
	
	/**
	 * 22.07.13 이건욱 T1 > J5, J6 배차관리 기능개선 -> Validation check error 레포트 뷰
	 * @param request
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping(value="/contents/order/popValidation.do")
	public String popValidation(HttpServletRequest request, HttpSession session, ModelMap model) {
		return "contents/order/view/popValidation";
	}
}
