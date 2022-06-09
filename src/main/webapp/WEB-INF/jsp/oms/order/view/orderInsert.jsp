<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.form-group{
		margin-bottom: 0;
	}
</style>
<div>
	<div class="editor_wrap pop-layer" id="layer1">
	    <div class="insertClose">
	    	<a class="insertCloseButton k-icon k-i-close" onclick="init_popup_close();"></a>
	    </div>
        <!-- wrap -->
		<div class="k-tabstrip-wrapper">
			<div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
				<div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
                    <div class="editor">
					<form id="f" data-toggle="validator" role="form" autocomplete="off">
                       	<input type="hidden" name="orderId" id="orderId">
                       	<input type="hidden" name="allocId" id="allocId">
                       	<input type="hidden" name="reqCustId" id="reqCustId">
                       	<input type="hidden" name="reqDeptId" id="reqDeptId">
						<input type="hidden" id="mode" name="mode" value="N">
						<fieldset>
                        	<legend id="order_legend">오더등록</legend>
                        	<div class="form-group row">
                                <label class="col-form-label big-name">화주</label>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong>요청사항</strong>
                                	<input type="text" class="form-control form-control-sm" id="reqMemo" name="reqMemo">
                            	</div>
                            </div>
                            
                            <div class="form-group row">
                        		<div class="col-form-label big-name big-name-div">
                                	<div>상차</div>
                                	<a id="startAddr" style="background: #fff;border-radius: 4px;box-shadow: 0px 0px 2px 0px;color: #0A8DFF;height: 20px;width: 100px;" class="k-pager-refresh k-button openCloseBtn">추가정보열기</a>
                                </div>
                        		<input type="hidden" name="sLat" id="sLat">
                                <input type="hidden" name="sLon" id="sLon">
                                <input type="hidden" name="sSido" id="sSido">
                                <input type="hidden" name="sGungu" id="sGungu">
                                <input type="hidden" name="sDong" id="sDong">
                                <div class="input-group input-group-sm col middle-name form-group">
                               	<strong class="required">상차지명</strong>
                                	<input style="width: 100%;" type="text" id="sComName" name="sComName" required="required">
                                	<div class="help-block with-errors"></div>
                                </div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong class="required">상차 일시</strong>
                                    <input style="padding: 0;" type="text" id="sDateDay" name="sDateDay" class="col-12" required>
                                    <div class="help-block with-errors"></div>
                                </div>
                                <div class="input-group input-group-sm col middle-name form-group" id="sTimeDiv">
                                	<strong class="required">상차 시간</strong>
                                    <input style="padding: 0;" type="text" id="sDateTime" name="sDateTime" class="col-12" required>
                                    <div class="help-block with-errors"></div>
                                </div>
                            </div>
                            
                            <div class="form-group row">
                                <label class="col-form-label"></label>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong class="required">주소(검색)</strong>
	                                <div class="textBox-in-icon">
                                    <input onclick="dummyPopSearchPost('sAddr');" id="sAddr" name="sAddr" type="text" class="form-control form-control-sm" required readonly="readonly">
									<i><img onclick="dummyPopSearchPost('sAddr');" src="/images/icon/search.png"></i>
