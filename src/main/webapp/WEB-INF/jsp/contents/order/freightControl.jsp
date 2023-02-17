<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#grid .k-grid-content {
		max-height: calc(100vh - 452px)
	}

	.editHeader {
		color: darkorange;
		display: inline;
		font-size: 14px !important;
	}
</style>

<div id="divTaxInvoice" class="editor-warp p-0">
	<form class="modalEditor" id="fTaxInvoice" data-toggle="validator" role="form" autocomplete="off">
		<div class="enter_form" style="padding: 1.875em;">
			<!-- 공급자/공급받는자 정보 -->
			<div style="display: inline-block; width: 100%">
				<div style="width: 50%; float: left;">
					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name">공급자</label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>사업자명</strong>
							<input class="form-control form-control-sm" id="supplierBizName" name="supplierBizName" type="text" readonly>
						</div>
					</div>

					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name"></label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>사업자번호</strong>
							<input type="text" name="supplierBizNo" id="supplierBizNo" class="form-control form-control-sm" readonly>
						</div>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>종사업장번호</strong>
							<input type="text" name="supplierBizSubNo" id="supplierBizSubNo" class="form-control form-control-sm" readonly>
						</div>
					</div>

					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name"></label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>대표자</strong>
							<input type="text" name="supplierCeo" id="supplierCeo" class="form-control form-control-sm" readonly>
						</div>
					</div>

					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name"></label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>사업장주소</strong>
							<input id="supplierAddr" name="supplierAddr" type="text" class="form-control form-control-sm" readonly>
						</div>
					</div>

					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name"></label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>업태</strong>
							<input type="text" name="supplierBizType" id="supplierBizType" class="form-control form-control-sm" readonly>
						</div>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>업종</strong>
							<input type="text" name="supplierBizClass" id="supplierBizClass" class="form-control form-control-sm" readonly>
						</div>
					</div>

					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name"></label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>담당자</strong>
							<input type="text" name="supplierMemName" id="supplierMemName" class="form-control form-control-sm" readonly>
						</div>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>연락처</strong>
							<input type="text" name="supplierMemTel" id="supplierMemTel" class="form-control form-control-sm" maxlength="13" readonly>
						</div>
					</div>

					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name"></label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>이메일</strong>
							<input type="text" name="supplierMemEmail" id="supplierMemEmail" class="form-control form-control-sm" readonly>
						</div>
					</div>
				</div>

				<div style="width: 50%; float: right;">
					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name">공급받는자</label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>사업자명</strong>
							<input class="form-control form-control-sm" id="buyerBizName" name="buyerBizName" type="text" style="width:100%;" readonly>
						</div>
					</div>

					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name"></label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>사업자번호</strong>
							<input type="text" name="buyerBizNo" id="buyerBizNo" class="form-control form-control-sm" readonly>
						</div>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>종사업장번호</strong>
							<input type="text" name="buyerBizSubNo" id="buyerBizSubNo" class="form-control form-control-sm" readonly>
						</div>
					</div>

					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name"></label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>대표자</strong>
							<input type="text" name="buyerCeo" id="buyerCeo" class="form-control form-control-sm" readonly>
						</div>
					</div>

					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name"></label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>사업장주소</strong>
							<input id="buyerAddr" name="buyerAddr" type="text" class="form-control form-control-sm" readonly>
						</div>
					</div>

					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name"></label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>업태</strong>
							<input type="text" name="buyerBizType" id="buyerBizType" class="form-control form-control-sm" readonly>
						</div>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>업종</strong>
							<input type="text" name="buyerBizClass" id="buyerBizClass" class="form-control form-control-sm" readonly>
						</div>
					</div>

					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name"></label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>담당자</strong>
							<input type="text" name="buyerMemName" id="buyerMemName" class="form-control form-control-sm" readonly>
						</div>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>연락처</strong>
							<input type="text" name="buyerMemTel" id="buyerMemTel" class="form-control form-control-sm" maxlength="13" readonly>
						</div>
					</div>

					<div style="height: 50px;" class="form-group row">
						<label class="col-form-label big-name"></label>
						<div class="input-group input-group-sm col middle-name form-group">
							<strong>이메일</strong>
							<input type="text" name="buyerMemEmail" id="buyerMemEmail" class="form-control form-control-sm" readonly>
						</div>
					</div>
				</div>
				<div id="brokerInfoDiv" style="width: 100%" class="form-group row">
					<label class="col-form-label big-name">수탁자</label>
					<div class="input-group input-group-sm col middle-name form-group">
						<strong>&nbsp;</strong>
						<textarea name="brokerInfo" id="brokerInfo" class="form-control form-control-sm textarea" readonly="readonly" rows="3"></textarea>
					</div>
				</div>
			</div>
			<div class="col" id="inGridDiv">
				<table class="form_table" style="width:100%">
					<tbody>
					<tr>
						<th style="padding: 5px 0px;">작성일자</th>
						<th>공급가액</th>
						<th>부가세액</th>
						<th>합계금액</th>
						<th>비고</th>
						<!-- <th>부가세구분</th> -->
						<th>구분</th>
					</tr>
					<tr>
						<td><input type="text" class="col" id="writeDate" name="writeDate" readonly="readonly"></td>
						<td><input type="text" class="col" placeholder="0" id="supprice" name="supprice" value="0" readonly="readonly" style="text-align:right;"></td>
						<td><input type="text" class="col" placeholder="0" id="tax" name="tax" value="0" readonly="readonly" style="text-align:right;"></td>
						<td><input type="text" class="col" placeholder="0" id="totPrice" name="totPrice" value="0" readonly="readonly" style="text-align:right;"></td>
						<td><input type="text" class="col" id="remarks" name="remarks" readonly="readonly"></td>
						<td>
							<div class="form-check-inline col">
								<div class="input-group input-group-sm col radio-or-checkBox">
									<input value="01" id="pubForm01" name="pubForm" type="radio" disabled="disabled">
									<label for="pubForm01" class="label-margin">
										<span>영수</span>
									</label>
								</div>
								<div class="input-group input-group-sm col radio-or-checkBox">
									<input value="02" id="pubForm02" name="pubForm" type="radio" disabled="disabled">
									<label for="pubForm02" class="label-margin">
										<span>청구</span>
									</label>
								</div>
							</div>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
			<table class="form_table" style="width:100%" id="taxDtlTbl">
				<tr>
					<!-- <th>선택</th> -->
					<th style="padding: 5px 0px;">등록일자</th>
					<th>품목</th>
					<th>규격</th>
					<th>수량</th>
					<th>단가</th>
					<th>공급가액</th>
					<th>부가세액</th>
					<th>비고</th>
				</tr>
			</table>
		</div>
	</form>
