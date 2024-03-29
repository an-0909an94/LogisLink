<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#purchDeadstyle .k-grid-content {max-height:calc(100vh - 310px)}
</style>

<div id="divTaxInvoice" class="editor-warp p-0">
	<form class="modalEditor" id="fTaxInvoice" data-toggle="validator" role="form" autocomplete="off">
       <div class="enter_form" style="padding: 1.875em;">
          <!-- 공급자/공급받는자 정보 -->
          <div style="display: inline-block; width: 100%">
	          <div style="width: 49%; float: left;padding-right:10px" class="gray_box ">
	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name">공급자</label>
	                 <div class="input-group input-group-sm col middle-name form-group">
	                 	<strong>사업자명</strong>
	                 	<input class="form-control form-control-sm wd420" id="supplierBizName" name="supplierBizName" type="text" readonly>
	                 </div>
	              </div>

	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name"></label>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>사업자번호</strong>
		                 <input type="text" name="supplierBizNo" id="supplierBizNo" class="form-control form-control-sm wd200" readonly>
		             </div>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>종사업장번호</strong>
		                 <input type="text" name="supplierBizSubNo" id="supplierBizSubNo" class="form-control form-control-sm wd200" readonly>
		             </div>
	              </div>

	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name"></label>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>대표자</strong>
		                 <input type="text" name="supplierCeo" id="supplierCeo" class="form-control form-control-sm wd200" readonly>
		             </div>
	              </div>

	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name"></label>
	                 <div class="input-group input-group-sm col middle-name form-group">
	                 <strong>사업장주소</strong>
	                 	<input id="supplierAddr" name="supplierAddr" type="text" class="form-control form-control-sm wd420" readonly>
	                 </div>
	              </div>

	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name"></label>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>업태</strong>
		                 <input type="text" name="supplierBizType" id="supplierBizType" class="form-control form-control-sm wd200" readonly>
		             </div>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>업종</strong>
		                 <input type="text" name="supplierBizClass" id="supplierBizClass" class="form-control form-control-sm wd200" readonly>
		             </div>
	              </div>

	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name"></label>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>담당자</strong>
		                 <input type="text" name="supplierMemName" id="supplierMemName" class="form-control form-control-sm wd200" readonly>
		             </div>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>연락처</strong>
		                 <input type="text" name="supplierMemTel" id="supplierMemTel" class="form-control form-control-sm wd200" maxlength="13" readonly>
		             </div>
	              </div>

	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name"></label>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>이메일</strong>
		                 <input type="text" name="supplierMemEmail" id="supplierMemEmail" class="form-control form-control-sm wd200" readonly>
		             </div>
	              </div>
	          </div>

	          <div style="width: 49%; float: right;" class="gray_box">
	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name">공급받는자</label>
	                 <div class="input-group input-group-sm col middle-name form-group">
	                 <strong>사업자명</strong>
	                 	<input class="form-control form-control-sm wd420" id="buyerBizName" name="buyerBizName" type="text" style="width:100%;" readonly>
	                 </div>
	              </div>

	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name"></label>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>사업자번호</strong>
		                 <input type="text" name="buyerBizNo" id="buyerBizNo" class="form-control form-control-sm wd200" readonly>
		             </div>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>종사업장번호</strong>
		                 <input type="text" name="buyerBizSubNo" id="buyerBizSubNo" class="form-control form-control-sm wd200" readonly>
		             </div>
	              </div>

	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name"></label>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>대표자</strong>
		                 <input type="text" name="buyerCeo" id="buyerCeo" class="form-control form-control-sm wd200" readonly>
		             </div>
	              </div>

	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name"></label>
	                 <div class="input-group input-group-sm col middle-name form-group">
	                 <strong>사업장주소</strong>
	                 	<input id="buyerAddr" name="buyerAddr" type="text" class="form-control form-control-sm wd420" readonly>
	                 </div>
	              </div>

	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name"></label>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>업태</strong>
		                 <input type="text" name="buyerBizType" id="buyerBizType" class="form-control form-control-sm wd200" readonly>
		             </div>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>업종</strong>
		                 <input type="text" name="buyerBizClass" id="buyerBizClass" class="form-control form-control-sm wd200" readonly>
		             </div>
	              </div>

	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name"></label>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>담당자</strong>
		                 <input type="text" name="buyerMemName" id="buyerMemName" class="form-control form-control-sm wd200" readonly>
		             </div>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>연락처</strong>
		                 <input type="text" name="buyerMemTel" id="buyerMemTel" class="form-control form-control-sm wd200" maxlength="13" readonly>
		             </div>
	              </div>

	              <div style="height: 50px;" class="form-group row">
	                 <label class="col-form-label big-name"></label>
		             <div class="input-group input-group-sm col middle-name form-group">
		             <strong>이메일</strong>
		                 <input type="text" name="buyerMemEmail" id="buyerMemEmail" class="form-control form-control-sm wd200" readonly>
		             </div>
	              </div>
	          </div>
			  <div id="brokerInfoDiv" style="width: 100%;height:100%" class="form-group row hd100 gray_box">
				  <label class="col-form-label big-name">수탁자</label>
				  <div class="input-group input-group-sm col middle-name form-group">
				     <textarea name="brokerInfo" id="brokerInfo" class="form-control textarea wd1000" style="height: 100%" readonly="readonly" rows="3"></textarea>
				  </div>
			  </div>
          </div>
          <div class="col" id="inGridDiv" style="padding-top: 10px" class="gray_box">
             <table class="form_table" style="width:100%;border-collapse: separate">
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
	                   <td><input type="text" class="col btn_gra_tax" 					id="writeDate" 	name="writeDate" 			readonly="readonly" style="text-align:right;"></td>
	                   <td><input type="text" class="col btn_gra_tax" placeholder="0" 	id="supprice" 	name="supprice" value="0" 	readonly="readonly" style="text-align:right;"></td>
	                   <td><input type="text" class="col btn_gra_tax" placeholder="0" 	id="tax" 		name="tax" 		value="0" 	readonly="readonly" style="text-align:right;"></td>
	                   <td><input type="text" class="col btn_gra_tax" placeholder="0" 	id="totPrice" 	name="totPrice" value="0" 	readonly="readonly" style="text-align:right;"></td>
	                   <td><input type="text" class="col btn_gra_tax" 					id="remarks" 	name="remarks" 				readonly="readonly" style="text-align:right;"></td>
	                   <td>
	                      <div class="form-check-inline btn_gra_tax" style="border-radius:10px;width:100%">
	                          <div class="input-group input-group-sm col radio-or-checkBox">
				            	<input value="01" id="pubForm01" name="pubForm" type="radio" disabled="disabled">
				            	<label for="pubForm01" class="label-margin" style="padding-bottom: 0px">
				            	<span>영수</span>
				            	</label>
				             </div>
				             <div class="input-group input-group-sm col radio-or-checkBox">
				            	<input value="02" id="pubForm02" name="pubForm" type="radio" disabled="disabled">
				            	<label for="pubForm02" class="label-margin" style="padding-bottom: 0px">
				            	<span>청구</span>
				               	</label>
				             </div>
	                      </div>
	                   </td>
	                </tr>
	             </tbody>
             </table>
          </div>
          <table class="form_table" style="width:100%;border-collapse: separate" id="taxDtlTbl">
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
			<P id="headerTitle">매입마감(기타계약)</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" name="fSearch" method="post" class="date-bnt">
				<input type="hidden" name="sCustId" id="sCustId" class="hiddenValue">
				<input type="hidden" name="driverId" id="driverId" class="hiddenValue">
				<input type="hidden" name="vehicId" id="vehicId" class="hiddenValue">
				<!-- 검색 1라인 -->
				<div class="form-group row mt0">
					<div class="input-group input-group-sm wd90 middle-name">
						<input style="padding: 0;" type="text" id="fromDate" name="fromDate"
							   class="wd90">
					</div>
					<span>~</span>
					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<input style="padding: 0;" type="text" id="toDate" name="toDate"
							   class="wd90">
					</div>

					<div class="input-group input-group-sm wd90 radio-or-checkBox">
						<input type="radio" name="dateChk" id="today" value="0"/>
						<label for="today" class="label-margin">
							<span>오늘</span>
						</label>
					</div>
					<div class="input-group input-group-sm wd90 radio-or-checkBox">
						<input type="radio" name="dateChk" id="yesterday" value="1"/>
						<label for="yesterday" class="label-margin">
							<span>어제</span>
						</label>
					</div>
					<div class="input-group input-group-sm wd90 radio-or-checkBox">
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

					<div class="input-group input-group-sm wd120 middle-name div-min-col-1">
						<select class="form-control custom-select wd120" id="sAllocState"
								name="sAllocState">
							<option value="">배차상태</option>
						</select>
					</div>

					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="form-control" class="custom-select wd90" id="sDeptId"
								name="sDeptId">
							<option value="">배차부서명</option>
						</select>
					</div>

					<div class="input-group input-group-sm wd100 middle-name div-min-col-1">
						<select class="form-control custom-select wd100" id="userId"
								name="userId"></select>
					</div>

					<div class="input-group input-group-sm wd110 middle-name div-min-col-1">
						<select class="form-control" class="custom-select" style="width:100%"
								id="sellFinishYn" name="sellFinishYn">
							<option value="">매출마감여부</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>

					<div class="input-group input-group-sm wd110 middle-name div-min-col-1">
						<select class="form-control" class="custom-select" style="width:100%"
								id="buyFinishYn" name="buyFinishYn">
							<option value="">매입마감여부</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>

					<div class="input-group input-group-sm wd110 middle-name div-min-col-1">
						<select class="form-control" class="custom-select" style="width:100%"
								id="reqPayYn" name="reqPayYn">
							<option value="">빠른지급여부</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>
				</div>

				<!-- 검색 2라인 -->
				<div class="form-group row" style="justify-content: space-between">
					<div class="row">
						<div class="input-group input-group-sm wd110 middle-name div-min-col-1">
							<select class="form-control custom-select wd110"
									id="carContractCode" name="carContractCode"></select>
						</div>

						<div class="input-group input-group-sm wd190 media190 middle-name div-min-col-1">
							<input type="text" id="driverValue" name="driverValue"
								   style="width:100%;" placeholder="차량번호" class="p-input">
						</div>

						<div class="input-group input-group-sm wd290 media290 middle-name div-min-col-1">
							<input type="text" id="sCustName" name="sCustName" style="width:100%;"
								   placeholder="거래처(화주)" class="p-input">
						</div>

						<div class="input-group input-group-sm wd190 media190 middle-name div-min-col-1">
							<input type="text" id="sTax" name="sTax" style="width:100%;"
								   class="form-control form-control-sm searchValue"
								   placeholder="계산서 발행지">
						</div>

						<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
							<select class="form-control" class="custom-select wd90" id="listSSido"
									name="listSSido">
								<option>상차지</option>
							</select>
						</div>

						<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
							<select class="form-control" class="custom-select wd90" id="listESido"
									name="listESido">
								<option>하차지</option>
							</select>
						</div>

						<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
							<select class="custom-select wd100" id="orderStopYn" name="orderStopYn">
								<option value="">경유지 여부</option>
								<option value="Y">있음</option>
								<option value="N">없음</option>
							</select>
						</div>
					</div>

					<div class="row">
						<div class="input-group-sm middle-name mr10">
							<button onclick="goList()" type="button"
									class="form-control-sm btn_58 btn_b">검색
							</button>
						</div>
						<div class="input-group-sm middle-name">
							<button onclick="fReset()" type="button"
									class="form-control-sm middle-button btn_58 btn_black">초기화
							</button>
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
											<a href="#" class="k-pager-refresh k-button wd100"
											   id="receiptView" style="display: none;"><b
													class="btn-b">인수증 보기</b></a>
											<a href="#" class="k-pager-refresh k-button wd100"
											   id="taxView" style="display: none;"><b class="btn-b">세금계산서
												보기</b></a>
											<a href="#" class="k-pager-refresh k-button wd100"
											   onClick="goPurchaseDivision()"><b class="btn-b">매입액
												배부계산</b></a>
											<a href="#" class="k-pager-refresh k-button wd100"
											   onClick="saveAll();"><b class="btn-b">배부액
												일괄저장</b></a>
											<a href="#" class="k-pager-refresh k-button wd100"
											   onClick="goExcel();"><b class="btn-x">엑셀출력</b></a>
										</div>
									</div>
								</div>
								<div class="btn-row">
									<div class="tool_group">
										<div class="mr10">
											<input type="text" id="purchase" name="purchase"
												   class="k-pager-refresh"
												   style="width:120px;height:27px;background-color: #f6f6f6;">
										</div>
									</div>
								</div>
								<div class="btn-row" style="float:left;">
									<div class="tool_group">
										<div style="width:400px;">
											※ 조회되는 금액은 배차 관리 기준 금액입니다.<br>최종 마감 금액은 정산관리에서 확인해주세요.
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div class="form-group row" style="padding: 0.625em 0em 0.625em 0em;height:48px">
							<table id="simpleDataRow">
								<thead>
								<tr>
									<th><span>매출마감 : </span><span id="sellFinishCnt">건</span></th>
									<th><span>매입마감 : </span><span id="buyFinishCnt">건</span></th>
									<th><span>배차건수 : </span><span id="allocCnt">건</span></th>
									<th><span>매출액(소계) : </span><span id="sellAmt"></span></th>
									<th><span>매입액(소계) : </span><span id="buyAmt"></span></th>
									<th><span>배부액(소계) : </span><span id="divisionAmt"></span></th>
									<!-- <th><span>지급액(소계) : </span><span id=""></span></th> -->
								</tr>
								</thead>
							</table>
						</div>
						<!--
						<div id="splitter" style="min-width: 500px; max-width: 100vw; min-height:100vh ;height: 100%;">
						-->

							<div id="splitter" style="min-width: 500px; max-width: 100vw; min-height:calc(100vh - 310px);">

							<div class="top-pane">
								<div style="height: 100%;" id="purchDead"></div>
							</div>
							<div class="bottom-pane">
								<div style="height: 100%" id="subGrid"></div>
							</div>
						</div>
						<div style="min-width: 500px;">
							<div style="height:calc(100vh - 409px);" id="purchDeadstyle"></div>

							<!-- 22.08.29 황정환 기존 그리드 개인화 설정 응용 -->
							<ul id="purchDeadContextMenu">
								<li id="cSave" class="privateRClick">리스트 현재설정 저장</li>
								<li class="k-separator privateRClick"></li>
								<li id="dSave" class="privateRClick">리스트 세부설정 변경</li>
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
var headerTitle = ($("#headerTitle").text());

