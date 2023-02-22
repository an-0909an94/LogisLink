<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .image_sizeK{
      height:25px;
      margin-right: 5px;
      left: 90px;
    }
</style>
<div class="pop-layer">
    <!--
    <div id="divAddDept" class="editor-warp p-0">
		<div class="modalEditor" id="addDept">
			<div id="popGrid"></div>
			<div class="modalHeader">
				<strong>부서명</strong>
				<input size="35" id="s_deptName" type="text">
			</div>
			<div class="editor_btns">
				<div class="padding">
			        <a onclick="addDept()" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i>추가</b></a>
			        <a id="closeBtn" onclick="addDeptModalClose()" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-cancel"></i>닫기</b></a>
			    </div>
		    </div>
		</div>
	</div>
	-->
    <div class="editor_wrap pop-layer" id="layer1">
	    <div class="insertClose">
	    	<a class="insertCloseButton k-icon k-i-close" onclick="init_popup_close();"></a>
	    </div>
    	<!-- <input type="hidden" id="deptId" name="deptId"> -->
        <!-- wrap -->
        <div class="k-tabstrip-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
                    <div class="editor">
                        <form id="f" data-toggle="validator" role="form">
					    	<input type="hidden" id="custId" name="custId">
                            <fieldset>
                                <legend id="cust_legend">거래처 등록</legend>
                                <div class="editor_btns order_editor_btns" style="text-align:center;">
                                    <div class="padding">
                                        <button type="submit" class="k-pager-refresh k-button" id="btn_saveCust"><b class="btn-b"><strong id="btn_save">저장</strong></b></button>
                                        <a onclick="init_popup_close();" class="k-pager-refresh k-button"><b class="btn-g">닫기</b></a>
                                    </div>
                                </div>
                                <div class="form-group row gray_box">
                                    <label class="col-form-label big-name">사업자조회</label>

                                    <div class="input-group input-group-sm wd290 middle-name form-group">
                                        <strong class="required">사업자번호</strong>
                                        <font size="1em" color="black">사업자번호/상호로 검색 가능합니다.</font>
                                        <div class="textBox-in-icon">
	                                        <input type="text" class="form-control form-control-sm " name="bizNum" id="bizNum" maxlength="12" required readonly>
										    <i><img class = "image_sizeK" src="/images/icon/search.png" id="searchBizinfo"></i>
										</div>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                    <!--
		                            <div class="input-group input-group-sm col middle-name">
		                            	<strong>사업자번호 확인</strong>
		                                <button type="button" class="form-control form-control-sm a-text-center" onclick="bizNumCheck();" id="btn_chkBizNum">사업자번호 확인</button>
		                            </div>
		                            -->
		                        </div>
                                <div class="mt20"></div>
                                <div class="form-group row gray_box">
                                    <label class="col-form-label big-name">우리회사<br>담당자</label>
                                    <div class="input-group input-group-sm wd140 middle-name form-group">
                                    	<strong class="required">담당부서</strong>
                                    	<select id="mngDeptId" name="mngDeptId" class="custom-select wd140" required></select>
                                    </div>
                                    <div class="input-group input-group-sm wd100 middle-name form-group">
                                    <strong class="required">담당자명</strong>
                                        <select class="custom-select wd100" id="manager" required></select>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                </div>
                                <div class="mt20"></div>
                                <div class="gray_box">
                                    <div class="form-group row">
                                        <label class="col-form-label big-name">기본정보</label>
                                        <div class="input-group input-group-sm wd190 middle-name form-group">
                                            <strong class="required">거래처명</strong>
                                            <input type="text" class="form-control form-control-sm" style="width:100%" id="custName" required>
                                            <div class="help-block with-errors"></div>
                                        </div>
                                    </div>

                                    <div class="form-group row mt10">
                                        <label class="col-form-label big-name"></label>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong class="required">거래처 구분</strong>
                                            <select class="custom-select col-12" id="sellBuySctn" required></select>
                                            <div class="help-block with-errors"></div>
                                        </div>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong class="required">거래처 분류</strong>
                                            <select class="custom-select col-12 middle-name" id="custTypeCode" required></select>
                                            <div class="help-block with-errors"></div>
                                        </div>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong class="required">사용여부</strong>
                                            <select class="custom-select col-12" id="useYn" required>
                                                <option value="Y">Y</option>
                                                <option value="N">N</option>
                                            </select>
                                            <div class="help-block with-errors"></div>
                                        </div>
                                    </div>

                                    <div class="form-group row mt10">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>거래처등급</strong>
                                            <select class="custom-select col-12" id="custMngCode" name="custMngCode"></select>
                                        </div>
                                        <div class="input-group input-group-sm wd140 middle-name form-group">
                                            <strong>거래처등급사유</strong>
                                            <input type="text" style="width:100%" class="form-control form-control-sm" id="custMngMemo">
                                        </div>

                                    </div>

                                    <div class="form-group row mt10">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>빠른지급여부</strong>
                                            <select class="custom-select col-12" id="payType" name="payType"></select>
                                        </div>
                                        <div class="input-group input-group-sm wd140 middle-name form-group">
                                            <strong>빠른지급사유</strong>
                                            <input id="payMemo" name="payMemo" type="text" style="width:100%" class="form-control form-control-sm">
                                        </div>
                                    </div>


                                    <div class="form-group row mt10">
                                        <label class="col-form-label"></label>
                                        <!-- 22.06.17 이건욱 T5 > J13, J14추가 -->
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>마감기준일</strong>
                                            <select class="custom-select col-12" id="dlineDayCode" name="dlineDayCode"></select>
                                        </div>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>마감기준점</strong>
                                            <select class="custom-select col-12" id="dlinePointCode" name="dlinePointCode"></select>
                                        </div>
                                        <!-- End -->
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>기사수수료율(%)</strong>
                                            <input id="driverCommission" name="driverCommission" type="text" style="width:100%"  class="form-control form-control-sm" pattern="^(\d*)[\.]?(\d{1,})?$"data-pattern-error='숫자와 "." 기호만 사용할 수 있습니다.'>
                                            <div class="help-block with-errors"></div>
                                        </div>
                                    </div>

                                    <div class="form-group row mt10">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm wd140 middle-name form-group">
                                            <strong>등록일자</strong>
                                            <input type="text" class="form-control form-control-sm" style="width:100%;text-indent:0px;"   id="regDate" readonly="readonly">
                                        </div>
                                        <div class="input-group input-group-sm wd140 middle-name form-group">
                                            <strong>해지일자</strong>
                                            <input type="text" class="form-control form-control-sm" style="width:100%;text-indent:0px"  id="disuseDate" readonly="readonly">
                                        </div>
                                    </div>

                                    <div class="form-group row mt10">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm wd140 middle-name form-group">
                                            <strong>우편물 우편번호(검색)</strong>
                                            <div class="textBox-in-icon">
                                                <input onClick="popSearchPost('postal');" type="text" class="form-control form-control-sm" readonly="readonly" id="postalPost" name="postalPost">
                                                <i><img onclick="popSearchPost('postal');" src="/images/icon/search.png"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row mt10">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm wd290 middle-name form-group">
                                            <strong>우편물 주소</strong>
                                            <div class="textBox-in-icon">
                                                <input type="text" class="form-control form-control-sm" id="postalAddr" name="postalAddr" maxlength="50" pattern="^(?=.{1,50}$).*"
                                                       data-pattern-error="50자 이하로 입력해 주세요.">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row mt10">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm wd290 middle-name form-group">
                                            <strong>우편물 상세주소</strong>
                                            <input type="text" class="form-control form-control-sm" style="width:100%" id="postalAddrDetail" name="postalAddrDetail" maxlength="50" pattern="^(?=.{1,50}$).*"
                                                   data-pattern-error="50자 이하로 입력해 주세요.">
                                        </div>
                                    </div>
                                </div>
                                <div class="mt20"></div>
                                <div class="gray_box">
                                    <div class="form-group row">
                                        <label class="col-form-label big-name">사업자정보</label>
                                        <div class="input-group input-group-sm wd140 middle-name form-group">
                                            <strong class="required">상호</strong>
                                            <input type="text" style="width:100%" class="form-control form-control-sm" id="bizName" required>
                                            <div class="help-block with-errors"></div>
                                        </div>

                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong class="required">대표자명</strong>
                                            <input type="text" class="form-control form-control-sm" id="ceo" required>
                                            <div class="help-block with-errors"></div>
                                        </div>
                                    </div>

                                    <div class="form-group row mt10">
                                        <label class="col-form-label"></label>

                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>업태</strong>
                                            <input type="text" class="form-control form-control-sm" id="bizCond" maxlength="40">
                                        </div>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>업종</strong>
                                            <input type="text" class="form-control form-control-sm" id="bizKind" maxlength="40">
                                        </div>
                                        <div class="input-group input-group-sm wd90 middle-name form-group" id="divBizNumSub">
                                            <strong>종사업장번호</strong>
                                            <input type="text" class="form-control form-control-sm" id="bizNumSub" maxlength="4">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong class="required">과세유형</strong>
                                            <select class="custom-select col-12" id="bizTypeCode" required></select>
                                            <div class="help-block with-errors"></div>
                                        </div>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>은행명</strong>
                                            <select class="custom-select col-12" id="bankCode"></select>
                                        </div>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>예금주</strong>
                                            <input type="text" class="form-control form-control-sm" id="bankCnnm">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm wd140 middle-name form-group">
                                            <strong>계좌번호</strong>
                                            <input type="text" style="width:100%" class="form-control form-control-sm" id="bankAccount">
                                        </div>
                                    </div>

                                    <div class="form-group row mt10">
                                        <label class="col-form-label big-name"></label>
                                        <div class="input-group input-group-sm wd140 middle-name form-group">
                                            <strong>우편번호(검색)</strong>
                                            <div class="textBox-in-icon">
                                                <input onClick="popSearchPost('biz');" type="text" class="form-control form-control-sm" id="bizPost" readonly="readonly">
                                                <i><img onclick="popSearchPost('biz');" src="/images/icon/search.png" id="searchBizPost"></i>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-form-label big-name"></label>
                                        <div class="input-group input-group-sm wd290 middle-name form-group">
                                            <strong>주소</strong>
                                            <input type="text" style="width:100%" class="form-control form-control-sm" id="bizAddr">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm wd290 middle-name form-group">
                                            <strong>상세주소</strong>
                                            <input type="text" style="width:100%" class="form-control form-control-sm" id="bizAddrDetail">
                                        </div>
                                    </div>
                                </div>
                                <div class="mt20"></div>
                                <div style="position: relative;" class="form-group row gray_box" id="deptGroup">
                                    <label class="col-form-label big-name">부서</label>
                                    <!-- <a style="display:none;position: absolute;top: 50%;transform: translateY(-99%);left: 0%;margin-left: 2.4em;background: #fff;border-radius: 4px;box-shadow: 0px 0px 2px 0px;color: #0A8DFF;font-weight: bolder;" 
                                    class="k-pager-refresh k-button" id="btnAddDept">신규추가</a>-->
                                    <div class="input-group input-group-sm wd140 middle-name form-group" style="width:100%" id="divDeptSelect">
                                    </div>  
                                </div>
                                <div class="mt20"></div>
                                <div class="gray_box">
                                    <div class="form-group row">
                                        <label class="col-form-label big-name">부서정보</label>
                                        <div class="input-group input-group-sm wd100 middle-name form-group">
                                            <strong>세금계산서 담당자</strong>
                                            <input type="text" style="width:100%" class="form-control form-control-sm" id="taxStaffName">
                                        </div>
                                        <div class="input-group input-group-sm wd140 middle-name form-group">
                                            <strong>세금계산서 전화번호</strong>
                                            <input type="text" style="width:100%" class="form-control form-control-sm" id="taxTelNum" maxlength="13">
                                        </div>

                                    </div>
                                    <div class="form-group row mt10">
                                        <label class="col-form-label big-name"></label>
                                        <div class="input-group input-group-sm wd190 middle-name form-group">
                                            <strong>세금계산서 이메일</strong>
                                            <input type="text" style="width:100%" class="form-control form-control-sm" id="taxEmail">
                                        </div>
                                    </div>

                                    <div class="form-group row mt10">
                                        <label class="col-form-label big-name"></label>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>주요운송품목</strong>
                                            <select class="custom-select col-12" id="itemCode"></select>
                                        </div>
                                        <div class="input-group input-group-sm wd140 middle-name form-group">
                                            <strong>팩스번호</strong>
                                            <input type="text" style="width:100%" class="form-control form-control-sm" id="fax">
                                        </div>
                                    </div>

                                    <div class="form-group row mt10">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm wd140 middle-name div-min-col-1">
                                            <strong>거래처 메모</strong>
                                            <textarea rows="4" style="width:100%" class="form-control textarea" id="custMemo"></textarea>
                                        </div>
                                        <div class="input-group input-group-sm wd140 middle-name">
                                            <strong>배차 메모</strong>
                                            <textarea rows="4"  style="width:100%" class="form-control textarea" id="orderMemo"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="mt20"></div>
                                <div class="gray_box">
                                    <div class="form-group row">
                                        <label class="col-form-label big-name">거래처 담당자</label>
                                        <div class="input-group input-group-sm wd140 middle-name form-group">
                                            <strong class="required">담당자명</strong>
                                            <input type="text" style="width:100%" class="form-control form-control-sm" id="userName" required>
                                            <div class="help-block with-errors"></div>
                                        </div>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>직급</strong>
                                            <input type="text" class="form-control form-control-sm" id="grade">
                                        </div>
                                    </div>

                                    <div class="form-group row mt10">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm wd140 middle-name form-group">
                                            <strong class="required">휴대전화</strong>
                                            <input type="text" style="width:100%" class="form-control form-control-sm" id="mobile" maxlength="13" required>
                                            <div class="help-block with-errors"></div>
                                        </div>
                                        <div class="input-group input-group-sm wd140 middle-name form-group">
                                            <strong>전화번호</strong>
                                            <input type="text" style="width:100%" class="form-control form-control-sm" id="telNum" maxlength="13">
                                        </div>
                                    </div>

                                    <div class="form-group row mt10">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>아이디</strong>
                                            <input type="text" class="form-control form-control-sm" id="userId">
                                            <div class="help-block with-errors"></div>
                                        </div>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>비밀번호</strong>
                                            <input type="password" class="form-control form-control-sm" id="passwd"  pattern="^(?=.{4,265}$).*"
                                                   data-pattern-error="4자리 이상 입력해 주세요.">
                                        </div>
                                    </div>



                                    <div class="form-group row mt10">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm wd190 middle-name form-group">
                                            <strong>이메일</strong>
                                            <input type="text" style="width:100%" class="form-control form-control-sm" id="email">
                                        </div>
                                        <div class="input-group input-group-sm wd90 middle-name form-group">
                                            <strong>알림톡 수신여부</strong>
                                            <input type="checkbox" id="talk" name="talk" class="input_on-off">
                                            <label for="talk" class="label_on-off">
                                                <span class="marble"></span>
                                                <span class="on">on</span>
                                                <span class="off">off</span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>

                        </form>
                    </div>
                    <!-- editor -->
                </div>
            </div><!-- content -->
        </div>
    </div><!-- wrap -->