<!-- 									<input onclick="popSearchPost('sAddr');" id="sAddr" name="sAddr" type="text" class="form-control form-control-sm" required readonly="readonly"> -->
<!-- 									<i><img onclick="popSearchPost('sAddr');" src="/images/icon/search.png"></i> -->
									</div>
									<div class="help-block with-errors"></div>
                           		</div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong >상세주소</strong>
                                	<input type="text" id="sAddrDetail" name="sAddrDetail" class="form-control form-control-sm" >
                            	</div>
                            </div>
                            
                            <!-- 상차지 접기, 열기 부분 -->
                            <div id="startAddrOpenClose" class="openCloseDiv">
	                            <div class="form-group row">
	                        		<label class="col-form-label big-name"></label>
	                                <div class="input-group input-group-sm col middle-name form-group">
	                               	<strong>담당자</strong>
	                                	<input type="text" id="sStaff" name="sStaff" class="form-control form-control-sm" >
	                                </div>
	                                <div class="input-group input-group-sm col middle-name form-group">
	                                <strong>연락처</strong>
	                                	<input type="text" id="sTel" name="sTel" class="form-control form-control-sm" maxlength="13">
	                                </div>
	                            </div>
	                            
	                            <div class="form-group row">
	                                <label class="col-form-label"></label>
	                                <div class="input-group input-group-sm col middle-name form-group">
	                                <strong>상차지메모</strong>
	                                    <input type="text" class="form-control form-control-sm" id="sMemo" name="sMemo">
	                                </div>
	                                <c:if test="${addrAuth.writeYn eq 'Y'}">
		                                <div class="col input-group radio-or-checkBox">
			                               	<input id="sAreaSave" name="sAreaSave" type="checkbox" onclick="btnChk(this)">
			                               	<label for="sAreaSave" class="insert-label">
			                               		<span>주소지 저장</span>
			                               	</label>
		                                </div>
	                                </c:if>
	                            </div>
                            </div>
                            
                            <div class="form-group row">
                            	<input type="hidden" name="orderStopData" id="orderStopData">
                                <label class="col-form-label big-name">경유지</label>
                                <div class="col input-group i-name">
                                	<i style="font-size: large;" id="iStopTxt"></i>
                                </div>
                                <div class="col input-group btn-name">
                                </div>
                                <div class="col input-group btn-name">
                                	<a onClick="popOrderStopDetail();" class="k-pager-refresh k-button btn-s">자세히보기</a>
                                </div>
                            </div>
                        	
                        	<div class="form-group row">
                        		<div class="col-form-label big-name big-name-div">
									<div>하차</div>
									<a id="endAddr" style="background: #fff;border-radius: 4px;box-shadow: 0px 0px 2px 0px;color: #0A8DFF;height: 20px;width: 100px;" class="k-pager-refresh k-button openCloseBtn">추가정보열기</a>
								</div>
                                <input type="hidden" name="eLat" id="eLat">
                                <input type="hidden" name="eLon" id="eLon">
                                <input type="hidden" name="eSido" id="eSido">
                                <input type="hidden" name="eGungu" id="eGungu">
                                <input type="hidden" name="eDong" id="eDong">
                                <div class="input-group input-group-sm col middle-name form-group">
                            	<strong class="required">하차지명</strong>
                                    <input style="width: 100%;" type="text" id="eComName" name="eComName" required>
                                	<div class="help-block with-errors"></div>
                                </div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong class="required">하차 일시</strong>
                                    <input style="padding: 0;" type="text" id="eDateDay" name="eDateDay" class="col-12" required>
                                    <div class="help-block with-errors"></div>
                                </div>
                                <div class="input-group input-group-sm col middle-name form-group" id="eTimeDiv">
                                <strong class="required">하차 시간</strong>
                                    <input style="padding: 0;" type="text" id="eDateTime" name="eDateTime" class="col-12" required>
                                    <div class="help-block with-errors"></div>
                                </div>
                            </div>
                            
                            <div class="form-group row">
                                <label class="col-form-label"></label>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong class="required">주소(검색)</strong>
	                                <div class="textBox-in-icon">
	                                    <input onClick="dummyPopSearchPost('eAddr');" id="eAddr" name="eAddr" type="text" class="form-control form-control-sm" readonly="readonly" required>
										<i><img onclick="dummyPopSearchPost('eAddr');" src="/images/icon/search.png"></i>
