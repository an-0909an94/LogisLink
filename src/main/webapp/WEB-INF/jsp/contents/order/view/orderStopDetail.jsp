<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" type="text/css" href="/css/style_V2.css">

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&amp;display=swap" rel="stylesheet">
<div class="pop-layer">
    <div class="editor_wrap pop-layer" id="layer1">
        <!-- wrap -->
        <div class="k-layout-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
                    <div class="editor">
                        <form id="fStop" name="fStop" method="post">
                        	<input type="hidden" name="orderId" id="orderId" value="${param.orderId}">
                        	<input type="hidden" name="deptId" id="deptId" value="${param.deptId}">
                        	<input type="hidden" name="stopSeq" id="stopSeq">
                            <fieldset>
                                <legend style="text-align: center;">경유지</legend>
                                	<div class="form-group row">
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong>상,하차 구분</strong>
                                    	<select class="form-control" class="custom-select col-12" id="stopSe" name="stopSe" required>
                                    		<option value="S">상차지</option>
                                    		<option value="E">하차지</option>
                                    	</select>
                                        <div class="help-block with-errors"></div>
                                        <!-- <select class="custom-select col-12">
                                            <option>하차지명</option>
                                            <option></option>
                                        </select> -->
                                    </div>
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong>경유지명(검색)</strong>
                                    	<input type="text" name="eComName" id="eComName" style="width: 100%;">
                                    	<input type="hidden" name="eLat" id="eLat">
                                    	<input type="hidden" name="eLon" id="eLon">
                                        <div class="help-block with-errors"></div>
                                        <!-- <select class="custom-select col-12">
                                            <option>하차지명</option>
                                            <option></option>
                                        </select> -->
                                    </div>
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong>주소(검색)</strong>
                                        <div class="textBox-in-icon">
	                                        <input onClick="popSearchPost('');" type="text" id="eAddr" name="eAddr" class="form-control form-control-sm" readonly="readonly">
										<i><img onclick="popSearchPost('');" src="/images/icon/search.png"></i>
										</div>
                                    </div>
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong>상세주소</strong>
                                        <input type="text" id="eAddrDetail" name="eAddrDetail" class="form-control form-control-sm">
                                    </div>
                                </div>
                                <div class="form-group row pb30">
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong>담당자</strong>
                                        <input type="text" id="eStaff" name="eStaff" class="form-control form-control-sm">
                                    </div>
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong>담당자연락처</strong>
                                        <input type="text" id="eTel" name="eTel" maxlength="13" class="form-control form-control-sm">
                                    </div>
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong>중량</strong>
                                        <input type="text" id="goodsWeight" name="goodsWeight" class="form-control form-control-sm">
                                    </div>
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong>　</strong>
                                    	<select class="custom-select col-12" id="weightUnitCode" name="weightUnitCode" disabled>
                                        </select>
                                    </div>
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong>수량</strong>
                                        <input type="text" class="form-control form-control-sm" id="goodsQty" name="goodsQty">
                                    </div>
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong>　</strong>
                                        <select class="custom-select col-12" id="qtyUnitCode" name="qtyUnitCode">
                                        </select>
                                    </div>
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong>품명</strong>
                                        <input type="text" class="form-control form-control-sm" id="goodsName" name="goodsName">
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                        <div class="editor_btns pb30" style="text-align:right;">
                        	<div class="padding">
						        <a onclick="javascript:addData();" class="btn_b k-pager-refresh k-button"><b id="btn_add" class="btn-b">추가</b></a>
						        <a onclick="javascript:removeData();" class="k-pager-refresh k-button"><b class="btn-b">삭제</b></a>
					        </div>
					    </div>
                       	<div id="gridPop" style="min-width:818px; height: 387px;"></div>
                    </div>
                    <!-- editor -->
                </div>
            </div><!-- content -->
        </div>
    </div><!-- wrap -->
</div>

<script type="text/x-kendo-template" id="template">
	<div class="toolbar row" >
		<a class="btn_b k-pager-refresh k-button" onClick="saveData()">등록</a>
	</div>
</script>

