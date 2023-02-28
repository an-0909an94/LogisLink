<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	#grid .k-grid-content {max-height:calc(100vh - 260px)}
</style>
<body>
<div class="header">
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">실적신고</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" name="fSearch" method="post" class="date-bnt">
				<div class="form-group row mt0" style="justify-content: space-between">
					<div class="row">
						<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
							<select class="custom-select wd90">
								<option>배차일자</option>
							</select>
						</div>
						<div class="input-group input-group-sm wd90 middle-name">
							<input style="padding: 0;" type="text" id="fromDate" name="fromDate"
								   class="wd90">
						</div>
						<span>~</span>
						<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
							<input style="padding: 0;" type="text" id="toDate" name="toDate"
								   class="wd90">
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="radio" name="dateChk" id="today" value="0" checked/>
							<label for="today" class="label-margin">
								<span>오늘</span>
							</label>
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="radio" name="dateChk" id="yesterday" value="1"/>
							<label for="yesterday" class="label-margin">
								<span>어제</span>
							</label>
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="radio" name="dateChk" id="weekly" value="7"/>
							<label for="weekly" class="label-margin">
								<span>7일</span>
							</label>
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
							<input type="radio" name="dateChk" id="monthly" value="30"/>
							<label for="monthly" class="label-margin">
								<span>30일</span>
							</label>
						</div>
						<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
							<select class="form-control" class="custom-select wd90" id="sDeptId"
									name="sDeptId">
								<option>담당부서명</option>
							</select>
						</div>
						<div class="input-group input-group-sm wd100 middle-name div-min-col-1">
							<select class="form-control custom-select wd100" id="userId"
									name="userId"></select>
						</div>
					</div>

					<div class="row">
						<div class="input-group input-group-sm middle-name">
							<button onclick="goList()" type="button" class="form-control-sm btn_58 btn_b">검색</button>
						</div>
					</div>

					<!--<div style="padding: 1em;" class="input-group input-group-sm col-1"></div>-->

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
												<a href="javascript:goExcel();" class="k-pager-refresh k-button wd100"><b class="btn-x">엑셀출력</b></a>
											</div>
										</div>
									</div>
								</div>
							</div><!-- /toolbar -->
							<div style="min-width: 500px;">
								<div style="height:calc(100vh - 260px)" id="grid"></div>
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
</body>
<script type="text/javascript">
var headerTitle = ($("#headerTitle").text());
var columns = [
	{
		title: "운송의뢰자 정보",
		columns: [
			{ field: "reqCustName", title: "거래처명", width: 100 },
			{ field: "reqBizNo", title: "사업자등록번호", width: 150, 
				template: "#=Util.formatBizNum(reqBizNo)#" },
			{ field: "reqCustType", title: "의뢰자구분", width: 100 }		
		]
	},
	{
		title: "계약정보",
		columns: [
			{ field: "contNo", title: "계약고유번호", width: 180 },
			{ field: "contYmd", title: "계약년월", width: 100 },
			{ field: "contAmt", title: "계약금액", width: 100,
				template: "#=Util.formatNumber(contAmt)#",
				attributes: { 
					style: "text-align: right" 
				}
			},
			{ field: "", title: "이사화물", width: 100 },
			{ field: "", title: "타운송수단이용여부", width: 150 }		
		]
	},
	{
		title: "배차정보",
		columns: [
			{ field: "carNum", title: "차량등록번호", width: 150 },
			{ field: "allocYmd", title: "운송완료년월", width: 150 },
			{ field: "allocCount", title: "운송완료횟수", width: 150 },
			{ field: "allocAmt", title: "운송료", width: 100,
				template: "#=Util.formatNumber(allocAmt)#",
				attributes: { 
					style: "text-align: right" 
				}
			}
		]
	},
	{
		title: "위탁계약정보",
		columns: [
			{ field: "trustBizNo", title: "사업자등록번호", width: 150, 
				template: "#=Util.formatBizNum(trustBizNo)#" },
			{ field: "trustYmd", title: "위탁계약년월", width: 150 },
			{ field: "trustAmt", title: "위탁계약금액", width: 150,
				template: "#=Util.formatNumber(trustAmt)#",
				attributes: { 
					style: "text-align: right" 
				}
			},
			{ field: "linkCode", title: "화물정보망이용여부", width: 150 }		
		]
	}
];

var oGrid = null;	
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/contents/calc/data/fpisList.do");
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");
oGrid.setPageable(true);
oGrid.setSelectable(true);

$(document).ready(function(){
	$("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
	$("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true}); 
	Util.setSearchDateForm();

	Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", {deptId:$(this).val()}, "userId", "userName", "", "전체");
	$('#sDeptId').on('change', function() {
		Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", {deptId:$(this).val()}, "userId", "userName", "", "전체");
	});
	
	Util.setSelectBox("/contents/basic/data/compDeptList.do", "sDeptId", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn :'Y'}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "부서명");
    
	goList();

	var exportFlag = true;
	$("#grid").data("kendoGrid").bind("excelExport", function (e) {
	    if (exportFlag) {
	        e.sender.hideColumn("reqCustName");
	        e.preventDefault();
	        exportFlag = false;
	        e.sender.saveAsExcel();
	    } else {
	        e.sender.showColumn("reqCustName");
	        exportFlag = true;
	    }
	});
});


function goList() {
	var grid = $("#grid").data("kendoGrid");

	oGrid.setSearchData($("#fSearch").serializeObject());
	
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#grid").data("kendoGrid");		
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}
//excel download
function goExcel(){
	$("#loading").show();
	var grid = $("#grid").data("kendoGrid");
	grid.saveAsExcel();
}
</script>