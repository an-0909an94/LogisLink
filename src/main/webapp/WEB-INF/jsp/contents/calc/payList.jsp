<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#calcList .k-grid-content {max-height:calc(100vh - 260px)}
</style>

<!--출금 요청-->
<div id="outreqModal" class="editor-warp p-0">
	<form class="modalEditor" id="fOutreqModal" style="display: block">
		<div class="modalHeader">
	        <div class="form-group row">
	            <label class="col-form-label big-name">출금방법</label>
				<div class="input-group-sm col">
				    <select class="form-control" class="custom-select wd140" style="width: 80%" id="outKind" name="outKind">
				    	<option value="F">펌뱅킹</option>
				    	<option value="I">인터넷뱅킹</option>
				    </select>
				</div>
			</div>
		</div>
		<div class="editor_btns" style="text-align: center">
			<div class="padding">
		        <a onclick="outreqModalSubmit()" class="k-pager-refresh k-button btn_b"><b class="btn-b">출금요청</b></a>
		        <a onclick="outreqModalClose()" class="k-pager-refresh k-button"><b class="btn-g">닫기</b></a>
	        </div>
	    </div>
	</form>
</div>

<!-- 지급반려 Modal -->
<div id="payReturnModal" class="editor-warp p-0">
	<form class="modalEditor" id="fPayReturnModal">
		<div class="modalHeader">
	        <div class="form-group row">
	            <label class="col-form-label big-name">반려내용</label>
				<div class="input-group input-group-sm wd310 middle-name">
					<textarea id="payReturnMemo" name="payReturnMemo" class="form-control textarea" style="width: 100%" rows="4"></textarea>
				</div>
			</div>
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <a onclick="payReturnModalSubmit()" class="k-pager-refresh k-button btn_b"><b class="btn-b">반려요청</b></a>
		        <a onclick="payReturnModalClose()" class="k-pager-refresh k-button"><b class="btn-g">닫기</b></a>
	        </div>
	    </div>
	</form>
</div>

<!-- 출금처리 Modal -->
<div id="divWithdrawalFinish" class="editor_wrap p-0">
    <form id="fWithdrawalFinish" class="modalEditor" data-toggle="validator" role="form" autocomplete="off">
        <input type="hidden" id="paySeqArr" name="paySeqArr" class="hiddenValue">
        <div class="modalHeader50">
            <div class="form-group row">
                <div id="finishMessage" style="text-align: left; padding: 0px; font-size: 17px;">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name">출금처리일자</label>
                <div style="text-align: left;" class="input-group input-group-sm col middle-name">
                    <input style="padding: 0;" type="text" id="withdrawalFinishDate" name="withdrawalFinishDate" class="col-12">
                </div>
            </div>
        </div>
        <div class="editor_btns">
            <div class="padding">
                <button type="submit" id="fWithdrawalFinishSubmitBtn" class="k-pager-refresh k-button btn_b"><b class="btn-b"><strong>확인</strong></b></button>
                <a onclick="withdrawalFinishModalClose()" class="k-pager-refresh k-button"><b class="btn-g">취소</b></a>
            </div>
        </div>
    </form>
</div>
<!-- 출금처리 Modal End -->

<!-- 출금예정일 변경 Modal -->
<div id="divChangeWithdrawalDueDate" class="editor_wrap p-0">
    <form id="fChangeWithdrawalDueDate" class="modalEditor" data-toggle="validator" role="form" autocomplete="off">
        <input type="hidden" id="changeWithdrawalDueDateArr" name="changeWithdrawalDueDateArr" class="hiddenValue">
        <div class="modalHeader">
            <div class="form-group row">
                <div id="ChangeMessage" style="text-align: left; padding: 0px; font-size: 17px;">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name">출금예정일자</label>
                <div style="text-align: left;" class="input-group input-group-sm col middle-name">
                    <input style="padding: 0;" type="text" id="withdrawalDueDate" name="withdrawalDueDate" class="col-12">
                </div>
            </div>
        </div>
        <div class="editor_btns">
            <div class="padding">
                <button type="submit" id="fChangeWithdrawalDueDateSubmitBtn" class="k-pager-refresh k-button btn_b"><b class="btn-b"><strong>확인</strong></b></button>
                <a onclick="changeWithdrawalDueDateModalClose()" class="k-pager-refresh k-button"><b class="btn-g">취소</b></a>
            </div>
        </div>
    </form>
</div>
<!-- 출금예정일 변경 Modal End -->

