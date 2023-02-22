<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#cust_list .k-grid-content {max-height:calc(100vh)}
</style>
<div class="insert_pop">
	<jsp:include page="./view/custInsert.jsp" />
</div>
<!-- <div id="divAddCust" class="editor-warp p-0">
	<div class="modalEditor" id="addCust">
		<div id="popGrid"></div>
		<div class="modalHeader">
			<div class="form-group row">
                <label class="col-form-label modal-big-name">사업자번호</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input class="form-control form-control-sm" id="s_bizNum" type="text" maxlength="12" onkeypress="if(event.which==13){modalSubmit();}">
                </div>
            </div>
			<strong>사업자번호</strong>
			<input size="35" id="s_bizNum" type="text" maxlength="12" onkeypress="if(event.which==13){modalSubmit();}">
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <a onclick="modalSubmit()" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i>조회</b></a>
		        <a id="closeBtn" onclick="modalClose()" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
	        </div>
	    </div>
	</div>
</div> -->
<div class="header">
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">거래처관리</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt" onSubmit="return false;">
			<div class="form-group row mt0" style="justify-content: space-between">
				<div>
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="form-control" class="custom-select wd90" id="s_dept" name="s_dept">
							<option>--부서명--</option>
						</select>
					</div>
					<div class="input-group input-group-sm wd100 middle-name div-min-col-1">
						<select class="custom-select wd100" id="searchColumn" name="searchColumn">
							<option value="s_custName" selected>--거래처명--</option>
							<option value="s_bizName" selected>--사업자상호--</option>
							<option value="s_bizNum" selected>--사업자번호--</option>
						</select>
					</div>
					<div class="input-group input-group-sm wd210 middle-name div-min-col-1">
						<input type="text" id="searchValue" name="searchValue" style="width:100%" class="form-control form-control-sm searchValue" placeholder="검색항목을 입력하세요">
					</div>
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="form-control" class="custom-select" style="width:100%" id="s_custTypeCode" name="s_custTypeCode">
						</select>
					</div>
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="form-control" class="custom-select" id="s_sellBuySctn" name="s_sellBuySctn">
						</select>
					</div>
					<div class="input-group input-group-sm wd100 middle-name div-min-col-1">
						<select class="form-control" class="custom-select" style="width:100%" id="s_custMngCode" name="s_custMngCode"></select>
					</div>
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="form-control" class="custom-select wd90" id="s_useYn" name="s_useYn">
							<option value="">--사용여부--</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="form-control" class="custom-select wd90" id="s_userId" name="s_userId"></select>
					</div>
					<div class="input-group input-group-sm wd120 middle-name div-min-col-1">
						<select class="form-control" class="custom-select" style="width:100%" id="s_payYn" name="s_payYn">
							<option value="">--빠른지급여부--</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="input-group-sm middle-name">
						<button onclick="goList()" type="button" class="form-control-sm btn_58 btn_b">검색</button>
					</div>
				</div>
			</div>
			</form>   
			<!--  -->
			<div class="cont-body">
				<!-- f-wrap -->
				<div class="k-wrap content">
					<div class="lookup_table">
						<!-- table -->
						<div class="toolbar row">
							<div class="tool_form col">
								<div class="btn-row">
									<div class="tool_group">
										<div class="padding">
											<c:if test="${menuAuth.readYn eq 'Y'}">
											<a onclick="custPrice();" class="k-pager-refresh k-button"><b class="btn-b">계약단가</b></a>
											</c:if>
											<c:if test="${menuAuth.printYn eq 'Y'}">
											<a class="k-pager-refresh k-button" onClick="goExcel();"><b class="btn-x">엑셀출력</b></a>
											</c:if>
											<c:if test="${menuAuth.writeYn eq 'Y'}">
											<a onclick="form_popup('N', '')" class="k-pager-refresh k-button"><b class="btn-h">신규등록</b></a>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div style="height:calc(100vh - 344px)" id="cust_list"></div>
						<!-- /table -->
					</div>
				</div>
			</div>
			<!--  -->
		</div>
		<!-- group-list -->
	</div>
	<!-- content -->
</div>

