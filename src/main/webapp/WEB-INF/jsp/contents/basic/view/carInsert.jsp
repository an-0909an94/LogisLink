<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="pop-layer">
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
                   		<form name="f" id="f" method="post" data-toggle="validator" role="form" autocomplete="off">
                   		   <input class="inputHidden" id="mode" name="mode">           		
	                       <input class="inputHidden" id="vehicId" name="vehicId">
	                       <input class="inputHidden" id="driverId" name="driverId">
	                       <input class="inputHidden" id="deptId" name="deptId">
	                       <input class="inputHidden" id="custId" name="custId">
	                       <input class="inputHidden" id="custVehicSeq" name="custVehicSeq">
                           <fieldset>
                               <legend id="car_legend">차량 등록</legend>
                                <div class="form-group row">
                                    <label class="col-form-label big-name">담당부서</label>
                                    <div class="input-group input-group-sm col middle-name form-group">
                                    	<strong class="required">담당부서</strong>
                                    	<select id="mngDeptId" name="mngDeptId" class="custom-select col-12" required></select>
                                    </div>
                                    <div class="input-group input-group-sm col middle-name form-group">
                                    <strong>담당자명</strong>
                                        <select class="custom-select col-12" id="userId" name="userId"></select>
                                    </div>
                                </div>
                                
                               <div class="form-group row">
                                   <label class="col-form-label big-name">기본정보</label>                                   
                                   <div id="carNumber" class="input-group input-group-sm col middle-name form-group">
                                   <strong class="required">차량번호</strong>
                                       <input type="text" class="form-control form-control-sm" id="carNum" name="carNum" pattern="^[가-힣ㄱ-ㅎㅏ-ㅣ\x20]{2}\d{2}[가-힣ㄱ-ㅎㅏ-ㅣ\x20]\d{4}$"
                                       data-pattern-error="차량번호를 확인해 주세요." maxlength="10" required placeholder="서울XX아XXXX">
                                       <div class="help-block with-errors"></div>
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong class="required">차주성명</strong>
                                       <input type="text" class="form-control form-control-sm" id="driverName" name="driverName" maxlength="20"  pattern="^(?=.{1,20}$).*" 
	                                	data-pattern-error="20자 이하로 입력해 주세요." required>
                                       <div class="help-block with-errors"></div>
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong class="required">차량구분</strong>
                                       <select class="custom-select col-12" id="carSctnCode" name="carSctnCode" required></select>
                                       <div class="help-block with-errors"></div>
                                   </div>
                               </div>
                               
                               <div class="form-group row">
                               	<label class="col-form-label"></label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>전화번호</strong>
                                       <input type="text" class="form-control form-control-sm" id="telNum" name="telNum" maxlength="13">
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong class="required">휴대전화</strong>
                                       <input type="text" class="form-control form-control-sm" id="mobile" name="mobile" maxlength="13" required>
                                       <div class="help-block with-errors"></div>
                                   </div>
								<div class="input-group input-group-sm col middle-name form-group">
                                   <strong>알림톡 수신여부</strong>
                                    <input type="hidden" id="talkYn" name="talkYn">
									<input type="checkbox" id="chkTalkYn" name="chkTalkYn" class="input_on-off" value="Y">
									<label for="chkTalkYn" class="label_on-off">
										<span class="marble"></span>
										<span class="on">on</span>
										<span class="off">off</span>
									</label>
								</div>
                               </div>
                               
                               <div class="form-group row">
                               	<label class="col-form-label"></label>
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
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>적재함길이</strong>
                                       <input type="text" class="form-control form-control-sm" id="cargoBox" name="cargoBox" maxlength="30">
                                   </div>
                               </div>
                               
                               <div class="form-group row">
                                   <label class="col-form-label"></label>
                                 <!--   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>담당직원</strong>
                                       <select class="custom-select col-12" id="userId" name="userId"></select>
                                   </div> -->
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong class="required">사용여부</strong>
                                       <select class="custom-select col-12" id="useYn" name="useYn" required>
                                           <option value=''>선택해주세요.</option>
                                           <option value="Y" selected>사용</option>
                                           <option value="N">미사용</option>
                                       </select>
                                       <div class="help-block with-errors"></div>
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>등록일자</strong>
                                       <input type="text" class="form-control form-control-sm" readonly="readonly" id="regdate" name="regdate">
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>해지일자</strong>
                                       <input type="text" class="form-control form-control-sm" readonly="readonly" id="disuseDate">
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>혼적선호여부</strong>
                                       <select class="custom-select col-12" id="mixPreferYn" name="mixPreferYn" required>
                                           <option value="Y" selected>선호</option>
                                           <option value="N">비선호</option>
                                   	   </select>	
                                   </div>
                              	</div>
                              	
                              	<div class="form-group row">
                                   <label class="col-form-label"></label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>위험물 운송여부</strong>
                                       <select class="custom-select col-12" id="dangerGoodsYn" name="dangerGoodsYn">
                                           <option value='' selected>선택해주세요.</option>
                                           <option value="Y">가능</option>
                                           <option value="N">불가</option>
                                       </select>
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>화학물 운송여부</strong>
                                       <select class="custom-select col-12" id="chemicalsYn" name="chemicalsYn">
                                           <option value='' selected>선택해주세요.</option>
                                           <option value="Y">가능</option>
                                           <option value="N">불가</option>
                                       </select>
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>보세면허 여부</strong>
                                       <select class="custom-select col-12" id="foreignLicenseYn" name="foreignLicenseYn">
                                           <option value='' selected>선택해주세요.</option>
                                           <option value="Y">있음</option>
                                           <option value="N">없음</option>
                                       </select>
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>지게차면허 여부</strong>
                                       <select class="custom-select col-12" id="forkliftYn" name="forkliftYn">
                                           <option value='' selected>선택해주세요.</option>
                                           <option value="Y">있음</option>
                                           <option value="N">없음</option>
                                       </select>
                                   </div>
                              	</div>
                              	
                               <div class="form-group row">
                               	<label class="col-form-label"></label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>이메일</strong>
                                       <input type="text" class="form-control form-control-sm" id="driverEmail" name="driverEmail">
                                       <div class="help-block with-errors"></div>
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>스마트빌가입일</strong>
                                       <input type="text" id="taxjoinDate" name="taxjoinDate" style="width: 100%">
                                       <div class="help-block with-errors"></div>
                                   </div>
                               </div>
                               
                               <div class="form-group row">
                               	<label class="col-form-label"></label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>차주계약유형</strong>
                                       <select class="custom-select col-12" id="carContractCode" name="carContractCode"></select>
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>차량개조상태</strong>
                                       <select class="custom-select col-12" id="carModifyCode" name="carModifyCode"></select>
                                   </div>
                               </div>
                               
							   <div class="form-group row">
                                   <label class="col-form-label"></label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>우편물 우편번호(검색)</strong>
                                       <div class="textBox-in-icon">
                                        <input onClick="popSearchPost('postal');" type="text" class="form-control form-control-sm" readonly="readonly" id="postalPost" name="postalPost">
										<i><img onclick="popSearchPost('postal');" src="/images/icon/search.png"></i>
										</div>
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
	                                   <strong>우편물 주소</strong>
	                                   <div class="textBox-in-icon">
	                                       <input type="text" class="form-control form-control-sm" id="postalAddr" name="postalAddr" maxlength="50" pattern="^(?=.{1,50}$).*" 
	                                       data-pattern-error="50자 이하로 입력해 주세요.">
	                                   </div>
	                               </div>
                               </div>
                               
                               <div class="form-group row">
                                   <label class="col-form-label"></label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>우편물 상세주소</strong>
                                       <input type="text" class="form-control form-control-sm" id="postalAddrDetail" name="postalAddrDetail" maxlength="50" pattern="^(?=.{1,50}$).*" 
                                       data-pattern-error="50자 이하로 입력해 주세요.">
                                   </div>
                               </div>
                              	
                               <div class="form-group row">
                                   <label class="col-form-label big-name">사업자정보</label>
                                   <div class="input-group input-group-sm col middle-name form-group form-group">
                                   <strong>사업자상호</strong>
                                       <input type="text" class="form-control form-control-sm" id="bizName" name="bizName" maxlength="50" pattern="^(?=.{1,50}$).*" 
	                                	data-pattern-error="50자 이하로 입력해 주세요.">
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group form-group">
                                   <strong>사업자번호</strong>
                                       <input type="text" class="form-control form-control-sm" id="bizNum" name="bizNum" maxlength="12" pattern="^(?=.{1,12}$).*" 
	                                	data-pattern-error="12자 이하로 입력해 주세요.">
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>종사업장번호</strong>
                                       <input type="text" class="form-control form-control-sm" id="subBizNum" name="subBizNum" maxlength="10" pattern="^(?=.{1,10}$).*" 
	                                	data-pattern-error="10자 이하로 입력해 주세요.">
                                   </div>
                               </div>
                               
								<div class="form-group row">
                                   <label class="col-form-label"></label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>대표자명</strong>
                                       <input type="text" class="form-control form-control-sm" id="ceo" name="ceo" maxlength="20" pattern="^(?=.{1,20}$).*" 
	                               	   data-pattern-error="20자 이하로 입력해 주세요.">
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>업태</strong>
                                       <input type="text" class="form-control form-control-sm" id="bizCond" name="bizCond" maxlength="20" pattern="^(?=.{1,20}$).*" 
	                                   data-pattern-error="20자 이하로 입력해 주세요.">
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>업종</strong>
                                       <input type="text" class="form-control form-control-sm" id="bizKind" name="bizKind" maxlength="20" pattern="^(?=.{1,20}$).*" 
	                                   data-pattern-error="20자 이하로 입력해 주세요.">
                                   </div>
                               </div>
                               
								<div class="form-group row">
                                   <label class="col-form-label"></label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>우편번호(검색)</strong>
                                       <div class="textBox-in-icon">
                                        <input onClick="popSearchPost('biz');" type="text" class="form-control form-control-sm" readonly="readonly" id="bizPost" name="bizPost">
										<i><img onclick="popSearchPost('biz');" src="/images/icon/search.png"></i>
										</div>
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
	                                   <strong>주소</strong>
	                                   <div class="textBox-in-icon">
	                                       <input type="text" class="form-control form-control-sm" id="bizAddr" name="bizAddr" maxlength="50" pattern="^(?=.{1,50}$).*" 
	                                       data-pattern-error="50자 이하로 입력해 주세요.">
	                                   </div>
	                               </div>
                               </div>
                               
                               <div class="form-group row">
                                   <label class="col-form-label"></label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>상세주소</strong>
                                       <input type="text" class="form-control form-control-sm" id="bizAddrDetail" name="bizAddrDetail" maxlength="50" pattern="^(?=.{1,50}$).*" 
                                       data-pattern-error="50자 이하로 입력해 주세요.">
                                   </div>
                               </div>
                               
                               <div class="form-group row">
                                   <label class="col-form-label big-name">APP사용정보</label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>CID</strong>
                                       <input type="text" class="form-control form-control-sm" id="cid" name="cid"  maxlength="13">
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>기기모델</strong>
                                       <input type="text" class="form-control form-control-sm" id="deviceModel" name="deviceModel" readonly="readonly">
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>OS</strong>
                                       <input type="text" class="form-control form-control-sm" id="deviceOs" name="deviceOs" readonly="readonly">
                                   </div>
                               </div>
                               
                               <div class="form-group row">
                                   <label class="col-form-label"></label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>APP 설치버전</strong>
                                       <input type="text" class="form-control form-control-sm" id="appVersion" name="appVersion" readonly="readonly">
                                   </div>
									<div class="input-group input-group-sm col middle-name form-group">
	                                   <strong>APP PUSH 수신여부</strong>
	                                    <input type="hidden" id="pushYn" name="pushYn">
										<input type="checkbox" id="chkPushYn" name="chkPushYn" class="input_on-off" value="Y">
										<label for="chkPushYn" class="label_on-off">
											<span class="marble"></span>
											<span class="on">on</span>
											<span class="off">off</span>
										</label>
									</div>
									<div class="input-group input-group-sm col middle-name form-group"></div>
                               </div>

                               <div class="form-group row">
                                   <label class="col-form-label big-name">계좌정보</label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>은행명</strong>
                                       <select class="custom-select col-12" id="bankCode" name="bankCode">
                                       </select>
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>예금주</strong>
                                       <input type="text" class="form-control form-control-sm" id="bankCnnm" name="bankCnnm" maxlength="20" pattern="^(?=.{1,20}$).*" 
                                       data-pattern-error="20자 이하로 입력해 주세요.">
                                   </div>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>계좌번호</strong>
                                       <input type="text" class="form-control form-control-sm" id="bankAccount" name="bankAccount" maxlength="30" pattern="^(?=.{1,30}$).*" 
                                       data-pattern-error="30자 이하로 입력해 주세요.">
                                   </div>
                               </div>
                               
                               <div class="form-group row">
	                               <label class="col-form-label"></label>
	                               <div class="input-group input-group-sm col middle-name form-group">
		                               <strong>빠른지급여부</strong>
		                               <select class="custom-select col-12" id="payType" name="payType"></select>
	                               </div>
	                               <div class="input-group input-group-sm col middle-name form-group">
		                               <strong>빠른지급사유</strong>
		                               <input id="payMemo" name="payMemo" type="text" class="form-control form-control-sm">
	                               </div>
                               </div>
                               
                               <div class="form-group row">
                                   <label class="col-form-label big-name">기타</label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>차량관리등급</strong>
                                       <select class="custom-select col-12" id="carMngCode" name="carMngCode">
                                       </select>
                                   </div>
                                   <div class="col middle-name form-group">
                                   <strong>관리등급사유</strong>
                                       <input type="text" id="carMngMemo" name="carMngMemo" class="form-control form-control-sm textarea" maxlength="1000">
                                 	</div>
                  	       	   </div>
                  	       	   
                  	       	   <div class="form-group row">
                                   <label class="col-form-label big-name"></label>
                                   <div class="input-group input-group-sm col middle-name form-group">
                                   <strong>메모</strong>
                                       <textarea class="form-control form-control-sm textarea" rows="4" id="memo" name="memo" maxlength="3000"></textarea>
                                   </div>
                  	       	   </div>
                           </fieldset>
                           <div class="editor_btns" style="text-align:center;">
		                       <div class="padding">
								   <button type="submit" class="k-pager-refresh k-button" id="btnSubmit"><b class="btn-b"><i class="k-icon k-i-check"></i><strong id="btn_save">저장</strong></b></button>
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
</div>
<script type="text/javascript">
$(document).ready(function(){
	$("#mngDeptId").on("change", function(){
		Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", {deptId:$(this).val()}, "userId", "userName", "", "선택하세요");
	});
	
	$("#taxjoinDate").kendoDatePicker({format:"yyyy-MM-dd"});
});

