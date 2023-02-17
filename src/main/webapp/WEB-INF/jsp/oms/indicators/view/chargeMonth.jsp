<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&amp;display=swap" rel="stylesheet">
<style>
body { 
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: bold;
	margin: 0;
	font-size: 1rem;
	line-height: 1.5;
	color: #212529;
	text-align: left;
	background-color: #fff;
}

.k-grid tr {
    pointer-events: none;
}

.k-grid-content-locked table tbody tr td {
	text-align: center;
	border-bottom: solid 1px #dbddde;
	border-left-width: thin !important;
	border-bottom-width: thin !important;
}

.k-grid-content table tbody tr td {
	border-bottom-width: thin !important;
}

.charge {
	text-align: right !important;
}
</style>

<div id="group-list" class="cont-wrapper-page-grid">
	<div class="p30">
		<form id="fSearch" class="date-bnt" method="post">
			<input type="hidden" name="custId" id="custId" class="hiddenValue">
			<input type="hidden" name="deptId" id="deptId" class="hiddenValue">
			<input type="hidden" name="orderStates" id="orderStates" class="hiddenValue">
			<div class="form-group row">
				<div class="input-group input-group-sm col-1 middle-name">
				    <input style="width:100%; padding: 0;" type="text" id="searchYear" name="searchYear">
				    <input type="hidden" id="fromDate" name="fromDate">
				    <input type="hidden" id="toDate" name="toDate">
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				    <select class="form-control" class="custom-select col-12" id="reqDeptId" name="reqDeptId"></select>
				</div>
				
				<div class="input-group input-group-sm col-2 middle-name">
				    <input type="text" id="sCustName" name="sCustName" style="width:100%;">
				</div>
	            
				<div class="input-group input-group-sm col radio-or-checkBox">
                   	<input type="checkbox" name="orderState" id="orderState05" value="05"/>
                   	<label for="orderState05" class="label-margin">
                   		<span>도착</span>
                   	</label>
                </div>
                
                <div class="input-group input-group-sm col radio-or-checkBox">
                 	<input type="checkbox" name="orderState" id="orderState01" value="01"/>
                   	<label for="orderState01" class="label-margin">
                   		<span>진행</span>
                   	</label>
                </div>
                   
				<div class="input-group input-group-sm col radio-or-checkBox">
                   	<input type="checkbox" name="orderState" id="orderState00" value="00"/>
                   	<label for="orderState00" class="label-margin">
                   		<span>접수</span>
                   	</label>
                </div>
            </div>
			<div class="toolbar row">
				<div class="tool_form col">
					<div style="float:left;margin-top:30px;">(단위:건 or % or 원)</div>
					<div style="float: right;" class="option-area">
		                <div class="form-group">
		                    <button onclick="goList();" type="button" class="sch-more btn_b">검색</button>
		                    <button onclick="goExcel();" type="button" class="btn-success">엑셀출력</button>
		                </div>
		            </div>
				</div>
			</div><!-- /toolbar -->
		</form>
	</div>
	<div id="grid" style="height:calc(100vh - 188px)"></div>
</div>

<script type="text/javascript">
var searchCustName;
var searchYear = "";
var columns;

$(document).ready(function(){
	$("#searchYear").kendoDatePicker({
        start: "decade",                          
        depth: "decade",                           
        format: "yyyy",
		dateInput: true
	});

	var now = new Date();	// 현재 날짜 및 시간
	var sYear = now.getFullYear();
	var yearPicker = $("#searchYear").data("kendoDatePicker");
	yearPicker.value(String(sYear));
	yearPicker.min(new Date(2018, 0));
	yearPicker.max(new Date(2030, 11));
	
	Util.setSelectBox("/contents/basic/data/compDeptList.do", "reqDeptId", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn:'Y'}, "deptId", "deptName", "", "--부서명--");
	
	searchCustName = MultiColumnComboBox.setCustName("s", "02", "${sessionScope.userInfo.deptId}");
	searchCustName.bind("select", selectSearchCust);
	searchCustName.bind("change", searchCustSelectTrigger);
	
	$("#reqDeptId").on("change", function(){
		searchCustName = $("#sCustName").data("kendoMultiColumnComboBox");
		searchCustName.value("");
		searchCustName.refresh();
		searchCustName.destroy();
		$(".hiddenValue").val("");
		searchCustName = MultiColumnComboBox.setCustName("s", "02", $("#reqDeptId").val());
		searchCustName.bind("select", selectSearchCust);
		searchCustName.bind("change", searchCustSelectTrigger);
	}); 
});

