<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="header">
	<div class="summary p30">
		<div class="hdr-tit">
			<P class="">계약단가</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt" onSubmit="return false;">
			<input type="hidden" id="custId" name="custId" value="${param.custId}" readonly />
			<input type="hidden" id="deptId" name="deptId" value="${param.deptId}" readonly />
			<input type="hidden" id="sellBuySctn" name="sellBuySctn" value="${param.sellBuySctn}" readonly />
			<div class="form-group row" style="width: auto;float: left;margin-right: 0.2vw;"">
				<div class="input-group input-group-sm col-2 middle-name">
				    <input type="text" value="${param.custName}" class="form-control form-control-sm" style="width: auto;" readonly>
				</div>
			</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1" style="margin: 5px 0 0 0;float: left"">
					<select class="form-control" class="custom-select col-12" id="sSido" name="sSido">
						<option>상차지</option>
					</select>
				</div>
				<div class="row" style="display: flex;justify-content: flex-end;position: relative;top: 5px;">
					<div class="btn_58 input-group-sm middle-name mr7">
						<button onclick="goList()" type="button" class="btn_58 btn_b">검색</button>
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
												<a href="#" class="k-pager-refresh k-button" onclick="goExcel();"><b class="btn-x">엑셀출력</b></a>
											</c:if>
											<c:if test="${menuAuth.writeYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button" onclick="viewBundle()"><b class="btn-h">신규등록</b></a>
											</c:if>
										</div>	
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div style="height:calc(100vh - 344px)" id="grid"></div>
						<!-- /table -->
					</div>
				</div>
			</div>
			<!-- group-list -->
		</div>
		<!--  -->
	</div>
	<!-- content -->
</div>
<script type="text/javascript">
var columns = [	
	{ field: "sSido", title: "출발시/도", width: 100 },
	{ field: "sGungu", title: "출발시/군/구", width: 120 },
	{ field: "eSido", title: "도착시/도", width: 100 },
	{ field: "eGungu", title: "도착시/군/구", width: 120 },
	{ field: "F0T5", title: "1톤미만", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F0T5);
		}
	},
	{ field: "F1", title: "1톤", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F1);
		}
	},
	{ field: "F1T4", title: "1.4톤", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F1T4);
		}
	},
	{ field: "F2T5", title: "2.5톤", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F2T5);
		}
	},
	{ field: "F3T5", title: "3.5톤", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F3T5);
		}
	},
	{ field: "F5", title: "5톤", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F5);
		}
	},
	{ field: "F5P", title: "5톤플러스", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F5P);
		}
	},
	{ field: "F5A", title: "5톤축", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F5A);
		}
	},
	{ field: "F8", title: "8톤", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F8);
		}
	},
	{ field: "F9T5", title: "9.5톤", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F9T5);
		}
	},
	{ field: "F11", title: "11톤", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F11);
		}
	},
	{ field: "F11A", title: "11톤축", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F11A);
		}
	},
	{ field: "F14", title: "14톤", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F14);
		}
	},
	{ field: "F14A", title: "14톤축", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F14A);
		}
	},
	{ field: "F16", title: "16톤", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F16);
		}
	},
	{ field: "F16A", title: "16톤축", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F16A);
		}
	},
	{ field: "F18", title: "18톤", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F18);
		}
	},
	{ field: "F18A", title: "18톤축", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F18A);
		}
	},
	{ field: "F22", title: "22톤", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F22);
		}
	},
	{ field: "F25", title: "25톤", width: 100,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.F25);
		}
	},
];

var oGrid = null;
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSortable(false);
oGrid.setSendUrl("/contents/basic/data/frtCostList.do");
oGrid.setExcelFile("계약단가.xlsx");
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
	var win = window.open("/contents/basic/view/custBundle.do?custId="+custId+"&deptId="+deptId+"&sellBuySctn="+sellBuySctn, "PopupOrder", "width=800, height=490");
}

//excel download
function goExcel(){
	$("#loading").show();
	var grid = $("#grid").data("kendoGrid");
	grid.saveAsExcel();
}
</script>
</html>