</div>
<script type="text/javascript">
var g_custList = [];
var g_idx = {};

var deptList = [];
$(document).ready(function(){
	$("#mngDeptId").on("change", function(){
		Util.setSelectBox("/contents/basic/data/userNameList.do", "manager", {deptId:$(this).val()}, "userId", "userName", "", "선택하세요");
	});
});

function init_pop(mode, data) {

	init();
	g_custList = [];
	g_idx = {};
	deptList = [];
	var $options = $("#s_dept > option").clone();
	$('#mngDeptId').html($options);
	$("#mngDeptId option[value='']").remove();
	
    var $options2 = $("#s_custMngCode > option").clone();
	$('#custMngCode').append($options2);
	$("#custMngCode option[value='']").remove();
	
	Util.setSelectBox("/contents/basic/data/userNameList.do", "manager", {deptId:"${sessionScope.userInfo.deptId}"}, "userId", "userName", "", "선택하세요");
	Util.setCmmCode("select", "custTypeCode", "CUST_TYPE_CD", "", "선택하세요");
    Util.setCmmCode("select", "sellBuySctn", "SELL_BUY_SCTN", "", "선택하세요");
    Util.setCmmCode("select", "bizTypeCode", "BIZ_TYPE_CD", "", "선택하세요");
    Util.setCmmCode("select", "itemCode", "ITEM_CD", "", "선택하세요");
    Util.setCmmCode("select", "bankCode", "BANK_CD", "", "선택하세요");
    Util.setCmmCode("select", "payType", "PAY_TYPE_CD", "Y", "선택하세요");
    // 22.06.07 이건욱 T5 > J13, J14추가
    Util.setCmmCode("select", "dlineDayCode", "DLINE_DAY_CD", "99", "");
    Util.setCmmCode("select", "dlinePointCode", "DLINE_POINT_CD", "1", "");
    // End
    g_idx.custSeq = data.custSeq;
    g_idx.custId = data.custId;
    g_idx.deptId = data.deptId;
    
    $("#btn_saveCust").show();
    $("#manager").val("${loginUser}");
	$("#mngDeptId").prop("disabled", false);
	if(mode == "N") {
		if(!data){
			chkUID = false;
		}else{
			$("#btn_chkBizNum").css('border', '#0bba82 solid 2px');
			$("#btn_chkBizNum").html("<i class=\"k-icon k-i-check-outline\" id=\"chkOK\" style=\"color:#0bba82;margin-right:3px;\"></i>사업자번호 확인");
			chkUID = true;
		}
		$("#btn_chkBizNum").attr("disabled", false);
		$("#cust_legend").text("거래처 등록");
		//$("#regDate").val(moment().format('YYYY-MM-DD HH:mm:ss'));
		$("#btn_save").html($("#btn_save").html().replace('수정', '저장'));
		$("#bizNum").val(data.bizNum);

		/* var bizNum = $("#bizNum").val().replace(/[^\d]/g, '');
		var temp = bizNum.replace(/(\d{3})(\d{1,2})(\d{1,5})/, '$1-$2-$3');
		$("#bizNum").val(temp); */
		setDeptTextBox();
		//$("#btnAddDept").show();
		$("#searchBizinfo").attr("onClick", "popSearchBizinfo()");
		
		if("${menuAuth.writeYn}" != "Y")	$("#btn_saveCust").hide();

	} else if(mode == "BE") {
		chkUID = true;
		$("#btn_chkBizNum").css('border', '#0bba82 solid 2px');
		$("#btn_chkBizNum").html("<i class=\"k-icon k-i-check-outline\" id=\"chkOK\" style=\"color:#0bba82;margin-right:3px;\"></i>사업자번호 확인");
		$("#btn_chkBizNum").attr("disabled", true);
		$("#cust_legend").text("거래처 등록");
		$("#btn_save").html($("#btn_save").html().replace('수정', '저장'));
		
		getCustInfo(data.bizNum);
		$("#custMngCode").val("01").prop("selected", true);
		Util.setReadOnlyEnable(["bizNum"]);
		Util.setDisabledList(["bizNumSub", "custTypeCode"]);
		//$("#btnAddDept").show();

		$("#bizPost").attr("onClick", "popSearchPost('biz')");
		$("#searchBizPost").attr("onClick", "popSearchPost('biz')");
		$("#searchBizinfo").removeAttr("onClick");

		if("${menuAuth.writeYn}" != "Y")	$("#btn_saveCust").hide();
		$("#passwd").val('');


	} else if(mode == "E") {
		chkUID = true;
		$("#btn_chkBizNum").attr("disabled", true);
		$("#cust_legend").text("거래처 수정");
		$("#regDate").val(moment(data.regDate).format('YYYY-MM-DD HH:mm:ss'));
		$("#btn_save").html($("#btn_save").html().replace('저장', '수정'));
		//setDeptList(data.custId, data.deptId);
		setDeptTextBox();
		Util.setPageData(data);
		if(data.talkYn == 'Y') {
			$("input:checkbox[id='talk']").prop('checked', true);
		} else {
			$("input:checkbox[id='talk']").prop('checked', false);
		}
		$("input:checkbox[id='talk']").prop('disabled', true);
		Util.setReadOnlyEnable(["bizNum","deptName"]);
		Util.setDisabledList(["custTypeCode", "sellBuySctn"]);
		
		if(data.userId) {
			Util.setReadOnlyEnable(["userId", "passwd", "userName", "grade", "mobile", "email", "telNum"]); 
		} 
		
		$("#mngDeptId").trigger("change");
		$("#manager").val(data.manager);
		
		$("#mngDeptId").prop("disabled", true);
		
		//$("#btnAddDept").hide();
		/* $("#bizPost").attr("onClick", "");
		$("#searchBizPost").attr("onClick", ""); */

		$("#bizPost").attr("onClick", "popSearchPost('biz')");
		$("#searchBizPost").attr("onClick", "popSearchPost('biz')");
		$("#searchBizinfo").removeAttr("onClick");
		
		if("${menuAuth.editYn}" != "Y")	$("#btn_saveCust").hide();

	}
}