function goList(){
	var colName, title, data;

	searchYear = $("#searchYear").val();
	
	$("#fromDate").val(searchYear + "-01-01");
	$("#toDate").val(searchYear + "-12-31");

	var orderState = "";
	$("#fSearch input[name=orderState]").each(function(){
		if($(this).is(":checked")){
			var value = $(this).val();
			orderState += value + ",";
		}	
	});
	
	$("#orderStates").val(orderState);
	
	columns = [
		{ field: "category", title: "지표", width: 120, locked: true },
		{ field: "type1", title: "구분", width: 80, locked: true, headerAttributes: {"class" : "typeMerge"} },
		{ field: "type2", title: "구분", width: 80, locked: true, headerAttributes: {"class" : "typeMerge"}},
		{ field: "subtotal", title: "소계", width: 100, locked: true,
			template: function(dataItem) {
				if(dataItem.subtotal == "") {
					return "0";
				} else {
					return Util.formatNumber(dataItem.subtotal);	
				}	
			}
		}
	];
	
	for(var i = 1; i<=12; i++) {
		var str = "0" + i.toString();
		str = str.substring(str.length, str.length-2);
		colName = "col" + str;
		title = searchYear + "." + i.toString();
		data = {field: colName, title: title, width: 117.7, encoded: false};
		
		columns.push(data);
	}
	
 	$("#grid").text("");
	$("#grid").kendoGrid({
		dataSource : {
			transport : {
				read : {
					url : "/oms/indicators/data/chargeMonth.do",
					type : "post",
					dataType : "json",
 					data : $("#fSearch").serializeObject(),
					beforeSend: function(req) {
						req.setRequestHeader("AJAX", true);
					}
				}
			}, 
			schema : {
				data : function(response) {
					var data = {"category":"배차현황", "type1":"전체오더", "type2":"전체오더", "subtotal":0};			//전체오더
					var allocData = {"category":"배차현황", "type1":"배차", "type2":"소계", "subtotal":0};			//전체오더
					var notAllocData = {"category":"배차현황", "type1":"미배차", "type2":"소계", "subtotal":0};		//전체오더
 					var dataTonSum = {"category" : "톤급별배차대수", "type1":"배차대수합계", "type2":"배차대수합계", "subtotal":0}	// 톤급별 배차대수 합계
					var data1T = {"category" : "톤급별배차대수", "type1":"배차대수소형", "type2":"1톤", "subtotal":0}
					var data2T5 = {"category" : "톤급별배차대수", "type1":"배차대수소형", "type2":"2.5톤", "subtotal":0}
					var data3T5 = {"category" : "톤급별배차대수", "type1":"배차대수소형", "type2":"3.5톤", "subtotal":0}
					var data5T = {"category" : "톤급별배차대수", "type1":"배차대수중형", "type2":"5톤", "subtotal":0}
					var data5TA = {"category" : "톤급별배차대수", "type1":"배차대수중형", "type2":"5톤축", "subtotal":0}
					var data11T = {"category" : "톤급별배차대수", "type1":"배차대수중형", "type2":"11톤", "subtotal":0}
					var data15T = {"category" : "톤급별배차대수", "type1":"배차대수대형", "type2":"15톤", "subtotal":0}
					var data25T = {"category" : "톤급별배차대수", "type1":"배차대수대형", "type2":"25톤", "subtotal":0}
					var data20FT = {"category" : "톤급별배차대수", "type1":"배차대수기타", "type2":"20FT", "subtotal":0}
					var data40FT = {"category" : "톤급별배차대수", "type1":"배차대수기타", "type2":"40FT", "subtotal":0}
 					var dataETC = {"category" : "톤급별배차대수", "type1":"배차대수기타", "type2":"기타", "subtotal":0}
 					var dataAmtSum = {"category" : "톤급별운송비", "type1":"운송비합계", "type2":"운송비합계", "subtotal":0}	// 톤급별 운송비 합계
					var data1TAmt = {"category" : "톤급별운송비", "type1":"운송비소형", "type2":"1톤", "subtotal":0}
					var data2T5Amt = {"category" : "톤급별운송비", "type1":"운송비소형", "type2":"2.5톤", "subtotal":0}
					var data3T5Amt = {"category" : "톤급별운송비", "type1":"운송비소형", "type2":"3.5톤", "subtotal":0}
					var data5TAmt = {"category" : "톤급별운송비", "type1":"운송비중형", "type2":"5톤", "subtotal":0}
					var data5TAAmt = {"category" : "톤급별운송비", "type1":"운송비중형", "type2":"5톤축", "subtotal":0}
					var data11TAmt = {"category" : "톤급별운송비", "type1":"운송비중형", "type2":"11톤", "subtotal":0}
					var data15TAmt = {"category" : "톤급별운송비", "type1":"운송비대형", "type2":"15톤", "subtotal":0}
					var data25TAmt = {"category" : "톤급별운송비", "type1":"운송비대형", "type2":"25톤", "subtotal":0}
					var data20FTAmt = {"category" : "톤급별운송비", "type1":"운송비기타", "type2":"20FT", "subtotal":0}
					var data40FTAmt = {"category" : "톤급별운송비", "type1":"운송비기타", "type2":"40FT", "subtotal":0}
 					var dataETCAmt = {"category" : "톤급별운송비", "type1":"운송비기타", "type2":"기타", "subtotal":0}
					var dataList = [];

					for(var k=0;k<13;k++){
						var str = "0" + k.toString();
						str = str.substring(str.length, str.length-2);
						data["col" + str] = "0";
						allocData["col" + str] = "0</br>0.00%";
						notAllocData["col" + str] = "0</br>0.00%";
						dataTonSum["col" + str] = "0";
						data1T["col" + str] = "0";
						data2T5["col" + str] = "0";
						data3T5["col" + str] = "0";
						data5T["col" + str] = "0";
						data5TA["col" + str] = "0";
						data11T["col" + str] = "0";
						data15T["col" + str] = "0";
						data25T["col" + str] = "0";
						data20FT["col" + str] = "0";
						data40FT["col" + str] = "0";
						dataETC["col" + str] = "0";
						
						dataAmtSum["col" + str] = "0";
						data1TAmt["col" + str] = "0";
						data2T5Amt["col" + str] = "0";
						data3T5Amt["col" + str] = "0";
						data5TAmt["col" + str] = "0";
						data5TAAmt["col" + str] = "0";
						data11TAmt["col" + str] = "0";
						data15TAmt["col" + str] = "0";
						data25TAmt["col" + str] = "0";
						data20FTAmt["col" + str] = "0";
						data40FTAmt["col" + str] = "0";
						dataETCAmt["col" + str] = "0";
					}
					
					for (var item, i=0; item = response.data[i]; i++) {
						var month = item.sDate.substring(7, 5);
						var tonSum = 0;
						var amtSum = 0;
						tonSum += item.cnt1T,
						tonSum += item.cnt2T5;
						tonSum += item.cnt3T5;
						tonSum += item.cnt5T;
						tonSum += item.cnt5A;
						tonSum += item.cnt11T;
						tonSum += item.cnt15T;
						tonSum += item.cnt25T;
						tonSum += item.cnt20FT;
						tonSum += item.cnt40FT;
						tonSum += item.cntETC;
						amtSum += item.amt1T,
						amtSum += item.amt2T5;
						amtSum += item.amt3T5;
						amtSum += item.amt5T;
						amtSum += item.amt5A;
						amtSum += item.amt11T;
						amtSum += item.amt15T;
						amtSum += item.amt25T;
						amtSum += item.amt20FT;
						amtSum += item.amt40FT;
						amtSum += item.amtETC;
						data["col" + month] = Util.formatNumber(item.orderCnt);
						data["subtotal"] = data["subtotal"] + item.orderCnt;
						allocData["subtotal"] = allocData["subtotal"] + item.allocCnt;
						notAllocData["subtotal"] = notAllocData["subtotal"] + item.notAllocCnt;
						dataTonSum["col" + month] = Util.formatNumber(tonSum);
						dataTonSum["subtotal"] = dataTonSum["subtotal"] + tonSum;
						data1T["col" + month] = Util.nvl(Util.formatNumber(item.cnt1T), 0);
						data1T["subtotal"] = data1T["subtotal"] + item.cnt1T;
						data2T5["col" + month] = Util.nvl(Util.formatNumber(item.cnt2T5), 0);
						data2T5["subtotal"] = data2T5["subtotal"] + item.cnt2T5;
						data3T5["col" + month] = Util.nvl(Util.formatNumber(item.cnt3T5), 0);
						data3T5["subtotal"] = data3T5["subtotal"] + item.cnt3T5;
						data5T["col" + month] = Util.nvl(Util.formatNumber(item.cnt5T), 0);
						data5T["subtotal"] = data5T["subtotal"] + item.cnt5T;
						data5TA["col" + month] = Util.nvl(Util.formatNumber(item.cnt5A), 0);
						data5TA["subtotal"] = data5TA["subtotal"] + item.cnt5A;
						data11T["col" + month] = Util.nvl(Util.formatNumber(item.cnt11T), 0);
						data11T["subtotal"] = data11T["subtotal"] + item.cnt11T;
						data15T["col" + month] = Util.nvl(Util.formatNumber(item.cnt15T), 0);
						data15T["subtotal"] = data15T["subtotal"] + item.cnt15T;
						data25T["col" + month] = Util.nvl(Util.formatNumber(item.cnt25T), 0);
						data25T["subtotal"] = data25T["subtotal"] + item.cnt25T;
						data20FT["col" + month] = Util.nvl(Util.formatNumber(item.cnt20FT), 0);
						data20FT["subtotal"] = data20FT["subtotal"] + item.cnt20FT;
						data40FT["col" + month] = Util.nvl(Util.formatNumber(item.cnt40FT), 0);
						data40FT["subtotal"] = data40FT["subtotal"] + item.cnt40FT;
						dataETC["col" + month] = Util.nvl(Util.formatNumber(item.cntETC), 0);
						dataETC["subtotal"] = dataETC["subtotal"] + item.cntETC;
						dataAmtSum["col" + month] = Util.nvl(Util.formatNumber(amtSum), 0);
						dataAmtSum["subtotal"] = dataAmtSum["subtotal"] + amtSum;
						data1TAmt["col" + month] = Util.nvl(Util.formatNumber(item.amt1T), 0);
						data1TAmt["subtotal"] = data1TAmt["subtotal"] + item.amt1T;
						data2T5Amt["col" + month] = Util.nvl(Util.formatNumber(item.amt2T5), 0);
						data2T5Amt["subtotal"] = data2T5Amt["subtotal"] + item.amt2T5;
						data3T5Amt["col" + month] = Util.nvl(Util.formatNumber(item.amt3T5), 0);
						data3T5Amt["subtotal"] = data3T5Amt["subtotal"] + item.amt3T5;
						data5TAmt["col" + month] = Util.nvl(Util.formatNumber(item.amt5T), 0);
						data5TAmt["subtotal"] = data5TAmt["subtotal"] + item.amt5T;
						data5TAAmt["col" + month] = Util.nvl(Util.formatNumber(item.amt5A), 0);
						data5TAAmt["subtotal"] = data5TAAmt["subtotal"] + item.amt5A;
						data11TAmt["col" + month] = Util.nvl(Util.formatNumber(item.amt11T), 0);
						data11TAmt["subtotal"] = data11TAmt["subtotal"] + item.amt11T;
						data15TAmt["col" + month] = Util.nvl(Util.formatNumber(item.amt15T), 0);
						data15TAmt["subtotal"] = data15TAmt["subtotal"] + item.amt15T;
						data25TAmt["col" + month] = Util.nvl(Util.formatNumber(item.amt25T), 0);
						data25TAmt["subtotal"] = data25TAmt["subtotal"] + item.amt25T;
						data20FTAmt["col" + month] = Util.nvl(Util.formatNumber(item.amt20FT), 0);
						data20FTAmt["subtotal"] = data20FTAmt["subtotal"] + item.amt20FT;
						data40FTAmt["col" + month] = Util.nvl(Util.formatNumber(item.amt40FT), 0);
						data40FTAmt["subtotal"] = data40FTAmt["subtotal"] + item.amt40FT;
						dataETCAmt["col" + month] = Util.nvl(Util.formatNumber(item.amtETC), 0);
						dataETCAmt["subtotal"] = dataETCAmt["subtotal"] + item.amtETC;
					}
					
					for (var item, i=0; item = response.data[i]; i++) {
						var month = item.sDate.substring(7, 5);
						var orderSum = data["col" + month];
						if(item.allocCnt != "0"){
		 					allocData["col" + month] = Util.formatNumber(item.allocCnt + "</br>" + (item.allocCnt / orderSum * 100).toFixed(2) + "%");
						}else{
							allocData["col" + month] = Util.formatNumber(item.allocCnt + "</br>" + "0.00%");
						}
						
	 					if(item.notAllocCnt != "0"){
		 					notAllocData["col" + month] = Util.formatNumber(item.notAllocCnt + "<br>" + (item.notAllocCnt / orderSum * 100).toFixed(2) + "%");
	 					}else{
	 						notAllocData["col" + month] = Util.formatNumber(item.notAllocCnt + "<br>" + "0.00%");
	 					}
					}
					var allocCntSum = allocData["subtotal"];
					var notAllocCntSum = notAllocData["subtotal"];
					
					if(allocCntSum != "0"){
						allocData["subtotal"] = allocCntSum + "<br>" + (allocCntSum / (allocCntSum + notAllocCntSum) * 100).toFixed(2) + "%";
					}else{
						allocData["subtotal"] = allocCntSum + "<br>" + "0.00%";
					}
					if(notAllocCntSum != "0"){
						notAllocData["subtotal"] = notAllocCntSum + "<br>" + (notAllocCntSum / (allocCntSum + notAllocCntSum) * 100).toFixed(2) + "%";
					}else{
						notAllocData["subtotal"] = notAllocCntSum + "<br>" + "0.00%"
					}
					
					dataList.push(data);
					dataList.push(allocData);
					dataList.push(notAllocData);
					dataList.push(dataTonSum);
					dataList.push(data1T);
					dataList.push(data2T5);
					dataList.push(data3T5);
					dataList.push(data5T);
					dataList.push(data5TA);
					dataList.push(data11T);
					dataList.push(data15T);
					dataList.push(data25T);
					dataList.push(data20FT);
					dataList.push(data40FT);
					dataList.push(dataETC);
					dataList.push(dataAmtSum);
					dataList.push(data1TAmt);
					dataList.push(data2T5Amt);
					dataList.push(data3T5Amt);
					dataList.push(data5TAmt);
					dataList.push(data5TAAmt);
					dataList.push(data11TAmt);
					dataList.push(data15TAmt);
					dataList.push(data25TAmt);
					dataList.push(data20FTAmt);
					dataList.push(data40FTAmt);
					dataList.push(dataETCAmt);
					return dataList;
				}
			},
			serverPaging : false,
			serverFiltering : true,
			error : function(e) {
				if(e.xhr.status == "400") {
					alert("세션값이 존재하지 않습니다. 로그인 페이지로 이동합니다.");
					location.href = "/";
				}
			}
		},
		excel: {
			fileName: "배차및운송비(월)(" + new Date().yyyymmdd() + ").xlsx",
			proxyURL: "/cmm/saveGrid.do",
			filterable: false,
			allPages: true
		},
		excelExport: function(e) {
			if($("#loading").length > 0) $("#loading").hide();
		},
		navigatable: true,
        selectable: true,
		sortable : false,
		pageable : false,
        resizable: true,
        scrollable: true,
        editable : false,
		columns : columns,
    	noRecords: true,
	  	messages: {
			noRecords: "조회된 데이터가 없습니다."
	  	}
	});

	var grid = $("#grid").data("kendoGrid");
	grid.bind("dataBound", grid_dataBound);
}

