<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="oms_header">
	<div class="summary p30">
		<div class="hdr-tit">
			<p id="headerTitle">계약단가</p>
		</div>
	</div>
	<div class="group-list">
		<div class="box">
			<div id="group-list" class="cont-wrapper">
				<form id="fSearch" name="fSearch" method="post">
				<input type="hidden" id="custId" name="custId" value="${param.custId}" readonly />
				<input type="hidden" id="deptId" name="deptId" value="${param.deptId}" readonly />
				<input type="hidden" id="sellBuySctn" name="sellBuySctn" value="${param.sellBuySctn}" readonly />
				<div class="form-inline f-wrap">
					<div class="form-group">
						<div class="padding">
							<input type="text" class="form-control com-input" value="${param.custName}" readonly>
						</div>
						<div class="padding">
						<select class="form-control" class="com-sel" id="sSido" name="sSido">
							<option>상차지</option>
						</select>
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
								        <div class="option-area">
							                <div class="form-group">
												<c:if test="${menuAuth.readYn eq 'Y'}">
							                    	<button onclick="goList();" type="button" class="sch-more">조회</button>
							                    </c:if>
												<c:if test="${menuAuth.printYn eq 'Y'}">
							                    	<button onclick="goExcel();" type="button" class="btn-warning">엑셀출력</button>
							                    </c:if>
							                </div>
							            </div>
									</div>
								</div>
							</div><!-- /toolbar -->
							<div id="grid"></div>
							<!-- /table -->
						</div>
					</div>
				</div>
				<!--  -->
			</div>
			<!-- group-list -->
		</div>
		<!--  -->
	</div>
	<!-- content -->
</div>
<script type="text/javascript">
var columns = [	
	{ field: "sSido", title: "출발시/도", width: 80 },
	{ field: "sGungu", title: "출발시/군/구", width: 100 },
	{ field: "eSido", title: "도착시/도", width: 80 },
	{ field: "eGungu", title: "도착시/군/구", width: 100 },
	{ field: "F1", title: "1톤", width: 100 },
	{ field: "F2T5", title: "2.5톤", width: 100 },
	{ field: "F3T5", title: "3.5톤", width: 100 },
	{ field: "F5", title: "5톤", width: 100 },
	{ field: "F5A", title: "5톤축", width: 100 },
	{ field: "F11", title: "11톤", width: 100 },
	{ field: "F18", title: "18톤", width: 100 },
	{ field: "F25", title: "25톤", width: 100 }
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/oms/cust/data/frtCostList.do");
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");
oGrid.setPageable(false);
oGrid.setSelectable(false);

$(document).ready(function(){

    Util.setCmmCode("select", "sSido", "SIDO", "", "--출발지--");
	goList();
});

function goList() {
	var grid = $("#grid").data("kendoGrid");
	var param = {
			custId : "${param.custId}",
			deptId : "${param.deptId}",
			sellBuySctn : "${param.sellBuySctn}",
			sSido : $("#sSido").val()
	}
	
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#grid").data("kendoGrid");
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}

//엑셀등록 팝업 띄우기
function viewBundle(){
	var custId = $("#custId").val();
	var deptId = $("#deptId").val();
	var sellBuySctn = $("#sellBuySctn").val();
	var win = window.open("/contents/basic/view/custBundle.do?custId="+custId+"&deptId="+deptId+"&sellBuySctn="+sellBuySctn, "PopupOrder", "width=800, height=650");
}

//excel download
function goExcel(){
	var grid = $("#grid").data("kendoGrid");
	grid.saveAsExcel();
}
</script>
</html>