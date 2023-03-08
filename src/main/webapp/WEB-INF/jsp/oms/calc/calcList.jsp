<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="divCalcInsert" class="editor_wrap p-0">
	<form class="modalEditor" id="fCalc" data-toggle="validator" role="form" autocomplete="off">
		<input type="hidden" name="fCalcMode" id="fCalcMode" class="hiddenValue">
		<div class="modalHeader">
			<div class="form-group row">
                <label class="col-form-label modal-big-name">정산유형</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <!-- <input type="text" class="form-control form-control-sm" type="text"> -->
                    <select name="calcTypeCode" id="calcTypeCode" class="custom-select col-12" required></select>
					<div class="help-block with-errors" style="position: absolute;"></div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name">정산금액</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" type="text" id="calcCharge" required>
					<div class="help-block with-errors" style="position: absolute;"></div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name">메모</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" type="text" id="memo" required>
					<div class="help-block with-errors" style="position: absolute;"></div>
                </div>
            </div>
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <button type="submit" id="fCalcSubmitBtn" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i><strong>저장</strong></b></button>
		        <a onclick="calcModalClose()" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
	        </div>
	    </div>
	</form>
</div>

<div class="oms_header">
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">정산관리</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt" method="post">
				<input type="hidden" name="custId" id="custId" class="hiddenValue">
				<input type="hidden" name="deptId" id="deptId" class="hiddenValue">
				<div class="form-group row">
					<div class="input-group input-group-sm wd90 middle-name">
					    <input style="padding: 0;" type="text" id="fromDate" name="fromDate" class="col-12">
					</div>
					<span>~</span>
					<div class="input-group input-group-sm wd90 mr10 middle-name">
					    <input style="padding: 0;" type="text" id="toDate" name="toDate" class="col-12">
					</div>
					<div class="input-group input-group-sm wd110 mr10 middle-name">
					    <select class="custom-select col-12" id="sellBuySctn" name="sellBuySctn">
					        <option value="02" selected="selected">운송/주선사명</option>
					    </select>
					</div>
					<div class="input-group input-group-sm wd190 mr10 middle-name">
					    <input type="text" id="sCustName" name="sCustName" style="width:100%;">
					</div>
					<div class="input-group input-group-sm wd90 mr10 middle-name">
	                	<input type="text" name="sSubName" id="sSubName" class="form-control form-control-sm" readonly>
	                </div>
					
					<div class="input-group input-group-sm wd140 mr10 middle-name">
					    <input type="hidden" id="inOutSctn" name="inOutSctn" value="02">
					    <select class="custom-select col-12" id="sCalcTypeCode" name="calcTypeCode"></select>
					</div>
					
					<div class="input-group input-group-sm wd90 middle-name">
					    <select class="custom-select col-12" id="sFinishYn" name="finishYn">
					        <option value="">정산여부</option>
					        <option value="Y">Y</option>
					        <option value="N">N</option>
					    </select>
					</div>
				    <!--<c:choose>
				    	<c:when test="${masterYn eq 'Y'}">
							<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
								<span>&nbsp;</span>
								<select class="form-control" class="custom-select col-12" id="s_dept" name="s_dept"></select>
							</div>
							<div class="input-group input-group-sm col-2 middle-name"></div>
						</c:when>
				    	<c:when test="${masterYn eq 'N'}">
							<div class="input-group input-group-sm col-3 middle-name"></div>
						</c:when>
				    </c:choose>-->
					<div class="input-group input-group-sm col middle-name form-group">
				        <div style="float: right;" class="option-area">
			                <div class="form-group">
			                	<c:if test="${menuAuth.readYn eq 'Y'}">
			                    	<button onclick="goList();" type="button" class="sch-more">검색</button>
			                   	</c:if>
			                   	<c:if test="${menuAuth.editYn eq 'Y'}">
			                    	<button id="btnFinishCalc" type="button" class="btn-default">정산마감</button>
			                    </c:if>
			                    <c:if test="${menuAuth.writeYn eq 'Y'}">
			                    	<button id="calcInsert" type="button" class="btn-default">운송비추가등록</button>
			                    </c:if>
			                 <%--    <c:if test="${menuAuth.editYn eq 'Y'}">
			                    	<button id="btnTranReceipt" type="button" class="sch-more">거래명세서</button>
			                    </c:if> --%>
			                    <c:if test="${menuAuth.printYn eq 'Y'}">
			                    	<button onclick="goExcel();" type="button" class="btn-success">엑셀출력</button>
			                    </c:if>
			                </div>
			            </div>
				    </div>
				</div>
			</form>                
			<div class="cont-body">
				<!-- f-wrap -->
				<div class="k-wrap content">
					<div class="lookup_table">
						<div style="min-width: 500px;">
							<div style="height: 706px;" id="calcList"></div>
							<ul id="calcListContextMenu">
					    		<li id="vReceipt">인수증 확인</li>
								<li class="k-separator"></li>
						    	<li id="vFinishCalc">마감처리</li>
								<li class="k-separator"></li>
						    	<li id="vCancelCalc">마감취소</li>
								<li class="k-separator"></li>
						    	<li id="vDeleteCalc">삭제</li>
						    </ul>
							<!-- /table -->
						</div>
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
var searchCustName;

