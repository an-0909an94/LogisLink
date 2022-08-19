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
                <i id="groupCount" style="font-size: larger;"></i>
            </div>
        </div>
    </div>

    <div class="contents">
        <div id="group-list" class="cont-wrapper-page-grid">
            <!-- 검색 조건 영역 -->
            <form id="fSearch" class="date-bnt" method="post">
            
                <!-- 검색 1라인 -->
                <div class="form-group row">
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>정산마감여부</strong>
                        <select id="sFinishYn" name="finishYn" class="custom-select col-12">
                            <option value="">--전체--</option>
                            <option value="Y">Y</option>
                            <option value="N" selected>N</option>
                        </select>
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>거래처검색</strong>
                        <select id="searchCustType" name="searchCustType" class="custom-select col-12">
                            <!-- 공통코드로 구분함. -->
                            <option value="custName" selected>화주명</option>
                            <option value="orderId">오더ID</option>
                        </select>
                    </div>
                    <div id="searchCustName" class="input-group input-group-sm col-2 middle-name">
                        <strong>&nbsp;</strong>
                        <input type="text" id="sCustName" name="custName" style="width: 100%;">
                    </div>
                    <div id="searchOrderId" class="input-group input-group-sm col-2 middle-name" style="display: none;">
                        <strong>&nbsp;</strong>
                        <input type="text" id="sOrderId" name="orderId" class="form-control form-control-sm">
                    </div>
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>&nbsp;</strong>
                        <input type="text" id="sCustDeptName" name="custDeptName" class="form-control form-control-sm" readonly>
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>사업자검색</strong>
                        <select id="searchBizType" name="searchBizType" class="custom-select col-12">
                            <option value="bizName" selected>사업자상호</option>
                            <option value="bizNum">사업자번호</option>
                        </select>
                    </div>
                    <div class="input-group input-group-sm col-2 middle-name">
                        <strong>&nbsp;</strong>
                        <input type="text" id="sBizName" name="bizName" style="width: 100%;">
                    </div>
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>&nbsp;</strong>
                        <select id="sBizDeptName" name="bizDeptName" class="custom-select"></select>
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>청구구분</strong>
                        <select id="sChargeType" name="chargeType" class="form-control custom-select col-12">
                            <option>--전체--</option>
                        </select>
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>담당부서명</strong>
                        <select id="sDeptId" name="deptId" class="form-control custom-select col-12">
                            <option>--전체--</option>
                        </select>
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>배차담당자</strong>
                        <select id="sUserId" name="userId" class="form-control custom-select col-12">
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
                        <strong>빠른지급여부</strong>
                        <select id="sFastPayYn" name="fastPayYn" class="custom-select col-12">
                            <option value="" selected>--전체--</option>
                            <option value="Y">Y</option>
                            <option value="N">N</option>
                        </select>
                    </div>
                    
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>삭제여부</strong>
                        <select id="sDeleteYn" name="deleteYn" class="custom-select col-12">
                            <option value="">--전체--</option>
                            <option value="Y">Y</option>
                            <option value="N" selected>N</option>
                        </select>
                    </div>

                    <div class="input-group input-group-sm col radio-or-checkBox ">
                        <input id="carryOverYn" name="carryOver" type="checkbox" value="Y" onClick="searchChecked(this)">
                        <label for="carryOverYn" class="label-margin"> <span>미처리 이월건 포함</span>
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
                                                            <a href="#" class="k-pager-refresh k-button" id="deleteCalc" onClick="deleteCalc()">
                                                                <b class="btn-r"> <i class="k-icon k-i-txt"></i>삭제처리
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="changeReqCust" onClick="">
                                                                <b class="btn-b"> <i class="k-icon k-i-user"></i>인수증보기
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="changeSellCharge" onClick="">
                                                                <b class="btn-b"> <i class="k-icon k-i-dollar"></i>매입계산서보기
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="tranReceiptComp" onClick="">
                                                                <b class="btn-b"> <i class="k-icon k-i-paste-plain-text"></i>매입처변경
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="taxinvPostSend" onClick="">
                                                                <b class="btn-b"> <i class="k-icon k-i-dollar"> </i>지불운송비변경
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="finishCalc" onClick="">
                                                                <b class="btn-b"> <i class="k-icon k-i-paste-plain-text"> </i>실물인수증수령
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="finishCalc" onClick="">
                                                                <b class="btn-b"> <i class="k-icon k-i-paste-plain-text"> </i>실물계산서수령
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="finishCalc" onClick="">
                                                                <b class="btn-b"> <i class="k-icon k-i-paste-plain-text"> </i>타사계산서수령
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="finishCalc" onClick="calcFinish()">
                                                                <b class="btn-b"> <i class="k-icon k-i-edit"> </i>마감처리
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="excelDownload" onClick="excelDownload()">
                                                                <b class="btn-x"> <i class="k-icon k-i-file-excel"> </i>엑셀출력
                                                                </b>
                                                            </a>
                                                        </c:if>
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
                                <li id="copyOrderId">오더아이디 복사</li>
                                <li class="k-separator"></li>
                                <li id="vReceipt">인수증보기</li>
                                <li class="k-separator"></li>
                                <li id="taxinvPostSendCancel">우편발송 취소</li>
                                <li class="k-separator"></li>
                                <li id="cancelCalc">마감 취소</li>
                                <li class="k-separator"></li>
                                <li id="cancelDeleteCalc">삭제 취소</li>
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
    $(document).ready(function() {
        
    });
</script>