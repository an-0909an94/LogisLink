<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

<!-- 22.07.19 이건욱 매출 정산관리 페이지 -->
<div class="header">
    <div style="justify-content: space-between; display: flex;" class="summary p30">
        <div class="hdr-tit">
            <P id="headerTitle">매입정산관리</P>
        </div>
        <div id="summaryData" style="height: 30px;">
            <div style="display: contents;" class="col input-group i-name">
                <i style="font-size: larger;" id="groupCount"></i>
            </div>
        </div>
    </div>

    <div class="contents">
        <div id="group-list" class="cont-wrapper-page-grid">
            <!-- 검색 조건 영역 -->
            <form id="fSearch" class="date-bnt" method="post">
                <input type="hidden" name="hCustId" id="custId" class="hiddenValue">
                <input type="hidden" name="hDeptId" id="deptId" class="hiddenValue">

                <!-- 검색 1라인 -->
                <div class="form-group row">
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>정산마감여부</strong>
                        <select class="custom-select col-12" id="sFinishYn" name="finishYn">
                            <option value="">--전체--</option>
                            <option value="Y">Y</option>
                            <option value="N" selected>N</option>
                        </select>
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>거래처검색</strong>
                        <select class="custom-select col-12" id="custType" name="custType">
                            <option value="01">화주명</option>
                            <option value="orderId">오더ID</option>
                        </select>
                    </div>
                    <div id="searchDiv" class="input-group input-group-sm col-2 middle-name">
                        <strong>&nbsp;</strong>
                        <input type="text" id="sCustName" name="sCustName" style="width: 100%;">
                    </div>
                    <div style="display: none;" id="orderSearch" class="input-group input-group-sm col-2 middle-name">
                        <strong>&nbsp;</strong>
                        <input type="text" id="orderId" name="orderId" class="form-control form-control-sm">
                    </div>
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>&nbsp;</strong>
                        <input type="text" name="sSubName" id="sSubName" class="form-control form-control-sm" readonly>
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>사업자검색</strong>
                        <select class="custom-select col-12" id="searchType" name="searchType">
                            <option value="bizName">사업자상호</option>
                            <option value="bizNum">사업자번호</option>
                        </select>
                    </div>
                    <div class="input-group input-group-sm col-2 middle-name">
                        <strong>&nbsp;</strong>
                        <input type="text" id="bizName" name="bizName" style="width: 100%;">
                    </div>
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>&nbsp;</strong>
                        <select name="sSubDept" id="sSubDept" class="custom-select"></select>
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>청구구분</strong>
                        <select class="form-control" class="custom-select col-12" id="sChargeType" name="chargeType">
                            <option>--전체--</option>
                        </select>
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>담당부서명</strong>
                        <select class="form-control" class="custom-select col-12" id="sDeptId" name="sDeptId">
                            <option>--전체--</option>
                        </select>
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>배차담당자</strong>
                        <select class="form-control" class="custom-select col-12" id="sUserId" name="sUserId">
                            <option>--전체--</option>
                        </select>
                    </div>
                </div>

                <!-- 검색 2라인 -->
                <div class="form-group row">
                    <div class="input-group input-group-sm col-1 middle-name">
                        <strong>배차일자</strong>
                        <input style="padding: 0;" type="text" id="fromDate" name="fromDate" class="col-12">
                    </div>
                    <span style="margin-top: 31px;">~</span>
                    <div class="input-group input-group-sm col-1 middle-name">
                        <strong>&nbsp;</strong>
                        <input style="padding: 0;" type="text" id="toDate" name="toDate" class="col-12">
                    </div>

                    <div class="input-group input-group-sm col radio-or-checkBox">
                        <input type="radio" name="dateChk" id="today" value="0" checked />
                        <label for="today" class="label-margin"> <span>오늘</span>
                        </label>
                    </div>
                    <div class="input-group input-group-sm col radio-or-checkBox">
                        <input type="radio" name="dateChk" id="yesterday" value="1" />
                        <label for="yesterday" class="label-margin"> <span>어제</span>
                        </label>
                    </div>
                    <div class="input-group input-group-sm col radio-or-checkBox">
                        <input type="radio" name="dateChk" id="weekly" value="7" />
                        <label for="weekly" class="label-margin"> <span>7일</span>
                        </label>
                    </div>
                    <div class="input-group input-group-sm col radio-or-checkBox">
                        <input type="radio" name="dateChk" id="monthly" value="30" />
                        <label for="monthly" class="label-margin"> <span>30일</span>
                        </label>
                    </div>

                    <!-- Hidden -->
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>&nbsp;</strong>
                        <input type="text" class="form-control form-control-sm" hidden="true">
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>우편발송여부</strong>
                        <select class="custom-select col-12" id="sPostYn" name="postYn">
                            <option value="">--전체--</option>
                            <option value="Y">Y</option>
                            <option value="N">N</option>
                        </select>
                    </div>

                    <div class="input-group input-group-sm col radio-or-checkBox ">
                        <input id="carryOverYn" name="carryOver" type="checkbox" checked>
                        <label for="carryOverYn" class="label-margin"> <span>미처리 이월건 포함</span>
                        </label>
                    </div>

                    <div class="input-group input-group-sm col radio-or-checkBox ">
                        <input id="deleteCalcYn" name="deleteCalc" type="checkbox">
                        <label for="deleteCalcYn" class="label-margin"> <span>삭제건 포함</span>
                        </label>
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name" style="max-width: 90px; min-width: 90px;">
                        <strong>&nbsp;</strong>
                        <button onclick="goList()" type="button" style="border-radius: 4px" class="form-control form-control-sm middle-button-dark">
                            <i class="k-icon k-i-search"></i>검색
                        </button>
                    </div>
                    <div class="input-group input-group-sm col-1 middle-name" style="max-width: 90px; min-width: 90px;">
                        <strong>&nbsp;</strong>
                        <button onclick="fReset()" type="button" class="form-control form-control-sm middle-button">
                            <i class="k-icon k-i-reset-sm"></i>초기화
                        </button>
                    </div>
                </div>
            </form>
            <!-- 검색 조건 영역 끝 -->

            <!-- 버튼과 그리드 영역 -->
            <div class="cont-body">
                <!-- f-wrap -->
                <div class="k-wrap content">
                    <div class="lookup_table">
                        <!-- 툴바 -->
                        <div class="toolbar row">
                            <div class="tool_form col">
                                <div class="btn-row">
                                    <!-- 툴바 1라인 -->
                                    <div class="tool_group">
                                        <div class="padding">
                                            <div class="btn-row">
                                                <div class="tool_group">
                                                    <div class="padding">
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="vReceipt">
                                                                <b class="btn-r"> <i class="k-icon k-i-txt"></i>삭제처리
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="vReceipt">
                                                                <b class="btn-b"> <i class="k-icon k-i-user"></i>화주변경
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="vReceipt">
                                                                <b class="btn-b"> <i class="k-icon k-i-dollar"></i>운송비변경
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="vReceipt">
                                                                <b class="btn-b"> <i class="k-icon k-i-edit"> </i>마감처리
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="vReceipt">
                                                                <b class="btn-b"> <i class="k-icon k-i-paste-plain-text"> </i>거래명세서
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="vReceipt">
                                                                <b class="btn-b"> <i class="k-icon k-i-txt"> </i>세금계산서
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="vReceipt">
                                                                <b class="btn-b"> <i class="k-icon k-i-txt"> </i>우편발송처리
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="vReceipt">
                                                                <b class="btn-x"> <i class="k-icon k-i-file-excel"> </i>엑셀출력
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 툴바 2라인 -->
                                    <div class="tool_group">
                                        <div class="padding">
                                            <div class="btn-row">
                                                <div class="tool_group">
                                                    <div class="padding">
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="vReceipt">
                                                                <b class="btn-b"> <i class="k-icon k-i-txt"></i>삭제취소
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <!-- Hidden -->
                                                        <a class="k-pager-refresh k-button" style="visibility: hidden;">
                                                            <b class="btn-b"> <i class="k-icon k-i-txt"></i>
                                                            </b>
                                                        </a>
                                                        <!-- Hidden -->
                                                        <a class="k-pager-refresh k-button" style="visibility: hidden;">
                                                            <b class="btn-b"> <i class="k-icon k-i-txt"></i>
                                                            </b>
                                                        </a>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="vReceipt">
                                                                <b class="btn-r"> <i class="k-icon k-i-edit"></i>마감취소
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="vReceipt">
                                                                <b class="btn-r"> <i class="k-icon k-i-txt"></i>명세서취소
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="vReceipt">
                                                                <b class="btn-r"> <i class="k-icon k-i-txt"></i>계산서취소
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="vReceipt">
                                                                <b class="btn-r"> <i class="k-icon k-i-txt"></i>우편처리취소
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <!-- Hidden -->
                                                        <a class="k-pager-refresh k-button" style="visibility: hidden;">
                                                            <b class="btn-b"> <i class="k-icon k-i-txt"></i>
                                                            </b>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!-- 툴바 끝 -->
                        <!-- 그리드 -->
                        <div style="min-width: 500px;">
                            <div style="height: calc(100vh - 409px)" id="grid"></div>

                            <ul id="calcListContextMenu">
                                <li id="cSave" class="privateRClick">리스트 현재설정 저장</li>
                                <li class="k-separator privateRClick"></li>
                                <li id="dSave" class="privateRClick">리스트 세부설정 변경</li>
                                <li class="k-separator privateRClick"></li>
                                <li id="vCopyId">오더아이디복사</li>
                                <li class="k-separator"></li>
                                <li id="vChangeReq">화주변경</li>
                                <li class="k-separator"></li>
                                <li id="vPaperReceipt">실물 인수증 수령</li>
                                <li class="k-separator"></li>
                                <li id="vPaperReceiptCancel">실물 인수증 수령 취소</li>
                                <li class="k-separator"></li>
                                <li id="vPaperTax">실물 세금계산서 수령</li>
                                <li class="k-separator"></li>
                                <li id="vPaperTaxCancel">실물 세금계산서 수령 취소</li>
                                <li class="k-separator"></li>
                                <li id="vTranReceipt">거래명세서 발행</li>
                                <li class="k-separator"></li>
                                <li id="vFinishCalc">마감처리</li>
                                <li class="k-separator"></li>
                                <li id="vCancelCalc">마감취소</li>
                                <li class="k-separator"></li>
                                <li id="vDeleteCalc">삭제</li>
                            </ul>
                        </div>
                        <!-- 그리드 끝 -->
                    </div>
                </div>
            </div>
            <!-- 버튼과 그리드 영역  끝 -->
        </div>
    </div>