<script type="text/javascript">
var delList = [];
var columns = [
 	{ field: "stopSeq", title: "seq", hidden: true},
 	{ field: "orderId", title: "seq", hidden: true},
	{ field: "stopSe", hidden: true},
	{ field: "stopSeNm", title: "상하차구분", 
		template: "#if(stopSe == 'S') {# 상차지 #} else {# 하차지 #} #"	
	},
	{ field: "eComName", title: "경유지명", width:130},
	{ field: "eAddr", title: "주소"},
	{ field: "eAddrDetail", title: "상세주소"},
	{ field: "eStaff", title: "담당자"},
	{ field: "eTel", title: "연락처"},
	{ field: "goodsWeight", title: "중량"},
	{ field: "weightUnitCode", title: "중량단위"},
	{ field: "goodsQty", title: "수량"},
	{ field: "qtyUnitCode", title: "수량단위"},
	{ field: "eLat", title: "위도", hidden:true },
	{ field: "eLon", title: "경도", hidden:true },
	{ field: "useYn", title: "사용여부", hidden: true },
	{ field: "finishYn", hidden: true},
	{ field: "finishDate", hidden: true},
	{ title: "도착", template: "#if(finishYn == 'Y'){# #=finishDate# #} else if (finishYn == 'N') {#<button type'button' class='k-pager-refresh k-button' onClick='goFinish(this);'><i class='k-icon k-i-success'></i>도착</button>#} else {#  #}#"}
];
/* 
var oGrid = null;
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/contents/order/data/orderStopList.do");
oGrid.setPageable(false);

 */
 var pEComName;
  
$(document).ready(function(){
	Util.setCmmCode("select", "weightUnitCode", "WGT_UNIT_CD", "TON", "선택하세요");
	Util.setCmmCode("select", "qtyUnitCode", "QTY_UNIT_CD", "", "선택하세요");

	$("#eTel").on("input", function(){
		$(this).val(Util.formatPhone($(this).val()));
	});
	
	$("#gridPop").kendoGrid({
		sortable: true,
		reorderable: true,
		groupable: false,
		resizable: true,
		scrollable: true,
		selectable: true,
		pageable: false,
		columns: columns,
		//dataSource: dataSource,
		change: onChange,
		toolbar: kendo.template($("#template").html())
	}); 
	
	pEComName = $("#fStop input[name=eComName]").kendoMultiColumnComboBox({
		dataTextField: "addrName",
		dataValueField: "addrName",
		filter: "contains",
		minLength: 2,
		autoBind: true,
		dataSource: {
			serverFiltering: true,
			transport: {
				read : {
					url: "/contents/basic/data/custAddrList.do",
					dataType: "json",
					type: "post",
					data: {
						useYn : "Y",
						deptId: $("#deptId").val()
					},
					beforeSend: function(req) {
						req.setRequestHeader("AJAX", true);
					}
				}
			},
			schema : {
				data : function(response) {
					return response.data;
				},
				total : function(response) {
					return response.total;
				}
			}
		},
		select: function(e) {
			var dataItem = e.dataItem;
			if(dataItem != null) {
				$("#fStop input[name=eAddr]").val(dataItem.addr);
				$("#fStop input[name=eAddrDetail]").val(dataItem.addrDetail);
				$("#fStop input[name=eStaff]").val(dataItem.staffName);
				$("#fStop input[name=eTel]").val(Util.formatPhone(dataItem.staffTel));
				$("#fStop input[name=eMemo]").val(dataItem.orderMemo);
				$("#fStop input[name=eLat]").val(dataItem.lat);
				$("#fStop input[name=eLon]").val(dataItem.lon);
			}else{
				if(e.sender.selectedIndex != -1){
					pEComName.select(e.sender.selectedIndex);
					var data = e.sender.listView._view[e.sender.selectedIndex];
					$("#fStop input[name=eAddr]").val(data.item.addr);
					$("#fStop input[name=eAddrDetail]").val(data.item.addrDetail);
					$("#fStop input[name=eStaff]").val(data.item.staffName);
					$("#fStop input[name=eTel]").val(Util.formatPhone(data.item.staffTel));
					$("#fStop input[name=eMemo]").val(data.item.orderMemo);
					$("#fStop input[name=eLat]").val(data.item.lat);
					$("#fStop input[name=eLon]").val(data.item.lon);
				}
			}
		},
		change: function(e){
			if(this.value() != ""){
				pEComName.trigger("select");
			}else{
				$("#fStop input[name=eAddr]").val("");
				$("#fStop input[name=eAddrDetail]").val("");
				$("#fStop input[name=eStaff]").val("");
				$("#fStop input[name=eTel]").val("");
				$("#fStop input[name=eMemo]").val("");
				$("#fStop input[name=eLat]").val("");
				$("#fStop input[name=eLon]").val("");
			}
		},
		columns: [
			{field: "addrName", title: "주소지명", width:160},
			{field: "addr", title: "주소", width:100},
			{field: "addrDetail", title: "상세주소", width:100},
			
		]
	}).data("kendoMultiColumnComboBox");	
	
	getOrderStopData();
});

