<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<div class="insert_pop">
	<%@ include file="./view/custInsert.jsp" %>
</div>
<div class="oms_header omsCustList">
	<div class="summary p30">
		<div class="hdr-tit">
			<p id="headerTitle">운송사관리</p>
		</div>
	</div>
	<form id="fSearch" method="POST" autocomplete="off" onSubmit="return false;">
		<div class="form-group row oms_header_set">
	    	<c:if test="${masterYn eq 'Y'}">
				<div class="input-group input-group-sm col-1 middle-name form-group">
				    <select class="form-control" class="custom-select col-12" id="s_dept" name="s_dept"></select>
				</div>
			</c:if>
			<div class="input-group input-group-sm wd90 mr10 middle-name form-group">
				<select class="form-control" class="com-sel" id="searchColumn" name="searchColumn">
					<option value="s_custName">거래처명</option>
				</select> 
			</div>
			<div class="input-group input-group-sm col-4 middle-name form-group">
				<input type="text" class="form-control form-control-sm searchValue" id="searchValue" name="searchValue" style="padding: 0;">
			</div>
			
			<div class="input-group input-group-sm col-3 middle-name form-group"></div>
			
			<div class="input-group input-group-sm col middle-name form-group">
		        <div class="option-area">
	                <div class="form-group">
	                    <button onclick="goList();" type="button" class="sch-more btn_b">검색</button>
	                	<button onclick="custPrice();" type="button" class="btn-primary">계약단가</button>
	                    <button onclick="goExcel();" type="button" class="btn-success">엑셀출력</button>
	                </div>
	            </div>
		    </div>
		</div>
	</form>
	<div id="group-list" class="cont-wrapper-page-grid bortop pt20">
   		<div style="height: 706px;" id="cust_list"></div>
	</div>
</div>
<script type="text/javascript">
var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "mngDeptName", title: "담당부서", width: 80 },
	{ field: "custTypeName", title: "분류", width: 100 },
	{ field: "sellBuySctnName", title: "구분", width: 100 },
	{ field: "custName", title: "거래처명", width: 100 },
	{ field: "bizName", title: "사업자상호", width: 100, hidden:true },
	{ field: "deptName", title: "부서명", width: 100 },
	{ field: "fax", title: "팩스번호", width: 100 },
	{ field: "mobile", title: "휴대전화", width: 100, 
		template: "#=Util.formatPhone(mobile)#"  },
	{ field: "bizName", title: "상호명", width: 100 },
	{ field: "ceo", title: "대표자명", width: 100 },
	{ field: "bizNum", title: "사업자번호", width: 100, 
		template: "#=Util.formatBizNum(bizNum)#" },
	{ field: "bizNumSub", title: "종사업장번호", width: 100 },
	{ field: "bizCond", title: "업태", width: 100 },
	{ field: "bizKind", title: "업종", width: 100 },
	{ field: "useYn", title: "사용여부", width: 100 },
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("cust_list");
oGrid.initGrid();
oGrid.setSendUrl("/oms/cust/data/custList.do");
oGrid.setSelectable(true);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

$(document).ready(function(){	
	Util.setCmmCode("select", "s_custTypeCode", "CUST_TYPE_CD", "", "--분류--");
    Util.setCmmCode("select", "s_sellBuySctn", "SELL_BUY_SCTN", "", "--구분--");

	if("${masterYn}" == "Y"){
		Util.setSelectBox("/contents/basic/data/compDeptList.do", "s_dept", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn:'Y'}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "--부서명--");
	}
	goList();
});

function custPrice(){
	var grid = $("#cust_list").data("kendoGrid");
	var selectedItem = grid.dataItem(grid.select());
	var param = "";
	if(selectedItem == null){
		alert("거래처를 선택해 주세요.");
		return
	} else{
		param = "custId="+selectedItem.custId+"&deptId="+selectedItem.deptId+"&custName="+encodeURI(selectedItem.custName + "-" + selectedItem.deptName)+"&sellBuySctn="+selectedItem.sellBuySctn;
		location.href="/oms/cust/omsCustPriceList.do?"+param;
	}
}

function goList() {
	var grid = $("#cust_list").data("kendoGrid");
	var id = $("#searchColumn").val().split('_')[1];
	var data = $("#searchValue").val();
	

	var param = {};
	param[id] = data;
	if("${masterYn}" == "Y"){
		param["deptId"] = $("#s_dept").val();
	}
	
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#cust_list").data("kendoGrid");
		//grid.bind("change", onChange);

		grid.tbody.delegate('tr', 'dblclick', function(){
			var dataItem = grid.dataItem($(this));
			form_popup(dataItem);
		});	
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}

/* function onChange(e){
	var row = this.select();
	var data = this.dataItem(row);
	
	form_popup(data);
} */

function form_popup(data) {
	Util.insertCloseButton();
	$('#group-list').addClass("block");
	$('.insert_pop').addClass("block");
	$('.insertClose').addClass("block");
	init_pop(data);
}

function form_popup_close() {
    $('#group-list').removeClass("block");
    $('.insert_pop').removeClass("block");
	$('.insertClose').removeClass("block");
}

function goExcel(){
	var grid = $("#cust_list").data("kendoGrid");
	grid.saveAsExcel();
	
}
</script>