</div>

<script type="text/javascript">
    var searchCustName;
    var bizName;
    var calcId;
    var taxData;
    var errChk = false;
    
    var userId = '${sessionScope.userInfo.userId}';
    var deptId = "${sessionScope.userInfo.deptId}";

    $("#calcListContextMenu").kendoContextMenu({
        target : "#grid",
        filter : "tr[role='row']"
    });

    var contextMenu = $("#calcListContextMenu").data("kendoContextMenu");
    contextMenu.bind("select", onContextMenuSelect);

    $(document).ready(function() {
        var dateOption = {
            format : "yyyy-MM-dd",
            value : new Date(),
            dateInput : true
        }
        $("#fromDate").kendoDatePicker(dateOption);
        $("#toDate").kendoDatePicker(dateOption);

        // 담당부서 셀렉트 박스
        var deptOption = {
            custId: '${custId}',
            deptId: deptId,
            useYn: 'Y'
        }
        Util.setSelectBox("/contents/basic/data/compDeptList.do", "sDeptId", deptOption, "deptId", "deptName", deptId, "--전체--");
        
        // 배차 담당자 셀렉트 박스
        Util.setSelectBox("/contents/basic/data/userNameList.do", "sUserId", { deptId: $(this).val() }, "userId", "userName", "", "--전체--");
        $("#sDeptId").on("change", function(){
            Util.setSelectBox("/contents/basic/data/userNameList.do", "sUserId", { deptId: $(this).val() }, "userId", "userName", "", "--전체--");
        });

        // 선택 날짜값에 따라 기간 설정
        Util.setSearchDateForm();
        
        // 청구구분 셀랙트 박스
        Util.setCmmCode("select", "sChargeType", "CHARGE_TYPE_CD", "01", "--전체--");
        
        // 컨트롤 기본값 설정
        $("#sFinishYn").val("N");
        $("#sChargeType").val("01");
        $("input:checkbox[id='carryOverYn']").prop("checked", true);
        
     	// 거래처 자동완성
        searchCustName = MultiColumnComboBox.setCustName("s", $("#custType").val(), $("#sDeptId").val());
        searchCustName.bind("select", changeSearchCust);
        searchCustName.bind("change", searchCustSelectTrigger);
        
        // 사업자 자동완성
        bizName = getSearchBiz();
        
        // 담당부서 컨트롤 이벤트
        $("#sDeptId").on("change", function() {
            setSearchForm();
        });
        
        // 사업자 컨트롤 이벤트
        $("#searchType").on("change", function() {
            bizName.destroy();
            bizName = getSearchBiz();
            bizName.value('');
        });
        
        goList();
    });
    
    function setSearchForm() {
        searchCustName = $("#sCustName").data("kendoMultiColumnComboBox");
        searchCustName.value("");
        searchCustName.refresh();
        searchCustName.destroy();
        
        $("#orderId").val("")
        $(".hiddenValue").val("");
        $("#sSubName").val("");
        
        var sellBuySctn = $("#custType").val();
        
        if (sellBuySctn == "orderId") {
            // 오더ID 선택
            searchCustName = $("#sCustName").kendoMultiColumnComboBox({});
            $("#searchDiv").hide();
            $("#orderSearch").show();
        } else {
            // 화주명 선택
            searchCustName = MultiColumnComboBox.setCustName("s", sellBuySctn, $("#sDeptId").val());
            searchCustName.bind("select", changeSearchCust);
            searchCustName.bind("change", searchCustSelectTrigger);
            $("#searchDiv").show();
            $("#orderSearch").hide();
        }
        
        bizName.destroy();
        bizName = getSearchBiz();
        bizName.value('');
        $("#sSubDept").val("");
    }
    
    function getSearchBiz() {
        var searchBiz = $("#bizName").kendoMultiColumnComboBox({
            dataTextField: "bizName",
            dataValueField: "custId",
            filter: "contains",
            minLength: 2,
            autoBind: true,
            dataSource: {
                serverFiltering: true,
                transport: {
                    read : {
                        url: "/contents/calc/data/custList.do",
                        dataType: "json",
                        type: "post",
                        data: {
                            searchType : $("#searchType").val(),
                            sDeptId: $("#sDeptId").val()
                        },
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
                }
            },
            
            columns: [
                {field: "bizName", title: "사업자명", width:100},
                {field: "bizNum", title: "사업자번호", width:100}
            ]
        }).data("kendoMultiColumnComboBox");    

        searchBiz.bind("select", changeBizName);
        $("#custType").on("change", function(){
            setSearchForm();
        }); 
        
        return searchBiz;
    }
    
    function goList() {
        //columns = setPrivateData("C3120", "grid", userId, columns);
        
        $("#grid").text("");
        $("#grid").kendoGrid({
            dataSource: {
                transport: {
                    read: {
                        url: "/contents/calc/data/sellCalcList.do",
                        type: "post",
                        dataType: "json",
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
                    },
                    model: {
                    	id: "orderId"
                    }
                },
                pageSize: 20,
                serverPaging: true,
                serverFiltering: true,
                error: function(e) {
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
            // 멀티셀렉트 제거?
//             selectable: "multiple row",
			selectable: "cell",
			persistSelection: true,
            editable: true,
            edit: function(e) {
            	// 에디트 타입 변경
            	$(".k-textbox").prop("type", "number");
        	},
        	save: onEditSave,
            columns: columns,
            noRecords: true,
            scrollable: {
                endless: true
            },
            pageable: false,
            change: onChange,
            messages: {
                noRecords: "조회된 데이터가 없습니다."
            }
        });
        
        var grid = $("#grid").data("kendoGrid");
        grid.thead.on("click", "#orderAllCheck", orderAllCheck);
        grid.table.on("click", ".orderCheck", orderCheck);
    }
    
    // 전체 선택
    function orderAllCheck(e) {
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
    
    // 부분 선택
    function orderCheck(e) {
    	var row = $(this).closest("tr")
    	var grid = $("#grid").data("kendoGrid");
    	var dataItem = grid.dataItem(row);
    	var checked = this.checked
		
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
    
    // 에디팅 저장 이벤트 처리
    function onEditSave(e) {
    	// Charge 항목 에디팅의 경우 에디트 완료 후 매출액 항목 업데이트 (변경전 값을 빼고 입력된 값으로.)
		var unpaidAmtVal = Number(e.model.get("unpaidAmt"));
		
		if (e.values.sellCharge) {
			unpaidAmtVal -= Number(e.model.get("sellCharge"));
			unpaidAmtVal += Number(e.values.sellCharge);
		}
		else if (e.values.sellWayPointCharge) {
			unpaidAmtVal -= Number(e.model.get("sellWayPointCharge"));
			unpaidAmtVal += Number(e.values.sellWayPointCharge);
		}
		else if (e.values.sellStayCharge) {
			unpaidAmtVal -= Number(e.model.get("sellStayCharge"));
			unpaidAmtVal += Number(e.values.sellStayCharge);
		}
		else if (e.values.sellHandWorkCharge) {
			unpaidAmtVal -= Number(e.model.get("sellHandWorkCharge"));
			unpaidAmtVal += Number(e.values.sellHandWorkCharge);
		}
		else if (e.values.sellRoundCharge) {
			unpaidAmtVal -= Number(e.model.get("sellRoundCharge"));
			unpaidAmtVal += Number(e.values.sellRoundCharge);
		}
		else if (e.values.sellOtherAddCharge) {
			unpaidAmtVal -= Number(e.model.get("sellOtherAddCharge"));
			unpaidAmtVal += Number(e.values.sellOtherAddCharge);
		}
		else {
			// null일 경우 이벤트 처리 안함.
			e.preventDefault();
		}
		
		e.model.set("unpaidAmt", unpaidAmtVal);
		
		// 에디팅 완료 후 체크 활성화
		var checkBoxId = e.model.get("orderId");
    	var checked = $("#" + checkBoxId).is(":checked");
    	if (!checked)
    		$("#" + checkBoxId).prop("checked", false).trigger('click');
    }
    
    // 그리드 변경 이벤트 처리
    // ??? selection 옵션 제거시 이벤트 수신 못함.
    function onChange(e) {
    	var grid = $("#grid").data("kendoGrid");
    	var data = grid.dataItem(e.target);
    	var row = grid.select();
//     	var multiSelectedData = [];
    	
//     	for(var i = 0; i < row.length; i++) {
//     		multiSelectedData.push(grid.dataItem(row[i]));
//     	}
    	
//     	if(multiSelectedData.length != '1'){
//     		/* 인수증, 세금계산서 버튼 숨기기 */
//     		$("#taxView").hide();
//     		$("#receiptView").hide();
//     	}else{
//     		/* 인수증, 세금계산서 버튼 표시 */
//     		$("#taxView").show();
//     		$("#receiptView").show();
//     	}
    }
    
    // 거래처 콤보 선택 이벤트 처리
    function changeSearchCust(e) {
    	var dataItem = e.dataItem;
    	if (dataItem != null) {
    		$("#hCustId").val(dataItem.custId);
    		$("#hDeptId").val(dataItem.deptId);
    		$("#sSubName").val(dataItem.deptName);
    		taxData = dataItem;
    	} else {
    		if (e.sender.selectedIndex != -1) {
    			searchCustName.select(e.sender.selectedIndex);
    			
    			var data = e.sender.listView._view[e.sender.selectedIndex];
    			$("#hCustId").val(data.item.custId);
    			$("#hDeptId").val(data.item.deptId);
    			$("#sSubName").val(data.item.deptName);
    			
    			taxData = data.item;
    		}
    	}
    }
    
    // 거래처 콤보 변경 이벤트 처리
    function searchCustSelectTrigger(e) {
    	if (this.value() != "") {
    		searchCustName.trigger("select");
    	} else {
    		$("#hCustId").val("");
    		$("#hDeptId").val("");
    		$("#sSubName").val("");
    		
    		bizName.value('');
    	}
    }
    
    // 사업자 콤보 선택 이벤트 처리
    function changeBizName(e){
    	var dataItem = e.dataItem;	

    	if (dataItem == null) {
    		$(".hiddenValue").val("");
    	} else {
    		$("#hCustId").val(dataItem.custId);
    		$("#hDeptId").val("");
    		$("#sSubName").val("");
    		
    		searchCustName.value("");
    		
    		Util.setSelectBox("/contents/calc/data/deptList.do", "sSubDept", { custId : dataItem.custId, sDeptId: $("#sDeptId").val() }, "deptId", "deptName", "", "--부서명--");
    	}
    }
    
    // 초기화 버튼 이벤트 처리
    function fReset() {
    	$("#fSearch")[0].reset();
    	$(".hiddenValue").val("");
    }
    
    // 헤더에 요약정보 표시
    function getSummary() {
    	var param = $("#fSearch").serializeObject();
    	
    	$.ajax({
    		url: "/contents/calc/data/calcSummary.do",
    		type: "POST",
    		dataType: "json",
    		data: param,
    		success: function(data){
    			if(data.result == true) {
    				var groupCount = 
    					"<i style=\"color: #3f75c1\">매출 : " + Util.nvl(Util.formatNumber(data.data.sellCnt), '0') + "건 / " + 
    					Util.nvl(Util.formatNumber(data.data.unpaidAmt), '0') + "원 / " + Util.nvl(Util.formatNumber(data.data.depositAmt), '0') + "원</i> | "
    				
    				$("#groupCount").html(groupCount);	
    			}	
    		}
    	});
    }
    
    // 그리드 컨택스트 메뉴 처리
    function onContextMenuSelect(e) {
        var grid = $("#grid").data("kendoGrid");
        var data = grid.dataItem(e.target);
        var row = grid.select();
        var multiSelectedData = [];
        var item = e.item.id;
        
        for(var i = 0; i < row.length; i++) {
            multiSelectedData.push(grid.dataItem(row[i]));
        }
        
        switch (item) {
        case "cSave":
            setPrivateSaveData("C3120", "grid", userId);
            break;
        case "dSave":
            setPrivatePanel("C3120", "grid", userId);
            break;
        case "vCopyId":
            if(row.length != 1) {
                alert("하나의 정산내역을 선택해주세요."); 
                return;
            }
            copyOrderId(data.orderId);
            break;
        case "vPaperReceipt":
            if(row.length < 1) {
                alert("정산내역을 하나이상 선택해주세요.");
                return;
            }
            multPaperReceipt(multiSelectedData, 'Y');
            break;
        case "vPaperReceiptCancel":
            if(row.length < 1) {
                alert("정산내역을 하나이상 선택해주세요.");
                return;
            }
            multPaperReceipt(multiSelectedData, 'N');
            break;
        case "vPaperTax":
            if(row.length < 1) {
                alert("정산내역을 하나이상 선택해주세요.");
                return;
            }
            multPaperTax(multiSelectedData, 'Y');
            break;
        case "vPaperTaxCancel":
            if(row.length < 1) {
                alert("정산내역을 하나이상 선택해주세요.");
                return;
            }
            multPaperTax(multiSelectedData, 'N');
            break;
        case "vTranReceipt":
            if(row.length < 1) {
                alert("정산내역을 하나이상 선택해주세요.");
                return;
            }
            var sellBuySctnList = [];
            var allocList = [];
            var orderList = [];
            
            for(var i = 0; i < row.length; i++) {
                allocList.push(grid.dataItem(row[i]).allocId);
                orderList.push(grid.dataItem(row[i]).orderId);
                sellBuySctnList.push(grid.dataItem(row[i]).sellBuySctnName);
            }
            
            if(sellBuySctnList.indexOf('매입') > -1){
                alert("매입구분은 발행할 수 없습니다.");
                return
            }
            
            tranModalShow(orderList, allocList);
            break;
        case "vChangeReq":  
            var sellBuySctnList = [];
            var allocList = [];
            var orderList = [];

            if(row.length < 1) {
                alert("변경할 내역을 선택해주세요.");
                return;
            }
            
            for(var i = 0; i < row.length; i++) {
                allocList.push(grid.dataItem(row[i]).allocId);
                orderList.push(grid.dataItem(row[i]).orderId);
                sellBuySctnList.push(grid.dataItem(row[i]).sellBuySctnName);
            }
            
            if(sellBuySctnList.indexOf('매입') > -1){
                alert("매입구분은 변경할 수 없습니다.");
                return
            }
            reqChangeModal.data("kendoDialog").open();
            $("#modalAllocList").val(allocList);
            $("#modalOrderList").val(orderList);
            break;
        case "vFinishCalc":
            if(row.length < 1) {
                alert("정산내역을 하나이상 선택해주세요.");
                return;
            }
            multiFinishCalc(multiSelectedData, 'Y');
            break;
        case "vCancelCalc":
            if(row.length < 1) {
                alert("정산내역을 하나이상 선택해주세요.");
                return;
            }
            multiFinishCalc(multiSelectedData, 'N');
            break;
        case "vDeleteCalc":
            deleteClac(multiSelectedData);
            break;
        }
    }
    
 	// 컬럼
    var columns = [
    	// 체크박스 추가 (order/freightControl.jsp 참고)
    	{ width: 70,
    		editable: function(e) { return false; }, 
		    headerTemplate: '<div class="auth-radio-or-checkBox">'
			 + 					'<input style="width: 13px;height: 13px;" type="checkbox" name="orderAllCheck" id="orderAllCheck" class="orderAllCheck"/>'
		     + 					'<label style="display: inline;font-size: 14px;" for="orderAllCheck">선택</label>'
		     + 				'</div>',
		    
			template: '<div class="auth-radio-or-checkBox">'
			 + 		      '<input style="width: 13px;height: 13px;" type="checkbox" name="orderCheck" value="#=orderId#" id="#=orderId#" class="orderCheck"/>'
			 + 			  '<label for="#=orderId#"></label>'
		     + 		  '</div>'
		},
		{ field: "number", title: "No", width: 50, editable: function (dataItem){} },
		{ field: "orderId", title: "오더ID", width: 160, editable: function (dataItem){} },
		{ field: "allocId", hidden: true, editable: function (dataItem){} },
		{ field: "finishYn", title: "매출마감일", width: 80,
			template: function(dataItem) {
				if (dataItem.finishYn == 'Y')
					return dataItem.calcDate;
				else
					return 'N';
			},
			editable: function (dataItem){}
		},
		{ field: "finishUserName", title: "매출마감원", width: 100, editable: function (dataItem){} },
		{ field: "allocDate", title: "배차일", width: 80, editable: function (dataItem){} },
		{ field: "eDate", title: "하차일", width: 80, editable: function (dataItem){} },
		{ field: "custName", title: "화주(거래처)", width: 120, editable: function (dataItem){} },
		{ field: "bizName", title: "거래처(계산서발행지)", width: 120, editable: function (dataItem){} },
		{ field: "sAddr", title: "상차지", width: 120, editable: function (dataItem){} },
		{ field: "eAddr", title: "하차지", width: 120, editable: function (dataItem){} },
		{ title: "2착지", width: 160,
			template: function(dataItem) {
			   if (dataItem.stopComName == null || dataItem.stopComName == '') {
				   return '';
			   } else {
				   if (dataItem.stopCount == '1') {
					   return (dataItem.stopComName);
				   } else {
					   return (dataItem.stopComName) + ' 외 ' + (dataItem.stopCount - 1) + '곳';
				   }   
			   }
			},
			editable: function (dataItem){}
		},
		{ field: "unpaidAmt", title: "매출액(소계)", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.unpaidAmt);
			},
			attributes: { 
				style: "text-align: right" 
			},
			editable: function (dataItem){}
		},
		{ field: "sellCharge", title: "내수운송료", width: 100, type: 'string',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.sellCharge);
			},
			attributes: {
				style: "text-align: right"
			},
			headerTemplate : '<label class="editHeader">내수운송료</label>'
		},
		{ field: "sellWayPointCharge", title: "경유비", width: 100, type: 'string',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.sellWayPointCharge);
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">경유비</label>'
		},
		{ field: "sellStayCharge", title: "대기료", width: 100, type: 'string',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.sellStayCharge);
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">대기료</label>'
		},
		{ field: "sellHandWorkCharge", title: "수작업비", width: 100, type: 'string',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.sellHandWorkCharge);
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">수작업비</label>'
		},
		{ field: "sellRoundCharge", title: "회차료", width: 100, type: 'string',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.sellRoundCharge);
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">회차료</label>'
		},
		{ field: "sellOtherAddCharge", title: "기타추가비", width: 100, type: 'string',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.sellOtherAddCharge);
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">기타추가비</label>'
		},
		{ field: "goodsName", title: "화물명", width: 120, editable: function (dataItem){} },
		{ field: "unitPriceTypeName", title: "단가구분", width: 100, editable: function (dataItem){} },
		{ field: "unitPrice", title: "단가", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.unitPrice);
			},
			attributes: { 
				style: "text-align: right" 
			},
			editable: function (dataItem){}
		},
		{ field: "sellWeight", title: "청구중량(톤)", width: 100, editable: function (dataItem){} },
		{ field: "goodsWeight", title: "중량(톤)", width: 100, editable: function (dataItem){} },
		{ field: "chargeTypeName", title: "청구구분", width: 100, editable: function (dataItem){} },
		{ field: "allocFee", title: "수수료", width: 100, type: 'number',
			template: function(dataItem) {
		       return Util.formatNumber(dataItem.allocFee);
		    },
			attributes: { 
				style: "text-align: right" 
			},
			editable: function (dataItem){}
		},
		{ field: "depositAmt", title: "입금액", width: 100, type: 'number',
			template: function(dataItem) {
		       return Util.formatNumber(dataItem.depositAmt);
		    },
			attributes: { 
				style: "text-align: right" 
			},
			editable: function (dataItem){}
		},  
		{ title: "명세서", width: 80,
			template: function(dataItem) {
				if (dataItem.tranReceiptYn == 'Y')
					return dataItem.tranReceiptDate;
				else
					return dataItem.tranReceiptYn;
			},
			editable: function (dataItem){}
		},
		{ field: "tranReceiptUserName", title: "발행원", width: 80 },
		{ title: "계산서", width: 80,
			template: function(dataItem) {
				if (dataItem.sellTaxInvDate != null && dataItem.sellTaxInvDate != '')
					return dataItem.sellTaxInvDate;
				else
					return 'N';
			},
			editable: function (dataItem){}
		},
		{ field: "sellTaxInvUserName", title: "발행원", width: 80 },
		{ title: "우편발송", width: 80,
			template: function(dataItem) {
				if (dataItem.postSendDate != null && dataItem.postSendDate != '')
					return dataItem.postSendDate;
				else
					return 'N';
			},
			editable: function (dataItem){}
		},
		{ field: "postSendUserName", title: "발송원", width: 80 },
		{ field: "payableAmt", title: "매입액(소계)", width: 100, type: 'number',
			template: function(dataItem) {
		    	return Util.formatNumber(dataItem.payableAmt);
		    },
			attributes: {
				style: "text-align: right" 
			},
			editable: function (dataItem){}
		},
		{ title: "차량구분", width: 90,
			template: function(dataItem) {
				if (dataItem.carSctnName != null && dataItem.carSctnName != '') 
					return dataItem.carSctnName;
				else
					return '';
			},
			editable: function (dataItem){}
		},
		{ title: "차량번호(또는 운송사)", width: 120,
			template: function(dataItem) {
				if (dataItem.carNum != null && dataItem.carNum != '')
					return dataItem.carNum;
				else {
					if (dataItem.carrierName != null && dataItem.carrierName != '') 
						return dataItem.carrierName;
					else
						return '';
				}
			},
			editable: function (dataItem){}
		},
		{ title: "차주명(또는 담당자)", width: 100,
			template: function(dataItem) {
				if (dataItem.driverName != null && dataItem.driverName != '')
					return dataItem.driverName;
				else {
					if (dataItem.carrierManager != null && dataItem.carrierManager != '') 
						return dataItem.carrierManager;
					else
						return '';
				}
			},
			editable: function (dataItem){}
		},
		{ title: "전화번호", width: 130,
			template: function(dataItem) {
				if (dataItem.driverMobile != null && dataItem.driverMobile != '')
					return Util.formatPhone(dataItem.driverMobile);
				else {
					if (dataItem.carrierMobile != null && dataItem.carrierMobile != '')
						return Util.formatPhone(dataItem.carrierMobile);
					else
						return '';
				}
			},
			editable: function (dataItem){}
		},
		{ title: "빠른지급", width: 100,
			template: function(dataItem) {
				if (dataItem.reqPayYn == 'Y')
					return dataItem.reqPayDate;
				else
					return 'N';
			},
			editable: function (dataItem){}
		},
		{ title: "인수증(전/실)", width: 130,
			template: function(dataItem) {
			   return (Util.nvl(dataItem.receiptDate, 'N')) + '/' + (Util.nvl(dataItem.paperReceiptDate, 'N'));
			},
			editable: function (dataItem){}
		},
		{ field: "taxinvDate", title: "계산서(전/실/타)", width: 130,
			template: function(dataItem) {
				var taxInv;
				if (dataItem.taxInvYn == 'Y')
					taxInv = dataItem.taxInvDate + '/' + 'N' + '/' + 'N';
				else if (dataItem.taxInvYn == 'P')
					taxInv = 'N' + '/' + dataItem.taxInvDate + '/' + 'N';
				else if (dataItem.taxInvYn == 'E')
					taxInv = 'N' + '/' + 'N' + '/' + dataItem.taxInvDate;
				else
					taxInv = 'N/N/N';
				
				return taxInv;
			},
			editable: function (dataItem){}
		},
		{ field: "appName", title: "어플명", width: 100, editable: function (dataItem){} },
		{ field: "driverCarrierName", title: "소속운송사", width: 100, editable: function (dataItem){} },
		{ field: "finishMemo", title: "마감 시 메모", width: 160, editable: function (dataItem){} },
		{ field: "refContent1", title: "참고 내용1", width: 160, editable: function (dataItem){} },
		{ field: "refContent2", title: "참고 내용2", width: 160, editable: function (dataItem){} },
		{ field: "reportBizNum", title: "신고용사업자번호", width: 160,
			template: function(dataItem) {
				return Util.formatBizNum(dataItem.reportBizNum);
			},
			editable: function (dataItem){}
		},
		{ field: "reportBizName", title: "신고용사업자명", width: 160, editable: function (dataItem){} },
		{ field: "mngDeptName", title: "담당부서", width: 120, editable: function (dataItem){} },
		{ field: "mngUserName", title: "배차원", width: 100, editable: function (dataItem){} },
		{ field: "delDate", title: "삭제일", width: 80, editable: function (dataItem){} },
		{ field: "delUser", title: "삭제자", width: 80, editable: function (dataItem){} }
	];
</script>