</div>

<div class="header freightControl">
	<div style="justify-content: space-between; display: flex;" class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">운임관리</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt">
				<input type="hidden" name="sCustId" id="sCustId" class="hiddenValue">
				<input type="hidden" name="driverId" id="driverId" class="hiddenValue">
				<input type="hidden" name="vehicId" id="vehicId" class="hiddenValue">
				<div class="form-group row mt0">
					<div class="input-group-sm col-1 middle-name">
						<input style="padding: 0;" type="text" id="fromDate" name="fromDate" class="col-12">
					</div>
					<span>~</span>
					<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
						<input style="padding: 0;" type="text" id="toDate" name="toDate" class="col-12">
					</div>

					<div class="input-group input-group-sm col radio-or-checkBox">
						<input type="radio" name="dateChk" id="today" value="0"/>
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

					<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
						<select class="form-control" class="custom-select col-12" id="sAllocState" name="sAllocState">
							<option>--배차상태--</option>
						</select>
					</div>

					<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
						<select class="form-control" class="custom-select col-12" id="sDeptId" name="sDeptId">
							<option>--부서명--</option>
						</select>
					</div>

					<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
						<select class="form-control" class="custom-select col-12" id="userId" name="userId"></select>
					</div>

					<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
						<select class="form-control" class="custom-select col-12" id="sellFinishYn" name="sellFinishYn">
							<option value="">매출마감여부</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>

					<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
						<select class="form-control" class="custom-select col-12" id="buyFinishYn" name="buyFinishYn">
							<option value="">매입마감여부</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>

					<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
						<select class="form-control" class="custom-select col-12" id="reqPayYn" name="reqPayYn">
							<option value="">빠른지급여부</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>
				</div>
				
				<div class="form-group row" style="justify-content: space-between">
					<div class="row">
						<div class="wd190 mr10 input-group input-group-sm middle-name">
							<input type="text" id="sCustName" name="sCustName" style="width:100%;">
						</div>
	
						<div class="wd190 mr10 input-group input-group-sm middle-name">
							<input type="text" id="driverValue" name="driverValue" style="width:100%;">
						</div>
	
						<div class="wd190 mr10 input-group input-group-sm middle-name">
							<input type="text" id="sTax" name="sTax" style="width:100%;" class="form-control form-control-sm searchValue">
						</div>
	
						<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
							<select class="form-control" class="custom-select col-12" id="listSSido" name="listSSido">
								<option>상차지</option>
							</select>
						</div>
	
						<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
							<select class="form-control" class="custom-select col-12" id="listESido" name="listESido">
								<option>하차지</option>
							</select>
						</div>
	
						<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
							<select class="custom-select col-12" id="orderStopYn" name="orderStopYn">
								<option value="">선택해주세요.</option>
								<option value="Y">있음</option>
								<option value="N">없음</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="btn_58 input-group input-group-sm middle-name mr10">
							<button onclick="goList()" type="button" style="border-radius:4px" class="btn_58 form-control-sm middle-button-dark">검색</button>
						</div>
						<div class="btn_58 input-group input-group-sm middle-name">
							<button onclick="fReset()"  type="button" class="btn_58 form-control-sm middle-button">초기화</button>
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
											<a href="#" class="k-pager-refresh k-button" id="receiptView" style="display: none;"><b class="btn-b"><i class="k-icon k-i-txt"></i>인수증 보기</b></a>
											<a href="#" class="k-pager-refresh k-button" id="taxView" style="display: none;"><b class="btn-b"><i class="k-icon k-i-txt"></i>세금계산서 보기</b></a>
											<a href="#" class="k-pager-refresh k-button" onClick="goUpdate();"><b class="btn-b">일괄저장</b></a>
											<a href="#" class="k-pager-refresh k-button" onClick="goExcel();"><b class="btn-x">엑셀출력</b></a>
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div style="min-width: 500px;">
							<div style="height:calc(100vh - 409px);" id="grid"></div>
							<!-- /table -->
							<!-- 22.08.24 그리드 시작 -->
							<ul id="gridContextMenu">
								<li id="cSave" class="privateRClick">리스트 현재설정 저장</li>
								<li class="k-separator privateRClick"></li>
								<li id="dSave" class="privateRClick">리스트 세부설정 변경</li>
								<li class="k-separator privateRClick"></li>
								<li id="vReceiptView">인수증 보기</li>
								<li class="k-separator"></li>
								<li id="vTaxView">세금계산서 보기</li>
								<li class="k-separator"></li>

							</ul>
							<!-- /table -->
						</div>
					</div>
				</div>
			</div>
			<!--  -->
		</div>
		<!-- group-list -->
	</div>