<!-- 										<input onClick="popSearchPost('eAddr');" id="eAddr" name="eAddr" type="text" class="form-control form-control-sm" readonly="readonly" required> -->
<!-- 										<i><img onclick="popSearchPost('eAddr');" src="/images/icon/search.png"></i> -->
									</div>
									<div class="help-block with-errors"></div>
                           		</div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong>상세주소</strong>
                                    <input type="text"  id="eAddrDetail" name="eAddrDetail" class="form-control form-control-sm" >
                            	</div>
                            </div>
                            
                            <!-- 하차지 접기, 열기 부분 -->
                            <div id="endAddrOpenClose" class="openCloseDiv">
	                            <div class="form-group row">
	                        		<label class="col-form-label big-name"></label>
	                                <div class="input-group input-group-sm col middle-name form-group">
	                                <strong>담당자</strong>
	                                    <input type="text" id="eStaff" name="eStaff" class="form-control form-control-sm" >
	                                </div>
	                                <div class="input-group input-group-sm col middle-name form-group">
	                                <strong>연락처</strong>
	                                    <input type="text" id="eTel" name="eTel" class="form-control form-control-sm" maxlength="13">
	                                </div>
	                            </div>
	                            
	                            <div class="form-group row">
	                                <label class="col-form-label"></label>
	                                <div class="input-group input-group-sm col middle-name form-group">
	                                <strong>하차지메모</strong>
	                                    <input type="text" class="form-control form-control-sm" id="eMemo" name="eMemo">
	                                </div>
	                                <c:if test="${addrAuth.writeYn eq 'Y'}">
		                                <div class="col input-group radio-or-checkBox">
			                               	<input id="eAreaSave" name="eAreaSave" type="checkbox" onclick="btnChk(this)">
			                               	<label for="eAreaSave" class="insert-label">
			                               		<span>주소지 저장</span>
			                               	</label>
		                                </div>
	                                </c:if>
	                            </div>
	                        </div>
                            
                            <div class="form-group row">
                                <div class="col-form-label big-name big-name-div">
									<div>화물</div>
									<a id="cargo" style="background: #fff;border-radius: 4px;box-shadow: 0px 0px 2px 0px;color: #0A8DFF;height: 20px;width: 100px;" class="k-pager-refresh k-button openCloseBtn">추가정보열기</a>
								</div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong class="required">차종</strong>
                                    <select class="custom-select col-12" id="carTypeCode" name="carTypeCode" required></select>
                                    <div class="help-block with-errors"></div>
                                </div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong class="required">톤수</strong>
                                    <select class="custom-select col-12" id="carTonCode" name="carTonCode" required></select>
                                    <div class="help-block with-errors"></div>
                                </div>
                            </div>
                            
                            <div class="form-group row">
                                <label class="col-form-label big-name"></label>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong>화물정보</strong>
                                    <input style="width: 237.13px;" type="text" class="form-control form-control-sm" id="goodsName" name="goodsName">
                                </div>
                                
                                <div class="col middle-name form-group">
                                <strong>중량</strong>
                                    <input type="text" class="form-control form-control-sm" id="goodsWeight" name="goodsWeight" pattern="^(\d*)[\.]?(\d{1,3})?$"
                                    data-pattern-error='숫자와 "." 기호만 사용할 수 있습니다.'>
                                </div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong>　</strong>
                                	<!-- <select class="custom-select col-12" id="weightUnitCode" name="weightUnitCode" required></select> -->
                                	<input class="form-control form-control-sm" id="weightUnitCode" name="weightUnitCode" value="TON" readonly >                                    	
                                    <div class="help-block with-errors"></div>
                                </div>
                            </div>
                            
                            <!-- 화물 접기, 열기부분 -->
                            <div id="cargoOpenClose" class="openCloseDiv">
	                            <div class="form-group row">
	                                <label class="col-form-label"></label>
	                                <div class="input-group input-group-sm col middle-name form-group">
	                                <strong class="required">수출입구분</strong>
	                                    <select id="inOutSctn" name="inOutSctn" class="custom-select col-12" required></select>
	                                    <div class="help-block with-errors"></div>
	                                </div>
	                                <div class="input-group input-group-sm col middle-name form-group">
	                                <strong class="required">운송유형</strong>
	                                    <select id="truckTypeCode" name="truckTypeCode" class="custom-select col-12" required></select>
	                                    <div class="help-block with-errors"></div>
	                                </div>
	                            </div>
	                            
	                            <div class="form-group row">
	                                <label class="col-form-label"></label>
	                                <div class="input-group input-group-sm col middle-name form-group">
	                                <strong>운송품목</strong>
	                                	<select style="width: 237.13px;" class="custom-select col-12" id="itemCode" name="itemCode"></select>
	                                </div>
	                                
	                                <div class="input-group input-group-sm col middle-name form-group">
	                                <strong>수량</strong>
	                                    <input type="text" class="form-control form-control-sm" id="goodsQty" name="goodsQty">
	                                </div>
	                                <div class="input-group input-group-sm col middle-name form-group">
	                                <strong>　</strong>
	                                	<select class="custom-select col-12" id="qtyUnitCode" name="qtyUnitCode"></select>
	                                </div>
	                            </div>
	                        	
	                        	<div class="form-group row">
	                                <label class="col-form-label"></label>
	                                <div class="input-group input-group-sm col middle-name form-group">
	                                <strong class="required">상차방법</strong>
	                                	<select class="custom-select col-12" id="sWayCode"name="sWayCode" required></select>
	                                </div>
	                                
	                                <div class="input-group input-group-sm col middle-name form-group">
	                                <strong class="required">하차방법</strong>
	                                    <select class="custom-select col-12" id="eWayCode" name="eWayCode" required></select>
	                                </div>
	                                
	                                <div class="input-group input-group-sm col radio-or-checkBox form-group">
	                                	<input type="checkbox" id="mixYn" name="mixYn" onclick="btnChk(this)">
	                                	<label for="mixYn" class="insert-label">
	                                	<span>혼적</span>
	                                	</label>
	                                </div>
	                                
	                                <div class="input-group input-group-sm col middle-name form-group form-group">
	                                <strong>혼적크기</strong>
	                                    <select class="custom-select col-12" id="mixSize" name="mixSize"></select>
	                             	</div>
	                             	
	                                <div class="input-group input-group-sm col radio-or-checkBox form-group">
	                                	<input type="checkbox" id="returnYn" name="returnYn" onclick="btnChk(this)">
	                                	<label for="returnYn" class="insert-label">
	                                	<span>왕복</span>
	                                	</label>
	                                </div>
	                            </div>
		                                
                                <div class="form-group row">
                                    <label class="col-form-label"></label>
                                    <div style="display: block;text-align: left;margin: 0.3em;" class="input-group input-group-sm col radio-or-checkBox form-group">
                                    	<input type="checkbox" id="dangerGoodsYn" name="dangerGoodsYn" onclick="btnChk(this)">
                                    	<label for="dangerGoodsYn" class="insert-label">
                                    	<span>위험물</span>
                                    	</label>
                                    </div>
                                    
                                    <div style="display: block;text-align: center;margin: 0.3em;" class="input-group input-group-sm col radio-or-checkBox form-group">
                                    	<input type="checkbox" id="chemicalsYn" name="chemicalsYn" onclick="btnChk(this)">
                                    	<label for="chemicalsYn" class="insert-label">
                                    	<span>유해물</span>
                                    	</label>
                                    </div>
                                    
                                    <div style="display: block;text-align: right;margin: 0.3em;" class="input-group input-group-sm col radio-or-checkBox form-group">
                                    	<input type="checkbox" id="foreignLicenseYn" name="foreignLicenseYn" onclick="btnChk(this)">
                                    	<label for="foreignLicenseYn" class="insert-label">
                                    	<span>보세운송</span>
                                    	</label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group row">
                              	<label class="col-form-label big-name">배차</label>
                            	<div class="input-group input-group-sm col middle-name form-group">
                                <input type="hidden" name="buyCustId" id="buyCustId">
                                <input type="hidden" name="buyDeptId" id="buyDeptId">
                                <strong class="required">운송사</strong>
                                	<input style="width: 100%;" type="text" name="buyCustName" id="buyCustName" required>
                                	<div class="help-block with-errors"></div>
                             	</div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong class="required">담당부서</strong>
                                    <input type="text" name="buyDeptName" id="buyDeptName" class="form-control form-control-sm" readonly required>
                                    <div class="help-block with-errors"></div>
                                </div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong>담당자</strong>
                                	<input type="hidden" name="buyStaffId" id="buyStaffId">
                                    <input style="width: 100%;" type="text" name="buyStaff" id="buyStaff">
                                </div>
                            </div>
                            
                             <div class="form-group row">
                            	<label class="col-form-label"></label>
                            </div>
                                
                            <div class="form-group row">
                            	<label class="col-form-label"></label>
                                <div class="input-group input-group-sm col middle-name form-group">
                                	<strong>지불운임</strong>
                                	<input id="buyCharge" name="buyCharge" type="text" class="form-control form-control-sm">
                                </div>
                                <div class="col input-group middle-name form-group">
                                <strong>차주확인사항</strong>
                                    <input id="driverMemo" name="driverMemo" type="text" class="form-control form-control-sm">
                                </div>
                            </div> 
                            
                            <div id="driverKind" class="form-group row">
                            	<label class="col-form-label big-name">차량</label>
                                <input type="hidden" name="vehicId" id="vehicId">
                                <input type="hidden" name="driverId" id="driverId">
                             	<div class="input-group input-group-sm col middle-name form-group">
                                	<strong>차량번호</strong>
                                	 <input type="text" id="carNumData" name="carNum" class="form-control form-control-sm" readonly>
                             	</div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                	<strong>차주성명</strong>
                                	<input type="text" id="driverNameData" name="driverName" class="form-control form-control-sm" readonly>
                                </div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                	<strong>휴대전화</strong>
                                	<input type="text" id="driverTelData" name="driverTel" class="form-control form-control-sm" readonly>
                                </div>
                            </div>
                            
                            <div id="driverStateDiv" class="form-group row">
                            	<label class="col-form-label big-name"></label>
                            	<div class="input-group input-group-sm col middle-name form-group">
                                	<strong>입차시간</strong>
                                	<input id="enterDate" name="enterDate" type="text" class="form-control form-control-sm" readonly>
                                </div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                	<strong>출발시간</strong>
                                	<input id="startDate" name="startDate" type="text" class="form-control form-control-sm" readonly>
                                </div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                	<strong>도착시간</strong>
                                	<input id="finishDate" name="finishDate" type="text" class="form-control form-control-sm" readonly>
                                </div>
                            </div>
                            
                            <div class="form-group row">
                            	<label class="col-form-label big-name">기타</label>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong>거리</strong>
                                	<input id="distance" name="distance" type="text" class="form-control form-control-sm" readonly>
                             	</div>
                                <div class="input-group input-group-sm col middle-name form-group">
                                	<strong>시간</strong>
                                	<input id="time" name="time" type="hidden" class="form-control form-control-sm" readonly>
                                	<input id="timeTxt" name="timeTxt" type="text" class="form-control form-control-sm" readonly>
                                </div>
                                <div class="input-group input-group-sm col middle-name form-group"></div>
                            </div>
                        	
						</fieldset>
						<div class="editor_btns" style="text-align:center;">
							<div class="padding">
								<button type="submit" onclick="readonlyValidator();" class="k-pager-refresh k-button" id="btnSubmit"><b class="btn-b"><i class="k-icon k-i-check"></i><strong id="btn_save">저장</strong></b></button>
								<a id="orderCopy" onclick="orderCopy();" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-file"></i>복사</b></a>
								<a onclick="init_popup_close();" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
							</div>
						</div>
						</form>
					</div>
                   <!-- editor -->
				</div>
			</div><!-- content -->
		</div>
	</div><!-- wrap -->
    <div id="divOrderStop"></div>
