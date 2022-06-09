<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

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

<div class="header">
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
			<div class="form-group row">
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>상차일자</strong>
				    <input style="padding: 0;" type="text" id="fromDate" name="fromDate" class="col-12">
				</div>
				<span style="margin-top: 31px;">~</span>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>　</strong>
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
				<strong>배차상태</strong>
				    <select class="form-control" class="custom-select col-12" id="sAllocState" name="sAllocState">
				    	<option>--배차상태--</option>
				    </select>
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>배차부서명</strong>
				    <select class="form-control" class="custom-select col-12" id="sDeptId" name="sDeptId">
				    	<option>--부서명--</option>
				    </select>
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>배차담당자</strong>
				    <select class="form-control" class="custom-select col-12" id="userId" name="userId"></select>
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>매출마감여부</strong>
				    <select class="form-control" class="custom-select col-12" id="sellFinishYn" name="sellFinishYn">
				    	<option value="">매출마감여부</option>
				    	<option value="Y">Y</option>
				    	<option value="N">N</option>
				    </select>
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>매입마감여부</strong>
				    <select class="form-control" class="custom-select col-12" id="buyFinishYn" name="buyFinishYn">
				    	<option value="">매입마감여부</option>
				    	<option value="Y">Y</option>
				    	<option value="N">N</option>
				    </select>
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>빠른지급여부</strong>
				    <select class="form-control" class="custom-select col-12" id="reqPayYn" name="reqPayYn">
				    	<option value="">빠른지급여부</option>
				    	<option value="Y">Y</option>
				    	<option value="N">N</option>
				    </select>
				</div>
			</div>
				
			<div class="form-group row">
				<div class="input-group input-group-sm col-2 middle-name">
				<strong>거래처(화주)</strong>
				    <input type="text" id="sCustName" name="sCustName" style="width:100%;">
				</div>
				
				<div class="input-group input-group-sm col-2 middle-name">
				<strong>차량번호</strong>
				    <input type="text" id="driverValue" name="driverValue" style="width:100%;">
				</div>
				
				<div class="input-group input-group-sm col-2 middle-name">
				<strong>계산서발행지</strong>
				    <input type="text" id="sTax" name="sTax" style="width:100%;" class="form-control form-control-sm searchValue">
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>상차지</strong>
				    <select class="form-control" class="custom-select col-12" id="listSSido" name="listSSido">
				    	<option>상차지</option>
				    </select>
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>하차지</strong>
				    <select class="form-control" class="custom-select col-12" id="listESido" name="listESido">
				    	<option>하차지</option>
				    </select>
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>경유지 여부</strong>
				    <select class="custom-select col-12" id="orderStopYn" name="orderStopYn">
				    	<option value="">선택해주세요.</option>
				        <option value="Y">있음</option>
				        <option value="N">없음</option>
				    </select>
				</div>
                
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1" style="max-width:90px;min-width:90px;">
				<strong>　</strong>
				    <button onclick="goList()" type="button" style="border-radius:4px" class="form-control form-control-sm middle-button-dark"><i class="k-icon k-i-search"></i>검색</button>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1" style="max-width:90px;min-width:90px;">
				<strong>　</strong>
				    <button onclick="fReset()"  type="button" class="form-control form-control-sm middle-button"><i class="k-icon k-i-reset-sm"></i>초기화</button>
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
											<a href="#" class="k-pager-refresh k-button" onClick="goUpdate();"><b class="btn-b"><i class="k-icon k-i-paste-plain-text"></i>일괄저장</b></a>
											<a href="#" class="k-pager-refresh k-button" onClick="goExcel();"><b class="btn-x"><i class="k-icon k-i-file-excel"></i>엑셀출력</b></a>
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div style="min-width: 500px;">
							<div style="height:calc(100vh - 409px);" id="grid"></div>
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
var headerTitle = ($("#headerTitle").text());