</div>
<script type="text/javascript">


	var userId = '${sessionScope.userInfo.userId}';

	$("#gridContextMenu").kendoContextMenu({
		target: "#grid",
		filter: "tr[role='row']"
	});

	var contextMenu = $("#gridContextMenu").data("kendoContextMenu");
	contextMenu.bind("select", onContextMenuSelect);

	var headerTitle = ($("#headerTitle").text());

	var refresh_timer;
	var autoRefresh;

	var searchCustName;
	var searchCar;

	var nonPrivateColumnCheck;

	$(document).ready(function(){
		Util.setCmmCode("select", "listSSido", "SIDO", "", "--상차지--");
		Util.setCmmCode("select", "listESido", "SIDO", "", "--하차지--");
		Util.setCmmCode("select", "sOrderState", "ORDER_STATE_CD", "", "--오더상태--");
		Util.setCmmCode("select", "sAllocState", "ALLOC_STATE_CD", "05", "--배차상태--");
		Util.setCmmCode("select", "sCarMngCode", "CAR_MNG_CD", "", "--차주등급--");
		Util.setCmmCode("select", "sCustMngCode", "CAR_MNG_CD", "", "--거래처등급--");

		var toDay = new Date();
		var year = toDay.getFullYear();
		var month = toDay.getMonth();
		var day = toDay.getDate();
		var fromDate = new Date(year, month-1, 1);
		var minDate =  new Date(year, month-3, day);

		$("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : fromDate, dateInput: true, min : minDate, max : new Date()});
		$("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true, min : minDate, max : new Date()});
		Util.setSearchDateForm();

		Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", {deptId:$(this).val()}, "userId", "userName", "", "전체");
		$('#sDeptId').on('change', function() {
			Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", {deptId:$(this).val()}, "userId", "userName", "", "전체");
		});

		Util.setSelectBox("/contents/basic/data/compDeptList.do", "sDeptId", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn :'Y'}, "deptId", "deptName", "", "--부서명--");

		var $options = $("#sDeptId > option").clone();
		$('#deptId').append($options);
		$("#deptId option[value='']").remove();

		var $options2 = $("#sCarMngCode > option").clone();
		$('#carMngCode').append($options2);
		$("#carMngCode option[value='']").remove();

		taxModal = $("#divTaxInvoice");

		taxModal.kendoDialog({
			width: "1200px",
			height: "620px",
			visible: false,
			title: "세금계산서",
			closable: true,
			modal: false,
			close: function(){
				$("#fTaxInvoice")[0].reset();
			}
		});

		searchCustName = MultiColumnComboBox.setSearchCustName("s", '01', $("#sDeptId").val());
		searchCustName.bind("select", selectSearchCust);
		searchCustName.bind("change", searchCustSelectTrigger);

		searchCar = MultiColumnComboBox.setSearchCarNum("driverValue", $("#sDeptId").val(), "");
		searchCar.bind("select", selectSearchCarNum);
		searchCar.bind("change", searchCarNumSelectTrigger);

		$("#sDeptId").on("change", function(){
			setSearchForm();
		});

		function preventPost(e) {
			if (e.keyCode === 13) {
				goList();
			}
		}

		searchCustName.input.keydown(preventPost);
		searchCar.input.keydown(preventPost);
		columns = setPrivateData("B2510", "grid", userId, columns);

		$("#grid").kendoGrid({
			excel: {
				fileName: headerTitle+"(" + new Date().yyyymmdd() + ").xlsx",
				proxyURL: "/cmm/saveGrid.do",
				filterable: false,
				allPages: true
			},
			excelExport: function(e) {
				if($("#loading").length > 0) $("#loading").hide();
			},dataBound: function(e) {
			nonPrivateColumnCheck = e.sender.columns[0];
			},
			sort: onSortEnd,
			navigatable: true,
			selectable: true,
			sortable : false,
			resizable: true,
			columns : columns,
			noRecords: true,
			editable: true,
			messages: {
				noRecords: "조회된 데이터가 없습니다."
			},
		});
		setOptionActive("B2510", "grid", userId);
		//goList();
	});

	function setSearchForm () {
		$("#sCustId").val("");
		searchCustName = $("#sCustName").data("kendoMultiColumnComboBox");
		searchCustName.value("");
		searchCustName.refresh();
		searchCustName.destroy();
		searchCustName = MultiColumnComboBox.setSearchCustName("s", '01', $("#sDeptId").val());
		searchCustName.bind("select", selectSearchCust);
		searchCustName.bind("change", searchCustSelectTrigger);

		searchCar = $("#driverValue").data("kendoMultiColumnComboBox");
		searchCar.value();
		searchCar.refresh();
		searchCar.destroy();
		searchCar = MultiColumnComboBox.setSearchCarNum("driverValue", $("#sDeptId").val(), "");
		searchCar.bind("select", selectSearchCarNum);
		searchCar.bind("change", searchCarNumSelectTrigger);
	}

	function selectSearchCust(e) {
		var dataItem = e.dataItem;
		if(dataItem != null) {
			$("#sCustId").val(dataItem.custId);
		}else{
			if(e.sender.selectedIndex != -1){
				searchCustName.select(e.sender.selectedIndex);
				var data = e.sender.listView._view[e.sender.selectedIndex];
				$("#sCustId").val(data.item.custId);
			}
		}
	}

	function searchCustSelectTrigger(e){
		if(this.value() != ""){
			searchCustName.trigger("select");
		}else{
			$("#sCustId").val("");
		}
	}

	function selectSearchCarNum(e) {
		var dataItem = e.dataItem;
		if (dataItem != null) {
			$("#vehicId").val(dataItem.vehicId);
			$("#driverId").val(dataItem.driverId);
		} else {
			if(e.sender.selectedIndex != -1){
				searchCar.select(e.sender.selectedIndex);
				var data = e.sender.listView._view[e.sender.selectedIndex];
				$("#vehicId").val(data.item.vehicId);
				$("#driverId").val(data.item.driverId);
			}
		}
	}

	function searchCarNumSelectTrigger(e) {
		if(this.value() != ""){
			searchCar.trigger("select");
		}else{
			$("#vehicId").val("");
			$("#driverId").val("");
		}
	}


	var columns = [
		{ field: "check", width: 70, editable:function(e) {return false;},
			headerTemplate: '<div class="auth-radio-or-checkBox">'
					+ 					'<input style="width: 13px;height: 13px;" type="checkbox" name="orderAllCheck" id="orderAllCheck" class="orderAllCheck"/>'
					+ 					'<label style="display: inline;font-size: 14px;" for="orderAllCheck">선택</label>'
					+ 				'</div>',

			template: '<div class="auth-radio-or-checkBox">'
					+ 		      '<input style="width: 13px;height: 13px;" type="checkbox" name="chkOrderId" value="#=orderId#" id="#=orderId#" class="orderCheck"/>'
					+ 			  '<label for="#=orderId#"></label>'
					+ 		  '</div>'
		},
		{ field: "number", title: "No", width: 70, editable: function (dataItem){}},
		{ field: "sellFinishDate", title: "매출마감일", width: 100, editable: function (dataItem){}},
		{ field: "buyFinishDate", title: "매입마감일", width: 100, editable: function (dataItem){}},
		{ field: "sDateDay", title: "상차일", width: 100, editable: function (dataItem){}},
		{ field: "eDateDay", title: "하차일", width: 100, editable: function (dataItem){}},
		{ field: "reqCustName", title: "화주(거래처)", width: 120, editable: function (dataItem){}},
		{ field: "sAddr", title: "상차지", width: 200, editable: function (dataItem){}},
		{ field: "eAddr", title: "하차지", width: 200, editable: function (dataItem){}},
		{ field: "stopCount", title: "2착지", width: 120, editable: function (dataItem){},
			template: function(dataItem) {
				var comName = "";
				comName = dataItem.stopName;
				if(dataItem.stopCount > 1)
					comName += " 외 " + (dataItem.stopCount-1) + "곳"
				if(comName != "")
					return Util.nvl(comName,"");
			}
		},
		{ field: "returnYn", title: "왕복", width: 70, editable: function (dataItem){}},
		{ field: "sellAmt", title: "청구운임(소계)", width: 150, editable: function (dataItem){},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.sellAmt,"0"));
			},
			attributes: {
				style: "text-align: right"
			}
		},
		{ field: "buyAmt", title: "지불운임(소계)", width: 150, editable: function (dataItem){},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.buyAmt,"0"));
			},
			attributes: {
				style: "text-align: right"
			}
		},
		{ field: "sellCharge", title: "기본운임(청구)", width: 130, type: "number",
			attributes: {
				"class": "#: orderId # sellCharge",
				"style": "text-align: right"
			},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.sellCharge,"0"));
			},
			headerTemplate : '<label class="editHeader">기본운임(청구)</label>'
		},
		{ field: "sellWayPointCharge", title: "경유비(청구)", width: 130, type: "number",
			attributes: {
				"class": "#: orderId # sellWayPointCharge",
				"style": "text-align: right"
			},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.sellWayPointCharge,"0"));
			},
			headerTemplate : '<label class="editHeader">경유비(청구)</label>'
		},
		{ field: "sellStayCharge", title: "대기료(청구)", width: 130, type: "number",
			attributes: {
				"class": "#: orderId # sellStayCharge",
				"style": "text-align: right"
			},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.sellStayCharge,"0"));;
			},
			headerTemplate : '<label class="editHeader">대기료(청구)</label>'
		},
		{ field: "sellHandWorkCharge", title: "수작업비(청구)", width: 130, type: "number",
			attributes: {
				"class": "#: orderId # sellHandWorkCharge",
				"style": "text-align: right"
			},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.sellHandWorkCharge,"0"));
			},
			headerTemplate : '<label class="editHeader">수작업비(청구)</label>'
		},
		{ field: "sellRoundCharge", title: "회차료(청구)", width: 130, type: "number",
			attributes: {
				"class": "#: orderId # sellRoundCharge",
				"style": "text-align: right"
			},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.sellRoundCharge,"0"));
			},
			headerTemplate : '<label class="editHeader">회차료(청구)</label>'
		},
		{ field: "sellOtherAddCharge", title: "기타추가(청구)", width: 130, type: "number",
			attributes: {
				"class": "#: orderId # sellOtherAddCharge",
				"style": "text-align: right"
			},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.sellOtherAddCharge,"0"));
			},
			headerTemplate : '<label class="editHeader">기타추가(청구)</label>'
		},
		{ field: "unitPriceType", title: "운임구분", width: 100, editable: function (dataItem){}},
		{ field: "unitCharge", title: "단가", width: 140, editable: function (dataItem){},
			attributes: {
				style: "text-align: right"
			},
			template: function(dataItem) {
				return Util.formatNumber(dataItem.unitCharge);
			},
		},
		{ field: "sellWeight", title: "청구중량(톤)", width: 130, type: "string",
			attributes: {
				"class": "#: orderId # sellWeight"
			}
		},
		{ field: "reqPayDate", title: "빠른지급신청", width: 130, editable: function (dataItem){}},
		{ field: "buyCharge", title: "기본운임(지불)", width: 130, type: "number",
			attributes: {
				"class": "#: orderId # buyCharge",
				"style": "text-align: right"
			},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.buyCharge,"0"));
			},
			headerTemplate : '<label class="editHeader">기본운임(지불)</label>'
		},
		{ field: "wayPointCharge", title: "경유비(지불)", width: 130, type: "number",
			attributes: {
				"class": "#: orderId # wayPointCharge",
				"style": "text-align: right"
			},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.wayPointCharge,"0"));
			},
			headerTemplate : '<label class="editHeader">경유비(지불)</label>'
		},
		{ field: "stayCharge", title: "대기료(지불)", width: 130, type: "number",
			attributes: {
				"class": "#: orderId # stayCharge",
				"style": "text-align: right"
			},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.stayCharge,"0"));
			},
			headerTemplate : '<label class="editHeader">대기료(지불)</label>'
		},
		{ field: "handWorkCharge", title: "수작업비(지불)", width: 130, type: "number",
			attributes: {
				"class": "#: orderId # handWorkCharge",
				"style": "text-align: right"
			},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.handWorkCharge,"0"));
			},
			headerTemplate : '<label class="editHeader">수작업비(지불)</label>'
		},
		{ field: "roundCharge", title: "회차료(지불)", width: 130, type: "number",
			attributes: {
				"class": "#: orderId # roundCharge",
				"style": "text-align: right"
			},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.roundCharge,"0"));
			},
			headerTemplate : '<label class="editHeader">회차료(지불)</label>'
		},
		{ field: "otherAddCharge", title: "기타추가(지불)", width: 130, type: "number",
			attributes: {
				"class": "#: orderId # otherAddCharge",
				"style": "text-align: right"
			},
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.otherAddCharge,"0"));
			},
			headerTemplate : '<label class="editHeader">기타추가(지불)</label>'
		},
		{ field: "carSctnName", title: "차량구분", width: 100, editable: function (dataItem){}},
		{ field: "chargeType", title: "지불마감기준", width: 130, editable: function (dataItem){}},
		{ field: "carNum", title: "차량번호", width: 140, editable: function (dataItem){}},
		{ field: "driverName", title: "차주명", width: 120, editable: function (dataItem){}},
		{ field: "driverTel", title: "차주전화번호", width: 140, editable: function (dataItem){},
			template: function(dataItem) {
				return Util.formatPhone(dataItem.driverTel);
			}
		},
		{ field: "carTonName", title: "차주톤급", width: 100, editable: function (dataItem){}},
		{ field: "carTypeName", title: "차주차종", width: 120, editable: function (dataItem){}},
		{ field: "buyCustName", title: "소속운송사", width: 150, editable: function (dataItem){}},
		{ field: "receiptDate", title: "인수증(전/실)", width: 120, editable: function (dataItem){}},
		{ field: "taxinvDate", title: "계산서(전/실)", width: 120, editable: function (dataItem){}},
		{ field: "allocStateName", title: "상태", width: 100, editable: function (dataItem){}},
		{ field: "orderId", title: "오더ID", width: 160, editable: function (dataItem){}},
		{ field: "sellAllocId", hidden: true,
			attributes: {
				"class": "#: orderId # sellAllocId"
			}
		},
		{ field: "allocId", hidden: true,
			attributes: {
				"class": "#: orderId # allocId"
			}
		},
		{ field: "buyCarNum", hidden: true,
			attributes: {
				"class": "#: orderId # buyCarNum"
			}
		},
		{ field: "sellCustId", hidden: true,
			attributes: {
				"class": "#: orderId # sellCustId"
			}
		},
		{ field: "sellCustId", hidden: true,
			attributes: {
				"class": "#: orderId # sellCustId"
			}
		},
		{ field: "buyCustId", hidden: true,
			attributes: {
				"class": "#: orderId # buyCustId"
			}
		},
		{ field: "buyDeptId", hidden: true,
			attributes: {
				"class": "#: orderId # buyDeptId"
			}
		},
		{ field: "receiptYn", hidden: true},
		{ field: "taxinvYn", hidden: true},
		{ field: "invId", hidden: true},
	];

	function goList() {
		if($("#driverId").val() == "" && $("#sCustId").val() == ""){
			alert("\"거래처\", \"차량번호\"\n중 하나 이상 입력, 선택해 주세요.");
			return;
		}

		columns = setPrivateData("B2510", "grid", userId, columns);

		$("#grid").text("");
		var grid = $("#grid").kendoGrid({
			dataSource : {
				transport : {
					read : {
						url : "/contents/order/data/freightControlList.do",
						type : "post",
						dataType : "json",
						data : $("#fSearch").serializeObject(),
						beforeSend: function(req) {
							req.setRequestHeader("AJAX", true);
						}
					}
				},
				schema : {
					data : function(response) {
						return response.data;
					},
					total : function(response) {
						return response.total;
					}
				},
				pageSize : 50,
				serverPaging : true,
				serverFiltering : true,
				error : function(e) {
					if(e.xhr.status == "400") {
						alert("세션값이 존재하지 않습니다. 로그인 페이지로 이동합니다.");
						location.href = "/";
					}
				}
			},dataBound: function(e) {
				nonPrivateColumnCheck = e.sender.columns[0];
			},
			excel: {
				fileName: headerTitle+"(" + new Date().yyyymmdd() + ").xlsx",
				proxyURL: "/cmm/saveGrid.do",
				filterable: false,
				allPages: true
			},
			excelExport: function(e) {
				if($("#loading").length > 0) $("#loading").hide();
			},
			navigatable: true,
			selectable: "cell",
			sortable : false,
			resizable: true,
			columns : columns,
			noRecords: true,
			save: onEditSave,
			//change : onChange,
			sort: onSortEnd,
			scrollable: {
				endless: true
			},
			pageable : false,
			messages: {
				noRecords: "조회된 데이터가 없습니다."
			},
			editable: true,
			edit: function(e) {
				// 에디트 타입 변경
                $(".k-textbox").prop("type", "number");
				var editColumn = e.container.find("input");
				setTimeout(function() {
					editColumn.select();
					editColumn.css("text-align", "left");
				}, 1);
			},
		}).data("kendoGrid");

		setOptionActive("B2510", "grid", userId);

		grid.thead.on("click", "#orderAllCheck", orderAllCheckHandler);
		grid.table.on("click", ".orderCheck", orderCheckHandler);

	}

	// 전체 선택 이벤트 핸들러
	function orderAllCheckHandler(e) {
		var grid = $("#grid").data("kendoGrid");
		var checked = this.checked;

		if (checked) {
			// 체크 해제하고 click 트리거 발생
			$(".orderCheck").prop("checked", false).trigger('click');
		} else {
			// 체크 하고 click 트리거 발생
			$(".orderCheck").prop("checked", true).trigger('click');
		}
	}

	// 부분 선택 이벤트 핸들러
	function orderCheckHandler(e) {
		var row = $(this).closest("tr")
		orderCheck(row);
	}

	// row selection
	function orderCheck(row) {
		var grid = $("#grid").data("kendoGrid");
		var dataItem = grid.dataItem(row);
		var checked = $("#" + dataItem.orderId).is(":checked");

		var checkedIds = {};
		checkedIds[dataItem.id] = checked;

		if (checked) {
			row.addClass("k-state-selected");

			// 체크 상태의 경우 전체선택도 체크해줌.
			var total = $(".orderCheck").length;
			var checked = $(".orderCheck:checked").length;
			if (total == checked)
				$("#orderAllCheck").prop("checked", true);
		} else {
			row.removeClass("k-state-selected");

			// 체크 해제상태의 경우 전체선택도 풀어줌.
			$("#orderAllCheck").prop("checked", false);
		}
	}
	function onSortEnd(e) {
		// 정렬 이벤트 발생 시 "check" 컬럼 항목이면 check 이벤트로 처리
		if (e.sort.field == "check") {
			e.preventDefault();
			var orderAllChecked = $("#orderAllCheck").is(":checked");
			if (orderAllChecked) {
				$("#orderAllCheck").prop("checked", false).trigger('click');
			} else {
				$("#orderAllCheck").prop("checked", true).trigger('click');
			}
		} else {
			// 그 외 항목의 경우 allCheck를 풀어줌. -> MultiSorting 기능이 활성화 된 경우
			$("#orderAllCheck").prop("checked", false);
		}
	}
	function onEditSave(e) {

		var sellAmtVal = Number(e.model.get("sellAmt"));
		var buyAmtVal = Number(e.model.get("buyAmt"));

		if (typeof e.values.sellCharge =='number') {
			//sellAmtVal -= Number(e.model.get("sellCharge"));
			sellAmtVal = Number(e.values.sellCharge);
			sellAmtVal += Number(e.model.get("sellWayPointCharge"));
			sellAmtVal += Number(e.model.get("sellStayCharge"));
			sellAmtVal += Number(e.model.get("sellHandWorkCharge"));
			sellAmtVal += Number(e.model.get("sellRoundCharge"));
			sellAmtVal += Number(e.model.get("sellOtherAddCharge"));

			e.model.set("sellAmt", sellAmtVal);
		}
		else if (typeof e.values.sellWayPointCharge =='number') {

			sellAmtVal = Number(e.model.get("sellCharge"));
			sellAmtVal += Number(e.values.sellWayPointCharge);
			sellAmtVal += Number(e.model.get("sellStayCharge"));
			sellAmtVal += Number(e.model.get("sellHandWorkCharge"));
			sellAmtVal += Number(e.model.get("sellRoundCharge"));
			sellAmtVal += Number(e.model.get("sellOtherAddCharge"));

			e.model.set("sellAmt", sellAmtVal);
		}
		else if (typeof e.values.sellStayCharge =='number') {

			sellAmtVal = Number(e.model.get("sellCharge"));
			sellAmtVal += Number(e.model.get("sellWayPointCharge"));
			sellAmtVal += Number(e.values.sellStayCharge);
			sellAmtVal += Number(e.model.get("sellHandWorkCharge"));
			sellAmtVal += Number(e.model.get("sellRoundCharge"));
			sellAmtVal += Number(e.model.get("sellOtherAddCharge"));

			e.model.set("sellAmt", sellAmtVal);
		}
		else if (typeof e.values.sellHandWorkCharge =='number') {
			sellAmtVal = Number(e.model.get("sellCharge"));
			sellAmtVal += Number(e.model.get("sellWayPointCharge"));
			sellAmtVal += Number(e.model.get("sellStayCharge"));
			sellAmtVal += Number(e.values.sellHandWorkCharge);
			sellAmtVal += Number(e.model.get("sellRoundCharge"));
			sellAmtVal += Number(e.model.get("sellOtherAddCharge"));

			e.model.set("sellAmt", sellAmtVal);
		}
		else if (typeof e.values.sellRoundCharge =='number') {
			sellAmtVal = Number(e.model.get("sellCharge"));
			sellAmtVal += Number(e.model.get("sellWayPointCharge"));
			sellAmtVal += Number(e.model.get("sellStayCharge"));
			sellAmtVal += Number(e.model.get("sellHandWorkCharge"));
			sellAmtVal += Number(e.values.sellRoundCharge);
			sellAmtVal += Number(e.model.get("sellOtherAddCharge"));

			e.model.set("sellAmt", sellAmtVal);
		}
		else if (typeof e.values.sellOtherAddCharge =='number') {
			sellAmtVal = Number(e.model.get("sellCharge"));
			sellAmtVal += Number(e.model.get("sellWayPointCharge"));
			sellAmtVal += Number(e.model.get("sellStayCharge"));
			sellAmtVal += Number(e.model.get("sellHandWorkCharge"));
			sellAmtVal += Number(e.model.get("sellRoundCharge"));
			sellAmtVal += Number(e.values.sellOtherAddCharge);

			e.model.set("sellAmt", sellAmtVal);
		}
		else if (typeof e.values.buyCharge =='number') {
			buyAmtVal = Number(e.values.buyCharge);
			buyAmtVal += Number(e.model.get("wayPointCharge"));
			buyAmtVal += Number(e.model.get("stayCharge"));
			buyAmtVal += Number(e.model.get("handWorkCharge"));
			buyAmtVal += Number(e.model.get("roundCharge"));
			buyAmtVal += Number(e.model.get("otherAddCharge"));

			e.model.set("buyAmt", buyAmtVal);
		}
		else if (typeof e.values.wayPointCharge =='number') {

			buyAmtVal = Number(e.model.get("buyCharge"));
			buyAmtVal += Number(e.values.wayPointCharge);
			buyAmtVal += Number(e.model.get("stayCharge"));
			buyAmtVal += Number(e.model.get("handWorkCharge"));
			buyAmtVal += Number(e.model.get("roundCharge"));
			buyAmtVal += Number(e.model.get("otherAddCharge"));

			e.model.set("buyAmt", buyAmtVal);
		}
		else if (typeof e.values.stayCharge =='number') {
			buyAmtVal = Number(e.model.get("buyCharge"));
			buyAmtVal += Number(e.model.get("wayPointCharge"));
			buyAmtVal += Number(e.values.stayCharge);
			buyAmtVal += Number(e.model.get("handWorkCharge"));
			buyAmtVal += Number(e.model.get("roundCharge"));
			buyAmtVal += Number(e.model.get("otherAddCharge"));

			e.model.set("buyAmt", buyAmtVal);
		}
		else if (typeof e.values.handWorkCharge =='number') {
			buyAmtVal = Number(e.model.get("buyCharge"));
			buyAmtVal += Number(e.model.get("wayPointCharge"));
			buyAmtVal += Number(e.model.get("stayCharge"));
			buyAmtVal += Number(e.values.handWorkCharge);
			buyAmtVal += Number(e.model.get("roundCharge"));
			buyAmtVal += Number(e.model.get("otherAddCharge"));

			e.model.set("buyAmt", buyAmtVal);
		}
		else if (typeof e.values.roundCharge =='number') {
			buyAmtVal = Number(e.model.get("buyCharge"));
			buyAmtVal += Number(e.model.get("wayPointCharge"));
			buyAmtVal += Number(e.model.get("stayCharge"));
			buyAmtVal += Number(e.model.get("handWorkCharge"));
			buyAmtVal += Number(e.values.roundCharge);
			buyAmtVal += Number(e.model.get("otherAddCharge"));

			e.model.set("buyAmt", buyAmtVal);
		}
		else if (typeof e.values.otherAddCharge =='number') {
			buyAmtVal = Number(e.model.get("buyCharge"));
			buyAmtVal += Number(e.model.get("wayPointCharge"));
			buyAmtVal += Number(e.model.get("stayCharge"));
			buyAmtVal += Number(e.model.get("handWorkCharge"));
			buyAmtVal += Number(e.model.get("roundCharge"));
			buyAmtVal += Number(e.values.otherAddCharge);

			e.model.set("buyAmt", buyAmtVal);
		}
		var row = e.container.closest("tr");
		var checkBoxId = e.model.get("orderId");
		var checked = $("#" + checkBoxId).is(":checked");

		if (!checked) {
			$("#" + checkBoxId).prop("checked", true);
			row.addClass("k-state-selected");
		}
	}