function getCustInfo(bizNum) {
	if(!bizNum) return;
	$.ajax({
		url: "/contents/basic/data/getCustInfo.do",
		type: "POST",
		dataType: "json",
		data: {
			bizNum: bizNum
		},
		success: function(data){
			if(data.result) {
				g_custList = data.data;
                setBizNumSub();
				changeBizNumSub();
			    $("#mngDeptId").val("${sessionScope.userInfo.deptId}");
			    $("#manager").val("${loginUser}");

			}
		}
	});	
}

function changeBizNumSub(obj){

    // 한군데에서만 쓰이는 Method
    // 매개변수 obj 미 사용으로 확인 - Junghwan.Hwang - memo

	var cust = getCust();

	if($(obj).val() == "new"){

		$("#bizNumSub").remove();
		var s = "<input type=\"text\" class=\"form-control form-control-sm\" id=\"bizNumSub\" onBlur=\"checkOverlapSub(this)\" maxlength=\"4\">";
		$("#divBizNumSub").append(s);		
		Util.setReadOnlyDisable(["bizName", "bizNumSub", "ceo", "bizCond", "bizKind", "bizPost", "bizAddr", "bizAddrDetail", "userId", "passwd", "userName", "grade", "mobile", "email", "telNum", "bankCode", "bankCnnm", "bankAccount"]);
		Util.setEnabledList(["bankCode", "bizTypeCode"]);
		$("input:checkbox[id='talk']").prop('checked', false).prop('disabled', false);
		Util.formReset("", ["#userId", "#passwd", "#userName", "#grade", "#mobile", "#email", "#telNum", "#bizTypeCode" ,"#bankCode", "#bankCnnm", "#bankAccount", "#taxEmail", "taxStaffName", "taxTelNum", "#itemCode", "#fax", "#custMemo", "#orderMemo", "#bizName", "#ceo", "#bizCond", "#bizKind", "#bizPost", "#bizAddr", "#bizAddrDetail","#custName"], {});

        //$("#custName").val(obj.cmpNm);
        setDeptTextBox();


	} else {

		cust.regDate = moment().format('YYYY-MM-DD HH:mm:ss');
		cust.useYn = 'Y';

		cust.custMngCode = '01';
		cust.mngDeptId = '${sessionScope.userInfo.deptId}';
		Util.setPageData(cust);	
		setDeptList(cust.custId, "");

        // 추가내용, 현재 Input박스에 넣는 내용은 해당 DB를 받아 직접 뿌려주는 형태로 되어 있다.
        // List도 자동완성으로 DB Generic 데이터를 Iterator 형태의 방범으로 뿌려주고 있기에 여기에 강제적으로
        // 하드코딩을 하게 되었다. - Junghwan.Hwang
        $("#custName").val(cust.bizName);
	}
}