var g_mode = "";

$("#mobile, #telNum, #cid").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});

$('#bizNum').on('input', function() {
	var bizNum = $(this).val().replace(/[^\d]/g, '');
	var temp = bizNum.replace(/(\d{3})(\d{1,2})(\d{1,5})/, '$1-$2-$3');
	$(this).val(temp);
});

function init_pop(mode, data) {
	g_mode = mode;
	init();

	var $options = $("#s_dept > option").clone();
	$('#mngDeptId').html($options);
	$("#mngDeptId option[value='']").remove();

	var $options2 = $("#s_carMngCode > option").clone();
	$('#carMngCode').html($options2);
	$("#carMngCode option[value='']").remove();
	
	Util.setCmmCode("select", "carTonCode", "CAR_TON_CD", "", "선택하세요");
	Util.setCmmCode("select", "carTypeCode", "CAR_TYPE_CD", "", "선택하세요");
	Util.setCmmCode("select", "bankCode", "BANK_CD", "", "선택하세요.");
	Util.setCmmCode("select", "carSctnCode", "CARGO_TRAN_CAR_SCTN_CD", "", "선택하세요");
	Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", {}, "userId", "userName", "", "선택하세요");
    Util.setCmmCode("select", "payType", "PAY_TYPE_CD", "N", "선택하세요");
	Util.setCmmCode("select", "carContractCode", "CAR_CONTRACT_CD", "01", "선택하세요");
	Util.setCmmCode("select", "carModifyCode", "CAR_MODIFY_CD", "", "선택하세요");
	
	$("#btnSubmit").show();

	$("#carSctnCode").attr("disabled", false);
	$("#userId").attr("disabled", false);
	$("#memo").attr("disabled", false);
	$("#useYn").attr("disabled", false);
	$("#mngDeptId").prop("disabled", false);
	if(g_mode == "N") {
		$("#car_legend").text("차량 등록");
		$("#btn_save").html($("#btn_save").html().replace('수정', '저장'));
		$("#carNum").removeAttr("readonly");
		$("#carSctnCode").attr("disabled", false);
		$("#userId").attr("disabled", false);
		$("#memo").attr("disabled", false);
		$("#useYn").attr("disabled", false);
		$("#mngDeptId").prop("disabled", false);
		if("${menuAuth.writeYn}" != "Y")	$("#btnSubmit").hide();
	}else{
		$("#car_legend").text("차량 수정");
		$("#btn_save").html($("#btn_save").html().replace('저장', '수정'));
		$("#carNum").attr("readonly",true);
		Util.setPageData(data);
		$("#mngDeptId").val(data.deptId);
		
		$("input[name=chkPushYn]").val(data.pushYn);
		btnChkData('chkPushYn');
		$("input[name=chkTalkYn]").val(data.talkYn);
		btnChkData('chkTalkYn');

		$("#mngDeptId").prop("disabled", true);
		if(!$("#custId").val()) {
			$("#carSctnCode").attr("disabled", true);
			$("#userId").attr("disabled", true);
			$("#memo").attr("disabled", true);
			$("#useYn").attr("disabled", true);
		} else {
			$("#carSctnCode").attr("disabled", false);
			$("#userId").attr("disabled", false);
			$("#memo").attr("disabled", false);
			$("#useYn").attr("disabled", false);
		}

		if("${menuAuth.editYn}" != "Y")	$("#btnSubmit").hide();
	}
}