function grid_dataBound(e) {
  	var rows = e.sender.lockedTable[0].children[1].children
	var cells = e.sender.table[0].children[1].children
	var gridCellClassName;
	
	colSpan("typeMerge");
  	for (var i = 0; i < rows.length; i++) {
    	var row = $(rows[i]);
   		categoryCells = row.children().eq(0);
   		type1Cells = row.children().eq(1);
   		type2Cells = row.children().eq(2);
   		
   		if(type2Cells[0].innerText == '전체오더' || type2Cells[0].innerText == '배차대수합계' || type2Cells[0].innerText == '운송비합계') {
   			type2Cells.addClass(gridAddClass(type2Cells[0].innerText, 'colspan'));
   		}
   		categoryCells.addClass(gridAddClass(categoryCells[0].innerText, "category"));
   		type1Cells.addClass(gridAddClass(type1Cells[0].innerText, "type1"));
   		if(type1Cells[0].innerText.includes("운송비")){
   			row.children().eq(3).addClass("charge");
   		}
  	}
  	for (var i = 15; i < cells.length; i++) {
  		var cell = $(cells[i]);
  		for(var j=0; j<cell[0].children.length; j++){
	  		cell.children().eq(j).addClass("charge");
  		}
  	}
}

function gridAddClass(className, mode) {
	if(mode != 'colspan'){
		rowSpan(className)
		return className;
	}else{
		colSpan(className)
		return className;
	}
}