function setBizNumSub() {
	$("#bizNumSub").remove();
	var str = "<select class=\"custom-select col-12\" id=\"bizNumSub\" onchange=\"changeBizNumSub(this)\">";
	for(var i=0, cust; cust=g_custList[i]; i++){
		str += "<option value=\"" + cust.bizNumSub + "\">" + cust.bizNumSub + "</option>";
	}
	str += "<option value=\"new\">신규입력</option>";
    str += "</select>";
	$("#divBizNumSub").append(str);		
}

//종사업장번호 text 입력 시, 중복체크
function checkOverlapSub(obj) {
	var str = $(obj).val();
	for(var i=0, cust; cust=g_custList[i]; i++){
		if(cust.bizNumSub == str){
			setBizNumSub();
			$("#bizNumSub").val(str).trigger("change");
			Util.setReadOnlyEnable(["bizName", "bizNum", "bizNumSub", "ceo", "bizCond", "bizKind", "bizPost", "bizAddr", "bizAddrDetail", "userId", "passwd", "userName", "grade", "mobile", "email", "telNum"]);
			break;
			
		}
	}
}
	
function getCust() {
	for(var i=0, cust; cust=g_custList[i]; i++){
		if(cust.bizNumSub == $("#bizNumSub").val()) return cust;
	}
	
	return null;
}