function init() {
	/*Util.formReset("", [".editor input",".editor select"], {".editor #useYn": 'Y'});
	$("#vehicId").val('');
	$("#driverId").val('');
	$("#deptId").val('');
	$("#custId").val('');
	$("#carTonCode").empty();
	$("#carTypeCode").empty();
	$("#bankCode").empty();
	$("#carSctnCode").empty();
	$(".list-unstyled").remove();
	$("#carMngCode").empty();
	$("#carMngMemo").empty(); */
	$("#f")[0].reset();
	$("#chkTalkYn").val("Y");
	$("#chkPushYn").val("Y");
	btnChkData('chkPushYn');
	btnChkData('chkTalkYn');
}

function popSearchPost(mode){
	addrFlag = arguments[0];
	Util.popSearchPost(mode);
}


$("#carSctnCode").change(function(){
	if($(this).val() == '13' || $(this).val() == '11'){
		$("#payType").val("Y");
	}else{
		$("#payType").val("N");
	}
});

$('#f').validator().on('submit', function (e) {
	  if (e.isDefaultPrevented()) {
	    alert("항목을 입력해 주세요.")
	  } else {
		  $("#mode").val(g_mode);
 		  var talkYn = $("#chkTalkYn").is(":checked") ? "Y" : "N";
		  var pushYn = $("#chkPushYn").is(":checked") ? "Y" : "N";
		  
		  $("#talkYn").val(talkYn);
		  $("#pushYn").val(pushYn);
		  // 이벤트 초기화 (submit 동작 중단)
		  e.preventDefault();
			$.ajax({
				url: "/contents/basic/data/insertCar.do",
				type: "POST",
				dataType: "json",
				//data: param,
				data: $("#f").serializeObject(),
				success: function(data){
					if(data.result) {
						alert(data.msg);
						init_popup_close();
						goList();
					} else {
						alert(data.msg);
					}
				}
			});
	  }
})

function isValid() {
	
	return true;
}

function btnChk(id){
	if(id.checked == true){
		$(id).val("Y")
	} else{
		$(id).val("N")
	}
}

function btnChkData(id){
	if($("#"+id).val() == "N"){
		$("input:checkbox[id='"+id+"']").prop("checked", false);
	}else{
		$("input:checkbox[id='"+id+"']").prop("checked", true);
	}
}

function init_popup_close() {
	form_popup_close();
	init();
}

function setSearchAddressInfo(data) {
	var zipNo = data.zipNo;
	var addr = data.roadAddr; // 주소 변수
    
    $("#"+data.mode+"Post").val(zipNo);
    $("#"+data.mode+"Addr").val(addr);
    $("#"+data.mode+"AddrDetail").focus();
}

</script>