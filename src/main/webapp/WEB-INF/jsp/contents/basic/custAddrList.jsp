<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#cust_addr_list .k-grid-content {max-height:calc(100vh)}
</style>

<div class="insert_pop">
	<jsp:include page="./view/custAddrInsert.jsp" />
</div>
<div class="header">
	
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">주소지 관리</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt" onSubmit="return false;">
			<div class="form-group row mt0" style="justify-content: space-between">
				<div>
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="form-control" class="custom-select wd90" id="s_dept" name="s_dept">
							<option value="">--부서명--</option>
						</select>
					</div>
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="custom-select wd90" id="searchColumn" name="searchColumn">
							<option value="ADDR_NAME">--주소지명--</option>
						</select>
					</div>
					<div class="input-group input-group-sm wd290 middle-name div-min-col-1">
						<input type="text" id="searchValue" name="searchValue" style="width:100%" class="form-control form-control-sm searchValue" placeholder="검색항목을 입력하세요">
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
											<c:if test="${menuAuth.printYn eq 'Y'}">
											<a href="#" class="k-pager-refresh k-button" onClick="goExcel();"><b class="btn-x">엑셀출력</b></a>
											</c:if>
											<c:if test="${menuAuth.writeYn eq 'Y'}">
											<a href="/contents/basic/custAddrBundle.do" class="k-pager-refresh k-button"><b class="btn-b">일괄등록</b></a>
											</c:if>
											<c:if test="${menuAuth.writeYn eq 'Y'}">
											<a href="#" class="k-pager-refresh k-button" onclick="form_popup('N', {})"><b class="btn-h">신규등록</b></a>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div style="min-width: 500px;">
							<div style="height:calc(100vh - 344px);" id="cust_addr_list"></div>
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
$(document).ready(function(){ 
	Util.setSelectBox("/contents/basic/data/compDeptList.do", "s_dept", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn:'Y'}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "--부서선택--");
	
 	goList();
});

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "deptName", title: "담당부서", width:100},
	{ field: "addrName", title: "주소지명", width: 100 },
	{ field: "sido", title: "시도", width: 100 },
	{ field: "gungu", title: "군구", width: 100 },
	{ field: "addr", title: "주소", width: 200 },
	{ field: "addrDetail", title: "상세주소", width: 200 },
	{ field: "staffName", title: "담당자명", width: 100 },
	{ field: "staffTel", title: "연락처", width: 100,
		template: function(dataItem) {
			return Util.formatPhone(dataItem.staffTel);
		}
	},
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("cust_addr_list");
oGrid.initGrid();
oGrid.setSortable(false);
oGrid.setSendUrl("/contents/basic/data/custAddrList.do");
oGrid.setExcelFile("주소지관리.xlsx");
oGrid.setPageable(true);
oGrid.setSelectable(true);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

function goList() {
	var grid = $("#cust_addr_list").data("kendoGrid");

	var param = {};
	param["select"] = $("#searchColumn").val();
	param["value"] = $("#searchValue").val();
	param["deptId"] = $("#s_dept").val();
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#cust_addr_list").data("kendoGrid");
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
	//location.href = "/contents/basic/compList.do?custId="+data.custId;
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

//excel download
function goExcel(){
	$("#loading").show();
	var grid = $("#cust_addr_list").data("kendoGrid");
	grid.saveAsExcel();
}
</script>