$("#calcListContextMenu").kendoContextMenu({
	target: "#calcList",
	filter: "tr[role='row']"
});

var contextMenu = $("#calcListContextMenu").data("kendoContextMenu");
contextMenu.bind("select", onContextMenuSelect);

$(document).ready(function(){
	if("${masterYn}" == "Y"){
		Util.setSelectBox("/contents/basic/data/compDeptList.do", "s_dept", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn:'Y'}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "--부서명--");
	}
	$("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
	$("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true}); 
	Util.setSearchDateForm();
	
	Util.setCmmCode("select", "sCalcTypeCode", "CALC_TYPE_CD", "", "정산유형");
	var $options = $("#sCalcTypeCode > option").clone();
	$('#calcTypeCode').append($options);
	$("#calcTypeCode option[value='0002']").remove();
	
	goList();

	//신규등록 modal
	calcModal = $("#divCalcInsert");
 	calcModalButton = $("#calcInsert");

	calcModalButton.click(function () {
		var grid = $("#calcList").data("kendoGrid");
		var row = grid.select();		
		
		if(row.length != 1) {
			alert("하나의 정산내역을 선택해주세요.");
			return;
		}
		$("#fCalcSubmitBtn").html($("#fCalcSubmitBtn").html().replace('수정', '저장'));
		$("#calcTypeCode").attr("disabled", false);
		$("#fCalcMode").val("N");
		$("#fCalc")[0].reset();
		$("#divCalcInsert").parents("div").find(".k-window-title").html("정산등록");
		calcModal.data("kendoDialog").open();
	});
	
	calcModal.kendoDialog({
		width: "446px",
		height: "350px",
		visible: false,
		title: "정산관리",
		closable: true,
		modal: false,
		close: function(){calcModalButton.fadeIn();}
	});
	
	//거래처 자동완성
	searchCustName = MultiColumnComboBox.setCustName("s", $("#sellBuySctn").val(), "${sessionScope.userInfo.deptId}");
	searchCustName.bind("select", changeSearchCust);
	searchCustName.bind("change", searchCustSelectTrigger);
	
	$("#sellBuySctn").on("change", function(){
		searchCustName = $("#sCustName").data("kendoMultiColumnComboBox");
		searchCustName.value("");
		searchCustName.refresh();
		searchCustName.destroy();
		$(".hiddenValue").val("");
		$("#sSubName").val("");
		var sellBuySctn = $(this).val();
		if(sellBuySctn == "02") {	
			searchCustName = MultiColumnComboBox.setCustName("s", sellBuySctn, "${sessionScope.userInfo.deptId}");
			searchCustName.bind("select", changeSearchCust);
			searchCustName.bind("change", searchCustSelectTrigger);
		}
	}); 

	function preventPost(e) {
    	if (e.keyCode === 13) {
    		goList();
    	}
    }
	searchCustName.input.keydown(preventPost);
});

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "mngDeptName", title: "담당부서", width: 70 },
	{ field: "calcTypeName", title: "정산유형", width: 70 },
	{ field: "allocDate", title: "배차일자", width: 75 },
	{ field: "carNum", title: "차량번호", width: 85 },
	{ field: "carrierName", title: "운송사", width: 120 },
	{ field: "sComName", title: "상차지", width: 100 },
	{ field: "eComName", title: "하차지", width: 100 },
	{ field: "goodsName", title: "화물명", width: 50 },
	{ field: "goodsWeight", title: "중량", width: 70 },
	{ field: "payableAmt", title: "미지급금", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.payableAmt);
		},
		attributes: { 
			style: "text-align: right" 
		}
	},
	{ field: "withdrawalAmt", title: "출금", width: 100,
		attributes: { 
			style: "text-align: right" 
		}
	},
	{ field: "receiptYn", title: "인수증", width: 100,
		template: "#if(receiptYn == 'Y') {# #=receiptDate# #} else if(receiptYn == 'P') {# #=paperReceiptDate# #} else {# N #} #"
	},
	{ field: "tranYn", title: "거래명세서", width: 100,
		template: "#if(tranYn == 'Y') {# #=tranDate# #} else {# N #} #"
	},
	{ field: "taxinvYn", title: "세금계산서", width: 100,
		template: "#if(taxinvYn == 'Y') {# #=taxinvDate# #} else if(taxinvYn == 'P') {# #=taxinvDate# #} else {# N #} #"	
	},
	{ field: "finishYn", title: "마감", width: 100,
		template: "#if(finishYn == 'Y') {# #=calcDate# #} else {# N #} #"
	}
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("calcList");
oGrid.initGrid();
oGrid.setSendUrl("/oms/calc/data/calcList.do");
oGrid.setSelectable("multiple");
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

