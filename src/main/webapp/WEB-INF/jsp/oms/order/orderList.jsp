<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.k-detail-row {
		pointer-events: none;
	}
</style>
<div class="insert_pop">
	<%@ include file="./view/orderInsert.jsp" %>
</div>

<div class="oms_header omsOrderList">
	<div class="summary p30">
		<div class="hdr-tit">
			<p id="headerTitle">배차목록</p>
		</div>
	</div>
	<form id="fSearch" method="POST" autocomplete="off" onSubmit="return false;">
    <input type="hidden" name="locationSLat" id="locationSLat">
    <input type="hidden" name="locationSLon" id="locationSLon">
    <input type="hidden" name="locationELat" id="locationELat">
    <input type="hidden" name="locationELon" id="locationELon">
    <input type="hidden" name="locationCarNum" id="locationCarNum">
    <input type="hidden" name="locationDriverName" id="locationDriverName">
    <input type="hidden" name="locationDriverTel" id="locationDriverTel">
    <input type="hidden" name="locationSComName" id="locationSComName">
    <input type="hidden" name="locationEComName" id="locationEComName">
    <input type="hidden" name="locationSAddr" id="locationSAddr">
    <input type="hidden" name="locationEAddr" id="locationEAddr">
    <input type="hidden" name="locationSAddrDetail" id="locationSAddrDetail">
    <input type="hidden" name="locationEAddrDetail" id="locationEAddrDetail">
		<div class="form-group row oms_header_set">
			<div class="input-group input-group-sm wd90 mr10 middle-name form-group">
				<select class="form-control" name="dateSelector">
					<option value="REGDATE"selected="selected">등록일</option>
			        <option value="S_DATE">상차일</option>
			        <option value="E_DATE">하차일</option>
				</select>
			</div>
			
			<div class="input-group input-group-sm wd90 middle-name form-group">
				<input style="padding: 0;" type="text" id="fromDate" name="fromDate" class="col-12">
			</div>
			<span>~</span>
			<div class="input-group input-group-sm wd90 mr10 middle-name form-group">
				<input style="padding: 0;" type="text" id="toDate" name="toDate" class="col-12">
			</div>
			
			<div class="input-group input-group-sm wd90 mr10 middle-name form-group">
				<select class="form-control" name="addrSelector">
					<option value="S_ADDR"selected="selected">상차지</option>
			        <option value="E_ADDR">하차지</option>
				</select>
			</div>
	    	<c:if test="${masterYn eq 'Y'}">
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
					<select class="form-control" class="custom-select col-12" id="deptId" name="deptId"></select>
				</div>
			</c:if>
			<div class="input-group input-group-sm col middle-name form-group">
		        <div class="option-area">
	                <div class="form-group">
	                	<div class="input-group input-group-sm col radio-or-checkBox ">
		                   	<input id="myOrder" name="myOrder" type="checkbox" onclick="btnChk(this)" value="N">
		                   	<label for="myOrder" class="label-margin">
		                   		<span>내거래 보기</span>
		                   	</label>
	                   </div>
	                    <button onclick="goList();" type="button" class="sch-more btn_b">검색</button>
	                    <!-- <button class="btn-default">알림톡 전송</button> -->
	                    <c:if test="${menuAuth.writeYn eq 'Y'}">
	                    	<button onclick="form_popup('N', {})" type="button" class="btn-warning">신규등록</button>
	                    </c:if>
	                    <c:if test="${menuAuth.readYn eq 'Y'}">
	                    <button onclick="popOrderViewLocation();" type="button" class="btn-primary">위치관제</button>
	                    </c:if>
	                    <c:if test="${menuAuth.printYn eq 'Y'}">
	                    	<button onclick="goExcel();" type="button" class="btn-success">엑셀출력</button>
	                    </c:if>
	                </div>
	            </div>
		    </div>
		</div>
	</form>
	<div id="group-list" class="cont-wrapper-page-grid bortop pt20">
   		<div id="grid"></div>
	</div>
    <div id="divViewLocation"></div>
