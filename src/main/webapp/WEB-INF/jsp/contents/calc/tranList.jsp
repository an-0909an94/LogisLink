<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<div class="text-center" id="loading" style="display:none;">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>
<div class="header">	
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">거래명세서</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt">
			<div class="form-group row">
				<div class="input-group input-group-sm col-2 middle-name">
				<strong>발행일자</strong>
				    <input style="padding: 0;" type="text" id="fromDate" name="fromDate" class="col-12">
				</div>
				<span style="margin-top: 31px;">&nbsp;&nbsp;~&nbsp;&nbsp;</span>
				<div class="input-group input-group-sm col-2 middle-name">
				<strong>　</strong>
				    <input style="padding: 0;" type="text" id="toDate" name="toDate" class="col-12">
				</div>
				
				<div class="input-group input-group-sm col radio-or-checkBox">
                   	<input type="radio" name="dateChk" id="today" value="0" checked/>
                   	<label for="today" class="label-margin">
                   		<span>오늘</span>
                   	</label>
                </div>
                   <div class="input-group input-group-sm col radio-or-checkBox">
                 	<input type="radio" name="dateChk" id="yesterday" value="1"/>
                   	<label for="yesterday" class="label-margin">
                   		<span>어제</span>
                   	</label>
                   </div>
				<div class="input-group input-group-sm col radio-or-checkBox">
                   	<input type="radio" name="dateChk" id="weekly" value="7"/>
                   	<label for="weekly" class="label-margin">
                   		<span>7일</span>
                   	</label>
                </div>
                   <div class="input-group input-group-sm col radio-or-checkBox">
                   	<input type="radio" name="dateChk" id="monthly" value="30"/>
                   	<label for="monthly" class="label-margin">
                   		<span>30일</span>
                   	</label>
                </div>
                <!-- 22.06.21 이건욱 T11 > J39 추가 -->
				<div class="input-group input-group-sm col-2 middle-name">
					<strong>공급자</strong>
				    <input type="text" id="frBizName" name="frBizName" style="width:100%;">
				</div>
				<div class="input-group input-group-sm col-2 middle-name">
					<strong>공급받는자</strong>
				    <input type="text" id="toBizName" name="toBizName" style="width:100%;">
				</div>
				<!-- End -->
				<div class="input-group input-group-sm col-1 middle-name" style="max-width:90px;min-width:90px;">
					<strong>　</strong>
				    <button onclick="goList()" type="button" style="border-radius:4px" class="form-control form-control-sm middle-button-dark"><i class="k-icon k-i-search"></i>검색</button>
				</div>
                <div style="padding: 1em;" class="input-group input-group-sm col-1"></div>
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
											<!-- <a href="#" class="k-pager-refresh k-button" onClick="goExcel();"><b class="btn-b"><i class="k-icon k-i-file-excel"></i>엑셀출력</b></a> -->
											<a href="#" class="k-pager-refresh k-button" onClick="goPdf();"><b class="btn-h"><i class="k-icon k-i-file-pdf"></i>명세서출력</b></a>
											<c:if test="${menuAuth.deleteYn eq 'Y'}">
											<a href="#" class="k-pager-refresh k-button" onClick="goDel();"><b class="btn-r"><i class="k-icon k-i-delete"></i>삭제</b></a>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div id="splitter" style="min-width: 500px; max-width: 100vw; min-height:calc(100vh - 344px);">
							<div class="top-pane">
								<div style="height: 100%;" id="tranList"></div>
							</div>
							<div class="bottom-pane">
								<div style="height: 100%;" id="tranDtlList"></div>
							</div>
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
 	$("#splitter").kendoSplitter({
        orientation: "vertical",
        panes: [{resizable:true}, {resizable:true}]
 	});
 	
 	$("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
	$("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true}); 
	Util.setSearchDateForm();
	
	// 22.06.21 이건욱 T11 > J39 추가
	Util.setBizName("frBizName", "");
	Util.setBizName("toBizName", "");
	
	goList();
	/* 
	var grid = $("#tranList").data("kendoGrid");
	
	grid.tbody.delegate('tr', 'dblclick', function(){
		var dataItem = grid.dataItem($(this));
		
		$.ajax({
			url: "/contents/calc/data/getInvoicePdf.do",
			type: "POST",
			dataType: "json",
			data: {
				receiptId: dataItem.receiptId
			},
			beforeSend: function(xmlHttpRequest) {
				xmlHttpRequest.setRequestHeader("AJAX", "true");
				$("#loading").show();
			},
			success: function(data){
				location.href = "/cmm/downloadInvoice.do?fileName="+data.fileName;
			},
			complete: function() {
				$("#loading").hide();
			}
		});
	}); */
});

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "regDate", title: "발행일자", width: 70 },
	{ field: "frBizName", title: "공급자", width: 100 },
	{ field: "toBizName", title: "공급받는자", width: 100 },
	{ field: "charge", title: "발행금액", width: 70,
		attributes: { 
			style: "text-align: right" 
		}
	},
	{ field: "vat", title: "부가세액", width: 70,
		attributes: { 
			style: "text-align: right" 
		}
	},
	{ field: "amt", title: "합계금액", width: 70,
		attributes: { 
			style: "text-align: right" 
		}
	},
	{ field: "totalCnt", title: "건수", width: 50 },
	{ field: "bankName", title: "은행명", width: 50 },
	{ field: "bankCnnm", title: "예금주", width: 100 },
	{ field: "bankAccount", title: "계좌번호", width: 100 },
	{ field: "regId", title: "발행자", width: 100 },
];