/*	function onChange(e){
		var grid = $("#grid").data("kendoGrid");
		var data = grid.dataItem(e.target);
		var row = grid.select();
		var multiSelectedData = [];

		for(var i = 0; i < row.length; i++) {
			multiSelectedData.push(grid.dataItem(row[i]));
		}

		if(multiSelectedData.length != '1'){
			/!* 인수증, 세금계산서 버튼 숨기기 *!/
			$("#taxView").hide();
			$("#receiptView").hide();
		}else{
			/!* 인수증, 세금계산서 버튼 표시 *!/
			$("#taxView").show();
			$("#receiptView").show();
		}
	}*/

	$('#taxView, #receiptView').click(function(){
		var grid = $("#grid").data("kendoGrid");
		var row = grid.select();
		var data = grid.dataItem(row);
		if(this.id == 'taxView'){
			viewTax(data.invId, data.taxinvYn, data.orderId, data.allocId);
		}else{
			viewReceipt(data.receiptYn, data.orderId);
		}
	});

	function viewReceipt(receiptYn, orderId) {
		if(receiptYn == "P"){
			alert("종이 인수증 입니다.");
			return;
		}else if(receiptYn != "Y"){
			alert("등록된 인수증이 없습니다.");
			return;
		}
		window.open("/contents/calc/view/orderFile.do?orderId="+orderId, "PopupPost", "width=620, height=707");
	}

	function viewTax(invId, taxinvYn, orderId, allocId){
		if(taxinvYn == "N"){
			alert("등록된 세금계산서가 없습니다.");
			return;
		}else if(taxinvYn == 'P'){
			alert("종이 세금계산서 입니다.")
			return;
		}
		$.ajax({
			url: "/contents/calc/data/viewTax.do",
			type: "POST",
			dataType: "json",
			data: {
				invId: invId,
				orderId: orderId,
				allocId: allocId
			},
			success: function(data){
				data.data.buyerMemTel = Util.formatPhone(data.data.buyerMemTel)
				data.data.supplierMemTel = Util.formatPhone(data.data.supplierMemTel)
				data.data.supplierBizNo = Util.formatBizNum(data.data.supplierBizNo)
				data.data.buyerBizNo = Util.formatBizNum(data.data.buyerBizNo)
				Util.setPageData(data.data);
				var tax = 0;
				var supprice = 0;
				$('#taxDtlTbl tr:gt(0)').remove();
				for(var i=0; i<data.data2.length; i++){
					var str = "";
					str += "<tr>" +
							"<td><input type='text' class='col' id='itemDate'       name='itemDate'     value='" + data.data2[i].itemDate + "'		readonly></td>" +
							"<td><input type='text' class='col' id='itemName'       name='itemName'     value='" + data.data2[i].itemName + "'		readonly></td>" +
							"<td><input type='text' class='col' id='itemType'       name='itemType'     value='" + data.data2[i].itemType + "'		readonly></td>" +
							"<td><input type='text' class='col' id='itemQty'        name='itemQty'      value='" + data.data2[i].itemQty + "'		readonly></td>" +
							"<td><input type='text' class='col' id='itemPrice'      name='itemPrice'    value='" + Util.formatNumber(data.data2[i].itemSupprice) + "'	readonly></td>" +
							"<td><input type='text' class='col' id='itemSupprice'   name='itemSupprice' value='" + Util.formatNumber(data.data2[i].itemSupprice) + "'	readonly></td>" +
							"<td><input type='text' class='col' id='itemTax'  		name='itemTax'      value='" + Util.formatNumber(data.data2[i].itemTax) + "'		readonly></td>" +
							"<td><input type='text' class='col' id='itemRemarks'    name='itemRemarks'  value='" + data.data2[i].itemRemarks + "'	readonly></td>" +
						"</tr>";
					tax += data.data2[i].itemTax;
					supprice += data.data2[i].itemSupprice;
					$("#taxDtlTbl").append(str);
				}
				$("#tax").val(Util.formatNumber(tax));
				$("#supprice").val(Util.formatNumber(supprice));
				$("#totPrice").val(Util.formatNumber(tax+supprice));
				$("input:radio[name='pubForm']:input[value=" + data.data.pubForm + "]").prop("checked", true);
				var str = "수탁자 주소 : ("+data.data.brokerAddr+"), 수탁자 업태 : ("+data.data.brokerBizType+"), 수탁자 업종 : ("+data.data.brokerBizClass+")"
						+ "\n수탁자 사업자명 : ("+data.data.brokerBizName+"), 수탁자 사업자 번호 ("+Util.formatBizNum(data.data.brokerBizNo)+"), 수탁 대표자 : ("+data.data.brokerCeo+")"
						+ "\n수탁 담당자 : ("+data.data.brokerMemName+"), 수탁자 연락처 : ("+Util.formatPhone(data.data.brokerMemTel)+"), 수탁자 이메일 : ("+data.data.brokerMemEmail+")";
				$("#brokerInfo").val(str);
				taxModal.data("kendoDialog").open();
			}
		});
	}

	function changeEvent(name){
		$("#grid").on("change", "input." + name , function(e) {
			if(name == "orderAllCheck"){
				if($("#orderAllCheck").is(":checked")){
					$("input[name=chkOrderId]").prop("checked", true);
				}else{
					$("input[name=chkOrderId]").prop("checked", false);
				}
			}else{
				var total = $("input[name=chkOrderId]").length;
				var checked = $("input[name=chkOrderId]:checked").length;
				if(total != checked){
					$("#orderAllCheck").prop("checked", false);
				} else {
					$("#orderAllCheck").prop("checked", true);
				}
				if(checked > 0){
					$("#orderAllCheck").prop("checked", true);
				}
			}
		});
	}

	function goUpdate(){

		var order = {};
		var ordersArray = [];

		var rows = $(".orderCheck:checked");
		var grid = $("#grid").data("kendoGrid");

		if(rows.length > 0){
			for (var l=0; l<rows.length; l++) {
				var dataItem = grid.dataItem(rows[l].closest("tr"));

				order.orderId = dataItem.orderId.toString();
				order.sellCharge = dataItem.sellCharge.toString();
				order.sellWayPointCharge = dataItem.sellWayPointCharge.toString();
				order.sellStayCharge = dataItem.sellStayCharge.toString();
				order.sellHandWorkCharge = dataItem.sellHandWorkCharge.toString();
				order.sellRoundCharge = dataItem.sellRoundCharge.toString();
				order.sellOtherAddCharge = dataItem.sellOtherAddCharge.toString();
				order.sellWeight = dataItem.sellWeight.toString();
				order.buyCharge = dataItem.buyCharge.toString();
				order.wayPointCharge = dataItem.wayPointCharge.toString();
				order.stayCharge = dataItem.stayCharge.toString();
				order.handWorkCharge = dataItem.handWorkCharge.toString();
				order.roundCharge = dataItem.roundCharge.toString();
				order.otherAddCharge = dataItem.otherAddCharge.toString();
				order.sellAllocId = dataItem.sellAllocId.toString();
				order.allocId = dataItem.allocId.toString();
				order.buyCarNum = dataItem.buyCarNum.toString();
				order.sellCustId = dataItem.sellCustId.toString();
				order.sellDeptId = dataItem.sellDeptId.toString();
				order.buyCustId = dataItem.buyCustId.toString();
				order.buyDeptId = dataItem.buyDeptId.toString();

				ordersArray.push({...order});
			}

			$.ajax({
				url: "/contents/order/data/freightControlUpdate.do",
				type: "POST",
				dataType: "json",
				data: "orderData=" + JSON.stringify(ordersArray),
				beforeSend: function(xmlHttpRequest) {
					xmlHttpRequest.setRequestHeader("AJAX", "true");
					$("#loading").show();
				},
				success: function(data) {
					if(data.result) {
						alert(data.msg);
						goList();
					} else {
						alert(data.msg);
					}
				},
				complete: function() {
					$("#loading").hide();
				}
			});
		}else{
			alert("하나이상 오더를 선택해 주세요.");
			return false;
		}
	}

	// 기존 일괄 저장 function
	/*function goUpdate(){
		var editOrderId = [];
		var order = {};
		var ordersArray = [];

		$("input[name=chkOrderId]").each(function() {
			if($(this).is(":checked")) {
				editOrderId.push($(this).val());
			}
		});

		if(editOrderId.length > 0){
			for (var l=0; l<editOrderId.length; l++) {
				order.orderId = editOrderId[l];
				alert($("."+editOrderId[l]).html());
				alert($("."+editOrderId[l]).text());
				order.sellCharge = $("."+editOrderId[l])[0].innerText.replace(/,/g, "");
				order.sellWayPointCharge = $("."+editOrderId[l])[1].innerText.replace(/,/g, "");
				order.sellStayCharge = $("."+editOrderId[l])[2].innerText.replace(/,/g, "");
				order.sellHandWorkCharge = $("."+editOrderId[l])[3].innerText.replace(/,/g, "");
				order.sellRoundCharge = $("."+editOrderId[l])[4].innerText.replace(/,/g, "");
				order.sellOtherAddCharge = $("."+editOrderId[l])[5].innerText.replace(/,/g, "");
				order.sellWeight = $("."+editOrderId[l])[6].innerText;
				order.buyCharge = $("."+editOrderId[l])[7].innerText.replace(/,/g, "");
				order.wayPointCharge = $("."+editOrderId[l])[8].innerText.replace(/,/g, "");
				order.stayCharge = $("."+editOrderId[l])[9].innerText.replace(/,/g, "");
				order.handWorkCharge = $("."+editOrderId[l])[10].innerText.replace(/,/g, "");
				order.roundCharge = $("."+editOrderId[l])[11].innerText.replace(/,/g, "");
				order.otherAddCharge = $("."+editOrderId[l])[12].innerText.replace(/,/g, "");
				order.sellAllocId = $("."+editOrderId[l])[13].innerText;
				order.allocId = $("."+editOrderId[l])[14].innerText;
				order.buyCarNum = $("."+editOrderId[l])[15].innerText;
				order.sellCustId = $("."+editOrderId[l])[16].innerText;
				order.sellDeptId = $("."+editOrderId[l])[17].innerText;
				order.buyCustId = $("."+editOrderId[l])[18].innerText;
				order.buyDeptId = $("."+editOrderId[l])[19].innerText;
				ordersArray.push({...order});
			}

			$.ajax({
				url: "/contents/order/data/freightControlUpdate.do",
				type: "POST",
				dataType: "json",
				data: "orderData=" + JSON.stringify(ordersArray),
				beforeSend: function(xmlHttpRequest) {
					xmlHttpRequest.setRequestHeader("AJAX", "true");
					$("#loading").show();
				},
				success: function(data) {
					if(data.result) {
						alert(data.msg);
						goList();
					} else {
						alert(data.msg);
					}
				},
				complete: function() {
					$("#loading").hide();
				}
			});
		}else{
			alert("하나이상 오더를 선택해 주세요.");
			return false;
		}
	}*/

	function fReset(){
		$("#fSearch")[0].reset();
		$(".hiddenValue").val("");
	}

	function goExcel(){
		$("#loading").show();
		var grid = $("#grid").data("kendoGrid");
		grid.saveAsExcel();
	}

	function onContextMenuSelect(e) {
		var item = e.item.id;

		switch (item) {
			case "cSave":
				setPrivateSaveData("B2510", "grid", userId);
				break;
			case "dSave":
				setPrivatePanel("B2510", "grid", userId);
				break;
			case "vReceiptView":
				var grid = $("#grid").data("kendoGrid");
				var dataItem = grid.dataItem(e.target);

				viewReceipt(dataItem.receiptYn, dataItem.orderId);
				break;
			case "vTaxView":

				var grid = $("#grid").data("kendoGrid");
				var dataItem = grid.dataItem(e.target);

				viewTax(dataItem.invId, dataItem.taxinvYn, dataItem.orderId, dataItem.allocId);
				break;

		}
	}
	/*function onContextMenuSelect(e) {
		var item = e.item.id;

		switch (item) {
			case "cSave":
				setPrivateSaveData("B2510", "grid", userId);
				break;
			case "dSave":
				setPrivatePanel("B2510", "grid", userId);
				break;
			case "copyOrderId":
				// 클립보드 복사
				var grid = $("#grid").data("kendoGrid");
				var dataItem = grid.dataItem(e.target);
				copyOrderId(dataItem.orderId);
				break;
			case "vReceipt":
				var grid = $("#grid").data("kendoGrid");
				var dataItem = grid.dataItem(e.target);
				viewReceipt(dataItem.receiptYn, dataItem.orderId);
				break;
			case "taxinvPostSendCancel":
				taxInvPostSendCancel();
				break;
			case "cancelCalc":
				calcFinishCancel();
				break;
			case "cancelDeleteCalc":
				cancelDeleteCalc();
				break;
		}
	}*/

</script>