var searchCustName;
var searchCar;
var submitChk = true;

var userId='${sessionScope.userInfo.userId}';

$(window).bind("resize", function() {
	$("#splitter").css("height", "calc(100vh - 310px)");

	$("#splitter").data("kendoGrid").resize();
});

$("#purchDeadContextMenu").kendoContextMenu({
	target: "#purchDead",
	filter: "tr[role='row']"
});

var contextMenu = $("#purchDeadContextMenu").data("kendoContextMenu");
contextMenu.bind("select", onContextMenuSelect);

$(document).ready(function(){
 	$("#splitter").kendoSplitter({
        orientation: "vertical",
		height: "100%",
        panes: [{resizable:true}, {resizable:true}]
 	});
    Util.setCmmCode("select", "listSSido", "SIDO", "", "상차지");
    Util.setCmmCode("select", "listESido", "SIDO", "", "하차지");
    Util.setCmmCode("select", "sOrderState", "ORDER_STATE_CD", "", "오더상태");
    Util.setCmmCode("select", "sAllocState", "ALLOC_STATE_CD", "05", "배차상태");
    Util.setCmmCode("select", "carContractCode", "CAR_CONTRACT_CD", "03", "차주계약유형");
	Util.setCmmCode("select", "sCarMngCode", "CAR_MNG_CD", "", "차주등급");
	Util.setCmmCode("select", "sCustMngCode", "CAR_MNG_CD", "", "거래처등급");

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

	Util.setSelectBox("/contents/basic/data/compDeptList.do", "sDeptId", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn :'Y'}, "deptId", "deptName", "", "부서명");

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

	searchCar = MultiColumnComboBox.setSearchCarNum("driverValue", $("#sDeptId").val(), $("#carContractCode").val());
	searchCar.bind("select", selectSearchCarNum);
	searchCar.bind("change", searchCarNumSelectTrigger);

	$("#sDeptId").on("change", function(){
		setSearchForm();
	});

	$("#carContractCode").on("change", function(){
		setSearchForm();
	});

	$("#simpleDataRow").kendoGrid({
        height: 0,
        sortable: false,
       	scrollable: false
    });

	function preventPost(e) {
    	if (e.keyCode === 13) {
    		goList();
    	}
    }

	searchCustName.input.keydown(preventPost);
	searchCar.input.keydown(preventPost);
	//goList();
	columns = setPrivateData("C3710","purchDead",userId,columns);

	$("#purchDead").kendoGrid({
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
		dataBound: function(e) {
			nonPrivateColumnCheck = e.sender.columns[0];
		},
		sort: onSortEnd
	})
	setOptionActive("C3710", "purchDead", userId);

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
	searchCar = MultiColumnComboBox.setSearchCarNum("driverValue", $("#sDeptId").val(), $("#carContractCode").val());
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

function searchCustSelectTrigger(e) {
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
	}else{
		if(e.sender.selectedIndex != -1){
			searchCar.select(e.sender.selectedIndex);
			var data = e.sender.listView._view[e.sender.selectedIndex];
			$("#vehicId").val(data.item.vehicId);
			$("#driverId").val(data.item.driverId);
		}
	}
// 	var dataItem = e.dataItem;
// 	if (dataItem == null) {
// 		$("#vehicId").val("");
// 		$("#driverId").val("");
// 	} else {
// 		$("#vehicId").val(dataItem.vehicId);
// 		$("#driverId").val(dataItem.driverId);
// 	}
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
		{ field: "check" , width: 70, editable:function(e) {return false;},
		    headerTemplate: '<div class="auth-radio-or-checkBox">'
			 + 					'<input style="width: 13px;height: 13px;" type="checkbox" name="orderAllCheck" id="orderAllCheck" class="orderAllCheck"/>'
		     + 					'<label style="display: inline;font-size: 14px;" for="orderAllCheck">선택</label>'
		     + 				'</div>',

			template: '<div class="auth-radio-or-checkBox">'
			 + 		      '<input style="width: 13px;height: 13px;" type="checkbox" name="chkOrderId" id="#=orderId#" value="#=orderId#" class="orderCheck"/>'
			 + 			  '<label for="#=orderId#"></label>'
		     + 		  '</div>'
		},
		{ field: "number", title: "No", width: 70, editable: function (dataItem){}},
		{ field: "sellFinishDate", title: "매출마감일", width: 100, editable: function (dataItem){}},
		{ field: "buyFinishDate", title: "매입마감일", width: 100, editable: function (dataItem){}},
		{ field: "sDateDay", title: "상차일", width: 100, editable: function (dataItem){}},
		{ field: "eDateDay", title: "하차일", width: 100, editable: function (dataItem){}},
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
		{ field: "sellAmt", title: "매출액(소계)", width: 150, editable: function (dataItem){},
			template: function(dataItem) {
				return Util.formatNumber(dataItem.sellAmt);
			},
			attributes: {
				style: "text-align: right"
			}
		},
		{ field: "buyAmt", title: "매입액(소계)", width: 150, editable: function (dataItem){},
			template: function(dataItem) {
				return Util.formatNumber(dataItem.buyAmt);
			},
			attributes: {
				style: "text-align: right"
			}
		},
		{ field: "divisionCharge", title: "배부액(조정)", width: 150, type: "string",
			attributes: {
				"class" : "#: orderId # divisionCharge",
				"onKeyup" : "this.value=this.value.replace(/[^-0-9]/g,'');",
				"style" : "text-align: right"
			},
			template: function(dataItem) {
				var divisionCharge = Util.nvl(Util.formatNumber(dataItem.divisionCharge),"0");
				var regex = /[^0-9]/g;
				var result = divisionCharge.replace(regex, "");
				return Util.formatNumber(result);
			},
		},
		/* { field: "", title: "지급액(소계)", width: 150, editable: function (dataItem){}}, */
		{ field: "tranYn", title: "명세서", width: 150, editable: function (dataItem){}},
		{ field: "unitPriceType", title: "운임구분", width: 150, editable: function (dataItem){}},
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
		{ field: "sellWeight", title: "청구중량", width: 130, editable: function (dataItem){}},
		{ field: "reqPayDate", title: "빠른지급신청", width: 130, editable: function (dataItem){}},
		{ field: "receiptDate", title: "인수증(전/실)", width: 120, editable: function (dataItem){}},
		{ field: "taxinvDate", title: "계산서(전/실)", width: 120, editable: function (dataItem){}},
		{ field: "reqCustName", title: "화주(거래처)", width: 120, editable: function (dataItem){}},
		{ field: "driverBizName", title: "계산서발행지", width: 120, editable: function (dataItem){}},
		{ field: "appName", title: "어플명", width: 120, editable: function (dataItem){}},
		{ field: "finishMemo", title: "마감시메모", width: 120, editable: function (dataItem){}},
		{ field: "refContent1", title: "참고내용1", width: 120, editable: function (dataItem){}},
		{ field: "refContent2", title: "참고내용2", width: 120, editable: function (dataItem){}},
		{ field: "reportBizNum", title: "신고용사업자번호", width: 120, editable: function (dataItem){}},
		{ field: "reportBizName", title: "신고용사업자명", width: 120, editable: function (dataItem){}},
		{ field: "payReturnMemo", title: "지급반려사유", width: 120, editable: function (dataItem){}},
		{ field: "goodsName", title: "화물명", width: 120, editable: function (dataItem){}},
		{ field: "mngDeptName", title: "배차부서", width: 120, editable: function (dataItem){}},
		{ field: "staffName", title: "배차원", width: 120, editable: function (dataItem){}},
		{ field: "finishUserName", title: "마감원", width: 120, editable: function (dataItem){}},
		{ field: "allocStateName", title: "상태", width: 100, editable: function (dataItem){}},
		{ field: "orderId", title: "오더ID", width: 160, editable: function (dataItem){}},
		{ field: "sellAllocId", hidden: true},
		{ field: "sellCharge", hidden: true},
		{ field: "buyCharge", hidden: true},
		{ field: "allocId", hidden: true,
			attributes: {
                "class": "#: orderId # allocId"
            }
        },
        { field: "otherAddCharge", hidden: true,
			attributes: {
                "class": "#: orderId # otherAddCharge"
            }
        }
];