</div>
<script type="text/javascript">
var viewLocation = null;
// debugger;
var columns = [
	{field: "orderStateName", title: "오더상태", width: 100, hidden: true},
	{field: "buyCharge", title: "지불운임", width: 80, hidden: true},
	{field: "chargeTypeName", title: "운임구분", width: 80, hidden: true},
	{field: "sAddr", title: "상차지", width: 400, hidden: true},
	{field: "sAddrDetail", title: "상차지상세주소", width: 400, hidden: true},
	{field: "sDateDay", title: "상차일", width: 80, hidden: true},
	{field: "sDateTime", title: "상차시", width: 80, hidden: true},
	{field: "eAddr", title: "하차지", width: 400, hidden: true},
	{field: "eAddrDetail", title: "하차지상세주소", width: 400, hidden: true},
	{field: "eDateDay", title: "하차일", width: 80, hidden: true},
	{field: "eDateTime", title: "하차시", width: 80, hidden: true},
	{field: "regdate", title: "등록일", width: 150, hidden: true},
	{field: "buyCustName", title: "매출처", width: 150, hidden: true},
	{field: "buyDeptName", title: "매출부서", width: 150, hidden: true},


	{template:'#if (orderStateName == "취소") {# <div style="color:\\\#FF0000;" class="grid-tr-18">#: orderStateName #</div> #} else if (orderStateName != "접수") {# <div style="color:\\\#0369DE;" class="grid-tr-18">#: orderStateName #</div> #} else {# <div class="grid-tr-18">#: orderStateName #</div> #} #'
						 +'<div class="grid-tr-14">#: orderId #</div>'
						 +'#if (buyCharge != 0) {# <div style="color:\\\#00152A;" class="grid-tr-18">#: Util.formatNumber(buyCharge) #원</div> #} else {# <div class="grid-tr-18">0원</div> #} #'
						 +'#if (chargeTypeName == null || chargeTypeName == "") {# <div class="grid-tr-14">인수증</div> #} else {# <div class="grid-tr-14">#: chargeTypeName #</div> #} #'},

    {template:'<div style="color: \\\#00152A; text-align: center;" class="grid-tr-14">#if (carNum == null) {# #=""# #} else {# #=carNum# #} #</div>'
				  		 +'<div style="color: \\\#00152A; text-align: center;" class="grid-tr-14">#if (driverTel == null) {# #=""# #} else {# #=Util.formatPhone(driverTel)# #} #</div>'
				  		 +'<div style="padding-bottom: 10px; color: \\\#00152A; text-align: center;" class="grid-tr-14">#if (driverName == null) {# #=""# #} else {# #=driverName# #} #</div>'
				  		 +'<div style="color: \\\#00152A; text-align: center;" class="grid-tr-14">#if (carNum, driverTel, driverName == null) {# #=""# #} else {# #=carTypeName# #=carTonName# #=returnName# #=mixName# #} #</div>'
				  		 +'#if (carNum, driverTel, driverName == null) {# <div style="text-align: center;" class="grid-tr-14">#: carTypeName # #: carTonName # #: returnName # #: mixName #</div> #} #'},

    {width: 100, template:'#if (orderStateName == "접수") {# <div style="text-align: center; color: \\\#0369DE;" class="grid-tr-14">접수</div> #} else {# <div style="text-align: center;" class="grid-tr-14">접수</div> #} #'},

    //접수(불투명), 배차, 입차, 출발, 도착
    {width: 100, template:'#if (orderStateName == "접수") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14"><span style="opacity: 0.3;">▶</span><span style="opacity: 0.6;">▶</span>▶</div> #} else if (orderStateName != "취소") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14">▶▶▶</div> #} #'},

    {width: 100, template:'#if (orderStateName == "배차") {# <div style="text-align: center; color:\\\#0369DE;" class="grid-tr-14">배차완료</div> #} else {# <div style="text-align: center;" class="grid-tr-14">배차완료</div> #} #'},

    //입차(불투명), 출발, 도착
    {width: 100, template:'#if (orderStateName == "입차") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14"><span style="opacity: 0.3;">▶</span><span style="opacity: 0.6;">▶</span>▶</div> #} else if (orderStateName == "출발") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14">▶▶▶</div> #} else if (orderStateName == "도착") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14">▶▶▶</div> #} #'},

    {template:'#if (orderStateName == "출발") {# <div class="grid-tr-18" style="padding-bottom: 10px; text-align: center; color: \\\#0369DE;">#: sComName #(출발)</div> #} else {# <div class="grid-tr-18" style="padding-bottom: 10px; text-align: center;">#: sComName #(출발)</div> #} #'
    		 +'#if (orderStateName == "출발") {# <div class="grid-tr-14" style="text-align: center; color: \\\#0369DE;">#: sAddr #</div> #} else {# <div class="grid-tr-14" style="text-align: center;">#: sAddr #</div> #} #'
    		 +'#if (orderStateName == "출발") {# <div class="grid-tr-14" style="text-align: center; color: \\\#0369DE;">#: sDateDay #(상차)</div> #} else {# <div class="grid-tr-14" style="text-align: center;">#: sDateDay #(상차)</div> #} #'},

   	//출발(불투명), 도착
    {width: 80, template:'#if (orderStateName == "출발") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14"><span style="opacity: 0.3;">▶</span><span style="opacity: 0.6;">▶</span>▶</div> #} else if (orderStateName == "도착") {# <div style="text-align: center; color: \\\#00152A;" class="grid-tr-14">▶▶▶</div> #} #'},

    {template:'#if (orderStateName == "도착") {# <div class="grid-tr-18" style="padding-bottom: 10px; text-align: center; color: \\\#0369DE;">#: eComName #(도착)</div> #} else {# <div class="grid-tr-18" style="padding-bottom: 10px;text-align: center;">#: eComName #(도착)</div> #} #'
		  	 +'#if (orderStateName == "도착") {# <div class="grid-tr-14" style="text-align: center; color: \\\#0369DE;">#: eAddr #</div> #} else {# <div class="grid-tr-14" style="text-align: center;">#: eAddr #</div> #} #'
		  	 +'#if (orderStateName == "도착") {# <div class="grid-tr-14" style="text-align: center; color: \\\#0369DE;">#: eDateDay #(하차)</div> #} else {# <div class="grid-tr-14" style="text-align: center;">#: eDateDay #(하차)</div> #} #'},

];
// debugger;
var headerTitle = ($("#headerTitle").text());
var oGrid = null;
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/oms/order/data/omsOrderList.do");
oGrid.setSelectable(true);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");
oGrid.setDetailTemplate("<div style='padding: 0px; pointer-events: none;' class='detail-row'><span>#:regdate# #:mngDeptName# → #:buyCustName# #:buyDeptName#</span></div>");