function setDeptList(custId, deptId) {
    /* var radioGrp = $("input:radio[name='deptId']");
    for(var i = 0; i < radioGrp.length; i++) {
        radioGrp[i].parentNode.remove();
    }	 */

	for(var i=0, cust; cust=g_custList[i]; i++){
		if(cust.bizNumSub == $("#bizNumSub").val()) {
			deptList = cust.deptList;
			break;
		}
	}
	
	if(deptList.length == 0) {
		$.ajax({
			url: "/contents/basic/data/compDeptList.do",
			type: "POST",
			dataType: "json",
			data: {
				custId: custId
			},
			success: function(data){
				if(data.result) {					
					deptList = data.data;
					setDeptListBox(deptId);
					//setUserInfo(deptId);
				}
			}
		});
	} else {
		setDeptListBox(deptId);
	}
	
}

function setDeptListBox(deptId) {
	var str = "";	
	if(deptList.length > 0) {
		str += "<strong class=\"required\">부서명</strong><select class=\"custom-select col-12\" name=\"deptId\" id=\"deptId\" onchange=\"setUserInfo($(this).val())\">";
		for(var i=0, dept; dept=deptList[i]; i++){
			
			str += "	<option value=\"" + dept.deptId + "\">" + dept.deptName + "</option>";
		}
		str += "	<option value=\"new\">신규입력</option>";
		str += "</select>";

		$("#divDeptSelect").html(str);
  
		if(deptId == "") deptId = deptList[0].deptId;

		$("#deptId").val(deptId);
		setUserInfo(deptId);
	} else {
		setDeptTextBox();
	}
	$("#f").validator('update');

}