var searchCustName;
var searchCar;
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

	$("#grid").kendoGrid({
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
		{ width: 70, editable:function(e) {return false;}, 
		    headerTemplate: '<div class="auth-radio-or-checkBox">'
			 + 					'<input style="width: 13px;height: 13px;" type="checkbox" name="orderAllCheck" id="orderAllCheck" class="orderAllCheck"/>'
		     + 					'<label style="display: inline;font-size: 14px;" for="orderAllCheck">선택</label>'
		     + 				'</div>',
		    
			template: '<div class="auth-radio-or-checkBox">'
			 + 		      '<input style="width: 13px;height: 13px;" type="checkbox" name="chkOrderId" value="#=orderId#" id="#=orderId#" class="orderId"/>'
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
		{ field: "sellCharge", title: "기본운임(청구)", width: 130, type: "string",
			attributes: {
                "class": "#: orderId # sellCharge",
   				"style": "text-align: right" 
            },
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.sellCharge,"0"));
			}
		},	
		{ field: "sellWayPointCharge", title: "경유비(청구)", width: 130, type: "string",
			attributes: {
                "class": "#: orderId # sellWayPointCharge",
     			"style": "text-align: right" 
            },
			template: function(dataItem) {
				return Util.formatNumber(dataItem.sellWayPointCharge);
			}
		},	
		{ field: "sellStayCharge", title: "대기료(청구)", width: 130, type: "string",
			attributes: {
                "class": "#: orderId # sellStayCharge",
     			"style": "text-align: right" 
            },
			template: function(dataItem) {
				return Util.formatNumber(dataItem.sellStayCharge);
			}
		},	
		{ field: "sellHandWorkCharge", title: "수작업비(청구)", width: 130, type: "string",
			attributes: {
                "class": "#: orderId # sellHandWorkCharge",
     			"style": "text-align: right" 
            },
			template: function(dataItem) {
				return Util.formatNumber(dataItem.sellHandWorkCharge);
			}
		},	
		{ field: "sellRoundCharge", title: "회차료(청구)", width: 130, type: "string",
			attributes: {
                "class": "#: orderId # sellRoundCharge",
     			"style": "text-align: right" 
            },
			template: function(dataItem) {
				return Util.formatNumber(dataItem.sellRoundCharge);
			}
		},	
		{ field: "sellOtherAddCharge", title: "기타추가(청구)", width: 130, type: "string",
			attributes: {
                "class": "#: orderId # sellOtherAddCharge",
     			"style": "text-align: right" 
            },
			template: function(dataItem) {
				return Util.formatNumber(dataItem.sellOtherAddCharge);
			}
		},	
		{ field: "unitPriceType", title: "운임구분", width: 100, editable: function (dataItem){}},
		{ field: "unitCharge", title: "단가", width: 140, editable: function (dataItem){},
			template: function(dataItem) {
				return Util.formatNumber(dataItem.unitCharge);
			},
			attributes: {
     			style: "text-align: right" 
            },
		},	
		{ field: "sellWeight", title: "청구중량(톤)", width: 130, type: "string",
			attributes: {
	            "class": "#: orderId # sellWeight"
	        }
		},
		{ field: "reqPayDate", title: "빠른지급신청", width: 130, editable: function (dataItem){}},
		{ field: "buyCharge", title: "기본운임(지불)", width: 130, type: "string",
			attributes: {
                "class": "#: orderId # buyCharge",
     			"style": "text-align: right" 
            },
			template: function(dataItem) {
				return Util.formatNumber(Util.nvl(dataItem.buyCharge,"0"));
			}
		},	
		{ field: "wayPointCharge", title: "경유비(지불)", width: 130, type: "string",
			attributes: {
                "class": "#: orderId # wayPointCharge",
     			"style": "text-align: right"
            },
			template: function(dataItem) {
				return Util.formatNumber(dataItem.wayPointCharge);
			}
		},	
		{ field: "stayCharge", title: "대기료(지불)", width: 130, type: "string",
			attributes: {
                "class": "#: orderId # stayCharge",
     			"style": "text-align: right"
            },
			template: function(dataItem) {
				return Util.formatNumber(dataItem.stayCharge);
			}
		},	
		{ field: "handWorkCharge", title: "수작업비(지불)", width: 130, type: "string",
			attributes: {
                "class": "#: orderId # handWorkCharge",
     			"style": "text-align: right"
            },
			template: function(dataItem) {
				return Util.formatNumber(dataItem.handWorkCharge);
			}
		},	
		{ field: "roundCharge", title: "회차료(지불)", width: 130, type: "string",
			attributes: {
                "class": "#: orderId # roundCharge",
     			"style": "text-align: right"
            },
			template: function(dataItem) {
				return Util.formatNumber(dataItem.roundCharge);
			}
		},	
		{ field: "otherAddCharge", title: "기타추가(지불)", width: 130, type: "string",
			attributes: {
                "class": "#: orderId # otherAddCharge",
     			"style": "text-align: right"
            },
			template: function(dataItem) {
				return Util.formatNumber(dataItem.otherAddCharge);
			}
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
 	$("#grid").text("");
	$("#grid").kendoGrid({
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
			pageSize : 20,
			serverPaging : true,
			serverFiltering : true,
			error : function(e) {
				if(e.xhr.status == "400") {
					alert("세션값이 존재하지 않습니다. 로그인 페이지로 이동합니다.");
					location.href = "/";
				}
			}
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
        selectable: true,
		sortable : false,
        resizable: true,
		columns : columns,
    	noRecords: true,
    	change : onChange,
        scrollable: {
        	endless: true
        },
        pageable : false,
	  	messages: {
			noRecords: "조회된 데이터가 없습니다."
	  	},
    	editable: true,
    	edit: function(e) {
    		var container = e.container;
    		var orderId = container.parent("tr")[0].childNodes[0].children[0].children[0].id;
    		
    		if(container.context.classList[1] != "sellWeight") {
				$(".k-textbox").prop("type", "number");
				$(".k-textbox").attr("onKeyup", "this.value=this.value.replace(/[^-0-9]/g,'')");
    		}else{
    			$(".k-textbox").prop("type", "number");
    		}
    	},
	});
	changeEvent("chkOrderId");
	changeEvent("orderAllCheck");
}

function onChange(e){
	var grid = $("#grid").data("kendoGrid");
	var data = grid.dataItem(e.target);
	var row = grid.select();
	var multiSelectedData = [];
	
	for(var i = 0; i < row.length; i++) {
		multiSelectedData.push(grid.dataItem(row[i]));
	}
	
	if(multiSelectedData.length != '1'){
		/* 인수증, 세금계산서 버튼 숨기기 */
		$("#taxView").hide();
		$("#receiptView").hide();
	}else{
		/* 인수증, 세금계산서 버튼 표시 */
		$("#taxView").show();
		$("#receiptView").show();
	}
}

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
}

function fReset(){
	$("#fSearch")[0].reset();
	$(".hiddenValue").val("");
}

function goExcel(){
	$("#loading").show();
	var grid = $("#grid").data("kendoGrid");
	grid.saveAsExcel();
}
</script>