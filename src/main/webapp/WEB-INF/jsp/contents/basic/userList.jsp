<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#user_list .k-grid-content {max-height:calc(100vh}
</style>
<div class="insert_pop">
	<jsp:include page="./view/userInsert.jsp" />
</div>
<div class="header">
	
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">사용자관리</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt" onSubmit="return false;">
			<div class="form-group row">
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="searchColumn" name="searchColumn">
						<option value="s_userId">--아이디--</option>
				    </select>
				</div>
				<div class="input-group input-group-sm col-2 middle-name">
				<strong>　</strong>
				    <input type="text" id="searchValue" name="searchValue" class="form-control form-control-sm searchValue">
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="form-control" class="custom-select col-12" id="s_authSeq" name="s_authSeq">
				    	<option>--권한--</option>
				    </select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="form-control" class="custom-select col-12" id="s_dept" name="s_dept">
				    	<option>--부서명--</option>
				    </select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="form-control" class="custom-select col-12" id="s_useYn" name="s_useYn">
				    	<option value="">--사용여부--</option>
                        <option value='Y'>사용</option>
                        <option value='N'>미사용</option>
                        <option value='W'>대기</option>
				    </select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1" style="max-width:90px;min-width:90px;">
				<strong>　</strong>
				    <button onclick="goList()" type="button" style="border-radius:4px" class="form-control form-control-sm middle-button-dark"><i class="k-icon k-i-search"></i>검색</button>
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
						<div style="min-width: 500px;">
							<div style="height:calc(100vh - 344px)" id="user_list"></div>
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
	if(${authChk}) {
		Util.setSelectBox("/contents/basic/data/allAuthList.do", "s_authSeq", {}, "authSeq", "authName", "", "--권한--");
	}
	Util.setSelectBox("/contents/basic/data/compDeptList.do", "s_dept", {custId:'${custId}', useYn :'Y'}, "deptId", "deptName", "", "--부서명--");
 	goList();
});

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "bizName", title: "조직", width: 100 },
	{ field: "deptName", title: "부서", width: 100 },
	{ field: "userId", title: "아이디", width: 100 },
	{ field: "userName", title: "이름", width: 100 },
	{ field: "grade", title: "직급", width: 100 },
	{ field: "authName", title: "권한", width: 100 },
	{ field: "telNum", title: "전화번호", width: 100, 
		template: "#=Util.formatPhone(telNum)#" },
	{ field: "mobile", title: "휴대전화", width: 100,
		template: "#=Util.formatPhone(mobile)#"},
	{ field: "authSeq", title: "권한시퀀스", hidden: true},
	{ field: "useYn", title: "상태", hidden: true},
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("user_list");
oGrid.initGrid();
oGrid.setSendUrl("/contents/basic/data/userList.do");
oGrid.setExcelFile("사용자리스트관리.xlsx");
oGrid.setSelectable(true);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

function goList() {
	var id = $("#searchColumn").val().split('_')[1];
	var data = $("#searchValue").val();
	
	var param = {};
	param[id] = data;
	if(${authChk}) {
		param["authSeq"] = $("#s_authSeq").val();
	}
	
	param["userId"] = $("#searchValue").val();
	param["deptId"] = $("#s_dept").val();
	param["useYn"] = $("#fSearch select[name=s_useYn] option:selected").val();
	
	var grid = $("#user_list").data("kendoGrid");
	
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#user_list").data("kendoGrid");
		//grid.bind("change", onChange);
		grid.tbody.delegate('tr', 'dblclick', function(){
			var dataItem = grid.dataItem($(this));
			form_popup("E", dataItem);
		});	
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}

}

/* function onChange(e){
	var row = this.select();
	var data = this.dataItem(row);
	
	form_popup("E", data);
} */

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
	Util.formReset("", [".editor input",".editor select"], {".editor #useYn": 'Y'});
}

//excel download
function goExcel(){
	$("#loading").show();
	var grid = $("#user_list").data("kendoGrid");
	grid.saveAsExcel();
}
</script>