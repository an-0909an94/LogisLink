<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#cust_mst_list .k-grid-content {max-height:calc(100vh)}
</style>
<div class="header">
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">조직관리</P>
		</div>
	</div> 
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt" onSubmit="return false;">
			<div class="form-group row mt0" style="justify-content: space-between">
				<div>
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="custom-select wd90" id="searchColumn" name="searchColumn">
							<option value="s_custId">--거래처ID--</option>
							<option value="s_bizName">--상호--</option>
							<option value="s_bizNum">--사업자번호--</option>
						</select>
					</div>
					<div class="input-group input-group-sm wd290 div-min-col-1 middle-name">
						<input type="text" id="searchValue" name="searchValue" style="width:100%"
							   class="form-control form-control-sm searchValue" placeholder="검색항목을 입력하세요">
					</div>
				</div>

				<div class="row">
					<div class="input-group-sm">
						<button onclick="goList()" type="button" class="form-control-sm btn_58 btn_b">
							검색
						</button>
					</div>
					<!--
					<div style="padding: 1em;" class="input-group input-group-sm col-1"></div>
					-->
				</div>
			</div>
			</form>   
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
											<a class="k-pager-refresh k-button" onClick="goExcel();"><b class="btn-x">엑셀출력</b></a>
											</c:if>
											<c:if test="${menuAuth.writeYn eq 'Y'}">
											<a class="k-pager-refresh k-button" onclick="create_comp()"><b class="btn-h">신규등록</b></a>
											</c:if>					
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div style="height:calc(100vh - 344px)" id="cust_mst_list"></div>
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
<div class="insert_pop" style="display:none;">
	<jsp:include page="./view/userInsert.jsp" />
</div>

<script type="text/javascript">

$(document).ready(function(){ 	
 	goList();
});

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "custId", title: "거래처ID", width: 155 },
	{ field: "bizName", title: "거래처상호", width: 150 },
	{ field: "custTypeName", title: "거래처분류", width: 100 },
	{ field: "ceo", title: "대표자명", width: 100 },
	{ field: "bizNum", title: "사업자번호", width: 110 },
	{ field: "bizNumSub", title: "종사업장번호", width: 105 },
	{ field: "bizCond", title: "업태", width: 100 },
	{ field: "bizKind", title: "업종", width: 100 },
	{ field: "bizPost", title: "우편번호", width: 80 },
	{ field: "bizAddr", title: "주소", width: 300 },
	{ field: "bizAddrDetail", title: "상세주소", width: 200 },
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("cust_mst_list");
oGrid.initGrid();
oGrid.setSortable(false);
oGrid.setSendUrl("/contents/basic/data/masterCompList.do");
oGrid.setSelectable(true);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

function goList() {
	var grid = $("#cust_mst_list").data("kendoGrid");
	var id = $("#searchColumn").val().split('_')[1];
	var data = $("#searchValue").val();
	
	var param = {};
	param[id] = data;
	
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#cust_mst_list").data("kendoGrid");
		grid.bind("change", onChange);
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}

function onChange(e){
	var grid = $("#cust_mst_list").data("kendoGrid");
	var row = this.select();
	var data = this.dataItem(row);
	grid.tbody.delegate('tr', 'dblclick', function(){
		location.href = "/contents/basic/compList.do?custId="+data.custId;
	});
}
/* 

function search_list() {
	var id = $("#s_search").val().split('_')[1];
	var data = $("#s_value").val();
	
	var param = {};
	param[id] = data;
	
	var grid = $("#cust_mst_list").data("kendoGrid");
	
	oGrid.setSearchData(param);
	grid.setDataSource(oGrid.gridOption.dataSource);
}
 */
function create_comp() {
	location.href = "/contents/basic/compList.do?custId=newComp";
}

/*
$("#cust_mst_list").kendoGrid({
	//height: 550,
	sortable: false,
	reorderable: true,
	groupable: false,
	resizable: true,
	filterable: false,
	selectable: "multiple",
	columnMenu: true,
	columns: [
		{ field: "number", title: "No", width: 50 },
		{ field: "custId", title: "거래처ID", width: 100 },
		{ field: "", title: "거래처상호", width: 100 },
		{ field: "", title: "거래처분류", width: 100 },
		{ field: "", title: "대표자명", width: 100 },
		{ field: "", title: "사업자번호", width: 100 },
		{ field: "", title: "업태", width: 100 },
		{ field: "", title: "업종", width: 100 },
		{ field: "", title: "우편번호", width: 100 },
		{ field: "", title: "주소", width: 100 },
		{ field: "", title: "상세주소", width: 100 },
	],
	dataSource: {
		data: [
			{ Number: 1, },
			{ Number: 2, },
			{ Number: 3, },
			{ Number: 4, },
			{ Number: 5, },
			{ Number: 6, },
			{ Number: 7, },
			{ Number: 8, },
			{ Number: 9, },
			{ Number: 10, },
		]
	}
}); 
*/
function form_popup() {
    $('.insert_pop').css('display', 'block');
}

function form_popup_close() {
    $('.insert_pop').css('display', 'none');
}

//excel download
function goExcel(){
	$("#loading").show();
	var grid = $("#cust_mst_list").data("kendoGrid");
	grid.saveAsExcel();
}
</script>