function setDeptTextBox(){
	var str = "";
	str += 	"<strong class=\"required\">부서명</strong>" +
			"<input type=\"hidden\" name=\"deptId\" id=\"deptId\">" +
			"<input type=\"text\" class=\"form-control form-control-sm\" style=\"width:100%\" name=\"deptName\" id=\"deptName\" onBlur=\"checkOverlapDeptName(this)\" required>" +
    		"<div class=\"help-block with-errors\"></div>";

	$("#divDeptSelect").html(str);
	$("#f").validator('update');
}

//부서명 text 입력 시, 중복체크
function checkOverlapDeptName(obj) {
	var str = $(obj).val();
	for(var i=0, dept; dept=deptList[i]; i++){
		if(dept.deptName == str){
			setDeptListBox();
			break;			
		}
	}
}

//부서 선택 시, 사용자 정보 가져오기.
function setUserInfo(deptId) {
	$('#userId').val('');
	$('#passwd').val('');
	$('#userName').val('');
	$('#grade').val('');
	$('#mobile').val('');
	$('#email').val('');
	$('#telNum').val('');
	$('#taxEmail').val('');
	$('#taxStaffName').val('');
	$('#taxTelNum').val('');
	$('#itemCode').val('');
	$('#fax').val('');
	$('#custMemo').val('');
	$('#orderMemo').val('');
	if(deptId == "new" ) {
		setDeptTextBox();
		Util.setReadOnlyDisable(['userId', 'passwd', 'userName', 'grade', 'mobile', 'email', 'telNum']);
		$("input:checkbox[id='talk']").prop('checked', false);
		$("input:checkbox[id='talk']").prop('disabled', false);
	} else {
		$.ajax({
			url: "/contents/basic/data/getUserInfo.do",
			type: "POST",
			dataType: "json",
			data: {
				custId: g_idx.custId,
				deptId: deptId,
				bizNum: $("#bizNum").val().replace(/\-/g, ''),
				bizNumSub: $("#bizNumSub").val(),
				custTypeCode : $("#custTypeCode").val()
			},
			success: function(data){
				if(data.result) {
					var userInfo = data.data;
					
					if(userInfo) {
						userKey = Object.keys(userInfo);
						for(var i = 0; i < userKey.length; i++) {
							var u = userKey[i];
							if(!userInfo[u]) delete userInfo[u];
						}
						Util.setPageData(userInfo);	
						if(data.data.talkYn == 'Y') {
							$("input:checkbox[id='talk']").prop('checked', true);
						} else {
							$("input:checkbox[id='talk']").prop('checked', false);
						}
						$("input:checkbox[id='talk']").prop('disabled', true);
						Util.setReadOnlyEnable(['userId', 'passwd', 'userName', 'grade', 'mobile', 'email', 'telNum']);
					} else {
						Util.setReadOnlyDisable(['userId', 'passwd', 'userName', 'grade', 'mobile', 'email', 'telNum']);
						$("input:checkbox[id='talk']").prop('checked', false);
						$("input:checkbox[id='talk']").prop('disabled', false);
						$('#userId').val('');
						$('#passwd').val('');
						$('#userName').val('');
						$('#grade').val('');
						$('#mobile').val('');
						$('#email').val('');
						$('#telNum').val('');
					}
				}
			}
		});
	}
}

// 부서 추가 Modal
/*
 addDeptModal = $("#divAddDept");
addDeptButton = $("#btnAddDept");

addDeptButton.click(function() {
	addDeptModal.data("kendoDialog").open();
});

addDeptModal.kendoDialog({
	width: "446px",
	height: "177px",
	visible: false,
	closable: false,
	title: "부서 추가",
	modal: false,
	close: function(){addDeptButton.fadeIn();}
});

function addDeptModalClose(){
	$("#s_deptName").val("");
	addDeptModal.data("kendoDialog").close();
}

function addDept(){
	var deptName = $("#s_deptName").val();
	if(deptName == "") {
		alert("부서명을 입력해주세요.");
		return;
	}
	
	var deptList = [];
	deptList.push({deptName, deptId:''});
	
	setDeptListBox();
	
	addDeptModalClose();
}
 */