</div>
<script type="text/javascript">
var sComName, eComName;
var buyCustName, buyStaff;
var g_mode = "";
var win = null;

var carTypeData = Util.getComCode("CAR_TYPE_CD");
var carTonData = Util.getComCode("CAR_TON_CD");
var truckTypeData = Util.getComCode("TRUCK_TYPE_CD");

$(document).ready(function(){
	Util.setCmmCode("select", "inOutSctn", "IN_OUT_SCTN", "01", "선택하세요");
	Util.setCmmCode("select", "itemCode", "ITEM_CD", "", "선택하세요");
	Util.setCmmCode("select", "qtyUnitCode", "QTY_UNIT_CD", "", "선택하세요");
	Util.setCmmCode("select", "mixSize", "MIX_SIZE_CD", "", "선택하세요");
	Util.setCmmCode("select", "sWayCode", "WAY_TYPE_CD", "일", "선택하세요");
	Util.setCmmCode("select", "eWayCode", "WAY_TYPE_CD", "일", "선택하세요");
	$("#sDateDay, #eDateDay").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
	$("#sDateTime, #eDateTime").kendoTimePicker({format: "HH:mm", value : new Date(), dateInput: true});

	setFrtSelect(truckTypeData, "truckTypeCode", "01", "TR");
	setFrtSelect(carTypeData, "carTypeCode", "TR", "");
	setFrtSelect(carTonData, "carTonCode", "TR", "");
	
	$("#inOutSctn").on("change", function(){
		setFrtSelect(truckTypeData, "truckTypeCode", $(this).val(), "");
	});

	$("#truckTypeCode").on("change", function(){
		setFrtSelect(carTypeData, "carTypeCode", $(this).val(), "");
		setFrtSelect(carTonData, "carTonCode", $(this).val(), "");		
	});
	
	//상하차지 자동완성
	sComName = MultiColumnComboBox.setComName("s", "${sessionScope.userInfo.deptId}");
	eComName = MultiColumnComboBox.setComName("e", "${sessionScope.userInfo.deptId}");
	
	//운송사 자동완성
	buyCustName = MultiColumnComboBox.setCustName("buy", "02", "${sessionScope.userInfo.deptId}");
	buyCustName.bind("select", changeBuyCust);
	buyCustName.bind("change", searchCustSelectTrigger);

	//담당직원 자동완성	
	buyStaff = 	MultiColumnComboBox.setStaff("buy");

	//계약단가
	$("#buyCustName").change(function() {
		var buyDeptName = $(this).val();
		if(buyDeptName != "") {
			getCharge("B");
		}
	});
	
	if("${addrAuth.writeYn}" == "Y") {
		// 주소지 체크
		$('#sComName, #sAddrDetail, #sStaff, #sTel').on('change', function() {
			checkCustAddr('s');
		})

		$('#eComName, #eAddrDetail, #eStaff, #eTel').on('change', function() {
			checkCustAddr('e');
		})
	}
	
	sComName.bind("select", addrLatLonValidation);
	eComName.bind("select", addrLatLonValidation);
	
	$("input[data-role='datepicker']").on("focus", function(e) {
		var id = e.target.id;
		switch (id) {
			case "sDateDay" :
				sDateDayChangeFocusFlag = 0;
				break;

			case "eDateDay" :
				eDateDayChangeFocusFlag = 0;
				break;
			default :
				break;
		}
	});

	$("input[data-role='timepicker']").on("focus", function(e) {
		var id = e.target.id;
		switch (id) {
			case "sDateTime" :
				sDateTimeChangeFocusFlag = 0;
				break;

			case "eDateTime" :
				eDateTimeChangeFocusFlag = 0;
				break;
			default :
				break;
		}
	});
	
    $("input[data-role='datepicker']").on("keydown", function(e) {
        if ($.isNumeric(e.key)) {
            var id = e.target.id;

            switch (id) {
                case "sDateDay":
                	sDateDayChangeFocusFlag++;
                    if (sDateDayChangeFocusFlag === 4 || sDateDayChangeFocusFlag === 6) {
                    	//sDateDayChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                case "eDateDay":
                	eDateDayChangeFocusFlag++;
                    if (eDateDayChangeFocusFlag === 4 || eDateDayChangeFocusFlag === 6) {
                    	//sDateDayChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                default:
                    break;
            }
        }
    });

    $("input[data-role='timepicker']").on("keydown", function(e) {
        if ($.isNumeric(e.key)) {
            var id = e.target.id;
            switch (id) {
                case "sDateTime":
                	sDateTimeChangeFocusFlag++;
                    if (sDateTimeChangeFocusFlag === 2) {
                    	sDateTimeChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                case "eDateTime":
                	eDateTimeChangeFocusFlag++;
                    if (eDateTimeChangeFocusFlag === 2) {
                    	eDateTimeChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                default:
                    break;
            }
        }
    });	

})

function init_popup_close() {
	form_popup_close();
	init();
}

function gridDataSet(data) {
	//더미 상/하차지 위도경도 세팅
	if(data.sLat == ""){
		data.sLat = "0.0"
	}
	if(data.sLon == ""){
		data.sLon = "0.0"
	}
	if(data.eLat == ""){
		data.eLat = "0.0"
	}
	if(data.eLon == ""){
		data.eLon = "0.0"
	}
	Util.setPageData(data);

	$("#orderCopy").show();
	
	if("${menuAuth.editYn}" != "Y")	$("#btnSubmit").hide();
	if("${menuAuth.writeYn}" != "Y")	$("#orderCopy").hide();
	
	//수출입 구분, 운송유형, 차종, 톤수 세팅
	$("#inOutSctn").val(data.inOutSctn);	
	setFrtSelect(truckTypeData, "truckTypeCode", data.inOutSctn, data.truckTypeCode);
	setFrtSelect(carTypeData, "carTypeCode", data.truckTypeCode, data.carTypeCode);
	setFrtSelect(carTonData, "carTonCode", data.truckTypeCode, data.carTonCode);
	$("#truckTypeCode").val(data.truckTypeCode);
	$("#carTypeCode").val(data.carTypeCode);	
	$("#carTonCode").val(data.carTonCode);
	

	$("#carNumData").val(data.carNum);
	$("#driverNameData").val(data.driverName);
	$("#driverTelData").val(Util.formatPhone(data.driverTel));

	$("#buyCharge").val(Util.formatNumberInput($("#buyCharge").val()))
	
	//상차지명 세팅
	sComName.value(data.sComName);
	
	//하차지명 세팅
	eComName.value(data.eComName);
	
	//배차거래처 세팅
	var name = data.buyCustName;
	buyCustName.select(function(dataItem) {
	    return dataItem.custName === name;
	});

	//배차담당자 세팅
	buyStaff= $("#buyStaff").data("kendoMultiColumnComboBox");
	buyStaff.refresh();
	buyStaff.value(data.buyStaff);

	//checkBox 별도 세팅
	$("input[name=mixYn]:input[value=" + data.mixYn + "]").prop("checked", true);
	btnChkData('mixYn');
	$("input[name=returnYn]:input[value=" + data.returnYn + "]").prop("checked", true);
	btnChkData('returnYn');
	
	$("input[name=dangerGoodsYn]:input[value=" + data.dangerGoodsYn + "]").prop("checked", true);
	btnChkData('dangerGoodsYn');
	
	$("input[name=chemicalsYn]:input[value=" + data.chemicalsYn + "]").prop("checked", true);
	btnChkData('chemicalsYn');
	
	$("input[name=foreignLicenseYn]:input[value=" + data.foreignLicenseYn + "]").prop("checked", true);
	btnChkData('foreignLicenseYn');
	
	// 경유지 값 세팅	
	var comName = "";
	var stopCount = parseInt(data.stopCount, 10);
	comName = data.stopName;
	if(stopCount > 1)	comName  += " 외 " + (stopCount-1) + "곳";

	$("#iStopTxt").html(comName);
	
	//시간 세팅
	var time = data.time;
	var timeTxt = "";
	if(time > 60) {
		timeTxt = parseInt(time / 60) + "시간 " + (time%60) + "분"; 
	}else {
		timeTxt = time + "분";
	}
	$("#timeTxt").val(timeTxt);
}

function init(){
	//Util.formReset("", [".editor input",".editor select", ".editor textarea"],{"#mixYn": 'N', "#returnYn": 'N',"#sAreaSave": 'N', "#eAreaSave": 'N',});
	
	$("#f")[0].reset();
	$("input[type=hidden]").val('');
	
	btnChkData('mixYn');
	btnChkData('returnYn');
	btnChkData('dangerGoodsYn'); 
	btnChkData('chemicalsYn'); 
	btnChkData('foreignLicenseYn'); 
	
	$("#mode").val("N");

	$("#sDateDay").data("kendoDatePicker").value(new Date());
	$("#eDateDay").data("kendoDatePicker").value(new Date());


	// form 초기화 시, timepicker data 사라짐 -> 다시 생성
	var sDateTime = "<strong class=\"required\">상차 시간</strong> " +
        			"<input style=\"padding: 0;\" type=\"text\" id=\"sDateTime\" name=\"sDateTime\" class=\"col-12\" required>" +
        			"<div class=\"help-block with-errors\"></div>" +
    				"</div>";

	var eDateTime = "<strong class=\"required\">하차 시간</strong> " +
        			"<input style=\"padding: 0;\" type=\"text\" id=\"eDateTime\" name=\"eDateTime\" class=\"col-12\" required>" +
        			"<div class=\"help-block with-errors\"></div>" +
    				"</div>";
			
    $("#sTimeDiv").html(sDateTime);
    $("#eTimeDiv").html(eDateTime);
    $("#sDateTime, #eDateTime").kendoTimePicker({format: "HH:mm", value : new Date(), dateInput: true});

	$("input[data-role='timepicker']").on("focus", function(e) {
		var id = e.target.id;
		switch (id) {
			case "sDateTime" :
				sDateTimeChangeFocusFlag = 0;
				break;

			case "eDateTime" :
				eDateTimeChangeFocusFlag = 0;
				break;
			default :
				break;
		}
	});

    $("input[data-role='timepicker']").on("keydown", function(e) {
        if ($.isNumeric(e.key)) {
            var id = e.target.id;
            switch (id) {
                case "sDateTime":
                	sDateTimeChangeFocusFlag++;
                    if (sDateTimeChangeFocusFlag === 2) {
                    	sDateTimeChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                case "eDateTime":
                	eDateTimeChangeFocusFlag++;
                    if (eDateTimeChangeFocusFlag === 2) {
                    	eDateTimeChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                default:
                    break;
            }
        }
    });

    $("input[data-role='timepicker']").on("keydown", function(e) {
        if ($.isNumeric(e.key)) {
            var id = e.target.id;
            switch (id) {
                case "sDateTime":
                	sDateTimeChangeFocusFlag++;
                    if (sDateTimeChangeFocusFlag === 2) {
                    	sDateTimeChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                case "eDateTime":
                	eDateTimeChangeFocusFlag++;
                    if (eDateTimeChangeFocusFlag === 2) {
                    	eDateTimeChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                default:
                    break;
            }
        }
    });
	
	sComName.value('');
	eComName.value('');
	buyCustName.value('');
	buyStaff.value('');
	$("#iStopTxt").val('');
	
	$(".list-unstyled").remove();

	
	$("#driverKind").hide();
	$("#driverStateDiv").hide(); 
	$("#orderCopy").hide();
	$("#btnSubmit").show();
	
	if("${menuAuth.writeYn}" != "Y")	$("#btnSubmit").hide();
	
	// 업무 초기값 불러오기
	getUserOption();
}

function btnChk(id){
	if(id.checked == true){
		$(id).val("Y")
	}else{
		$(id).val("N")
	}
}

function getUserOption(){
	$.ajax({
		url: "/oms/user/data/getUserOption.do",
		type: "POST",
		dataType: "json",
		data: $("#fUserOption").serialize(),				
		success: function(data){
			if(data.result) {
				var data = data.data;
				if(data != null){
					//수출입 구분, 운송유형, 차종, 톤수 세팅
					setFrtSelect(truckTypeData, "truckTypeCode", data.defaultInOutSctn, data.truckTypeCode);
					setFrtSelect(carTypeData, "carTypeCode", data.defaultTruckTypeCode, data.defaultCarTypeCode);
					setFrtSelect(carTonData, "carTonCode", data.defaultTruckTypeCode, data.defaultCarTonCode);
					
					$("#buyCustId").val(data.defaultBuyCustId);
					$("#buyDeptId").val(data.defaultBuyDeptId);
					$("#reqMemo").val(data.defaultReqMemo);
					
					$("#sLat").val(data.defaultSLat);
					$("#sLon").val(data.defaultSLon);
					$("#sSido").val(data.defaultSSido);
					$("#sGungu").val(data.defaultSGungu);
					$("#sDong").val(data.defaultSDong);
					$("#sAddr").val(data.defaultSAddr);
					$("#sAddrDetail").val(data.defaultSAddrDetail);
					$("#sStaff").val(data.defaultSStaff);
					$("#sTel").val(Util.formatPhone(data.defaultSTel));
					$("#sMemo").val(data.defaultSMemo);
	
					$("#carTypeCode").val(data.defaultCarTypeCode);
					$("#carTonCode").val(data.defaultCarTonCode);
					$("#goodsName").val(data.defaultGoodsName);
					$("#goodsWeight").val(data.defaultGoodsWeight);
				 	$("#inOutSctn").val(data.defaultInOutSctn);	
					$("#truckTypeCode").val(data.defaultTruckTypeCode);
					$("#itemCode").val(data.defaultItemCode);
					$("#sWayCode").val(data.defaultSWayCode);
					$("#eWayCode").val(data.defaultEWayCode);
					$("#buyDeptName").val(data.defaultBuyDeptName);
					$("#buyCharge").val(Util.formatNumberInput(data.defaultBuyCharge));
					$("#driverMemo").val(data.defaultDriverMemo);
	
					setTimeout(function(){
						var buyCustSelect = data.defaultBuyCustName;
						buyCustName.select(function(dataItem) {
						    return dataItem.custName === buyCustSelect;
						});
						buyStaff.value(data.defaultBuyStaffName);
						sComName.value(data.defaultSComName);
					}, 50);
				}
			}
		}
	});
}

function popOrderStopDetail(){
	var orderId = $("#orderId").val();
	
	win = $("#divOrderStop").data("kendoWindow");
	if(win == null) {
		win = $("#divOrderStop").kendoWindow({
			width: 850,
			height: 729,
			content: {
				url: "/oms/order/view/orderStopDetail.do?orderId=" + orderId
			},
			iframe: true,
			visible:false
		}).data("kendoWindow");	
	} else {
		win.refresh("/oms/order/view/orderStopDetail.do?orderId=" + orderId);
	}	
	win.center().open();
}

//경유지 팝업창에서 호출
function setOrderStopData(data) {
	$("#orderStopData").val(data);
	
	var jsonData = JSON.parse(data);
	var size = 0;
	var comName = "";
	
	for(var item, i=0; item=jsonData[i]; i++) {
		if(item.useYn != "N") {
			if (comName ==  "") comName = item.eComName;
			size ++;
		}
	}
	
	if(size > 1)	comName  += " 외 " + (size-1) + "곳";

	$("#iStopTxt").html(comName);
}

function btnChkData(id){
	if($("#"+id).val() == "N"){
		$("input:checkbox[id='"+id+"']").prop("checked", false);
	}else{
		$("input:checkbox[id='"+id+"']").prop("checked", true);
	}
}

function readonlyValidator(){
	$("input[name$='Addr']").removeAttr('readonly');
}
$('#f').validator().on('submit', function (e) {
	$("input[name$='Addr']").attr('readonly', true);
	if (e.isDefaultPrevented()) {
		alert("항목을 입력해 주세요.")
	} else {
		// 이벤트 초기화 (submit 동작 중단)
		e.preventDefault();

		$("#buyCharge").val($("#buyCharge").val().replace(/,/g, ""));
		$("#sTel").val($("#sTel").val().replace(/\-/g, ""));
		$("#eTel").val($("#eTel").val().replace(/\-/g, ""));
		
		 $.ajax({
			url: "/oms/order/data/orderWrite.do",
			type: "POST",
			dataType: "json",
			data: $("#f").serialize(),				
			success: function(data){
				if(data.result) {
					alert(data.msg);
					init_popup_close();
					goList();
				} else {
					alert(data.msg);
				}
			}
		})
	}
})


/**
 * 오더 복사
 * @returns
 */
function orderCopy() {
	$("#mode").val("C");

	$("#buyCharge").val($("#buyCharge").val().replace(/,/g, ""));
	$("#sTel").val($("#sTel").val().replace(/\-/g, ""));
	$("#eTel").val($("#eTel").val().replace(/\-/g, ""));
	
	$.ajax({
		url: "/oms/order/data/orderWrite.do",
		type: "POST",
		dataType: "json",
		data: $("#f").serialize(),			
		success: function(data){
			if(data.result) {
				alert(data.msg);
				init_popup_close();
				goList();
			} else {
				alert(data.msg);	
			}
		}
	})
}

function popSearchPost(mode){
	Util.popSearchPost(mode);
}

function setSearchAddressInfo(data) {
    //var addr = data.roadAddr; // 주소 변수
	var addr = data.jibunAddr; // 주소 변수
    var sido = data.siNm;
    var gungu = data.sggNm;
    var dong = data.emdNm;
    var mode = data.mode;
	    
   $.ajax({
      url: "/contents/basic/data/getLatLon.do",
      type: "POST",
      dataType: "json",
      data: {
         searchAddress: addr,
         size: 10
      },
      success: function(apiData){
         if(apiData.result){
            var localData = JSON.parse(apiData.data);
            var lat = '';
             var lon = '';
             lon = localData.documents[0].x;
            lat = localData.documents[0].y;
            var addressData = localData.documents[0].address;
            
            $("#"+mode).val(addressData.address_name);
            if(mode == "sAddr"){
                   $("#sSido").val(addressData.region_1depth_name);
                   $("#sGungu").val(addressData.region_2depth_name);
                   $("#sDong").val(addressData.region_3depth_name);
                    $("#sLon").val(lon);
                    $("#sLat").val(lat);
            } else if(mode == "eAddr"){
                   $("#eSido").val(addressData.region_1depth_name);
                   $("#eGungu").val(addressData.region_2depth_name);
                   $("#eDong").val(addressData.region_3depth_name);
                    $("#eLon").val(lon);
                    $("#eLat").val(lat);                    
            }

            getRoute();            
                $("#"+mode+"Detail").focus();

         } else {
            if(mode == "sAddr"){
               $("#sAddr").val(addr);
               $("#sSido").val(sido);
               $("#sGungu").val(gungu);
               $("#sDong").val(dong);
            } else if(mode == "eAddr"){
               $("#eAddr").val(addr);
               $("#eSido").val(sido);
               $("#eGungu").val(gungu);
               $("#eDong").val(dong);                    
            }
         }
      }
   });
}

function dummyAddressInfo(data) {
	$.ajax({
		url: "/contents/basic/data/getLatLon.do",
		type: "POST",
		dataType: "json",
		data: {
			searchAddress: data.sido+" "+data.gungu,
			size: 10
		},
		success: function(apiData){
			if(apiData.result){
				var localData = JSON.parse(apiData.data);
				var lat = '';
    			var lon = '';
    			lon = localData.documents[0].x;
				lat = localData.documents[0].y;
				var addressData = localData.documents[0].address;
				
				if(data.mode == "sAddr"){
					$("#sAddr").val(data.sido+" "+data.gungu);
	                $("#sSido").val(addressData.region_1depth_name);
	                $("#sGungu").val(addressData.region_2depth_name);
                    $("#sLon").val(lon);
                    $("#sLat").val(lat);

            		$("input:checkbox[id='sAreaSave']").prop("checked", true);
            		$("input:checkbox[id='sAreaSave']").val("Y")
            		$("#sAreaSave").parent(".radio-or-checkBox").css("display", "contents");
	                $("#sAddrDetail").focus();
				} else if(mode == "eAddr"){
					$("#eAddr").val(data.sido+" "+data.gungu);
					$("#eSido").val(data.sido);
				    $("#eGungu").val(data.gungu);
				    $("#eDong").val("");
                    $("#eLon").val(lon);
                    $("#eLat").val(lat);                

            		$("input:checkbox[id='eAreaSave']").prop("checked", true);
            		$("input:checkbox[id='eAreaSave']").val("Y")
            		$("#eAreaSave").parent(".radio-or-checkBox").css("display", "contents");
	                $("#eAddrDetail").focus();
				}

				getRoute();				
			} else {
				if(mode == "sAddr"){
					$("#sAddr").val(data.sido+" "+data.gungu);
					$("#sSido").val(data.sido);
                    $("#sGungu").val(data.gungu);
                    $("#sDong").val("");
				} else if(mode == "eAddr"){
					$("#eAddr").val(data.sido+" "+data.gungu);
					$("#eSido").val(data.sido);
                    $("#eGungu").val(data.gungu);
                    $("#eDong").val("");                    
				}
			}
		}
	});
	/* 
	$("#distance").val("");
	$("#time").val("");
	$("#timeTxt").val(""); */
}


$(".openCloseBtn").on('click', function (){
	var divId = $(this).context.id;
	if($("#"+divId+"OpenClose").css("display") == "none"){
		$("#"+divId+"OpenClose").show();
		$("#"+divId).html("추가정보접기");
	}else{
		$("#"+divId+"OpenClose").hide();
		$("#"+divId).html("추가정보열기");
	}
});

function dummyPopSearchPost(mode){
	Util.dummyPopSearchPost(mode);
}

function addrLatLonValidation(){
	if($("#sLat").val() == "0E-13")
	$("#sLat").val("0.0");
	
	if($("#eLat").val() == "0E-13")
	$("#eLat").val("0.0");
	
	if($("#sLon").val() == "0E-12")
	$("#sLon").val("0.0");
	
	if($("#eLon").val() == "0E-12")
	$("#eLon").val("0.0");
}


function searchCustSelectTrigger(e){
	if(this.value() != ""){
		buyCustName.trigger("select");
	}else{
		$("#custId").val("");
		$("#deptId").val("");
		$("#buyDeptName").val("");
	}
}

$("#buyCharge").on("input", function(){
	$(this).val(Util.formatNumberInput($(this).val()));
});

$("#sTel, #eTel").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});
</script>