var dtlColumns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "orderId", title: "오더번호", width: 100 },
	{ field: "allocDate", title: "배차일", width: 50 },
	{ field: "sComName", title: "상차지", width: 50 },
	{ field: "eComName", title: "하차지", width: 50 },
	{ field: "goodsName", title: "품명", width: 100 },
	{ field: "goodsWeight", title: "중량", width: 100, template: function(item) { return kendo.htmlEncode(item.goodsWeight + ' ' + item.weightUnitCode);} },
	{ field: "allocCharge", title: "금액", width: 50,
		attributes: { 
			style: "text-align: right" 
		}
	},
	{ field: "allocVat", title: "세액", width: 50,
		attributes: { 
			style: "text-align: right" 
		}
	},
	{ field: "allocAmt", title: "합계", width: 100,
		attributes: { 
			style: "text-align: right" 
		}
	},
	//{ field: "custName", title: "거래처", width: 100 },
	{ field: "carNum", title: "차량번호", width: 70 },
	{ field: "memo", title: "비고", width: 100 }
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("tranList");
oGrid.initGrid();
oGrid.setSendUrl("/contents/calc/data/tranList.do");
oGrid.setSelectable(true);
oGrid.setPageable(false);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

var oSubGrid = null;
oSubGrid = new gridData("tranDtlList");
oSubGrid.initGrid();
oSubGrid.setSendUrl("/contents/calc/data/tranDtlList.do");
oSubGrid.setEditable(false);
oSubGrid.setSelectable(true);
oSubGrid.setSortable(false);
oSubGrid.setPageable(false);
oSubGrid.setGrid(dtlColumns); 

function goList() {
	var grid = $("#tranList").data("kendoGrid");
	
	var param = {};
	param["fromDate"] = $("#fromDate").val();
	param["toDate"] = $("#toDate").val();
	// 22.06.21 이건욱 T11 > J39 추가
	param["frBizName"] = $("#frBizName").val();
	param["toBizName"] = $("#toBizName").val();
	// End
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#tranList").data("kendoGrid");
		grid.bind("change", onChange);
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
	$("#tranDtlList").data("kendoGrid").setDataSource([]);
}

function onChange(e){
	var row = this.select();
	var data = this.dataItem(row);
	
	/* $("#gCode").val(data.gCode); */
	viewCode(data.receiptId);
}

function viewCode(){	
	var searchData = {
			receiptId : arguments[0]
	}
	
	var subGrid = $("#tranDtlList").data("kendoGrid");
	oSubGrid.setSearchData(searchData);
	subGrid.setDataSource(oSubGrid.gridOption.dataSource);	
}


//excel download
function goExcel(){
	$("#loading").show();
	var grid = $("#tranList").data("kendoGrid");
	grid.saveAsExcel();
}

function goPdf(){
	var grid = $("#tranList").data("kendoGrid");
	var selectedItem = grid.dataItem(grid.select());
	
	if(selectedItem == null) {
		alert("발행할 명세서를 선택해주세요.");
		return false;
	}
	
	$.ajax({
		url: "/contents/calc/data/getInvoicePdf.do",
		type: "POST",
		dataType: "json",
		data: {
			receiptId: selectedItem.receiptId
		},
		beforeSend: function(xmlHttpRequest) {
			xmlHttpRequest.setRequestHeader("AJAX", "true");
			$("#loading").show();
		},
		success: function(data){
			location.href = "/cmm/downloadInvoice.do?fileName="+data.fileName;
		},
		complete: function() {
			$("#loading").hide();
		}
	});
}

function goDel() {

	var grid = $("#tranList").data("kendoGrid");
	var selectedItem = grid.dataItem(grid.select());
	
	if(selectedItem == null) {
		alert("삭제할 명세서를 선택해주세요.");
		return false;
	}
	
	$.ajax({
		url: "/contents/calc/data/deleteTran.do",
		type: "POST",
		dataType: "json",
		data: {
			receiptId: selectedItem.receiptId
		},
		success: function(data){
			if (data.result) {
				alert(data.msg);
				goList();
			}else {
				alert(data.msg);
			}
		}
	});
	
}
</script>