function goList() {
	var grid = $("#calcList").data("kendoGrid");
	
	var id = "";
	if($("#sellBuySctn").val() == "02") id = "carrierName";
	
	var param = {};
	param[id] = $("#sCustName").val();
	param["fromDate"] = $("#fromDate").val();
	param["toDate"] = $("#toDate").val();
	param["calcTypeCode"] = $("#sCalcTypeCode").val();
	param["finishYn"] = $("#sFinishYn").val();
	param["deptId"] = $("#s_dept").val();
	
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#calcList").data("kendoGrid");
		//grid.bind("change", onChange);
		grid.tbody.delegate('tr', 'dblclick', function(){
			var grid = $("#calcList").data("kendoGrid");
			var row = grid.select();
			selectedData = grid.dataItem(row);
			if(selectedData.calcTypeCode == '0002'){
				alert("내수운송료는 변경할 수 없습니다.");
			}else if(selectedData.finishYn == 'Y'){
				alert("정산마감된 정산은 변경할 수 없습니다.");
			}else{
				$("#calcTypeCode").val(selectedData.calcTypeCode);
				$("#memo").val(selectedData.memo);
				$("#calcCharge").val(selectedData.payableAmt);
				$("#fCalcSubmitBtn").html($("#fCalcSubmitBtn").html().replace('저장', '수정'));
				$("#calcTypeCode").attr("disabled", true);
				$("#fCalcMode").val("E");
				$("#calcCharge").val(Util.formatNumberInput($("#calcCharge").val()));
				$("#divCalcInsert").parents("div").find(".k-window-title").html("정산수정");
				calcModal.data("kendoDialog").open();
			}
		});	
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}