<script type="text/javascript">
var chkUID = false;
$(document).ready(function(){
    $('.insert_pop').css('display', 'block');
    Util.setCmmCode("select", "s_custTypeCode", "CUST_TYPE_CD", "", "--분류--");
    Util.setCmmCode("select", "s_sellBuySctn", "SELL_BUY_SCTN", "", "--구분--");
    Util.setCmmCode("select", "s_custMngCode", "CAR_MNG_CD", "", "--거래처등급--");

	Util.setSelectBox("/contents/basic/data/compDeptList.do", "s_dept", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn:'Y'}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "--부서명--");
    Util.setSelectBox("/contents/basic/data/userNameList.do", "s_userId", {deptId:$("#s_dept").val()}, "userId", "userName", "", "--담당자--");
	$("#s_dept").on("change", function(){
		Util.setSelectBox("/contents/basic/data/userNameList.do", "s_userId", {deptId:$(this).val()}, "userId", "userName", "", "--담당자--");
	});

	goList();

});

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "mngDeptName", title: "담당부서", width:100},
	{ field: "managerName", title: "당사 담당자명", width:120},
	{ field: "custTypeName", title: "분류", width: 110 },
	{ field: "sellBuySctnName", title: "구분", width: 70 },
	{ field: "custName", title: "거래처명", width: 130 },
	{ field: "bizName", title: "사업자상호", width: 130, hidden:true },
	{ field: "deptName", title: "부서명", width: 100 },
	{ field: "fax", title: "팩스번호", width: 100 },
	{ field: "userName", title: "거래처 담당자명", width: 120 },
	{ field: "grade", title: "담당자 직급", width: 110 },
	{ field: "mobile", title: "담당자 전화번호", width: 120, 
		template: "#=Util.formatPhone(mobile)#"  },
	{ field: "email", title: "담당자 이메일", width: 120 },
	{ field: "taxEmail", title: "세금계산서 이메일", width: 140 },
	{ field: "payType", title: "빠른지급 대상여부", width: 140 },
	{ field: "bizName", title: "상호명", width: 100 },
	{ field: "ceo", title: "대표자명", width: 100 },
	{ field: "bizNum", title: "사업자번호", width: 110,
		template: "#=Util.formatBizNum(bizNum)#" },
	{ field: "bizNumSub", title: "종사업장번호", width: 120 },
	{ field: "bizCond", title: "업태", width: 100 },
	{ field: "bizKind", title: "업종", width: 100 },
	{ field: "bizPost", title: "우편번호", width: 100 },
	{ field: "bizAddr", title: "주소", width: 250 },
	{ field: "bizAddrDetail", title: "상세주소", width: 150 },
	{ field: "bankName", title: "은행명", width: 120 },
	{ field: "bankCnnm", title: "예금주", width: 110 },
	{ field: "bankAccount", title: "계좌번호", width: 130 },
	{ field: "custMngName", title: "거래처등급", width: 90 },
	{ field: "useYn", title: "사용여부", width: 80 },
	{ field: "regDate", title: "등록일자", width: 175 },
	{ field: "custMemo", title: "거래처메모", width: 120 },
	{ field: "orderMemo", title: "배차메모", width: 120 },
	// 22.06.17 이건욱 T5 > J13, J14추가
	{ field: "dlineDay", title: "마감기준일", width: 100 },
	{ field: "dlinePoint", title: "마감기준점", width: 100 },
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("cust_list");
oGrid.initGrid();
oGrid.setSortable(false);
oGrid.setSendUrl("/contents/basic/data/custList.do");
oGrid.setExcelFile("거래처관리리스트.xlsx");
oGrid.setSelectable(true);
oGrid.setPageable(true);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

// 사업자번호 체크
function checkBN(str){
	const regExp = /[-]/;
	if(regExp.test(str)){
		return true;
	}else{
		return false;
	}
	//var bizNum = $(this).val().replace(/[^\d]/g, '');
	//var temp = bizNum.replace(/(\d{3})(\d{1,2})(\d{1,5})/, '$1-$2-$3');
}

function goList() {
	var grid = $("#cust_list").data("kendoGrid");
	var id = $("#searchColumn").val().split('_')[1];
	var data = $("#searchValue").val();
	var dataResult = "";

	if(checkBN(data)){
		dataResult=data.replace(/[^\d]/g, '');
	}else{
		dataResult=data;
	}

	var param = {};
	param[id] = dataResult;
	param["custTypeCode"] = $("#fSearch select[name=s_custTypeCode] option:selected").val();
	param["sellBuySctn"] = $("#fSearch select[name=s_sellBuySctn] option:selected").val();
	param["useYn"] = $("#fSearch select[name=s_useYn] option:selected").val();
	param["deptId"] = $("#s_dept").val();
	param["userId"] = $("#s_userId").val();
	param["payYn"] = $("#s_payYn").val();
	param["custMngCode"] = $("#s_custMngCode").val();
	
	oGrid.setSearchData(param);

	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#cust_list").data("kendoGrid");
		//grid.bind("change", onChange);
		grid.tbody.delegate('tr', 'dblclick', function(){
			var dataItem = grid.dataItem($(this));
			form_popup("E", dataItem);
		});	
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}

}
/* 
function onChange(e){
	var row = this.select();
	var data = this.dataItem(row);
	form_popup("E", data);
}
 */
