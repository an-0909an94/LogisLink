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
</style>

<div class="text-center" id="loading" style="display:none;">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>

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
				
				<div class="input-group-sm middle-name div-min-col-1 wd90" style="margin:0 10px">
				    <select class="form-control" class="custom-select col-12" id="reqDeptId" name="reqDeptId"></select>
				</div>
				
				<div class="input-group input-group-sm col-2 middle-name" style="margin:0 10px 0 0">
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
					<div style="float:left;margin-top:30px;">(단위:건 or %)</div>
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
					url : "/oms/indicators/data/kpiMonth.do",
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
					var data = {"category" : "오더현황", "type1":"전체오더", "type2":"전체오더", "subtotal":0};			//전체오더
					var preData = {"category" : "오더현황", "type1":"사전오더", "type2":"소계", "subtotal":0};		//사전오더
					var postData = {"category" : "오더현황", "type1":"당일오더", "type2":"소계", "subtotal":0};		//당일오더
					var todayData = {"category" : "오더현황", "type1":"당일오더", "type2":"당착", "subtotal":0};		//당착오더
					var tomorrowData = {"category" : "오더현황", "type1":"당일오더", "type2":"익착", "subtotal":0};	//익착오더
					var allocData = {"category" : "배차KPI", "type1":"책임배차", "type2":"미준수", "subtotal":0};		//책임배차미준수
					var enterData = {"category" : "배차KPI", "type1":"입차준수", "type2":"미준수", "subtotal":0};		//입차미순수
					var finishData = {"category" : "배차KPI", "type1":"도착준수", "type2":"미준수", "subtotal":0};	//도착미준수
					var dataList = [];

					for(var k=0;k<13;k++){
						var str = "0" + k.toString();
						str = str.substring(str.length, str.length-2);
						data["col" + str] = "0";
						preData["col" + str] = "0</br>0.00%";
						postData["col" + str] = "0</br>0.00%";
						todayData["col" + str] = "0</br>0.00%";
						tomorrowData["col" + str] = "0</br>0.00%";
						allocData["col" + str] = "0</br>0.00%";
						enterData["col" + str] = "0</br>0.00%";
						finishData["col" + str] = "0</br>0.00%";
					}
					for (var item, i=0; item = response.data[i]; i++) {
						var month = item.sDate.substring(7, 5);
						data["col" + month] = item.allocCnt;
						data["subtotal"] = data["subtotal"] + item.allocCnt;
						preData["subtotal"] = preData["subtotal"] + item.preOrder;
						postData["subtotal"] = postData["subtotal"] + item.postOrder;
						todayData["subtotal"] = todayData["subtotal"] + item.todayFinish;
						tomorrowData["subtotal"] = tomorrowData["subtotal"] + item.tomorrowFinish;
						allocData["subtotal"] = allocData["subtotal"] + item.allocDelay;
						enterData["subtotal"] = enterData["subtotal"] + item.enterDelay;
						finishData["subtotal"] = finishData["subtotal"] + item.finishDelay;
					}

					for (var item, i=0; item = response.data[i]; i++) {
						var month = item.sDate.substring(7, 5);
						var orderSum = data["col" + month];
						if(item.preOrder != "0"){
							preData["col" + month] = Util.formatNumber(item.preOrder + "</br>" + (item.preOrder / orderSum * 100).toFixed(2) + "%");
						}else{
							preData["col" + month] = Util.formatNumber(item.preOrder + "</br>" + "0.00%");
						}
						
						if(item.postOrder != "0"){
							postData["col" + month] = Util.formatNumber(item.postOrder + "</br>" + (item.postOrder / orderSum * 100).toFixed(2) + "%");
						}else{
							postData["col" + month] = Util.formatNumber(item.postOrder + "</br>" + "0.00%");
						}
						
						if(item.todayFinish != "0"){
							todayData["col" + month] = Util.formatNumber(item.todayFinish + "</br>" + (item.todayFinish / (item.tomorrowFinish + item.todayFinish) * 100).toFixed(2) + "%");
						}else{
							todayData["col" + month] = Util.formatNumber(item.todayFinish + "</br>" + "0.00%");
						}
						
						if(item.tomorrowFinish != "0"){
							tomorrowData["col" + month] = Util.formatNumber(item.tomorrowFinish + "</br>" + (item.tomorrowFinish / (item.tomorrowFinish + item.todayFinish) * 100).toFixed(2) + "%");
						}else{
							tomorrowData["col" + month] = Util.formatNumber(item.tomorrowFinish + "</br>" + "0.00%");
						}
						
						if(item.allocDelay != "0"){
							allocData["col" + month] = Util.formatNumber(item.allocDelay + "</br>" + (item.allocDelay / orderSum * 100).toFixed(2) + "%");
						}else{
							allocData["col" + month] = Util.formatNumber(item.allocDelay + "</br>" + "0.00%");
						}
						
						if(item.enterDelay != "0"){
							enterData["col" + month] = Util.formatNumber(item.enterDelay + "</br>" + (item.enterDelay / orderSum * 100).toFixed(2) + "%");
						}else{
							enterData["col" + month] = Util.formatNumber(item.enterDelay + "</br>" + "0.00%");
						}
						
						if(item.finishDelay != "0"){
							finishData["col" + month] = Util.formatNumber(item.finishDelay + "</br>" + (item.finishDelay / orderSum * 100).toFixed(2) + "%");
						}else{
							finishData["col" + month] = Util.formatNumber(item.finishDelay + "</br>" + "0.00%");
						}
					}
					var totalSum = data["subtotal"]
					var preOrderSum = preData["subtotal"];
					var postOrderSum = postData["subtotal"];
					var todayOrderSum = todayData["subtotal"];
					var tomorrowOrderSum = tomorrowData["subtotal"];
					var allocOrderSum = allocData["subtotal"];
					var enterOrderSum = enterData["subtotal"];
					var finishOrderSum = finishData["subtotal"];
					
					if(preOrderSum != "0"){
						preData["subtotal"] = preOrderSum + "<br>" + (preOrderSum / totalSum * 100).toFixed(2) + "%";
					}else{
						preData["subtotal"] = preOrderSum + "<br>" + "0.00%";
					}
					
					if(postOrderSum != "0"){
						postData["subtotal"] = postOrderSum + "<br>" + (postOrderSum / totalSum * 100).toFixed(2) + "%";
					}else{
						postData["subtotal"] = postOrderSum + "<br>" + "0.00%";
					}
					
					if(todayOrderSum != "0"){
						todayData["subtotal"] = todayOrderSum + "<br>" + (todayOrderSum / (todayOrderSum + tomorrowOrderSum) * 100).toFixed(2) + "%";
					}else{
						todayData["subtotal"] = todayOrderSum + "<br>" + "0.00%";
					}
					
					if(tomorrowOrderSum != "0"){
						tomorrowData["subtotal"] = tomorrowOrderSum + "<br>" + (tomorrowOrderSum / (todayOrderSum + tomorrowOrderSum) * 100).toFixed(2) + "%";
					}else{
						tomorrowData["subtotal"] = tomorrowOrderSum + "<br>" + "0.00%";
					}
					
					if(allocOrderSum != "0"){
						allocData["subtotal"] = allocOrderSum + "<br>" + (allocOrderSum / totalSum * 100).toFixed(2) + "%";
					}else{
						allocData["subtotal"] = allocOrderSum + "<br>" + "0.00%";
					}
					
					if(enterOrderSum != "0"){
						enterData["subtotal"] = enterOrderSum + "<br>" + (enterOrderSum / totalSum * 100).toFixed(2) + "%";
					}else{
						enterData["subtotal"] = enterOrderSum + "<br>" + "0.00%";
					}
					
					if(finishOrderSum != "0"){
						finishData["subtotal"] = finishOrderSum + "<br>" + (finishOrderSum / totalSum * 100).toFixed(2) + "%";
					}else{
						finishData["subtotal"] = finishOrderSum + "<br>" + "0.00%";
					}
					
					dataList.push(data);
					dataList.push(preData);
					dataList.push(postData);
					dataList.push(todayData);
					dataList.push(tomorrowData);
					dataList.push(allocData);
					dataList.push(enterData);
					dataList.push(finishData);
					
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
			fileName: "KPI(월)(" + new Date().yyyymmdd() + ").xlsx",
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
	var cells;
	var gridCellClassName;
	
	colSpan("typeMerge");
  	for (var i = 0; i < rows.length; i++) {
    	var row = $(rows[i]);
   		categoryCells = row.children().eq(0);
   		type1Cells = row.children().eq(1);
   		type2Cells = row.children().eq(2);
   		
   		if(type2Cells[0].innerText == '전체오더') {
   			type2Cells.addClass(gridAddClass(type2Cells[0].innerText, 'colspan'));
   		}
   		categoryCells.addClass(gridAddClass(categoryCells[0].innerText, "category"));
   		type1Cells.addClass(gridAddClass(type1Cells[0].innerText, "type1"));
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

function goExcel(){
	$("#loading").show();
	var grid = $("#grid").data("kendoGrid");
	grid.saveAsExcel();
}
</script>