function onChange(e) {
	var selectedRow = this.select();
	var dataItem = this.dataItem(selectedRow);
	if(dataItem != null) {
		Util.setPageData(dataItem);
		pEComName.value(dataItem.eComName);	
		
		$("#btn_add").html($("#btn_add").html().replace('추가', '수정'));
	} else {
		$("#btn_add").html($("#btn_add").html().replace('수정', '추가'));
	}
}

function getOrderStopData(){
	var dataSource;
	var data = parent.$("#orderStopData").val();
	var grid = $("#gridPop").data("kendoGrid");
	var list = [];
	if(data != "" && data != null) {
		for (var i = 0; i < JSON.parse(data).length; i++) {
			if(JSON.parse(data)[i].useYn != 'N'){
				list.push(JSON.parse(data)[i]);
			}
		}
		dataSource = list;
//  	dataSource = JSON.parse(data);
		if(grid != null) grid.setDataSource(dataSource);
	} else {
		if($("#orderId").val()){
			dataSource = new kendo.data.DataSource({
				transport : {
					read: {
						url: "/contents/order/data/orderStopList.do",
						type: "post",
						dataType: "json",
						data: {orderId : $("#orderId").val()}
					}
				},
				schema : {
					data: function(response) {
						return response.data;
					},
					total: function(response) {
						return response.total;
					}
				}
			});

			if(grid != null) grid.setDataSource(dataSource);
		}
	}
	
	
}

function addData(){
    if($("#eAddr").val() ==''){
        alert("주소를 입력해 주세요")
        return;
    }
	var rowData = $("#fStop").serializeObject();
	rowData["weightUnitCode"] = "TON";
	rowData["stopSeq"] = "";
	rowData["useYn"] = "Y";
	rowData["finishYn"] = "";
	rowData["finishDate"] = "";
	
	var eAddr = rowData["eAddr"];
	var replaceAddr = eAddr.replace(/(광역시|특별시|특별자치시|경상남도|경상북도|전라남도|전라북도|충청남도|충청북도|도)/g, function(str) {
		switch(str) {
		case "광역시" : return "";
		case "특별시" : return "";
		case "특별자치시" : return "";
		case "경상남도" : return "경남";
		case "경상북도" : return "경북";
		case "전라남도" : return "전남";
		case "전라북도" : return "전북";
		case "충청남도" : return "충남";
		case "충청북도" : return "충북";
		case "도" : return "";
		}
	});
	rowData["eAddr"] = replaceAddr;
	
	var grid = $("#gridPop").data("kendoGrid");
	var selectedItem = grid.dataItem(grid.select());
	if (selectedItem)  {
		
// 		$.each(selectedItem, function(key, value) {
// 			selectedItem[key] = rowData[key];
// 		});

		removeData();
		grid.dataSource.add(rowData);
		grid.refresh();
	} else {
		grid.dataSource.add(rowData);	
	}
	
	$("#fStop")[0].reset();
	grid.clearSelection();
}

function popSearchPost(){
	addrFlag = arguments[0];
	Util.popSearchPost();
}

function saveData() {
	var grid = $("#gridPop").data("kendoGrid");
	var dataItem = [];
	grid.dataSource.fetch(function() {
		dataItem = this.data();
	});
	for(var i=0, item; item=delList[i]; i++) {
		dataItem.push(item);
	}
	
	/* 
	if(dataItem.length == 0 && delList.length == 0) {
		alert("변경된 내용이 없습니다.");
		return;
	} */
	var stopList = JSON.stringify(dataItem);
	parent.setOrderStopData(stopList);
	parent.$("#divOrderStop").data("kendoWindow").close();
}

function removeData() {
	var grid = $("#gridPop").data("kendoGrid");
	var selectedItem = grid.dataItem(grid.select());
	
	if(!$("#stopSeq").val()) {
		grid.dataSource.remove(selectedItem);
	} else {
		selectedItem["useYn"]="N";
		delList.push(selectedItem);
		grid.dataSource.remove(selectedItem);
	}
}

function goFinish(e) {
	var grid = $("#gridPop").data("kendoGrid");
    var dataItem = grid.dataItem($(e).closest("tr"));
	
    $.ajax({
    	url: "/contents/order/data/orderStopFinish.do",
    	type: "POST",
    	dataType: "json",
    	data: "orderId=" + dataItem.orderId + "&stopSeq=" + dataItem.stopSeq,
    	success: function(data) {
    		alert(data.msg);
    		getOrderStopData();
    	}
    });
}


function setSearchAddressInfo(data) {
	var addr = data.roadAddr; // 주소 변수
    
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

                $("#eAddr").val(addr);
                $("#eLon").val(lon);
                $("#eLat").val(lat);

                $("#eAddrDetail").focus();

			} else {
                $("#eAddr").val(addr);
				alert("ERROR");
				console.log("ERROR");
			}
		}
	});
}	

</script>