<div class="header">
	<div style="justify-content: space-between; display: flex;" class="summary p30">
        <div class="hdr-tit">
            <P id="headerTitle">운송비지급</P>
        </div>
        <div id="summaryData" style="height: 30px;">
            <div style="display: contents;" class="col input-group i-name">
                <i id="groupCount" style="font-size: larger;"></i>
            </div>
        </div>
    </div>
    
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt" method="post">
			<input type="hidden" name="custId" id="custId" class="hiddenValue">
			<input type="hidden" name="deptId" id="deptId" class="hiddenValue">
			<input type="hidden" name="vehicId" id="vehicId" class="hiddenValue">
			<input type="hidden" name="driverId" id="driverId" class="hiddenValue">
			<input type="hidden" name="hCustName" id="hCustName" class="hiddenValue">
			<input type="hidden" name="hCarNum" id="hCarNum" class="hiddenValue">
			<input type="hidden" name="bizTypeCd" id="bizTypeCd" value="01" class="hiddenValue">
			<input type="hidden" name="orderList" id="orderList" class="hiddenValue">

				<!-- 검색 1라인 -->
				<div class="form-group row mt0">
					<div class="input-group input-group-sm wd100 middle-name div-min-col-1">
						<select id="searchPeriodType" name="searchPeriodType"
								class="form-control wd100" class="custom-select ">
							<option value="dueDate" selected>지급예정일자</option>
							<option value="finishDate">마감일자</option>
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
						<input type="radio" name="dateChk" id="today" value="0"/>
						<label for="today" class="label-margin">
							<span>오늘</span>
						</label>
					</div>
					<div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
						<input type="radio" name="dateChk" id="yesterday" value="1" checked/>
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
						<input id="sFinishId" name="sFinishId"
							   class="form-control form-control-sm wd90" placeholder="마감담당자">
					</div>

					<div class="input-group input-group-sm wd100 middle-name div-min-col-1">
						<select class="form-control wd100" class="custom-select" id="payApproYn"
								name="payApproYn">
							<option value="" selected="selected">지급승인여부</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>

					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<input id="outreqId" name="outreqId"
							   class="form-control form-control-sm wd90" placeholder="출금요청자">
					</div>

					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="form-control wd90" class="custom-select" id="sOutKind"
								name="sOutKind" ></select>
					</div>
				</div>

				<!-- 검색 2라인 -->
				<div class="form-group row" style="justify-content: space-between">
					<div class="row">
						<div class="input-group input-group-sm wd100 middle-name div-min-col-1">
							<select class="form-control wd100" class="custom-select " id="outYn"
									name="outYn">
								<option value="">출금처리여부</option>
								<option value="Y">Y</option>
								<option value="N" selected="selected">N</option>
							</select>
						</div>

						<div class="input-group input-group-sm wd100 middle-name div-min-col-1">
							<select class="form-control wd100" class="custom-select" id="sSerach1"
									name="sSerach1">
								<option value="tax">계산서발행지</option>
								<option value="bankCnnm">예금주</option>
							</select>
						</div>

						<div class="input-group input-group-sm wd190 media190 middle-name div-min-col-1">
							<input id="sValue1" name="sValue1"
								   class="form-control form-control-sm wd190 media190 searchValue" placeholder="출금 처리 정보를 입력해주세요">
						</div>

						<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
							<select class="form-control" class="custom-select wd90" id="sSerach2"
									name="sSerach2">
								<option value="ceo">대표자명</option>
								<option value="driverName">차주명</option>
								<option value="carNum">차량번호</option>
							</select>
						</div>

						<div class="input-group input-group-sm wd190 media190 middle-name div-min-col-1">
							<input id="sValue2" name="sValue2"
								   class="form-control form-control-sm wd190 media190 searchValue " placeholder="ex> 대표자명,차주명, 차량번호...">
						</div>

						<div class="input-group input-group-sm wd110 middle-name div-min-col-1">
							<select class="form-control custom-select wd110" id="payreqYn"
									name="payreqYn">
								<option value="">빠른지급대상</option>
								<option value="Y" selected="selected">Y</option>
								<option value="N">N</option>
							</select>
						</div>
					</div>

					<div class="form-group row">
						<div class="input-group-sm middle-name mr10">
							<button onclick="goList()" type="button" class="form-control-sm btn_58 btn_b">검색</button>
						</div>
						<div class="input-group-sm middle-name">
							<button onclick="fReset()" type="button" class="form-control-sm btn_58 btn_black">초기화</button>
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
                                <div class="btn-row" style="float: left !important;">
                                    <div class="tool_group">
                                        <div class="padding">
                                            <c:if test="${menuAuth.editYn eq 'Y'}">
                                                <a href="#" class="k-pager-refresh k-button wd140" onClick="changeWithdrawalDueDate()"><b class="btn-b">출금예정일 변경</b></a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
								<div class="btn-row">
									<div class="tool_group">
										<div class="padding">
											<c:if test="${menuAuth.editYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button wd90" onClick="payAppro()"><b class="btn-b">지급승인</b></a>
											</c:if>
											<c:if test="${menuAuth.editYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button wd90" onClick="payReturn();"><b class="btn-b">지급반려</b></a>
											</c:if>
											<c:if test="${menuAuth.editYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button wd90" onclick="outreqOpen()"><b class="btn-b">출금요청</b></a>
											</c:if>
											<c:if test="${menuAuth.editYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button wd90" onclick="out()"><b class="btn-b">출금처리</b></a>
											</c:if>
											<c:if test="${menuAuth.editYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button wd90" onClick="bankChk()"><b class="btn-b">예금주조회</b></a>
											</c:if>
											<c:if test="${menuAuth.printYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button wd90" onClick="goExcel();"><b class="btn-x">엑셀출력</b></a>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div id="splitter" style="min-width: 500px; max-width: 100vw; min-height:calc(100vh - 260px);">
							<div class="top-pane">
								<div style="height: 100%;" id="grid"></div>
                                
                                <ul id="payListContextMenu">
                                    <li id="cSave" class="privateRClick">리스트 현재설정 저장</li>
                                    <li class="k-separator privateRClick"></li>
                                    <li id="dSave" class="privateRClick">리스트 세부설정 변경</li>
                                    <li class="k-separator privateRClick"></li>
                                </ul>
							</div>
							<div class="bottom-pane">
								<div style="height: 100%;" id="subGrid"></div>
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
    var loginCustId = '${sessionScope.userInfo.custId}';
    var userId = '${sessionScope.userInfo.userId}';
    var deptId = "${sessionScope.userInfo.deptId}";
    
    var headerTitle = ($("#headerTitle").text());
    
    var selectedDataList = [];
	var paySeqList = [];
    
	$(document).ready(function() {

		Util.setCmmCode("select", "sOutKind", "OUT_KIND_CD", "", "출금방법");

		$("#splitter").kendoSplitter({
            orientation: "vertical",
            panes: [
            	{resizable:true},
            	{resizable:true}
            ]
     	});
     	
     	var date = new Date();
     	
     	var year = date.getFullYear();
     	var month = date.getMonth();
     	var day = date.getDate();
     	
     	$("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(year, month, day - 1), dateInput: true});
    	$("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(year, month, day - 1), dateInput: true});
    	Util.setSearchDateForm();
    	
    	goList();
    	
    	$("#payListContextMenu").kendoContextMenu({
            target: "#grid",
            filter: "tr[role='row']",
            select: onContextMenuSelect
        });
	});
	
	function goList() {
		columns = setPrivateData("C3610", "grid", userId, columns);
		
		var grid = $("#grid").kendoGrid({
			dataSource: {
                transport: {
                    read: {
                        url: "/contents/calc/data/payList.do",
                        type: "POST",
                        dataType: "JSON",
                        data: $("#fSearch").serializeObject(),
                        beforeSend: function(req) {
                            req.setRequestHeader("AJAX", true);
                        }
                    }
                },
                schema: {
                    data: function(response) {
                        return response.data;
                    },
                    total: function(response) {
                        return response.total;
                    }
                },
                pageSize: 50,
                serverPaging: true,
                serverFiltering: true,
                error: function(e) {
                    if (e.xhr.status == "400") {
                        alert("세션값이 존재하지 않습니다. 로그인 페이지로 이동합니다.");
                        location.href = "/";
                    }
                }
            },
            excel: {
                fileName: headerTitle + "(" + new Date().yyyymmdd() + ").xlsx",
                proxyURL: "/cmm/saveGrid.do",
                filterable: false,
                allPages: true
            },
            excelExport: function(e) {
                if ($("#loading").length > 0) $("#loading").hide();
            },
            navigatable: true,
			selectable: "multiple",
			pageable: false,
			resizable: true,
			scrollable: true,
			editable: false,
			columns: columns,
            noRecords: true,
            messages: {
                noRecords: "조회된 데이터가 없습니다."
            }
		}).data("kendoGrid");
		
		setOptionActive("C3610", "grid", userId);
		
		grid.bind("change", onChange);
		grid.tbody.delegate('tr', 'dblclick', function(){
			var grid = $("#grid").data("kendoGrid");
			var row = grid.select();
			selectedData = grid.dataItem(row);
			
			viewCalc(selectedData.orderId, selectedData.allocId, selectedData.mngCustId, selectedData.mngDeptId);
		});
		
		var subGrid = $("#subGrid").kendoGrid({
            dataSource: {
                transport: {
                    read: {
                        url: "/contents/calc/data/payCalcList.do",
                        type: "POST",
                        dataType: "JSON",
                        data: $("#fSearch").serializeObject(),
                        beforeSend: function(req) {
                            req.setRequestHeader("AJAX", true);
                        }
                    }
                },
                schema: {
                    data: function(response) {
                        return response.data;
                    },
                    total: function(response) {
                        return response.total;
                    }
                },
                pageSize: 50,
                serverPaging: true,
                serverFiltering: true,
                error: function(e) {
                    if (e.xhr.status == "400") {
                        alert("세션값이 존재하지 않습니다. 로그인 페이지로 이동합니다.");
                        location.href = "/";
                    }
                }
            },
			selectable: true,
			sortable: false,
			pageable: false,
			editable: false,
			columns: subColumns,
			noRecords: true,
            messages: {
                noRecords: "조회된 데이터가 없습니다."
            }
        }).data("kendoGrid");
    	
    	// 요약 정보 설정
    	setPaySummary();
	}
	
	function onChange(e) {
    	var grid = $("#grid").data("kendoGrid");
    	var data = grid.dataItem(e.target);
    	var row = grid.select();
    	
    	selectedDataList = [];
    	for (var i = 0; i < row.length; i++) {
    		selectedDataList.push(grid.dataItem(row[i]));
    	}
    }
	
	function viewCalc(orderId, allocId, mngCustId, mngDeptId) {	
    	var searchData = {
			orderId: orderId,
			allocId: allocId,
			custId: mngCustId,
			deptId: mngDeptId
    	}
    	
    	var subDataSource = new kendo.data.DataSource({
			transport: {
				read: {
					url: "/contents/calc/data/payCalcList.do",
					type: "POST",
					dataType: "JSON",
					data: searchData,
					beforeSend: function(req) {
						req.setRequestHeader("AJAX", true);
					}
				}
			},
			schema: {
				data: function(response) {
					return response.data;
				},
				total: function(response) {
					return response.total;
				}
			},
			pageSize: 50,
			serverPaging: true,
			serverFiltering: true,
			error: function(e) {
				if (e.xhr.status == "400") {
					alert("세션값이 존재하지 않습니다. 로그인 페이지로 이동합니다.");
					location.href = "/";
				}
			}
		});
    	
    	var subGrid = $("#subGrid").data("kendoGrid");
    	subGrid.setDataSource(subDataSource);
    }
	
	function goExcel() {
    	$("#loading").show();
    	var grid = $("#grid").data("kendoGrid");
    	grid.saveAsExcel();
    }
    
    function bankChk() {
    	row = selectedDataList;
    	if(row.length != 1) {
    		alert("하나의 정산내역을 선택해주세요.");
    		return;
    	}
    	
    	var param = {
    		module: "VA",
    		trAmt: 0,
    		custId: row[0].custId,
    		deptId: row[0].deptId,
    		driverId: row[0].driverId,
    		vehicId: row[0].vehicId,
    		trCd: "2001",
    		mngCustId: row[0].mngCustId,
    		mngDeptId: row[0].mngDeptId,
    		paySeq: row[0].paySeq,
    		acctNm: row[0].bankCnnm
    	}
    
    	$.ajax({
    		url: "/contents/calc/data/bankChk.do",
    		type: "POST",
    		dataType: "json",
    		data: param,
    		async: true,
    		beforeSend : function(xmlHttpRequest) {
    			xmlHttpRequest.setRequestHeader("AJAX", "true");
    			$("#loading").show();
    		},
    		success: function(data) {
    			if(data.result) {
    				$("#btnCheckAccNm").prop("disabled", true);				
    			}
    			alert(data.msg);
    		},
    		complete: function() {
    			$("#loading").hide();
    		}
    	});
    }
	
	// 지급승인 버튼클릭 이벤트 핸들러
	function payAppro() {
    	var paySeqArr = [];
    	row = selectedDataList;
    	
    	if (row.length < 1) {
    		alert("지급승인할 내역을 선택해주세요.");
    		return;
    	}
    	
    	for (var i = 0; i < row.length; i++) {
    		if (row[i].payApproId != null) {
    			alert("이미 지급승인 처리된 정산입니다.")
    			return 
    		}
    		paySeqArr.push(row[i].paySeq);
    	}
    		
    	$.ajax({
    		url: "/contents/calc/data/payApproUpdate.do",
    		type: "POST",
    		dataType: "json",
    		data: {
    			paySeqArr: paySeqArr.toString()
    		},
    		success: function(data) {
    			if (data.result) {
    				alert(data.msg);
    				goList();
    			}
    		}
    	});
    }
	
	/*
     * 출금요청 Modal
     */
	outreqModal = $("#outreqModal");
	outreqModal.kendoDialog({
		width: "400px",
		height: "200px",
		visible: false,
		title: "출금요청",
		closable: true,
		modal: true,
		close: function() {
			$("#fOutreqModal")[0].reset();
		}
	});
	
	// 출금요청 버튼클릭 이벤트 핸들러
	function outreqOpen() {
    	row = selectedDataList;
    	
    	if (row.length < 1) {
    		alert("출금요청할 내역을 선택해주세요.");
    		return;
    	}
    
    	for (var i = 0; i < row.length; i++) {
    		if(row[i].payApproId == null || row[i].payApproId == '') {
    			alert("지급승인 된 내역만 선택해 주세요.")
    			return 
    		}
    	}
    	
    	// 출금방법 선택 시 처리자 소속이 로지스마일이 아닌경우 펌뱅킹은 선택하지 못하도록 제한한다.
    	if (loginCustId != 'C20210802130835001') {
        	$("#outKind option[value='F']").prop("hidden", true);
        	$("#outKind option[value='I']").prop("selected", true);
    	}
    	
    	outreqModal.data("kendoDialog").open();
    }
	
	function outreqModalClose() {
    	outreqModal.data("kendoDialog").close();
    	
    	// 모달 Open시 설정해 두었음.
    	// 추후 문제 발생 시 주석 해제
//     	$("#outKind option[value='F']").prop("hidden", false);
//     	$("#outKind option[value='I']").prop("selected", false);
    	
    	$("#fOutreqModal")[0].reset();
    }
	
	function outreqModalSubmit() {
    	var paySeqArr = [];
    	var payStateCodeArr = [];
    	row = selectedDataList;
    	
    	for(var i = 0; i < row.length; i++) {
    		paySeqArr.push(row[i].paySeq);
    		payStateCodeArr.push(row[i].payStateCode);
    	}
    
    	if($.inArray("1", payStateCodeArr) != -1 || $.inArray("2", payStateCodeArr) != -1){
    		alert("이미 출금요청한 정산입니다.");
    		outreqModalClose();
    		return 
    	}
    	
    	$.ajax({
    		url: "/contents/calc/data/outreqUpdate.do",
    		type: "POST",
    		dataType: "json",
    		data: {
    			paySeqArr: paySeqArr.toString(),
    			outKind: $("#outKind").val()
    		},
    		success: function(data){
    			if (data.result) {
    				alert(data.msg);
    				outreqModalClose();
    				goList();
    			}
    		}
    	});
    }
	
	/*
     * 지급반려 Modal
     */
	payReturnModal = $("#payReturnModal");
	payReturnModal.kendoDialog({
		width: "500px",
		height: "230px",
		visible: false,
		title: "지급반려",
		closable: true,
		modal: true,
		close: function() {
			$("#fPayReturnModal")[0].reset();
		}
	});
	
	// 지급반려 버튼클릭 이벤트 핸들러
    function payReturn() {
    	row = selectedDataList;
    	
    	if(row.length < 1) {
    		alert("지급반려할 내역을 선택해주세요.");
    		return;
    	}
    	
    	for(var i = 0; i < row.length; i++) {
    		if(Util.nvl(row[i].payApproId,'') != ''){
    			alert("지급승인 된 내역은 처리 불가합니다.")
    			return 
    		}
    	}
    	
    	payReturnModal.data("kendoDialog").open();
    }
	
    function payReturnModalClose() {
    	payReturnModal.data("kendoDialog").close();
    	$("#fPayReturnModal")[0].reset();
    }
	
    function payReturnModalSubmit() {
    	var paySeqArr = [];
    	var orderIdArr = [];
    	var allocIdArr = [];
    	row = selectedDataList;
    	
    	for(var i = 0; i < row.length; i++) {
    		paySeqArr.push(row[i].paySeq);
    		orderIdArr.push(row[i].orderId);
    		allocIdArr.push(row[i].allocId);
    	}
    
    	$.ajax({
    		url: "/contents/calc/data/payReturn.do",
    		type: "POST",
    		dataType: "json",
    		data: {
    			paySeqArr: paySeqArr.toString(),
    			orderIdArr: orderIdArr.toString(),
    			allocIdArr: allocIdArr.toString(),
    			payReturnMemo: $("#payReturnMemo").val()
    		},
    		success: function(data) {
    			if (data.result) {
    				alert(data.msg);
    				payReturnModalClose();
    				goList();
    			}
    		}
    	});
    }
	
	/*
     * 출금처리 Modal
     */
    withdrawalFinishModal = $("#divWithdrawalFinish");
    withdrawalFinishModal.kendoDialog({
        width: "400px",
        height: "300px",
        visible: false,
        title: "출금처리",
        closable: true,
        modal: true
    });
    
    function out() {
    	var paySeqArr = [];
    	row = selectedDataList;
    	
    	if (row.length < 1) {
    		alert("출금처리할 내역을 선택해주세요.");
    		return;
    	}
    	
    	for (var i = 0; i < row.length; i++) {
    		if (row[i].outKind == null || row[i].outKind == '') {
    			alert("출금요청 된 내역만 선택해 주세요.")
    			return 
    		} else if (row[i].outKind == 'F') {
    			alert("펌뱅킹은 출금처리 할 수 없습니다.\n인터넷뱅킹으로 요청된 내역을 선택해 주세요.")
    			return
    		} else {
    			// 출금처리되지 않은 항목만 처리
    			if (row[i].outDate == null || row[i].outDate == '') {
    				paySeqArr.push(row[i].paySeq);
    			}
    		}
    	}
    	
    	$("#paySeqArr").val(paySeqArr);
    	
    	// 출금처리 Modal
    	withdrawalFinishModalOpen(paySeqArr);
    }
    
    function withdrawalFinishModalOpen() {
    	$("#finishMessage").html("<p>출금 처리일을 지정해 주세요.<br />이미 처리된 건은 제외됩니다.</p>");
    	
    	var dateOption = {
            format: "yyyy-MM-dd",
            value: new Date(),
            dateInput: true,
            max: new Date()
        }
    	$("#withdrawalFinishDate").kendoDatePicker(dateOption);
    	
    	withdrawalFinishModal.data("kendoDialog").open();
    };
    
    function withdrawalFinishModalClose() {
    	withdrawalFinishModal.data("kendoDialog").close();
    };
    
    $('#fWithdrawalFinish').validator().on('submit', function(e) {
    	e.preventDefault();
    	
    	var withdrawalFinishDate =  $("#withdrawalFinishDate").val();
    	var message = "출금일을 \"" + withdrawalFinishDate + "\" 로 확정하고 출금처리를 하시겠습니까?";
    	if (!confirm(message))
    		return;
    	
    	var paySeqArr = $("#paySeqArr").val();
    	var outDate = $("#withdrawalFinishDate").val();
    	
    	$.ajax({
    		url: "/contents/calc/data/outUpdate.do",
    		type: "POST",
    		dataType: "json",
    		data: {
    			paySeqArr: paySeqArr.toString(),
    			// 출금처리는 인터넷 뱅킹으로만 처리 가능함.
    			//outKind: $("#outKind").val()
    			outKind: "I",
    			outDate: outDate
    		},
    		success: function(data) {
    			if (data.result) {
    				alert(data.msg);
    				withdrawalFinishModalClose();
    				goList();
    			}
    		}
    	});
    });
	
    /*
     * 출금예정일 변경 Modal
     */
    changeWithdrawalDueDateModal = $("#divChangeWithdrawalDueDate");
    changeWithdrawalDueDateModal.kendoDialog({
        width: "400px",
        height: "240px",
        visible: false,
        title: "출금예정일 변경",
        closable: true,
        modal: true
    });
    
    function changeWithdrawalDueDate() {
    	var paySeqArr = [];
    	var row = selectedDataList;
    	
    	if (row.length < 1) {
    		alert("출금예정일을 변경할 내역을 선택해주세요.");
    		return;
    	}
    	
    	// 출금예정일 변경에 대한 조건 체크
    	for (var i = 0; i < row.length; i++) {
    		// 출금예정일의 경우 매입정산에서 마감처리 시 확정되기 때문에 아래의 조건에 해당하지 않을듯..
//     		if (row[i].outKind == null || row[i].outKind == '') {
//     			alert("출금요청 된 내역만 선택해 주세요.")
//     			return 
//     		} else if (row[i].outKind == 'F') {
//     			alert("펌뱅킹은 출금처리 할 수 없습니다.\n인터넷뱅킹으로 요청된 내역을 선택해 주세요.")
//     			return
//     		} else {
//     			// 출금처리되지 않은 항목만 처리
//     			if (row[i].outDate == null || row[i].outDate == '') {
    				paySeqArr.push(row[i].paySeq);
//     			}
//     		}
    	}
    	
    	$("#paySeqArr").val(paySeqArr);
    	
    	changeWithdrawalDueDateModalOpen();
    }
    
    function changeWithdrawalDueDateModalOpen() {
		$("#ChangeMessage").html("<p>출금예정일을 지정해 주세요.</p>");
    	
    	var dateOption = {
            format: "yyyy-MM-dd",
            value: new Date(),
            dateInput: true,
            min: new Date()
        }
    	$("#withdrawalDueDate").kendoDatePicker(dateOption);
    	
    	changeWithdrawalDueDateModal.data("kendoDialog").open();
    }
    
    function changeWithdrawalDueDateModalClose() {
    	changeWithdrawalDueDateModal.data("kendoDialog").close();
    }
    
    $('#fChangeWithdrawalDueDate').validator().on('submit', function(e) {
		e.preventDefault();
    	
    	var withdrawalDueDate =  $("#withdrawalDueDate").val();
    	var message = "출금예정일을 \"" + withdrawalDueDate + "\" 로 확정하고 변경을 하시겠습니까?";
    	if (!confirm(message))
    		return;
    	
    	var paySeqArr = $("#paySeqArr").val();
    	var withdrawalDueDate = $("#withdrawalDueDate").val();
    	
    	$.ajax({
    		url: "/contents/calc/data/setWithdrawalDueDate.do",
    		type: "POST",
    		dataType: "json",
    		data: {
    			paySeqArr: paySeqArr.toString(),
    			withdrawalDueDate: withdrawalDueDate
    		},
    		success: function(data) {
    			if (data.result) {
    				alert(data.msg);
    				changeWithdrawalDueDateModalClose();
    				goList();
    			}
    		}
    	});
    });
    
    // 요약정보 표시
    function setPaySummary() {
    	$.ajax({
    		url: "/contents/calc/data/getPaySummary.do",
    		type: "POST",
    		dataType: "JSON",
    		data: $("#fSearch").serializeObject(),
    		success: function(data) {
    			if (data.result) {
    				// 요약정보 표시
    				var groupCount = 
            			"<i style=\"color: #000000\">전체 : " 		+ 	Util.nvl(Util.formatNumber(data.data.tCount), 			"<span style=\"color: #dc3545; font-weight: bold; font-style: initial; font-size: 14px; \">0</span>") + "건 /</i> " +
            			"<i style=\"color: #e84524\">미지급금 : " 	+ 	Util.nvl(Util.formatNumber(data.data.tPayableAmt), 		"<span style=\"color: #dc3545; font-weight: bold; font-style: initial; font-size: 14px; \">0</span>") + "원 </i><i>/</i> " +
            			"<i style=\"color: #3f75c1\">출금액 : " 		+ 	Util.nvl(Util.formatNumber(data.data.tWithdrawalAmt), 	"<span style=\"color: #dc3545; font-weight: bold; font-style: initial; font-size: 14px; \">0</span>") + "원 (" +
            										"펌뱅킹 : " 		+ 	Util.nvl(Util.formatNumber(data.data.fWithdrawalAmt), 	"<span style=\"color: #dc3545; font-weight: bold; font-style: initial; font-size: 14px; \">0</span>") + "원 <i style=\"color:#333\">/</i> " +
            										"인터넷뱅킹 : "	+ 	Util.nvl(Util.formatNumber(data.data.iWithdrawalAmt), 	"<span style=\"color: #dc3545; font-weight: bold; font-style: initial; font-size: 14px; \">0</span>") + "원)</i>";
            			
    				$("#groupCount").html(groupCount);
    			}
    		}
    	});
    }
    
	// 그리드 컨택스트 메뉴 처리
    function onContextMenuSelect(e) {
    	var item = e.item.id;
    	
    	switch (item) {
    	case "cSave":
            setPrivateSaveData("C3610", "grid", userId);
            break;
        case "dSave":
            setPrivatePanel("C3610", "grid", userId);
            break;
    	}
    }
    
    var columns = [
    	{ field: "number", title: "No", width: 50 },
    	{ field: "orderId", title: "오더ID", width: 160 },
    	{ field: "finishDate", title: "마감일", width: 70},
    	{ field: "finishId", title: "마감원", width: 120 },
    	{ field: "withdrawalDueDate", title: "출금예정일", width: 100 },
    	{ field: "payApproDate", title: "지급승인일", width: 120 },
    	{ field: "payApproId", title: "결재자", width: 120 },
    	{ field: "outreqDate", title: "출금요청일", width: 100 },
    	{ field: "outreqId", title: "요청자", width: 120 },
    	{ field: "payStateCode", title: "출금요청상태", width: 120,
    		template: "#if(payStateCode == '00') {# 출금미신청 #} else if(payStateCode == '1') {# 요청처리중 #} else if(payStateCode == '2') {# 출금완료 #} else if(payStateCode == '3' || payStateCode == '4') {# 출금오류 #} #"
    	},
    	{ field: "outKind", title: "출금방법", width: 100,
    		template: "#if(outKind == 'I') {# 인터넷뱅킹 #} else if(outKind == 'F') {# 펌뱅킹 #} #"
    	},
    	{ field: "outDate", title: "출금처리일", width: 120 },
    	{ field: "outId", title: "처리자", width: 120 },
    	{ field: "buyAmt", title: "공급가액", width: 100, 
    		template: function(dataItem) {
    	    	return Util.formatNumber(dataItem.buyAmt);
    	    }
    	},  
    	{ field: "payableAmt", title: "미지급금", width: 100, 
    		template: function(dataItem) {
    	    	return Util.formatNumber(dataItem.payableAmt);
    	    }
    	},  
    	{ field: "withdrawalAmt", title: "출금", width: 100, 
    		template: function(dataItem) {
    	    	return Util.formatNumber(dataItem.withdrawalAmt);
    	    }
    	},  
    	{ field: "reqPayYn", title: "빠른지급", width: 100 },
    	{ title: "계산서발행지", width: 120,
    		template: function(dataItem) {
    		   if(dataItem.taxOwnerBizName == '' || dataItem.taxOwnerBizName == null){
    			   return (Util.nvl(dataItem.taxDriverBizName,''));
    		   }else{
    			   return (Util.nvl(dataItem.taxOwnerBizName,''));
    		   }
    		}
    	},
    	{ field: "bankCnnm", title: "예금주", width: 100 },
    	{ field: "bankCode", title: "은행명", width: 100 },
    	{ field: "bankAccount", title: "계좌번호", width: 160 },
    	{ field: "bankChkDate", title: "예금주확인", width: 120,
    		template: function(dataItem) {
    		   if(Util.nvl(dataItem.bankChkDate,'') == ''){
    			   return ('N');
    		   }else{
    			   return (dataItem.bankChkDate);
    		   }
    		}
    	},
    	{ field: "carNum", title: "차량번호", width: 120 },
    	{ field: "driverName", title: "차주명", width: 120 },
    	{ field: "driverTel", title: "전화번호", width: 160,
    		template: function(dataItem) {
    			return Util.formatPhone(dataItem.driverTel);
    		} 
    	},
    	{ field: "unitPriceType", title: "운임구분", width: 100 },
    	{ field: "allocDate", title: "배차일", width: 100 },
    	{ field: "eDate", title: "하차일", width: 100 },
    	{ field: "sComName", title: "상차지", width: 120 },
    	{ field: "eComName", title: "하차지", width: 120 },
    	{ title: "2착지", width: 160, 
    		template: function(dataItem) {
    		   if(dataItem.stopComName == '' || dataItem.stopComName == null){
    			   return '';
    		   }else{
    			   if(dataItem.stopCount == '1'){
    				   return (dataItem.stopComName);
    			   }else{
    				   return (dataItem.stopComName)+' 외 '+(dataItem.stopCount-1)+'곳';
    			   }
    			   
    		   }
    		}
    	},
    	{ field: "sellWeight", title: "청구중량", width: 100 },
    	{ field: "goodsWeight", title: "중량", width: 100 },
    	{ field: "userName", title: "배차원", width: 120 },
    	{ field: "memo1", title: "지급확정 시 메모", width: 150 },
    	{ field: "memo2", title: "지급요청 시 메모", width: 150 },
    	{ field: "memo3", title: "지급처리 시 메모", width: 150 },
    	{ field: "goodsName", title: "화물명", width: 100 },
    	{ field: "mngDeptName", title: "담당부서", width: 100 },
    	{ field: "allocId", hidden: true},	
    	{ field: "mngCustId", hidden: true},	
    	{ field: "mngDeptId", hidden: true},
    	{ field: "custId", hidden: true},	
    	{ field: "deptId", hidden: true},
    	{ field: "driverId", hidden: true},
    	{ field: "vehicId", hidden: true},
    	{ field: "paySeq", hidden: true},
    ];
    
    var subColumns = [
    	{ field: "number", title: "No", width: 50 },
    	{ field: "orderId", title: "오더ID", width: 160 },
    	{ field: "sellBuySctnName", title: "구분", width: 70 },
    	{ field: "finishYn", title: "마감일", width: 80,
    		template: "#if(finishYn == 'Y') {# #=calcDate# #} else {# N #} #"
    	},
    	{ field: "allocDate", title: "배차일", width: 80 },
    	{ field: "eDateDay", title: "하차일", width: 80 },
    	{ field: "sComName", title: "상차지", width: 120 },
    	{ field: "eComName", title: "하차지", width: 120 },
    	{ title: "2착지", width: 160, 
    		template: function(dataItem) {
    		   if(dataItem.stopComName == '' || dataItem.stopComName == null){
    			   return '';
    		   }else{
    			   if(dataItem.stopCount == '1'){
    				   return (dataItem.stopComName);
    			   }else{
    				   return (dataItem.stopComName)+' 외 '+(dataItem.stopCount-1)+'곳';
    			   }
    			   
    		   }
    		}
    	},
    	{ field: "unpaidAmt", title: "매출액", width: 100, 
    		template: function(dataItem) {
    		   return Util.formatNumber(dataItem.unpaidAmt);
    		}
    	},  
    	{ field: "depositAmt", title: "입금액", width: 100, 
    		template: function(dataItem) {
    	       return Util.formatNumber(dataItem.depositAmt);
    	    }
    	},  
    	{ field: "tranYn", title: "명세서", width: 80,
    		template: "#if(tranYn == 'Y') {# #=tranDate# #} else {# N #} #"
    	},
    	{ field: "carNum", title: "차량번호", width: 120 },
    	{ field: "driverName", title: "차주명", width: 100 },
    	{ field: "driverTel", title: "전화번호", width: 130,
    		template: function(dataItem) {
    			return Util.formatPhone(dataItem.driverTel);
    		} 
    	},
    	{ field: "unitPriceType", title: "운임구분", width: 100 },
    	{ field: "sellWeight", title: "청구중량", width: 100 },
    	{ field: "goodsWeight", title: "중량", width: 100 },
    	{ field: "calcTypeName", title: "정산항목", width: 100 },
    	{ field: "payableAmt", title: "공급가액", width: 100, 
    		template: function(dataItem) {
    	    	return Util.formatNumber(dataItem.payableAmt);
    	    }
    	},  
    	{ field: "withdrawalAmt", title: "지급액", width: 100, 
    		template: function(dataItem) {
    		   return Util.formatNumber(dataItem.withdrawalAmt);
    		}
    	},  
    	{ field: "reqPayYn", title: "빠른지급", width: 100,
    		template: "#if(reqPayYn == 'Y') {# #=reqPayDate# #} else {# N #} #"
    	},
    	{ title: "인수증(전/실)", width: 130,
    		template: function(dataItem) {
    		   return (Util.nvl(dataItem.receiptDate,'N'))+'/'+(Util.nvl(dataItem.paperReceiptDate,'N'));
    		}
    	},
    	{ field: "taxinvYn", title: "계산서(전/실)", width: 130,
    		template: "#if(taxinvYn == 'Y') {# #=taxinvDate# #} else if(taxinvYn == 'P') {# #=taxinvDate# #} else {# N #} #"	
    	},
    	{ field: "custName", title: "화주(거래처)", width: 150 },
    	{ title: "거래처(계산서발행지)", width: 160,
    		template: function(dataItem) {
    		   if(dataItem.driverId == '' || dataItem.driverId == null){
    			   return (dataItem.reqBizName);
    		   }else{
    			   return (dataItem.driverBizName);
    		   }
    		}
    	},
    	{ field: "appName", title: "어플명", width: 100 },
    	{ field: "carrierName", title: "소속운송사", width: 100 },
    	{ field: "userName", title: "배차원", width: 100 },
    	{ field: "finishMemo", title: "마감 시 메모", width: 160 },
    	{ field: "refContent1", title: "참고 내용1", width: 160 },
    	{ field: "refContent2", title: "참고 내용2", width: 160 },
    	{ field: "reportBizNum", title: "신고용사업자번호", width: 160,
    		template: function(dataItem) {
    			return Util.formatBizNum(dataItem.reportBizNum);
    		} 
    	},
    	{ field: "reportBizName", title: "신고용사업자명", width: 160},
    	{ field: "goodsName", title: "화물명", width: 120 },
    	{ field: "mngDeptName", title: "담당부서", width: 120 },
    	{ field: "finishUserName", title: "마감원", width: 100 },
    	{ field: "allocId", hidden: true },
    	{ field: "invId", hidden: true }
    ];
</script>