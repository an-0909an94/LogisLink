<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#grid .k-grid-content {max-height:calc(100vh)}
</style>
<div class="insert_pop">
	<jsp:include page="./view/boardInsert.jsp" />
</div>
<div class="header">
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">공지사항</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt" onSubmit="return false;">
			<div class="form-group row">
				<div class="input-group input-group-sm col-1 middle-name">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="searchColumn" name="searchColumn">
							<option value="USER_NAME">--등록자--</option>
							<option value="TITLE">--제목--</option>
							<option value="CONTENT">--내용--</option>
				    </select>
				</div>
				<div class="input-group input-group-sm col-2 middle-name">
				<strong>　</strong>
				    <input type="text" id="searchValue" name="searchValue" class="form-control form-control-sm searchValue">
				</div>
				<div class="input-group input-group-sm col-1 middle-name" style="max-width:90px;min-width:90px;">
				<strong>　</strong>
				    <button onclick="goList()" type="button" style="border-radius:4px" class="form-control form-control-sm middle-button-dark"><i class="k-icon k-i-search"></i>검색</button>
				</div>
				
				<div style="padding: 1em;" class="input-group input-group-sm col-1"></div>		
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
												<a href="#" class="k-pager-refresh k-button" onClick="goExcel();"><b class="btn-x"><i class="k-icon k-i-file-excel"></i>엑셀출력</b></a>
											</c:if>
											<c:if test="${menuAuth.writeYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button" onclick="form_popup('N', {})"><b class="btn-h"><i class="k-icon k-i-plus"></i>신규등록</b></a>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div style="height:calc(100vh - 344px)" id="grid"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

var columns = [
		{ field: "number", title: "No", width: 100 },
		{ field: "title", title: "제목",},
		{ field: "userName", title: "등록자", width: 100 },
		{ field: "regdate", title: "등록일", width: 200 },
		{ field: "boardSeq", title: "boardSeq", hidden: true}
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/contents/notice/data/boardList.do");
oGrid.setPageable(true);
oGrid.setSelectable(true);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

$(document).ready(function(){ 	
 	goList();
});

function goList() {
	var param = {};
	param["select"] = $("#searchColumn").val();;
	param["value"] = $("#searchValue").val();;
	
	var grid = $("#grid").data("kendoGrid");
	
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#grid").data("kendoGrid");
		//grid.bind("change", onChange);

		grid.tbody.delegate('tr', 'dblclick', function(){
			var dataItem = grid.dataItem($(this));
			//form_popup("E", dataItem);
			setChange(dataItem);
		});	
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}

function setChange(rowData){
	if($("#oldBoardSeq").val() != rowData.boardSeq){
		$.ajax({
			url: "/contents/notice/data/boardReadCount.do",
			type: "POST",
			dataType: "json",
			data: {
					boardSeq: rowData.boardSeq,
				  },	
			success: function(data){
				if(data.result) {
					$.ajax({
						url: "/contents/notice/data/boardDetail.do",
						type: "POST",
						dataType: "json",
						data: {
								boardSeq: rowData.boardSeq, 
							  },				
						success: function(data){
							if(data.result) {
								form_popup("E", data);
							} else {
								alert(data.msg);
							}
						}
					});
				}
			}
		});
	}
	$("#oldBoardSeq").val(rowData.boardSeq);
}

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
	var grid = $("#grid").data("kendoGrid");
	grid.saveAsExcel();
}
</script>