<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.sum {background: #FAFAD2}
</style>
<div class="header">
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">운임분석</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" name="fSearch" class="date-bnt" method="post">
				<div class="form-group row mt0">
					<input type="hidden" name="searchType" id="searchType">
					<div class="input-group input-group-sm wd90 middle-name">
					    <input style="padding: 0;" type="text" id="fromDate" name="fromDate" class="wd90">
					</div>
					<span>~</span>
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
					    <input style="padding: 0;" type="text" id="toDate" name="toDate" class="wd90">
					</div>
					
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
					    <select class="form-control" class="custom-select wd90" id="sSido" name="sSido"></select>
	                </div>
	                
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
					    <select id="sGungu" name="sGungu" class="form-control form-control-sm">
	                  		<option value="" selected="selected">군/구</option>
	                  		<option>출발지역 시/도 를 선택해 주세요.</option>
	                  	</select>
	                </div>
	                
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="form-control" class="custom-select wd90" id="eSido" name="eSido"></select>
	                </div>
	                
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
					    <select id="eGungu" name="eGungu" class="form-control form-control-sm">
	                  		<option value="" selected="selected">군/구</option>
	                  		<option>도착지역 시/도 를 선택해 주세요.</option>
	                  	</select>
	                </div> 
	                
					<div class="input-group input-group-sm wd120 middle-name div-min-col-1">
					    <select class="form-control custom-select" style="width: 100%" id="carContractCode" name="carContractCode"></select>
	                </div>
	                
	                <div class="input-group input-group-sm wd120 middle-name div-min-col-1">
					    <select class="form-control custom-select wd120" id="carTypeName" name="carTypeName">
					    	<option value="" selected="selected">차종</option>					    	
					    </select>
	                </div>
	                
	                <div class="input-group input-group-sm wd110 middle-name div-min-col-1">
					    <select class="form-control custom-select wd110" id="itemCode" name="itemCode"></select>
	                </div>
	                
	                <div class="input-group input-group-sm wd90 middle-name div-min-col-1">
					    <select id="weightTypeCode" name="weightTypeCode" class="form-control" class="custom-select wd90">
					    	<option value="" selected="selected">중량물구분</option>
					    	<option value="01">경량물</option>
					    	<option value="02">표준물</option>
					    	<option value="03">중량물</option>
					    </select>
	                </div>
	                
	                <div class="input-group input-group-sm wd110 middle-name div-min-col-1">
					    <select id="arrivalTimeCode" name="arrivalTimeCode" class="form-control custom-select" style="width: 100%">
					    	<option value="" selected="selected">운송소요시간</option>
					    	<option value="01">당착</option>
					    	<option value="02">익착</option>
					    </select>
	                </div>
                </div>
                
				<div class="form-group row" style="justify-content: space-between">
	                <div class="row">
						<!--
						<div class="middle-name" style="width: 0px; padding: 0em 0em 0em 0.3em;">
							<strong>면허요건</strong>
						</div>
						-->
						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="checkbox" name="general" id="general" value="Y" checked/>
							<label for="general" class="label-margin">
								<span>일반</span>
							</label>
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="checkbox" name="dangerGoodsYn" id="dangerGoodsYn" value="Y"/>
							<label for="dangerGoodsYn" class="label-margin">
								<span>위험물</span>
							</label>
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="checkbox" name="chemicalsYn" id="chemicalsYn" value="Y"/>
							<label for="chemicalsYn" class="label-margin">
								<span>유해물</span>
							</label>
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="checkbox" name="foreignLicenseYn" id="foreignLicenseYn" value="Y"/>
							<label for="foreignLicenseYn" class="label-margin">
								<span>보세운송</span>
							</label>
						</div>

						<div class="middle-name" style="width: 0px; padding: 0em 0em 0em 0.3em;">
							<strong>조회조건</strong>
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="checkbox" name="our" id="our" value="Y" checked/>
							<label for="our" class="label-margin">
								<span>당사</span>
							</label>
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="checkbox" name="other" id="other" value="Y"/>
							<label for="other" class="label-margin">
								<span>타사</span>
							</label>
						</div>
					</div>

					<div class="tool_group">
						<div class="padding">
							<a href="#" class="k-pager-refresh k-button" onClick="goList('mode')"><b class="btn-b">최빈값</b></a>
							<a href="#" class="k-pager-refresh k-button" onClick="goList('modeAll')"><b class="btn-b">최빈값(all)</b></a>
							<a href="#" class="k-pager-refresh k-button" onClick="goList('avg')"><b class="btn-b">평균값</b></a>
							<a href="#" class="k-pager-refresh k-button" onClick="goList('avgAll')"><b class="btn-b">평균값(all)</b></a>
							<a href="#" class="k-pager-refresh k-button" onClick="goList('min')"><b class="btn-b">최소값</b></a>
							<a href="#" class="k-pager-refresh k-button" onClick="goList('max')"><b class="btn-b">최대값</b></a>
							<a href="#" class="k-pager-refresh k-button" onClick="goExcel();"><b class="btn-x">엑셀출력</b></a>
						</div>
					</div>
                </div>
                
				<div class="form-group row" style="padding: 0.625em 0em 0.625em 0em;height: 48px">
				    <table id="simpleDataRow">
				        <thead>
				            <tr>
				                <th>최빈값 결과</th>
				                <th><span>배차소요 : </span><span id="dispatchTime"></span></th>
				                <th><span>상차대기 : </span><span id="loadTime"></span></th>
				                <th><span>하차대기 : </span><span id="unloadTime"></span></th>
				                <th><span>당착비율 : </span><span id="toDayArriveRatio"></span></th>
				            </tr>
				        </thead>
				    </table>
				</div>
				<div id="grid" style="height:calc(100vh - 250px)"></div>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
var headerTitle = ($("#headerTitle").text());

var carTypeList = "카고,윙바디,탑,호퍼/벌크,카고/윙바디/축,기타".split(",");
var carTonList = "1T,2T5,3T5,5T,5A,11T,15T,25T,20FT,40FT".split(",");
var carTonNameList = "1톤(1.4톤포함),2.5톤,3.5톤,5톤,5톤축,11톤,15톤,25톤,20FT,40FT".split(",");
var chargeColList = [];
var cntColList = [];
var chargeCol, cntCol;

$(document).ready(function(){
    Util.setCmmCode("select", "sSido", "SIDO", "", "출발 시/도");
	$('#sSido').on('change', function() {
		Util.setSelectBox("/cmm/getAreaCodeList.do", "sGungu", {sido:$("#sSido option:checked").text()}, "sigun", "sigun", "", "군/구");
	});
    Util.setCmmCode("select", "eSido", "SIDO", "", "도착 시/도");
	$('#eSido').on('change', function() {
		Util.setSelectBox("/cmm/getAreaCodeList.do", "eGungu", {sido:$("#eSido option:checked").text()}, "sigun", "sigun", "", "군/구");
	});
	Util.setCmmCode("select", "carContractCode", "CAR_CONTRACT_CD", "", "차주계약유형");
	Util.setCmmCode("select", "itemCode", "ITEM_CD", "", "운송품목");
		
	var toDay = new Date();
	var year = toDay.getFullYear();
	var month = toDay.getMonth();
	var day = toDay.getDate();
	var yesterDay = new Date(year, month, day - 7)
	
	$("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : "2019-01-01", dateInput: true});
	$("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : yesterDay, dateInput: true}); 

    $("#simpleDataRow").kendoGrid({
        height: 0,
        sortable: false,
       	scrollable: false
    });
    
	//차종 select option 값 세팅
	var option = "";
	for (var i=0; i<carTypeList.length; i++) {
		option += "<option value=\"" + carTypeList[i] + "\">" + carTypeList[i] + "</option>";
	}
	$("#carTypeName").append(option);
	
	for (var i=0; i<carTonList.length; i++) {
		chargeCol = { field: "charge" + carTonList[i], title: carTonNameList[i], width: 120};
		cntCol = { field: "cnt" + carTonList[i], title: carTonNameList[i], width: 120};
		
		chargeColList.push(chargeCol);
		cntColList.push(cntCol);
	}
    
	goList("mode");
});

function goList(searchType){
	var sSido = $("#sSido option:checked").val();
	var eSido = $("#eSido option:checked").val();
	var sGungu = $("#sGungu option:checked").val();
	var eGungu = $("#eGungu option:checked").val();
	
	var selectedCarType = $("#carTypeName").val();
	if(selectedCarType) {
		carTypeList = selectedCarType.split(",");
	} else {
		carTypeList = "카고,윙바디,탑,호퍼/벌크,카고/윙바디/축,기타,소계".split(",");
	}
	
	$("#searchType").val(searchType);	
	if($("#grid").text() != ""){
		if(sSido == "" || sGungu == ""){
			alert("출발지역을 선택해주세요.");
			return;
		}
	}
	
 	$("#grid").text("");
	$("#grid").kendoGrid({
		dataSource: {
			transport: {
				read: {
					url: "/contents/analysis/data/freight.do",
					type: "POST",
					dataType: "json",
					data: $("#fSearch").serializeObject(),
					beforeSend: function(req) {
						req.setRequestHeader("AJAX", true);
					}
				}
			},
			schema: {
				data: function(response) {
					var data = {};
					var dataList = [];
					
					if(response.stat.length > 0) {
						var stat = response.stat[0];
						$("#dispatchTime").html(stat.allocAvg + "Hr");
						$("#loadTime").html(stat.sAvg + "Hr");
						$("#unloadTime").html(stat.eAvg + "Hr");
						$("#toDayArriveRatio").html(stat.arrivalPercentage + "%");	
					}
					for(var i=0, item; item=response.area[i]; i++) {
						for(var j=0; j<carTypeList.length; j++) {
							data = {"carType" : carTypeList[j]};
							data["sArea"] = item.sSido + (item.sGungu == null ? "" : " " + item.sGungu);
							data["eArea"] = item.eSido + (item.eGungu == null ? "" : " " + item.eGungu);
							
							// 모든 필드값 0으로 초기화
							for(var k=0; k<carTonList.length; k++) {
								data["charge" + carTonList[k]] = 0;
								data["cnt" + carTonList[k]] = 0;
							}
							
							for(var k=0, item2; item2=response.data[k]; k++) {
								if (item.eSido == item2.eSido && item.eGungu == item2.eGungu && carTypeList[j] == item2.carTypeName){
									data["charge" + item2.carTonCode] = Util.formatNumber(item2.allocCharge);
									data["cnt" + item2.carTonCode] = Util.formatNumber(item2.allocCount);
								}
								if (item.eSido == item2.eSido && item.eGungu == item2.eGungu && carTypeList[j] == "소계"){
									data["charge" + item2.carTonCode] += item2.allocCharge;
									data["cnt" + item2.carTonCode] += item2.allocCount;
								}
							}
							if(data.carType == "소계"){
								for(var h in data){
									if(typeof(data[h]) == "number"){
										if(data[h] != 0){
											data[h] = Util.formatNumber(data[h]);
										}
									}
								}
							}
							dataList.push(data);
						}
					}
					return dataList;
				}
			}
		},
		excel: {
			fileName: headerTitle+"(" + new Date().yyyymmdd() + ").xlsx",
			proxyURL: "/cmm/saveGrid.do",
			filterable: false,
			allPages: true
		},
		excelExport: function(e) {
			if($("#loading").length > 0) $("#loading").hide();
		},
		sortable: false,
		reorderable: true,
		groupable: false,
		resizable: true,
		filterable: false,
		selectable: false,
		columnMenu: false,
		pageable: false,
		columns: [
			{	
				title: '구간',
				columns: [
					{ field: "sArea", title: "출발지역", width: 100},
					{ field: "eArea", title: "도착지역", width: 100},
				]
			},
			{ field: "carType", title: "차종", width: 100,
				headerAttributes: {style: "vertical-align: middle"}
			},
			{	
				title: '톤급별 기사 순수운임',
				columns: chargeColList
			},
			{	
				title: '산정 데이터 수',
				columns: cntColList
			}
		]
	}); 
	var grid = $("#grid").data("kendoGrid");
	grid.bind("dataBound", grid_dataBound);
}

function grid_dataBound(e) {
	var rows = e.sender.tbody.children();
	var row_len = rows.length;
	for (var j = 0; j < row_len; j++) {
	    var row = $(rows[j]);
	    var dataItem = e.sender.dataItem(row);
	  	var cells = row.children();	  
	    if (dataItem.get("carType") == "소계"){
	    	cells.each(function(i){
	    		cells.addClass("sum");
	    	});
	    }
	}
}

function goExcel(){
	var grid = $("#grid").data("kendoGrid");
	grid.saveAsExcel();
}

$('#general').click(function(){
	var ischecked = $(this).is(':checked');
	if(ischecked){
		$('input:checkbox[name=dangerGoodsYn]').attr('checked', false);
		$('input:checkbox[name=chemicalsYn]').attr('checked', false);
		$('input:checkbox[name=foreignLicenseYn]').attr('checked', false);
	}
});

$('#dangerGoodsYn, #chemicalsYn, #foreignLicenseYn').click(function(){
	var ischecked = $(this).is(':checked');
	if(ischecked){
		$('input:checkbox[name=general]').attr('checked', false);
	}
});
</script>