var subColumns = [
	{ field: "orderId", title: "오더ID", width: 150},
	{ field: "calcTypeName", title: "정산항목", width: 100},
	{ field: "sellCharge", title: "매출액", width: 100,
		attributes: {
			style: "text-align: right"
		}
	},
	{ field: "buyCharge", title: "매입액", width: 100,
		attributes: {
			style: "text-align: right"
		}
	}
]
var sellAmt = 0;

var nonPrivateColumnCheck;

function goList() {

	if(!$("#driverId").val() && !$("#vehicId").val()) {
		alert("조회할 차량번호를 선택해주세요.");
		return;
	}

	// 22.08.29 황정환 기존 그리드 개인화 설정 응용 -> 메뉴코드, 그리드아이디, 접속사용자아이디, 기존 컬럼정보 전달
	columns = setPrivateData("C3710","purchDead",userId,columns);

	$("#divisionAmt").html("");
	$("#purchDead").text("");
	var grid = $("#purchDead").kendoGrid({
		dataSource : {
			transport : {
				read : {
					url : "/contents/calc/data/purchaseDeadline.do",
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
					if(response.summary != null) {
						sellAmt = response.summary.sellAmt;
						$("#sellFinishCnt").html(Util.formatNumber(response.summary.sellFinishCnt) + "건");
						$("#buyFinishCnt").html(Util.formatNumber(response.summary.buyFinishCnt) + "건");
						$("#sellAmt").html(Util.formatNumber(response.summary.sellAmt));
						$("#buyAmt").html(Util.formatNumber(response.summary.buyAmt));
						$("#allocCnt").html(Util.formatNumber(response.summary.allocCnt) + "건");
					}
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
		},
		dataBound: function(e) {
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
        selectable: true,
		sortable : false,
        resizable: true,
        scrollable: true,
		columns : columns,
    	noRecords: true,
    	change : onChange,
		sort: onSortEnd,
    	editable: true,
    	edit: function(e) {
    		var prevCharge = $("#divisionCharge").val();
			$('#divisionCharge').on("blur", function() {
				var newCharge = $('#divisionCharge').val();
				if(newCharge != prevCharge){
					var divisionAmt = 0;
					setTimeout(function() {
						for(var i=0; i<$(".divisionCharge").length; i++){
							if($(".divisionCharge")[i].tagName == "TD"){
								var charge = $(".divisionCharge")[i].textContent.replace(/[^0-9]/g, "");
								var sum = parseInt(Util.nvl(charge,"0"));
								divisionAmt += sum;
							}
						}
						if(isNaN(divisionAmt)){
							$("#divisionAmt").html("\"숫자만\" 입력해 주세요.");
							submitChk = false;
						}else{
							$("#divisionAmt").html(Util.formatNumber(divisionAmt));
							submitChk = true;
						}
					}, 50);
				}
			});
    	},
	  	messages: {
			noRecords: "조회된 데이터가 없습니다."
	  	},

	}).data("kendoGrid");

	// 22.08.29 황정환 기존 그리드 개인화 설정 응용 -> 그리드 옵션 활성화 여부 처리
	// 추가로 페이지에서 적용되는 이벤트가 있는 경우
	// 그 이벤트 앞에 아래 함수 호출 부분이 적용되어야 함
	setOptionActive("C3710", "purchDead", userId);

	grid.thead.on("click", "#orderAllCheck", orderAllCheckHandler);
	grid.table.on("click", ".orderCheck", orderCheckHandler);

	//changeEvent("chkOrderId");
	//changeEvent("orderAllCheck");
}

//매입액 일괄계산
function goPurchaseDivision() {

	var purchase = $("#purchase").val().replace(/[^0-9]/g, "");
	if(!purchase) {
		alert("배부대상총매입액을 입력해주세요.");
		return;
	}
	var grid = $("#purchDead").data("kendoGrid");
	var data = grid.dataSource._data;
	//var gridData = JSON.stringify(grid.dataSource._data);

	if(data.length == 0) {
		alert("데이터를 조회해주세요.");
		return;
	}
	var divisionAmt = 0;
	for(var i=0, item; item = data[i]; i++) {
		var divisionCharge = (item.sellCharge == 0) ? 0 : item.sellAmt / sellAmt * purchase;
		//divisionCharge = Math.ceil(divisionCharge / 100) * 100 ;
		divisionCharge = Math.floor(divisionCharge);
		item.divisionCharge = divisionCharge;
		divisionAmt += divisionCharge;
	}

	$("#divisionAmt").html(Util.formatNumber(divisionAmt));

	var dataSource = new kendo.data.DataSource({
		data: grid.dataSource._data,
	});

	grid.setDataSource(dataSource);
	grid.thead.on("click", "#orderAllCheck", orderAllCheckHandler);
	grid.table.on("click", ".orderCheck", orderCheckHandler);

}

function onChange(e){

	var grid = $("#purchDead").data("kendoGrid");
	var data = grid.dataItem(e.target);
	var row = grid.select();
	var multiSelectedData = [];

	for(var i = 0; i < row.length; i++) {
		multiSelectedData.push(grid.dataItem(row[i]));
	}

	var selectedData = grid.dataItem(row[row.length-1]);
	var orderId = selectedData.orderId;
	var allocId = selectedData.allocId;
	var sellCharge = Util.formatNumber(selectedData.sellCharge);
	var buyCharge = Util.formatNumber(selectedData.buyCharge);
	var sellAllocId = selectedData.sellAllocId;

	if(multiSelectedData.length != '1'){
		/* 인수증, 세금계산서 버튼 숨기기 */
		$("#taxView").hide();
		$("#receiptView").hide();
	}else{
		/* 인수증, 세금계산서 버튼 표시 */
		$("#taxView").show();
		$("#receiptView").show();
	}

	$("#subGrid").text("");
	$("#subGrid").kendoGrid({
		dataSource : {
			transport : {
				read : {
					url : "/contents/calc/data/addChargeList.do",
					type : "post",
					dataType : "json",
					data : {orderId : orderId},
					beforeSend: function(req) {
						req.setRequestHeader("AJAX", true);
					}
				}
			},
			schema : {
				data : function(response) {
					var dataList = [];
					var chargeData = {"orderId" : orderId, "calcTypeName" : "내수운송료", "buyCharge" : buyCharge, "sellCharge" : sellCharge}
					var wayPointData = {"orderId" : orderId, "calcTypeName" : "경유비", "buyCharge" : 0, "sellCharge" : 0};
					var stayData = {"orderId" : orderId, "calcTypeName" : "대기료", "buyCharge" : 0, "sellCharge" : 0};
					var handWorkData = {"orderId" : orderId, "calcTypeName" : "수작업비", "buyCharge" : 0, "sellCharge" : 0};
					var roundData = {"orderId" : orderId, "calcTypeName" : "회차료", "buyCharge" : 0, "sellCharge" : 0};
					var otherAddData = {"orderId" : orderId, "calcTypeName" : "기타추가비", "buyCharge" : 0, "sellCharge" : 0};

					for(var i=0, item; item=response.data[i]; i++) {
						switch(item.calcTypeCode) {
						case "0023" :
							if(item.allocId == allocId) wayPointData["buyCharge"] =  Util.formatNumber(item.addCharge);
							if(item.allocId == sellAllocId) wayPointData["sellCharge"] =  Util.formatNumber(item.addCharge);
							break;
						case "0025" :
							if(item.allocId == allocId) stayData["buyCharge"] =  Util.formatNumber(item.addCharge);
							if(item.allocId == sellAllocId) stayData["sellCharge"] =  Util.formatNumber(item.addCharge);
							break;
						case "0371" :
							if(item.allocId == allocId) handWorkData["buyCharge"] =  Util.formatNumber(item.addCharge);
							if(item.allocId == sellAllocId) handWorkData["sellCharge"] =  Util.formatNumber(item.addCharge);
							break;
						case "0372" :
							if(item.allocId == allocId) roundData["buyCharge"] =  Util.formatNumber(item.addCharge);
							if(item.allocId == sellAllocId) roundData["sellCharge"] =  Util.formatNumber(item.addCharge);
							break;
						case "0294" :
							if(item.allocId == allocId) otherAddData["buyCharge"] =  Util.formatNumber(item.addCharge);
							if(item.allocId == sellAllocId) otherAddData["sellCharge"] =  Util.formatNumber(item.addCharge);
							break;
						}
					}
					dataList.push(chargeData);
					dataList.push(wayPointData);
					dataList.push(stayData);
					dataList.push(handWorkData);
					dataList.push(roundData);
					dataList.push(otherAddData);
					return dataList;
				}
			},
			serverPaging : false,
			serverFiltering : true,
			error : function(e) {
				if(e.xhr.status == "400") {
					alert("세션값이 존재하지 않습니다. 로그인 페이지로 이동합니다.");
					location.href = "/";
				}
			}
		},
		navigatable: true,
        selectable: true,
		sortable : false,
        resizable: true,
        scrollable: true,
		columns : subColumns,
    	noRecords: true,
    	editable: false,
	  	messages: {
			noRecords: "조회된 데이터가 없습니다."
	  	},
		// 22.08.29 황정환 기존 그리드 개인화 설정 응용
		reorderable: true, // 컬럼 위치 변경
		columnReorder: onReorderEnd, // 컬럼 위치 변경 이벤트
		columnResize: onResizeEnd, // 컬럼 사이즈 변경 이벤트
	});

}

$('#taxView, #receiptView').click(function(){

	var grid = $("#purchDead").data("kendoGrid");
	var row = grid.select();
	var data = grid.dataItem(row);
	if(this.id == 'taxView'){
 		viewTax(data.invId, data.taxinvYn, data.orderId, data.allocId);
	}else{
	 	viewReceipt(data.receiptYn, data.orderId);
	}
});

function saveAll(){



	if(!confirm("배부액(조정)은 마감 건을 제외하고 저장됩니다. 이미 마감된 건은 기존 금액이 그대로 유지됩니다.")) {
		return;
	}

	if(!submitChk){
		alert("\"배부액\"을 확인해 주세요.");
		return;
	}

	var ordersArray = [];
	var grid = $("#purchDead").data("kendoGrid");

	var rows = grid.select();

	if(rows.length < 1){
		alert("하나이상 오더를 선택해 주세요.");
		return false;
	}else{
		rows.each(function (index, row) {
			gridData = grid.dataItem(this);
			if(typeof gridData.divisionCharge != "undefined" && gridData.divisionCharge != null
					&& gridData.divisionCharge != "" && gridData.divisionCharge.toString() != "0") {
				debugger;
				order = {};
				order.orderId = gridData.orderId;
				order.divisionCharge = gridData.divisionCharge.toString().replace(/,/g, "");
				order.allocId = gridData.allocId;
				order.addCharge = gridData.otherAddCharge;
				ordersArray.push(order);
			}
		});
	}
	if(ordersArray.length >0){
		$.ajax({
			url: "/contents/calc/data/updateCharge.do",
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
		alert("\"배부액\"을 확인해 주세요.");
		return;
	}


//	return;

/*
	var editOrderId = [];
	var order = {};
	//var ordersArray = [];
/!*
	if(!confirm("배부액(조정)은 마감 건을 제외하고 저장됩니다. 이미 마감된 건은 기존 금액이 그대로 유지됩니다.")) {
		return;
	}

	if(!submitChk){
		alert("\"배부액\"을 확인해 주세요.");
		return;
	}*!/

	$("input[name=chkOrderId]").each(function(){
		if($(this).is(":checked")) {
			editOrderId.push($(this).val());
		}
	});

	if(editOrderId.length > 0){

		for (var l=0; l<editOrderId.length; l++) {
			order = {};
			order.orderId = editOrderId[l];
			order.divisionCharge = $("."+editOrderId[l])[0].innerText.replace(/,/g, "");
			order.allocId = $("."+editOrderId[l])[1].innerText;
			order.addCharge = $("."+editOrderId[l])[2].innerText;
		    ordersArray.push(order);
		}

		$.ajax({
			url: "/contents/calc/data/updateCharge.do",
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
	}*/
}

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
			        "<td><input type='text' class='col btn_gra_tax' id='itemDate'       name='itemDate'     value='" + data.data2[i].itemDate 							+ "'readonly style='text-align:right;'></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemName'       name='itemName'     value='" + data.data2[i].itemName 							+ "'readonly style='text-align:right;'></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemType'       name='itemType'     value='" + data.data2[i].itemType 							+ "'readonly style='text-align:right;'></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemQty'        name='itemQty'      value='" + data.data2[i].itemQty 							+ "'readonly style='text-align:right;'></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemPrice'      name='itemPrice'    value='" + Util.formatNumber(data.data2[i].itemSupprice) 	+ "'readonly style='text-align:right;'></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemSupprice'   name='itemSupprice' value='" + Util.formatNumber(data.data2[i].itemSupprice) 	+ "'readonly style='text-align:right;'></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemTax'  		name='itemTax'      value='" + Util.formatNumber(data.data2[i].itemTax) 		+ "'readonly style='text-align:right;'></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemRemarks'    name='itemRemarks'  value='" + data.data2[i].itemRemarks 						+ "'readonly style='text-align:right;'></td>" +
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

	$("#purchDead").on("change", "input." + name , function(e) {
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

function fReset(){
	$("#fSearch")[0].reset();
	$(".hiddenValue").val("");
}

function goExcel(){
	$("#loading").show();

	var grid = $("#purchDead").data("kendoGrid");
	grid.saveAsExcel();
}

$("#purchase").on("input", function(){
	$(this).val(Util.formatNumberInput($(this).val()));
});

function onContextMenuSelect(e) {

	var grid = $("#purchDead").data("kendoGrid");
	var data = grid.dataItem(e.target);
	var row = grid.select();
	var multiSelectedData = [];
	var item = e.item.id;

	for(var i = 0; i < row.length; i++) {
		multiSelectedData.push(grid.dataItem(row[i]));
	}

	switch (item) {
		case "cSave" : // 리스트 현재설정 저장 버튼 이벤트
			setPrivateSaveData("C3710", "purchDead", userId);
			break;
		case "dSave" : // 리스트 세부설정 변경 버튼 이벤트
			setPrivatePanel("C3710", "purchDead", userId);
			break;
	}
}

// 정렬 이벤트 핸들러
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

// 전체 선택 이벤트 핸들러
function orderAllCheckHandler(e) {
	var grid = $("#purchDead").data("kendoGrid");
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
	var grid = $("#purchDead").data("kendoGrid");
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

</script>