function onContextMenuSelect(e) {
	var grid = $("#calcList").data("kendoGrid");
	var data = grid.dataItem(e.target);
	var row = grid.select();
	var multiSelectedData = [];
	var item = e.item.id;
	
	for(var i = 0; i < row.length; i++) {
		multiSelectedData.push(grid.dataItem(row[i]));
	}
	switch (item) {
	case "vReceipt":
		if(row.length != 1) {
			alert("하나의 정산내역을 선택해주세요.");
			return;
		}
		viewReceipt(data.receiptYn, data.receiptPath, data.orderId);
		break;
	case "vFinishCalc":
		if(row.length < 1) {
			alert("정산내역을 하나이상 선택해주세요.");
			return;
		}
		multiFinishCalc(multiSelectedData, 'Y');
		break;
	case "vCancelCalc":
		if(row.length < 1) {
			alert("정산내역을 하나이상 선택해주세요.");
			return;
		}
		multiFinishCalc(multiSelectedData, 'N');
		break;
	case "vDeleteCalc":
		deleteClac(multiSelectedData);
		break;
		
	}
}

function chkCarrierName() {	
	var f = true;
	
	if($("#sellBuySctn").val() != "02") {
		f = false; 
	} else {
		if( $("#sCustName").val().length == 0) f = false;
	}
	
	if(f) {
		return {
			isSelected: true,
			item: {
				carrierName: $("#sCustName").val(),
				fromDate: $("#fromDate").val(),
				toDate: $("#toDate").val()
			}
		};
	} else {
		alert("대상 운송사를 선택해 주세요.");
		return {
			isSelected: false,
			item: null
		};
	}
}

function changeSearchCust(e) {
	var dataItem = e.dataItem;
	if(dataItem != null) {
		$("#custId").val(dataItem.custId);
		$("#deptId").val(dataItem.deptId);
		$("#sSubName").val(dataItem.deptName);
	}else{
		if(e.sender.selectedIndex != -1){
			searchCustName.select(e.sender.selectedIndex);
			var data = e.sender.listView._view[e.sender.selectedIndex];
			$("#custId").val(data.item.custId);
			$("#deptId").val(data.item.deptId);
			$("#sSubName").val(data.item.deptName);
		}
	}
	
	
}

function searchCustSelectTrigger(e){
	if(this.value() != ""){
		searchCustName.trigger("select");
	}else{
		$("#custId").val("");
		$("#deptId").val("");
	}
}

function calcModalClose() {
	calcModal.data("kendoDialog").close();
	$("#fCalc")[0].reset();
	$(".list-unstyled").remove();
}
$('#fCalc').validator().on('submit', function (e) {	
	$("#calcCharge").val($("#calcCharge").val().replace(/,/g, ""));
	var grid = $("#calcList").data("kendoGrid");
	var row = grid.select();
	var selectedData = {};
	
	if(row.length > 1) {
		alert("하나의 정산내역만 선택해주세요.");
		return;
	}
	
	selectedData = grid.dataItem(row);
	if (e.isDefaultPrevented()) {
		alert("항목을 입력해 주세요.");
	} else {
		// 이벤트 초기화 (submit 동작 중단)
		e.preventDefault();
		if($("#fCalcMode").val() != "N"){
			var param = {
				calcId: selectedData.calcId,
				calcCharge: $("#calcCharge").val(),
				memo: $("#memo").val(),
				sellBuySctn : selectedData.sellBuySctn,
				orderId : selectedData.orderId,
				allocId : selectedData.allocId,
				mode: 'E'
			}
		}else{
			var param = {
				calcId: selectedData.calcId,
				calcTypeCode: $("#calcTypeCode").val(),
				calcCharge: $("#calcCharge").val(),
				memo: $("#memo").val(),
				mode: 'N'
			}
		}
		$.ajax({
			url: "/contents/calc/data/newCalcCharge.do",
			type: "POST",
			dataType: "json",
			data: param,
			success: function(data){
				if (data.result) {
					alert(data.msg);
					goList();
					calcModalClose();
				}else {
					alert(data.msg);
				}
			}
		});
	}
});	