$('#userId').on('blur', function() {
	var userId = $(this).val();
	if(!userId) {
		$("#btn_saveCust").attr("disabled", false);
		return;
	}
	if(!$("#userId").attr("readonly")) {
		$.ajax({
			url: "/contents/basic/data/checkUserId.do",
			type: "POST",
			dataType: "json",
			data: {
				userId: userId
			},
			success: function(data){
				if(data.result) {
				 	/* $("#userId").parent().removeClass("has-error").removeClass("has-danger");
					$("#userId").next().empty(); */
					alert("사용 가능한 아이디입니다.");
					$("#btn_saveCust").attr("disabled", false);
				} else {
				/* 	$("#userId").parent().addClass("has-error").addClass("has-danger").focus();
					$(".list-unstyled").remove();
					$("#userId").next().append("<ul class=\"list-unstyled\"><li>이미 존재하는 아이디입니다.</li></ul>"); */
					alert("이미 존재하는 아이디입니다.");
					$("#btn_saveCust").attr("disabled", true);
				}
			}
		});
	}	
});

/*
$('#bizNum').on('input', function() {
	var bizNum = $(this).val().replace(/[^\d]/g, '');
	var temp = bizNum.replace(/(\d{3})(\d{1,2})(\d{1,5})/, '$1-$2-$3');
	$(this).val(temp);
});
*/

$('#bizNum').on('change', function() {
	$("#btn_chkBizNum").css('border', '#ced4da solid 1px');
	$('#btn_chkBizNum .k-icon').remove();
	chkUID = false;
});

document.getElementById('bizNum').addEventListener('keydown',function (event) {

    if(event.code === "Enter"){
        event.preventDefault();
        popSearchBizinfo();
    }
});

// 저장 버튼에 대한 Submit 처리 내용
$('#f').validator().on('submit', function (e) {

    if(!chkUID) {
      e.preventDefault();
      alert("사업자번호 확인을 해주세요.");
      return;
    }
    if (e.isDefaultPrevented()) {
      alert("항목을 입력해 주세요.");
    } else {

      // 이벤트 초기화 (submit 동작 중단)
      e.preventDefault();
      if (!$("#userId").attr("readonly")){
        if(!checkUserInfo()) {
          e.preventDefault();
          return;
        }
      }
      $("#mngDeptId").prop("disabled", false);
      var param = {
        mngDeptId: $("#mngDeptId").val(),
        custSeq : Util.nvl(g_idx.custSeq, ''),
        custId : Util.nvl(g_idx.custId, ''),
        deptId : Util.nvl($("#deptId").val(), ''),
        bizName : $("#bizName").val(),
        custTypeCode : $("#custTypeCode").val(),
        bizNum : $("#bizNum").val().replace(/\-/g, ''),
        bizNumSub : $("#bizNumSub").val(),
        bizTypeCode : $("#bizTypeCode").val(),
        ceo : $("#ceo").val(),
        bizCond : $("#bizCond").val(),
        bizKind : $("#bizKind").val(),
        bizPost : $("#bizPost").val(),
        bizAddr : $("#bizAddr").val(),
        bizAddrDetail : $("#bizAddrDetail").val(),
        sellBuySctn : $("#sellBuySctn").val(),
        custName : $("#custName").val(),
        telNum: $("#telNum").val().replace(/\-/g, ""),
        mobile: $("#mobile").val().replace(/\-/g, ""),
        fax : $("#fax").val(),
        taxEmail : $("#taxEmail").val(),
        taxStaffName : $("#taxStaffName").val(),
        taxTelNum: $("#taxTelNum").val().replace(/\-/g, ""),
        itemCode : $("#itemCode").val(),
        manager : $("#manager").val(),
        custMemo : $("#custMemo").val(),
        orderMemo : $("#orderMemo").val(),
        useYn : $("#useYn").val(),
        //deptName : $('input[name="deptId"]:checked').next().text(),
        deptName: $("#deptName").val(),
        userId : $("#userId").val(),
        passwd : $("#passwd").val(),
        userName : $("#userName").val(),
        grade : $("#grade").val(),
        email : $("#email").val(),
        talkYn : $("#talk").val() == 'on' ? "Y" : "N",
        bankCode : $("#bankCode").val(),
        bankCnnm : $("#bankCnnm").val(),
        bankAccount : $("#bankAccount").val(),
        custMngCode : $("#custMngCode").val(),
        custMngMemo : $("#custMngMemo").val(),
        payType : $("#payType").val(),
        payMemo : $("#payMemo").val(),
        driverCommission : $("#driverCommission").val(),
        postalAddr : $("#postalAddr").val(),
        postalAddrDetail : $("#postalAddrDetail").val(),
        postalPost : $("#postalPost").val(),
        // 22.06.17 이건욱 T5 > J13, J14추가
        dlineDayCode : $("#dlineDayCode").val(),
        dlinePointCode : $("#dlinePointCode").val()
      };
      $.ajax({
        url: "/contents/basic/data/insertCust.do",
        type: "POST",
        dataType: "json",
        data: param,
        success: function(data){
          if(data.result) {
            alert(data.msg);
            init_popup_close();
            goList();
          } else {
            alert(data.msg);
            $("#userId").focus();
          }
        }
      });
  }
});