function rowSpan(className){
	setTimeout(function() {
		$("." + className).each(function() {
	        var rows = $("." + className + ":contains('" + $(this).text() + "')");
	        if (rows.length > 1) {
	    	    $("." + className).parent("tr").css({"border":"solid"})
	        	rows.not(":eq(0)").remove(); 
	            rows.eq(0).attr("rowspan", rows.length);
	            $("." + className).css({"box-shadow":"rgb(213 213 213) 1px 0px 0px 0px"});
	        }
	    });
		if($("." + className).text() == '배차대수소형' ||
		   $("." + className).text() == '배차대수중형' ||
		   $("." + className).text() == '배차대수대형' ||
		   $("." + className).text() == '배차대수기타' ||
		   $("." + className).text() == '운송비소형' ||
		   $("." + className).text() == '운송비중형' ||
		   $("." + className).text() == '운송비대형' ||
		   $("." + className).text() == '운송비기타'){
			$("." + className).text($("." + className).text().slice(-2));
		}
		
		if($("." + className).text() == "톤급별배차대수"){
			$("." + className).text("톤급별 배차대수");
		} 
		
		if($("." + className).text() == "톤급별운송비"){
			$("." + className).text("톤급별 운송비");
		} 
	}, 10);
}

function colSpan(className){
	setTimeout(function() {
		$("." + className).each(function() {
	        var rows = $("." + className + ":contains('" + $(this).text() + "')");
	        if (rows.length > 1) {
	        	rows.not(":eq(0)").remove(); 
	            rows.eq(0).attr("colspan", rows.length);
	        }
	    });
		if($("." + className).text() != "전체오더"){
			$("." + className).text('합계');
		}
	}, 10);
}

function selectSearchCust(e) {
	var dataItem = e.dataItem;
	if(dataItem != null) {
		$("#custId").val(dataItem.custId);
		$("#deptId").val(dataItem.deptId);
	}else{
		if(e.sender.selectedIndex != -1){
			searchCustName.select(e.sender.selectedIndex);
			var data = e.sender.listView._view[e.sender.selectedIndex];
			$("#custId").val(data.item.custId);
			$("#deptId").val(data.item.deptId);
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

function openSearchCust(e){
	searchCustName.value("");
	searchCustName.refresh();
	$(".hiddenValue").val("");
}

function goExcel(){
	$("#loading").show();
	var grid = $("#grid").data("kendoGrid");
	grid.saveAsExcel();
}
</script>