// $("#btnTranReceipt").click(function() {
// 	if($("#sCustName").val().length == 0) {
// 		alert("거래처를 선택해주세요.");
// 		return;
// 	}
	
// 	var param = {
// 		custId: $("#custId").val(),
// 		deptId: $("#deptId").val(),
// 		fromDate: $("#fromDate").val(),
// 		toDate: $("#toDate").val()
// 	};

// 	var grid = $("#calcList").data("kendoGrid");	
// 	var orderList = '';
// 	for(var i = 0; i < grid._data.length; i++){
// 		orderList += grid._data[i].orderId +"," 
// 	}
// 	orderList = orderList.substring(0, orderList.length - 1);
// 	$("#orderList").val(orderList)
// 	console.log(orderList);
// 	$.ajax({
// 		url: "/contents/calc/data/regTranReceipt.do",
// 		type: "POST",
// 		dataType: "json",
// 		data: param,
// 		success: function(data){
// 			if (data.result) {
// 				alert(data.msg);
// 				goList();
// 			}
// 		}
// 	});
// });

$("#btnFinishCalc").click(function() {
	if($("#sCustName").val().length == 0) {
		alert("거래처를 선택해주세요.");
		return;
	}
	
	var param = {
		custId: $("#custId").val(),
		deptId: $("#deptId").val(),
		fromDate: $("#fromDate").val(),
		toDate: $("#toDate").val(),
		calcTypeCode: $("#sCalcTypeCode").val()
	};
	
	$.ajax({
		url: "/oms/calc/data/custFinishCalc.do",
		type: "POST",
		dataType: "json",
		data: param,
		success: function(data){
			if (data.result) {
				alert(data.msg);
				goList();
			}else {
				alert(data.msg);
			}
		}
	});
});

function viewReceipt(receiptYn, receiptPath, orderId) {
	if(receiptYn == "P"){
		alert("종이 인수증 입니다.");
		return;
	}else if(receiptYn != "Y"){
		alert("등록된 인수증이 없습니다.");
		return;
	}
	window.open("/oms/calc/view/orderFile.do?orderId="+orderId, "PopupPost", "width=620, height=707");
}

function deleteClac(datas){
	var calcTypeCodeArr = [];
	var calcIdArr = [];
	
	for(var i = 0; i < datas.length; i++) {
		calcTypeCodeArr.push(datas[i].calcTypeCode);
		calcIdArr.push(datas[i].calcId);
	}
	
	function codeCheck(calcTypeCodeArr){
		if(calcTypeCodeArr === '0002'){
			return true;
		}
	}
	
	if(calcTypeCodeArr.find(codeCheck) == '0002'){
		alert("내수운송료는 삭제할 수 없습니다.")
	}else {
		$.ajax({
			url: "/oms/calc/data/multiDeleteCalc.do",
			type: "POST",
			dataType: "json",
			data: {
				calcIdArr: calcIdArr.toString()
			},
			success: function(data){
				if (data.result) {
					alert(data.msg);
					goList();
					contextMenu.close();
				}else {
					alert(data.msg);
				}
			}
		});
	}
}

function multiFinishCalc(datas, mode) {
	var calcIdArr = [];
	for(var i = 0; i < datas.length; i++) {
		calcIdArr.push(datas[i].calcId);
	}
	
	$.ajax({
		url: "/oms/calc/data/multiFinishCalc.do",
		type: "POST",
		dataType: "json",
		data: {
			calcIdArr: calcIdArr.toString(),
			mode : mode
		},
		success: function(data){
			if (data.result) {
				alert(data.msg);
				goList();
				contextMenu.close();
			}else {
				alert(data.msg);
			}
		}
	});
}

function goExcel(){
	var grid = $("#calcList").data("kendoGrid");
	grid.saveAsExcel();
	
}
$("#calcCharge").on("input", function(){
	$(this).val(Util.formatNumberInput($(this).val()));
});
</script>