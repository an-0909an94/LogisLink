<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<div class="insert_pop">
	<%@ include file="./view/custAddrInsert.jsp" %>
</div>
<div class="oms_header">
	<div class="summary p30">
		<div class="hdr-tit">
			<p id="headerTitle">주소지관리</p>
		</div>
	</div>
	<form id="fSearch" method="POST" autocomplete="off" onSubmit="return false;">
		<div class="form-group row oms_header_set">
	    	<c:if test="${masterYn eq 'Y'}">
				<div class="input-group input-group-sm col-1 middle-name form-group">
				    <select class="form-control" class="custom-select col-12" id="s_dept" name="deptId"></select>
				</div>
			</c:if>
			<div class="input-group input-group-sm col-1 middle-name form-group">
				<select class="form-control" class="com-sel" id="s_select" name="select">
					<option value="ADDR_NAME">--주소지명--</option>
					<option value="ADDR">--주소--</option>
				</select> 
			</div>
			<div class="input-group input-group-sm col-4 middle-name form-group">
				<input type="text" class="form-control form-control-sm searchValue" id="s_value" name="value">
			</div>
			
			<div class="input-group input-group-sm col-2 middle-name form-group"></div>
			
			<div class="input-group input-group-sm col middle-name form-group">
		        <div style="float: right;" class="option-area">
	                <div class="form-group">
	                    <c:if test="${menuAuth.readYn eq 'Y'}">
		                    <button onclick="goList();" type="button" class="sch-more">검색</button>
						</c:if>
						<c:if test="${menuAuth.writeYn eq 'Y'}">
		                    <button onclick="form_popup('N', {})" type="button" class="btn-warning">신규등록</button>
						</c:if>
						<c:if test="${menuAuth.writeYn eq 'Y'}">
							<button onclick="location.href='/oms/cust/custAddrBundle.do'" type="button" class="btn-primary">일괄등록</button>
						</c:if>
						<c:if test="${menuAuth.printYn eq 'Y'}">
		                    <button onclick="goExcel();" type="button" class="btn-success">엑셀출력</button>
						</c:if>
	                </div>
	            </div>
		    </div>
		</div>
	</form>
	<div id="group-list" class="cont-wrapper-page-grid">
   		<div style="height: 706px;" id="grid"></div>
	</div>
</div>
<script type="text/javascript">
var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "addrName", title: "주소지명", width: 100 },
	{ field: "sido", title: "시도", width: 100 },
	{ field: "gungu", title: "군구", width: 100 },
	{ field: "addr", title: "주소", width: 100 },
	{ field: "addrDetail", title: "상세주소", width: 100 },
	{ field: "staffName", title: "담당자명", width: 100 },
	{ field: "staffTel", title: "연락처", width: 100,
		template: function(dataItem) {
			return Util.formatPhone(dataItem.staffTel);
		}
	},
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/oms/cust/data/custAddrList.do");
oGrid.setPageable(true);
oGrid.setSelectable(true);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

$(document).ready(function(){	
	if("${masterYn}" == "Y"){
		Util.setSelectBox("/contents/basic/data/compDeptList.do", "s_dept", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn:'Y'}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "--부서명--");
	}
	goList();
});

function goList() {
	var grid = $("#cust_list").data("kendoGrid");
	
	oGrid.setSearchData($("#fSearch").serializeObject());
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#grid").data("kendoGrid");

		grid.tbody.delegate('tr', 'dblclick', function(){
			var dataItem = grid.dataItem($(this));
			form_popup('E', dataItem);
		});	
		//grid.bind("change", onChange);
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}
/* 
function onChange(e){
	var row = this.select();
	var data = this.dataItem(row);
	
	form_popup('E', data);
}
 */

function form_popup(mode, data) {
	Util.insertCloseButton();
	$('#group-list').addClass("block");
	$('.insert_pop').addClass("block");
	$('.insertClose').addClass("block");
	init_pop(mode, data);
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
</script>