$(document).ready(function(){
	if("${masterYn}" == "Y"){
		Util.setSelectBox("/contents/basic/data/compDeptList.do", "deptId", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn:'Y'}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "부서명");
	}
	$("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
	$("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true}); 
	Util.setSearchDateForm();
	
	goList();

	$(".k-grid-header th:not(:first)").css({ "display": "none", "width": "0px" });
	
	var exportFlag = false;
	$("#grid").data("kendoGrid").bind("excelExport", function (e) {
	    var hiddenCnt = 0;
    	$.each(columns, function (idx,row){
        	if(columns[idx].hidden == true){
        		hiddenCnt ++;
        	}
        });
		
	    if (!exportFlag) {
	    	for(var i = 0; i < hiddenCnt; i++){
	        	e.sender.showColumn(i);
	    	}
		        e.preventDefault();
		        exportFlag = true;
	        setTimeout(function () {
	            e.sender.saveAsExcel();
	        });
	    } else {
	    	for(var i = 0; i < hiddenCnt; i++){
	        	e.sender.hideColumn(i);
	    	}
	        exportFlag = false;
	    }
	});
});

function goList() {
	var grid = $("#grid").data("kendoGrid");
	
	oGrid.setSearchData($("#fSearch").serializeObject());
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#grid").data("kendoGrid");
		grid.bind("change", onChange);
		grid.tbody.delegate('tr', 'dblclick', function(){
			var dataItem = grid.dataItem($(this));
			form_popup("E", dataItem);
		});

	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
	grid.bind("dataBound", grid_dataBound);
}

function grid_dataBound(e) {
	var grid = $("#grid").data("kendoGrid");
    $( ".k-master-row" ).each(function( index ) {
    	grid.expandRow(this);
    });
}

function onChange(e){
	var row = this.select();
	var data = this.dataItem(row);
	$("#locationSLat").val(data.sLat);
	$("#locationSLon").val(data.sLon);
	$("#locationELat").val(data.eLat);
	$("#locationELon").val(data.eLon);
	$("#locationCarNum").val(Util.nvl(data.buyCarNum,data.carNum));
	$("#locationDriverName").val(Util.nvl(data.buyDriverName,data.driverName));
	$("#locationDriverTel").val(Util.nvl(data.buyDriverTel,data.driverTel));
	$("#locationSComName").val(data.sComName);
	$("#locationEComName").val(data.eComName);
	$("#locationSAddr").val(data.sAddr);
	$("#locationEAddr").val(data.eAddr);
	$("#locationSAddrDetail").val(data.sAddrDetail);
	$("#locationEAddrDetail").val(data.eAddrDetail);
}

function form_popup(mode, data) {
	Util.insertCloseButton();
	$('#mixYn').val("N");
	$('#returnYn').val("N");
	$('#dangerGoodsYn').val("N");
	$('#chemicalsYn').val("N");
	$('#foreignLicenseYn').val("N");
	$('#group-list').addClass("block");
	$('.insert_pop').addClass("block");
	$('.insertClose').addClass("block");
	
	if(mode == "E") {
		$("#order_legend").text("오더 수정");
		$("#btn_save").html($("#btn_save").html().replace('저장', '수정'));
		$("#sAreaSave").parent(".radio-or-checkBox").css("display", "none");
		$("#eAreaSave").parent(".radio-or-checkBox").css("display", "none");
		if($("#vehicId").val() != '', $("#driverId").val() != '', $("#carNum").val() != ''
		 , $("#driverName").val() != '', $("#driverTel").val() != '', data.orderStateName != '접수'){
			$("#driverKind").show();
			$("#driverStateDiv").show();
		}
		$(".openCloseDiv").hide();
		$(".openCloseBtn").html("추가정보열기");

		//수정 모드로 변경
		$("#mode").val("E");
		gridDataSet(data);
	} else {
		$("#order_legend").text("오더 등록");
		$("#btn_save").html($("#btn_save").html().replace('수정', '저장'));
		$("#sAreaSave").parent(".radio-or-checkBox").css("display", "contents");
		$("#eAreaSave").parent(".radio-or-checkBox").css("display", "contents");
		$(".openCloseDiv").hide();
		$(".openCloseBtn").html("추가정보열기");
		init();
	}
}

function form_popup_close() {
    $('#group-list').removeClass("block");
    $('.insert_pop').removeClass("block");
	$('.insertClose').removeClass("block");
}

function goExcel(){
	var grid = $("#grid").data("kendoGrid");
	grid.saveAsExcel();
	
}

// function popOrderViewLocation(){
// 	var selectedItem = chkSelectedOrder();
	
// 	if(selectedItem.isSelected){
// 		var orderId = selectedItem.item.orderId;
// 		viewLocation = $("#divViewLocation").data("kendoWindow");
// 		if(viewLocation == null) {
// 			viewLocation = $("#divViewLocation").kendoWindow({
// 				width: 850,
// 				height: 790,
// 				content: {
// 					url: "/contents/order/view/viewLocation.do?orderId=" + orderId
// 				},
// 				iframe: true,
// 				visible:false
// 			}).data("kendoWindow");	
// 		} else {
// 			viewLocation.refresh({url: "/contents/order/view/viewLocation.do?orderId=" + orderId});
// 		} 
// 		viewLocation.center().open();	
// 	}
// }

function chkSelectedOrder() {
	var grid = $("#grid").data("kendoGrid");
	var selectedItem = grid.dataItem(grid.select());
	
	if(selectedItem == null) {
		alert("오더를 선택하세요.");
		return {
			isSelected: false,
			item: null
		};
	}
	
	return {
		isSelected: true,
		item: selectedItem
	};
}
</script>
<style>
.grid-tr-14 {
  	font-size: 14px;
  	color: #73777E;
    text-overflow: ellipsis;
    overflow: hidden;
}
  	
.grid-tr-18 {
  	font-size: 18px;
  	color: #73777E;
  	text-overflow: ellipsis;
  	overflow: hidden;
}
  	
.k-grid-content table td{
  	text-align: left;
  	border-left: none;
   	box-shadow: none;
}

.k-grid-content.k-auto-scrollable {
    height: 656px;
}
</style>