//거래처추가 modal
/* modal = $("#divAddCust");
modalButton = $("#btnAddCust");

modalButton.click(function() {
	modal.data("kendoDialog").open();
});

modal.kendoDialog({
	width: "446px",
	height: "228px",
	visible: false,
	closable: false,
	title: "거래처 조회",
	modal: false,
	close: function(){modalButton.fadeIn();}
});

$('#s_bizNum').on('input', function() {
	var bizNum = $(this).val().replace(/[^\d]/g, '');
	var temp = bizNum.replace(/(\d{3})(\d{1,2})(\d{1,5})/, '$1-$2-$3');
	$(this).val(temp);
});

function modalClose(){
	$("#s_bizNum").val("");
	modal.data("kendoDialog").close();
} */

function bizNumCheck(mode,data){

	var bData = data;
	var bMode = mode;
	/*
	* 사업자 번호 Check 버튼 내용을 지우지 않고 Method 연결로 처리 진행
	* Junghwan.Hwang - NICE_DNB - 2022-10-19
	*/

	form_popup(bMode, bData); // popUp 처리 된 내용 반영 : custList.jsp 파일에 한정
}
function custPrice(){
	var grid = $("#cust_list").data("kendoGrid");
	var selectedItem = grid.dataItem(grid.select());
	var param = "";
	if(selectedItem == null){
		alert("거래처를 선택해 주세요.");
		return
	} else{
		param = "custId="+selectedItem.custId+"&deptId="+selectedItem.deptId+"&custName="+encodeURI(selectedItem.custName + "-" + selectedItem.deptName)+"&sellBuySctn="+selectedItem.sellBuySctn;
		location.href="/contents/basic/custPriceList.do?"+param;
	}
}

function form_popup(mode, data) {
	Util.insertCloseButton();
	//modal.data("kendoDialog").close();
	$('#group-list').addClass("block");
	$('.insert_pop').addClass("block");
	$('.insertClose').addClass("block");
	init_pop(mode, data);

 	if(mode == 'N' && data != ""){
		 //bizInfo(data);
		 bizSetting(data);
	} 
}

function form_popup_close() {
    $('#group-list').removeClass("block");
    $('.insert_pop').removeClass("block");
	$('.insertClose').removeClass("block");
    $("#deptList").empty();
}

// Junghwan.Hwang - memo
// Nice DNB에는 있고 내부 DB에는 없을때의 최종 UI Setting 내용
function bizSetting(recvData){
	$("#bizName").val(recvData.cmpNm); // 사업자상호
	$("#ceo").val(recvData.ceoNm);		// 대표자명
	//$("#bizCond").val(recvData.bizNo);	// 업태
	$("#bizCond").val(recvData.indNm);	// 업태
	//$("#bizKind").val(recvData.indNm);	// 업종
	$("#bizPost").val(recvData.zip);	// 우편번호
	$("#bizAddr").val(recvData.adr);	// 주소
	$("#bizTypeCode").val("01");
	$("#bizNum").val(Util.formatBizNum(recvData.bizNum)); // 사업자번호
	$("#bizNumSub").val("0000");
	$("#bizAddrDetail").val(recvData.dtlAdr); // 상세주소
	// 추가내용
	$("#custName").val(recvData.cmpNm);

	Util.setReadOnlyEnable(["bizNum"]);
	Util.setDisabledList(["bizNumSub"]);

	$("#btn_chkBizNum").css('border', '#0bba82 solid 2px');
	$("#btn_chkBizNum").html("<i class=\"k-icon k-i-check-outline\" id=\"chkOK\" style=\"color:#0bba82;margin-right:3px;\"></i>사업자번호 확인");
	$("#btn_chkBizNum").attr("disabled", true);
}

function bizInfo(recvData){

	$.ajax({
		url: "/contents/basic/data/bizInfo.do",
		type: "POST",
		dataType: "json",
		data: {
			//bizNum: $("#bizNum").val().replace(/\-/g, "")
			bizNum: recvData.bizNum
		},
		success: function(data){
			if(data.data != null){

				var bizInfo = data.data;
				$("#bizName").val(bizInfo.bizName);	// 사업자상호
				$("#ceo").val(bizInfo.ceo);		// 대표자명
				$("#bizCond").val(bizInfo.bizCond);	// 업태
				$("#bizKind").val(bizInfo.bizKind);	// 업종
				$("#bizPost").val(bizInfo.bizPost.replace(/[^0-9]/g, "")); // 우편번호
				$("#bizAddr").val(bizInfo.bizAddr);	// 주소
			    $("#bizTypeCode").val("01");
				// 추가내용
				//$("#custName").val(bizInfo.bizName);

			}
		}
	});
} 

//excel download
function goExcel(){
	$("#loading").show();
	var grid = $("#cust_list").data("kendoGrid");
	grid.saveAsExcel();
}
</script>