function init() {
	$("#btn_chkBizNum").css('border', '#ced4da solid 1px');
	$('#btn_chkBizNum .k-icon').remove();
	chkUID = false;
	Util.formReset("", [".editor input",".editor select", ".editor textarea"], {".editor #useYn": 'Y'});
	$("#bizNumSub").remove();
	var str = "<input type=\"text\" class=\"form-control form-control-sm\" id=\"bizNumSub\">";
	$("#divBizNumSub").append(str);		
	
	Util.setReadOnlyDisable(["bizName", "bizNum", "bizNumSub", "ceo", "bizCond", "bizKind", "bizPost", "bizAddr", "bizAddrDetail", "userId", "passwd", "userName", "grade", "mobile", "email", "telNum", "bankCnnm", "bankAccount"]);
	Util.setEnabledList(["bizTypeCode", "bizNumSub", "custTypeCode", "sellBuySctn", "bankCode"]);
	$(".list-unstyled").remove();

}

function init_popup_close() {
	form_popup_close();
	init();
}
	
function popSearchPost(mode){
	if(typeof $("#bizPost").attr("readonly") != "undefined") {
		return;
	}
	Util.popSearchPost(mode);
}

// 한글 체크
function checkKor(str) {
  const regExp = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g;
  if(regExp.test(str)){
    return true;
  }else{
    return false;
  }
}

// 숫자 체크
function checkNum(str){
  const regExp = /[0-9]/g;
  if(regExp.test(str)){
    return true;
  }else{
    return false;
  }
}

//특수문자 체크
function checkSpc(str){
  const regExp = /[~!@#$%^&*()_+|<>?:{}]/;
  if(regExp.test(str)){
    return true;
  }else{
    return false;
  }
}

function popSearchBizinfo(){

    /*
    * Junghwan.Hwang - NICE_DNB 추가내용 2022-10-19
    */
    var mBizName=$("#bizNum").val().replace(/\-/g, '');
    var mBizCode = "CMP_NM";

    if(mBizName == null || mBizName==""){
        alert("공란으로 입력되었습니다.");
        return;
    }

    if(checkSpc(mBizName)){
        alert("특수문자가 입력되었습니다.");
        return;
    }

    if(checkKor(mBizName)) {
        mBizCode = "CMP_NM";
    }

    if(checkNum(mBizName)) {
        mBizCode = "BIZ_NO";
    }

    var mParam = {
        BizCode: mBizCode,
        BizValue: mBizName,
        page: "1",
        pageSize: "1"
    };

    $.ajax({
        url : "/contents/basic/data/searchNiceinfoGet.do",
        type : "post",
        dataType : "json",
        data:mParam,
        success:function (data) {

            if(data.total==0){

                if(checkKor(mBizName)){
                   alert("해당되는 업체가 없습니다. 사업자 번호로 조회해보세요");
                }
                else{
                  // 영세업체, 세무서에 등록은 되어있으나 Nice DNB에는 미 등록
                  var nData = {
                    bizNo: mBizName
                  }
                  var nMode = "DEFAULT";
                  setSearchBizInfo(nMode,nData);
                }
            }
            else
            {
                window.open("/contents/basic/view/searchBizinfo.do?bizname="+mBizName, "PopupPost", "width=1380, height=663");
            }
        }
    });

    //window.open("/contents/basic/view/searchBizinfo.do?bizname="+mBizName, "PopupPost", "width=1380, height=663");
	//Util.popSearchBizinfo($("#bizNum").val());
}

function setSearchAddressInfo(data) {
    $("#"+data.mode+"Post").val(data.zipNo);
    $("#"+data.mode+"Addr").val(data.roadAddr);
    $("#"+data.mode+"AddrDetail").focus();
}

function setSearchBizInfo(mode,data) {

  /*
   * 기존 DB 모듈 이식, DEFAULT 일 경우 대비
   * Junghwan.Hwang - 2022-10-19
   */

  var sData = data;
  var sMode = mode;
  var sBizNum = sData.bizNo;

  if(mode=="DEFAULT"){
    $.ajax({
      url: "/contents/basic/data/checkBizNum.do",
      type: "POST",
      dataType: "json",
      data: {
        bizNum : sBizNum
      },
      success: function(data) {
        var chkNum = {};
        if (data.result) {
          sMode = "BE";
          alert("기존 등록되어있는 사업자 입니다. 추가등록을 진행합니다.");
        } else {
          sMode = "N";
          alert("조회된 데이터가 없습니다. 신규 사용자 입니다.");
        }
        chkNum.bizNum = sData.bizNo;
        bizNumCheck(sMode,chkNum)
      },
    });
  }
  else{
    bizNumCheck(sMode,sData)
  }

}

function checkUserInfo() {
	var userIdChk = ($("#userId").val() ? 1 : 0);
	var passwdChk = ($("#passwd").val() ? 1 : 0);
	//var userNameChk = ($("#userName").val() ? 1 : 0);
	
	var chk = userIdChk + passwdChk;
	
	if(chk > 0 && chk < 2) {
		alert("거래처 담당자 입력 시 아이디,비밀번호는 필수값입니다.");
		return false;
	}
	
	return true;
}


$("#mobile, #telNum, #taxTelNum").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});
</script>