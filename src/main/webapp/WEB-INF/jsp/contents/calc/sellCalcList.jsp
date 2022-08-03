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

<!-- 거래명세서 발행 Modal -->
<div id="divTranReceipt" class="editor_wrap p-0">
    <form class="modalEditor" id="fTranReceipt" data-toggle="validator" role="form" autocomplete="off">
        <input type="hidden" name="tranMode" id="tranMode" class="hiddenValue">
        <input type="hidden" name="tranCustId" id="tranCustId" class="hiddenValue">
        <input type="hidden" name="tranDeptId" id="tranDeptId" class="hiddenValue">
        <input type="hidden" name="tranSupplierCustId" id="tranSupplierCustId" class="hiddenValue">
        <input type="hidden" name="tranSupplierDeptId" id="tranSupplierDeptId" class="hiddenValue">
        <input type="hidden" name="tranSupplierVehicId" id="tranSupplierVehicId" class="hiddenValue">
        <input type="hidden" name="tranSupplierDriverId" id="tranSupplierDriverId" class="hiddenValue">
        <input type="hidden" name="tranSupplierBizName" id="tranSupplierBizName" class="hiddenValue">
        <input type="hidden" name="tranSupplierBizNo" id="tranSupplierBizNo" class="hiddenValue">
        <input type="hidden" name="tranSupplierBizSubNo" id="tranSupplierBizSubNo" class="hiddenValue">
        <input type="hidden" name="tranSupplierCeo" id="tranSupplierCeo" class="hiddenValue">
        <input type="hidden" name="tranSupplierAddr" id="tranSupplierAddr" class="hiddenValue">
        <input type="hidden" name="tranSupplierBizType" id="tranSupplierBizType" class="hiddenValue">
        <input type="hidden" name="tranSupplierBizClass" id="tranSupplierBizClass" class="hiddenValue">
        <input type="hidden" name="tranBuyerCustId" id="tranBuyerCustId" class="hiddenValue">
        <input type="hidden" name="tranBuyerDeptId" id="tranBuyerDeptId" class="hiddenValue">
        <input type="hidden" name="tranBuyerVehicId" id="tranSupplierVehicId" class="hiddenValue">
        <input type="hidden" name="tranBuyerDriverId" id="tranSupplierDriverId" class="hiddenValue">
        <input type="hidden" name="tranBuyerBizName" id="tranBuyerBizName" class="hiddenValue">
        <input type="hidden" name="tranBuyerBizNo" id="tranBuyerBizNo" class="hiddenValue">
        <input type="hidden" name="tranBuyerBizSubNo" id="tranBuyerBizSubNo" class="hiddenValue">
        <input type="hidden" name="tranBuyerCeo" id="tranBuyerCeo" class="hiddenValue">
        <input type="hidden" name="tranBuyerAddr" id="tranBuyerAddr" class="hiddenValue">
        <input type="hidden" name="tranBuyerBizType" id="tranBuyerBizType" class="hiddenValue">
        <input type="hidden" name="tranBuyerBizClass" id="tranBuyerBizClass" class="hiddenValue">
        <input type="hidden" name="tranRemarksDefault" id="tranRemarksDefault" class="hiddenValue">
        <div class="modalHeader">
            <div style="width: 50%; float: left;" class="form-group row">
                <label class="col-form-label modal-big-name">발행 구분</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <select name="tranBizTypeCd" id="tranBizTypeCd" class="custom-select col-12">
                        <option value="01" selected="selected">과세(부가세별도)</option>
                        <option value="02">비과세</option>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name">세금계산서</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <select name="taxYn" id="taxYn" class="custom-select col-12">
                        <option value="N" selected="selected">미발행</option>
                        <option value="Y">발행</option>
                    </select>
                </div>
            </div>
            <div style="width: 50%; float: left;" class="form-group row">
                <label class="col-form-label modal-big-name">청구 구분</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <select name="tranPubForm" id="tranPubForm" class="custom-select col-12" disabled="disabled">
                        <option value="01">영수</option>
                        <option value="02" selected="selected">청구</option>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name">비고</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input class="form-control form-control-sm" type="text" id="tranRemarks" name="tranRemarks" disabled="disabled">
                </div>
            </div>
            
            <div style="display: inline-block;">
                <div style="float: left; width: 50%;">
                    <div class="form-group row">
                        <label class="col-form-label big-name">다중표시</label>
                        <div style="text-align: left;" class="input-group input-group-sm col middle-name form-group">
                            <select name="itemTotalType" id="itemTotalType" class="custom-select col-12" disabled="disabled">
                                <option value="0" selected="selected">단건</option>
                                <option value="1">다중</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label class="col-form-label big-name">공급자</label>
                        <div style="text-align: left;" class="input-group input-group-sm col middle-name form-group">
                        <strong class="required">담당자</strong>
                            <input type="text" name="tranSupplierMemName" id="tranSupplierMemName" class="form-control form-control-sm" disabled="disabled">
                            <div  class="help-block with-errors"></div>
                        </div>
                        <div style="text-align: left;" class="input-group input-group-sm col middle-name form-group">
                        <strong class="required">연락처</strong>
                            <input type="text" name="tranSupplierMemTel" id="tranSupplierMemTel" class="form-control form-control-sm" disabled="disabled" maxlength="13">
                            <div  class="help-block with-errors"></div>
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label class="col-form-label big-name"></label>
                        <div style="text-align: left;" class="input-group input-group-sm col middle-name form-group">
                        <strong class="required">이메일</strong>
                            <input type="text" name="tranSupplierMemEmail" id="tranSupplierMemEmail" class="form-control form-control-sm" disabled="disabled">
                            <div  class="help-block with-errors"></div>
                        </div>
                    </div>
                </div>
            
                <div style="float: right; width: 50%;">
                    <div class="form-group row">
                        <label class="col-form-label big-name">발행일자</label>
                        <div class="input-group input-group-sm col-2 middle-name">
                            <input type="checkbox" id="taxDateYn" name="taxDateYn" class="input_on-off">
                            <label for="taxDateYn" class="label_on-off">
                                <span class="marble"></span>
                                <span class="on">on</span>
                                <span class="off">off</span>
                            </label>
                        </div>
                        <div style="text-align: left;" class="input-group input-group-sm col middle-name form-group">
                            <input style="padding: 0;" type="text" id="taxDate" name="taxDate" class="col-12" disabled="disabled">
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label class="col-form-label big-name">공급받는자</label>
                        <div style="text-align: left;" class="input-group input-group-sm col middle-name form-group">
                        <strong class="required">담당자</strong>
                            <input type="text" name="tranBuyerMemName" id="tranBuyerMemName" class="form-control form-control-sm" disabled="disabled">
                            <div  class="help-block with-errors"></div>
                        </div>
                        <div style="text-align: left;" class="input-group input-group-sm col middle-name form-group">
                        <strong class="required">연락처</strong>
                            <input type="text" name="tranBuyerMemTel" id="tranBuyerMemTel" class="form-control form-control-sm"  maxlength="13" disabled="disabled">
                            <div  class="help-block with-errors"></div>
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label class="col-form-label big-name"></label>
                        <div style="text-align: left;" class="input-group input-group-sm col middle-name form-group">
                        <strong class="required">이메일</strong>
                            <input type="text" name="tranBuyerMemEmail" id="tranBuyerMemEmail" class="form-control form-control-sm" disabled="disabled">
                            <div  class="help-block with-errors"></div>
                        </div>
                    </div>
                </div>
            </div>
        
            <div class="form-group row">
                <label class="col-form-label big-name">공급받는자<br/>주소</label>
                <div style="text-align: left;" class="input-group input-group-sm col-2 middle-name form-group">
                <strong>우편물 우편번호</strong>
                    <input type="text" name="tranBuyerPostalPost" id="tranBuyerPostalPost" class="form-control form-control-sm" readonly="readonly">
                </div>
                <div style="text-align: left;" class="input-group input-group-sm col middle-name form-group">
                <strong>우편물 주소</strong>
                    <input type="text" name="tranBuyerPostalAddr" id="tranBuyerPostalAddr" class="form-control form-control-sm" readonly="readonly">
                </div>
                <div style="text-align: left;" class="input-group input-group-sm col-3 middle-name form-group">
                <strong>우편물 상세주소</strong>
                    <input type="text" name="tranBuyerPostalAddrDetail" id="tranBuyerPostalAddrDetail" class="form-control form-control-sm" readonly="readonly">
                </div>
            </div>
        </div>
        <div class="editor_btns">
            <div class="padding">
                <button type="submit" id="fTranReceiptSubmitBtn" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i><strong>발행</strong></b></button>
                <a onclick="pubTranReceiptClose()" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
            </div>
        </div>
    </form>
</div>
<!-- 거래명세서 발행 Modal End -->

<!-- 화주변경 Modal -->
<div id="divChangeReq" class="editor-warp p-0">
    <form class="modalEditor" id="fChangeReq" data-toggle="validator" role="form" autocomplete="off">
        <input type="hidden" name="modalCustId" id="modalCustId" class="hiddenValue">
        <input type="hidden" name="modalDeptId" id="modalDeptId" class="hiddenValue">
        <input type="hidden" name="modalManager" id="modalManager"  class="hiddenValue">
        <input type="hidden" name="modalAllocList" id="modalAllocList"  class="hiddenValue">
        <input type="hidden" name="modalOrderList" id="modalOrderList"  class="hiddenValue">
        <input type="hidden" name="modalBizAddr" id="modalBizAddr"  class="hiddenValue">
        <input type="hidden" name="modalBizAddrDetail" id="modalBizAddrDetail"  class="hiddenValue">
        <input type="hidden" name="modalMobile" id="modalMobile"  class="hiddenValue">
        <input type="hidden" name="modalOrderMemo" id="modalOrderMemo"  class="hiddenValue">
        <div class="modalHeader">
            <div class="form-group row">
               <label class="col-form-label modal-big-name">화주</label>
               <div class="input-group input-group-sm col-6 middle-name form-group">
                   <input type="text" id="sModalCustName" name="modalCustName" style="width:100%;" required>
                   <div class="help-block with-errors" ></div>
               </div>
               <div class="input-group input-group-sm col middle-name form-group">
                   <input type="text" id="sModalDeptName" name="modalDeptName" class="form-control form-control-sm" readonly>
               </div>
           </div>
        </div>
        <div class="editor_btns">
            <div class="padding">
                <button type="submit"  class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i><strong>변경</strong></b></button>
                <a id="closeBtn" onclick="reqChangeModalClose();" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
            </div>
        </div>
    </form>
</div>
<!-- 화주변경 Modal End -->

<!-- 매출 정산관리 페이지 -->
<div class="header">
    <div style="justify-content: space-between; display: flex;" class="summary p30">
        <div class="hdr-tit">
            <P id="headerTitle">매출정산관리</P>
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
                            <!-- 공통코드로 구분함. -->
                            <option value="01">화주명</option>
                            <option value="orderId">오더ID</option>
                        </select>
                    </div>
                    <div id="searchDiv" class="input-group input-group-sm col-2 middle-name">
                        <strong>&nbsp;</strong>
                        <input type="text" id="sCustName" name="custName" style="width: 100%;">
                    </div>
                    <div style="display: none;" id="orderSearch" class="input-group input-group-sm col-2 middle-name">
                        <strong>&nbsp;</strong>
                        <input type="text" id="orderId" name="orderId" class="form-control form-control-sm">
                    </div>
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>&nbsp;</strong>
                        <input type="text" name="sSubName" id="subName" class="form-control form-control-sm" readonly>
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
                        <select class="form-control" class="custom-select col-12" id="sDeptId" name="deptId">
                            <option>--전체--</option>
                        </select>
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <strong>배차담당자</strong>
                        <select class="form-control" class="custom-select col-12" id="sUserId" name="userId">
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
                        <input id="carryOverYn" name="carryOver" type="checkbox" value="Y" onClick="searchChecked(this)">
                        <label for="carryOverYn" class="label-margin"> <span>미처리 이월건 포함</span>
                        </label>
                    </div>

                    <div class="input-group input-group-sm col radio-or-checkBox " hidden="true">
                        <input id="deleteCalcYn" name="deleteCalc" type="checkbox" value="N" onClick="searchChecked(this)">
                        <label for="deleteCalcYn" class="label-margin"> <span>삭제건 포함</span>
                        </label>
                    </div>

                    <div class="input-group input-group-sm col-1 middle-name" style="max-width: 90px; min-width: 90px;">
                        <strong>&nbsp;</strong>
                        <button onclick="getCalcList()" type="button" style="border-radius: 4px" class="form-control form-control-sm middle-button-dark">
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
                                                            <a href="#" class="k-pager-refresh k-button" id="changeReqCust" onClick="reqChangeModalOpen()">
                                                                <b class="btn-b"> <i class="k-icon k-i-user"></i>화주변경
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="changeSellCharge" onClick="changeSellCharge()">
                                                                <b class="btn-b"> <i class="k-icon k-i-dollar"></i>청구운송비변경
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="tranReceiptComp" onClick="pubTranReceiptOpen()" disabled>
                                                                <b class="btn-b"> <i class="k-icon k-i-paste-plain-text"></i>거래명세서발행
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="taxinvComp" disabled>
                                                                <b class="btn-b"> <i class="k-icon k-i-txt"> </i>세금계산서발행
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="taxinvPostSend" onClick="taxinvPostSend()">
                                                                <b class="btn-b"> <i class="k-icon k-i-txt"> </i>우편발송처리
                                                                </b>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${menuAuth.printYn eq 'Y'}">
                                                            <a href="#" class="k-pager-refresh k-button" id="finishCalc" disabled>
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
    var searchCustName;
    var bizName;
    var calcId;
    var taxData;
    var errChk = false;
    
    var userId = '${sessionScope.userInfo.userId}';
    var deptId = "${sessionScope.userInfo.deptId}";
    
    var selectedList = new Map();
    var editedList = [];
   	
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
        
        // 리스트 출력
       	getCalcList();
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
                { field: "bizName", title: "사업자명", width:100 },
                { field: "bizNum", title: "사업자번호", width:100 }
            ]
        }).data("kendoMultiColumnComboBox");    

        searchBiz.bind("select", changeBizName);
        $("#custType").on("change", function(){
            setSearchForm();
        }); 
        
        return searchBiz;
    }
    
    function getCalcList() {
    	// 선택된 항목 리스트 초기화
    	selectedList.clear();
    	// 에디트 항목 리스트 초기화
    	editedList.splice(0, editedList.length);
    	// 컬럼 전체 선택 초기화
    	$("#orderAllCheck").prop("checked", false);
    	
        columns = setPrivateData("C3120", "grid", userId, columns);
        
        var grid = $("#grid").kendoGrid({
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
//             	$(".k-textbox").prop("type", "number");
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
        }).data("kendoGrid");
        
        setOptionActive("C3120", "grid", userId);
        
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
			
			selectedList.set(dataItem.id, dataItem);
		} else {
			row.removeClass("k-state-selected");
			
			// 체크 해제상태의 경우 전체선택도 풀어줌.
			$("#orderAllCheck").prop("checked", false);
			
			selectedList.delete(dataItem.id);
		}
    }
    
    // 에디팅 저장 이벤트 처리
    function onEditSave(e) {
    	// 편집하려는 정산이 이미 마감처리된 항목이면 변경 불가능
    	if (e.model.get("finishYn") != "N") {
    		alert("이미 마감된 정산 항목의 경우 운송비를 변경할 수 없습니다.");
    		e.preventDefault();
    		return;
    	}	
    	
    	// Charge 항목 에디팅의 경우 에디트 완료 후 매출액 항목 업데이트 (변경전 값을 빼고 입력된 값으로.)
		var unpaidAmtVal = Number(e.model.get("unpaidAmt"));
		
		if (e.values.sellCharge) {
			unpaidAmtVal -= Number(e.model.get("sellCharge"));
			unpaidAmtVal += Number(e.values.sellCharge);
			
			var orderId = e.model.get("orderId");
			var allocId = e.model.get("sellAllocId");
			var calcId = e.model.get("sellChargeId");
			var chargeCode = "0002";
			var value = e.values.sellCharge;
			var insert = false;
			
			editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert);
		}
		else if (e.values.sellWaypointCharge) {
			unpaidAmtVal -= Number(e.model.get("sellWaypointCharge"));
			unpaidAmtVal += Number(e.values.sellWaypointCharge);
			
			var orderId = e.model.get("orderId");
			var allocId = e.model.get("sellAllocId");
			var calcId = (e.model.get("sellWaypointChargeId") == '') ? e.model.get("sellChargeId") : e.model.get("sellWaypointChargeId");
			var chargeCode = "0023";
			var value = e.values.sellWaypointCharge;
			var insert = (e.model.get("sellWaypointChargeId") == '') ? true : false
			
			editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert);
		}
		else if (e.values.sellStayCharge) {
			unpaidAmtVal -= Number(e.model.get("sellStayCharge"));
			unpaidAmtVal += Number(e.values.sellStayCharge);
			
			var orderId = e.model.get("orderId");
			var allocId = e.model.get("sellAllocId");
			var calcId = (e.model.get("sellStayChargeId") == '') ? e.model.get("sellChargeId") : e.model.get("sellStayChargeId");
			var chargeCode = "0025";
			var value = e.values.sellStayCharge;
			var insert = (e.model.get("sellStayChargeId") == '') ? true : false
			
			editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert);
		}
		else if (e.values.sellHandworkCharge) {
			unpaidAmtVal -= Number(e.model.get("sellHandworkCharge"));
			unpaidAmtVal += Number(e.values.sellHandworkCharge);
			
			var orderId = e.model.get("orderId");
			var allocId = e.model.get("sellAllocId");
			var calcId = (e.model.get("sellHandworkChargeId") == '') ? e.model.get("sellChargeId") : e.model.get("sellHandworkChargeId");
			var chargeCode = "0371";
			var value = e.values.sellHandworkCharge;
			var insert = (e.model.get("sellHandworkChargeId") == '') ? true : false
			
			editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert);
		}
		else if (e.values.sellRoundCharge) {
			unpaidAmtVal -= Number(e.model.get("sellRoundCharge"));
			unpaidAmtVal += Number(e.values.sellRoundCharge);
			
			var orderId = e.model.get("orderId");
			var allocId = e.model.get("sellAllocId");
			var calcId = (e.model.get("sellRoundChargeId") == '') ? e.model.get("sellChargeId") : e.model.get("sellRoundChargeId");
			var chargeCode = "0372";
			var value = e.values.sellRoundCharge;
			var insert = (e.model.get("sellRoundChargeId") == '') ? true : false
			
			editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert);
		}
		else if (e.values.sellOtheraddCharge) {
			unpaidAmtVal -= Number(e.model.get("sellOtheraddCharge"));
			unpaidAmtVal += Number(e.values.sellOtheraddCharge);
			
			var orderId = e.model.get("orderId");
			var allocId = e.model.get("sellAllocId");
			var calcId = (e.model.get("sellOtheraddChargeId") == '') ? e.model.get("sellChargeId") : e.model.get("sellOtheraddChargeId");
			var chargeCode = "0294";
			var value = e.values.sellOtheraddCharge;
			var insert = (e.model.get("sellOtheraddChargeId") == '') ? true : false;
			
			editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert);
		}
		else {
			// null일 경우 이벤트 처리 안함.
			e.preventDefault();
		}
		
		e.model.set("unpaidAmt", unpaidAmtVal);
		
		// 에디팅 완료 후 체크 활성화
		var row = e.container.closest("tr");
		var checkBoxId = e.model.get("orderId");
		var checked = $("#" + checkBoxId).is(":checked");
		if (!checked) {
			$("#" + checkBoxId).prop("checked", true);
			orderCheck(row);
		}
    }
    
    // 에디트 리스트 중복값 체크
    function editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert) {
    	// 에디트된 항목 리스트에서 중복된 데이터를 찾고 없으면 신규 항목, 있으면 업데이트 한다.
    	for (var i = 0; i < editedList.length; i++) {
			var dataItem = editedList[i];
			if (dataItem.orderId == orderId && dataItem.allocId == allocId &&
				dataItem.calcId == calcId && dataItem.chargeCode == chargeCode) {
				// value값만 업데이트
				dataItem.value = value;
				
				return;
			}
		}
    	
    	// 신규항목 삽입
    	var item = {
			orderId: orderId,
			allocId: allocId,
			calcId: calcId,
			chargeCode: chargeCode,
			value: value,
			insert: insert
		}
		editedList.push(item);
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
    
 	// 우편발송 처리
    function taxinvPostSend() {
    	if (selectedList.size > 0) {
    		var message = "선택된 (" + selectedList.size + ")건에 대한 우편발송 처리를 하시겠습니까?";
    		if (confirm(message)) {
    			var orderIdList = [];
    			var allocIdList = [];
        		for (var [key, value] of selectedList) {
        			orderIdList.push(value.orderId);
        			allocIdList.push(value.sellAllocId);
            	}
        		
        		$.ajax({
        			url: "/contents/calc/data/updatePostSendYn.do",
        			type: "POST",
        			dataType: "json",
        			data: {
        				orderIdList: orderIdList.toString(),
        				allocIdList: allocIdList.toString(),
        				postSendYn: 'Y'
        			},
        			success: function(data){
        				if (data.linkMessage.status == 0) {
        					// 요청 성공시 내용 기술
							alert(data.linkMessage.message);
							getCalcList();
							contextMenu.close();
        				} else {
        					alert(data.linkMessage.message);
        				}
        			}
        		});
    		}
    	} else {
    		alert("우편발송 처리할 항목을 선택해 주세요.");
    	}
    }
    
	// 우편발송 취소
    function taxInvPostSendCancel() {
    	if (selectedList.size > 0) {
    		var message = "선택된 (" + selectedList.size + ")건에 대한 우편발송 처리를 취소 하시겠습니까?";
    		if (confirm(message)) {
    			var orderIdList = [];
    			var allocIdList = [];
        		for (var [key, value] of selectedList) {
        			orderIdList.push(value.orderId);
        			allocIdList.push(value.sellAllocId);
            	}
        		
        		$.ajax({
        			url: "/contents/calc/data/updatePostSendYn.do",
        			type: "POST",
        			dataType: "json",
        			data: {
        				orderIdList: orderIdList.toString(),
        				allocIdList: allocIdList.toString(),
        				postSendYn: 'N'
        			},
        			success: function(data){
        				if (data.linkMessage.status == 0) {
        					// 요청 성공시 내용 기술
							alert(data.linkMessage.message);
							getCalcList();
							contextMenu.close();
        				} else {
        					alert(data.linkMessage.message);
        				}
        			}
        		});
    		}
    	} else {
    		alert("우편발송 처리할 항목을 선택해 주세요.");
    	}
    }
	
 	// 삭제 처리
	function deleteCalc() {
		if (selectedList.size > 0) {
    		var message = "선택된 (" + selectedList.size + ")건에 대한 삭제 처리를 하시겠습니까?\n이미 마감 처리 및 삭제 처리된 건은 제외됩니다.";
    		if (confirm(message)) {
    			var orderIdList = [];
    			var allocIdList = [];
        		for (var [key, value] of selectedList) {
        			if (value.finishYn == "" || value.finishYn == "N") {
        				if (value.deleteYn == "" || value.deleteYn == "N") {
            				orderIdList.push(value.orderId);
                			allocIdList.push(value.sellAllocId);
        				}
        			}
            	}
        		
        		$.ajax({
        			url: "/contents/calc/data/updateDeleteYn.do",
        			type: "POST",
        			dataType: "json",
        			data: {
        				orderIdList: orderIdList.toString(),
        				allocIdList: allocIdList.toString(),
        				deleteYn: 'Y'
        			},
        			success: function(data){
        				if (data.linkMessage.status == 0) {
        					// 요청 성공시 내용 기술
							alert(data.linkMessage.message);
							getCalcList();
							contextMenu.close();
        				} else {
        					alert(data.linkMessage.message);
        				}
        			}
        		});
    		}
    	} else {
    		alert("삭제 처리할 항목을 선택해 주세요.");
    	}
    }
	
    // 삭제 취소
    function cancelDeleteCalc() {
    	if (selectedList.size > 0) {
    		var message = "선택된 (" + selectedList.size + ")건에 대한 삭제 취소를 하시겠습니까?\n삭제되지 않은 건은 제외됩니다.";
    		if (confirm(message)) {
    			var orderIdList = [];
    			var allocIdList = [];
        		for (var [key, value] of selectedList) {
        			if (value.deleteYn != "" && value.deleteYn != "N") {
        				orderIdList.push(value.orderId);
            			allocIdList.push(value.sellAllocId);	
        			}
            	}
        		
        		$.ajax({
        			url: "/contents/calc/data/updateDeleteYn.do",
        			type: "POST",
        			dataType: "json",
        			data: {
        				orderIdList: orderIdList.toString(),
        				allocIdList: allocIdList.toString(),
        				deleteYn: 'N'
        			},
        			success: function(data){
        				if (data.linkMessage.status == 0) {
        					// 요청 성공시 내용 기술
							alert(data.linkMessage.message);
							getCalcList();
							contextMenu.close();
        				} else {
        					alert(data.linkMessage.message);
        				}
        			}
        		});
    		}
    	} else {
    		alert("삭제 처리할 항목을 선택해 주세요.");
    	}
    }
    
    // 오더 ID 클립보드 복사
    function copyOrderId(orderId){
    	var grid = $("#grid").data("kendoGrid");
    	if (!grid.areaClipBoard) {
            grid.areaClipBoard = $('<textarea />').css({
                position: 'fixed',
                top: '50%',
                left: '50%',
                opacity: 0,
                width: 0,
                height: 0
            }).appendTo(grid.wrapper);
        }

        //overwrite the default clipboard content of kendo with our custom data source
        grid.areaClipBoard.val(orderId);
        //call copy to clipboard to copy the contents
        copyToClipboard(orderId);
    }

 	// 오더 ID 클립보드 복사
    function copyToClipboard(html) {
        var textarea = document.createElement('textarea');
        $(textarea).addClass('k-spreadsheet-clipboard').val(html).appendTo(document.body).focus().select();
        document.execCommand('copy');
        $(textarea).remove();
    }
    
  	// 엑셀 다운로드
    function excelDownload() {
    	$("#loading").show();
    	
    	var grid = $("#grid").data("kendoGrid");
    	grid.saveAsExcel();
    }
  	
  	// 검색조건 체크박스 Value 설정
  	function searchChecked(e) {
  		if (e.checked == true)
  			$(e).val("Y")
  		else
  			$(e).val("N")
  	}
  	
  	// 인수증보기
  	function viewReceipt(receiptYn, orderId) {
  		if (receiptYn == "N") {
  			alert("등록된 인수증이 없습니다.");
  			return;
  		} else if (!receiptYn.includes("전자")) {
  			alert(receiptYn + "으로 등록된 인수증입니다.");
  			return;
  		}
  		
  		window.open("/contents/calc/view/orderFile.do?orderId=" + orderId, "PopupPost", "width=620, height=707");
  	}
  	
 	// 청구운송비 변경
 	function changeSellCharge() {
 		if (editedList.length > 0) {
 			var message = "항목이 변경된  (" + editedList.length + ")건에 대한 운송비 변경을 하시겠습니까?";
 			if (confirm(message)) {
 				
 				var params = {
				   "params" : JSON.stringify(editedList)
				}
 				
 				$.ajax({
					url: "/contents/calc/data/upsertCalcCharge.do",
					type: "POST",
					dataType: "json",
					data: params,
					success: function(data) {
						// 결과 출력
						var failCnt = 0;
    	  				for (var i = 0; i < data.linkMessages.length; i++) {
    	  					linkMessage = data.linkMessages[i];
    	  					if (linkMessage.status < 0) {
    	  						failCnt++;
    	  					}
    	  				}
    	  				if (failCnt <= 0) {
    	  					alert(data.linkMessages.length + "건의 운송비 내역를 변경했습니다.");
    	  				} else {
    	  					alert(data.linkMessages.length + "건 중 " + failCnt + "건이 실패했습니다.\n상세 내역은 로그를 확인하세요.");
    	  				}
						
						getCalcList();
					}
				});
 			}
 		} else {
 			alert("변경할 청구운송비 항목을 선택해 주세요.");
 		}
 	}
 	
 	// 마감처리
 	function calcFinish() {
 		if (selectedList.size > 0) {
    		var message = "선택된 (" + selectedList.size + ")건에 대한 마감 처리를 하시겠습니까?\n이미 처리된 건은 제외됩니다.";
    		if (confirm(message)) {
//     			var orderIdList = [];
//     			var allocIdList = [];
//         		for (var [key, value] of selectedList) {
//         			if (value.deleteYn != "" && value.deleteYn != "N") {
//         				orderIdList.push(value.orderId);
//             			allocIdList.push(value.sellAllocId);	
//         			}
//             	}
        		
//         		$.ajax({
//         			url: "/contents/calc/data/updateDeleteYn.do",
//         			type: "POST",
//         			dataType: "json",
//         			data: {
//         				orderIdList: orderIdList.toString(),
//         				allocIdList: allocIdList.toString(),
//         				deleteYn: 'N'
//         			},
//         			success: function(data){
//         				if (data.linkMessage.status == 0) {
//         					// 요청 성공시 내용 기술
// 							alert(data.linkMessage.message);
// 							getCalcList();
// 							contextMenu.close();
//         				} else {
//         					alert(data.linkMessage.message);
//         				}
//         			}
//         		});
    		}
    	} else {
    		alert("삭제 처리할 항목을 선택해 주세요.");
    	}
 	}
 	
 	// 마감취소
 	function calcFinishCancel() {
 		if (selectedList.size > 0) {
    		var message = "선택된 (" + selectedList.size + ")건에 대한 마감 취소 처리를 하시겠습니까?\n마감되지 않은 건은 제외됩니다.";
    		if (confirm(message)) {
//     			var orderIdList = [];
//     			var allocIdList = [];
//         		for (var [key, value] of selectedList) {
//         			if (value.deleteYn != "" && value.deleteYn != "N") {
//         				orderIdList.push(value.orderId);
//             			allocIdList.push(value.sellAllocId);	
//         			}
//             	}
        		
//         		$.ajax({
//         			url: "/contents/calc/data/updateDeleteYn.do",
//         			type: "POST",
//         			dataType: "json",
//         			data: {
//         				orderIdList: orderIdList.toString(),
//         				allocIdList: allocIdList.toString(),
//         				deleteYn: 'N'
//         			},
//         			success: function(data){
//         				if (data.linkMessage.status == 0) {
//         					// 요청 성공시 내용 기술
// 							alert(data.linkMessage.message);
// 							getCalcList();
// 							contextMenu.close();
//         				} else {
//         					alert(data.linkMessage.message);
//         				}
//         			}
//         		});
    		}
    	} else {
    		alert("삭제 처리할 항목을 선택해 주세요.");
    	}
 	}
 	
 	
    /*
     * 화주변경 Modal
     */
    reqChangeModal = $("#divChangeReq");
    reqChangeModal.kendoDialog({
        width: "500px",
        height: "240px",
        visible: false,
        title: "화주변경",
        closable: true,
        modal: true
    });
    
    function reqChangeModalOpen() {
    	if(!$("#sDeptId").val()) {
 			alert("담당부서를 선택해주세요.");
 			return;
 		}
 		
 		if (selectedList.size <= 0) {
 			alert("화주를 변경할 항목을 선택해 주세요.");
			return; 			
 		}
 		
 		if (selectedList.size > 0) {
 			var orderIdList = [];
			var allocIdList = [];
    		for (var [key, value] of selectedList) {
    			if (value.deleteYn != "" && value.deleteYn != "Y") {
    				orderIdList.push(value.orderId);
        			allocIdList.push(value.sellAllocId);
    			}
        	}
 		}
 		
 		reqChangeModal.data("kendoDialog").open();
 		$("#modalAllocList").val(allocIdList);
 		$("#modalOrderList").val(orderIdList);
 		
 		searchModalCustName = $("#sModalCustName").data("kendoMultiColumnComboBox");
 		searchModalCustName = MultiColumnComboBox.setCustName("sModal", $("#custType").val(), $("#sDeptId").val());
 		searchModalCustName.bind("select", onChangeSearchModalCust);
    }
    
    function onChangeSearchModalCust(e) {
 		var dataItem = e.dataItem;
 		if (dataItem != null) {
 			$("#sModalDeptName").val(dataItem.deptName);
 			
 			$("#modalCustId").val(dataItem.custId);
 			$("#modalDeptId").val(dataItem.deptId);
 			$("#modalManager").val(dataItem.userId);
 			$("#modalBizAddr").val(dataItem.bizAddr);
 			$("#modalBizAddrDetail").val(dataItem.bizAddrDetail);
 			$("#modalMobile").val(dataItem.mobile);
 			$("#modalOrderMemo").val(dataItem.orderMemo);
 		}
 	}

    function reqChangeModalClose() { 
    	reqChangeModal.data("kendoDialog").close();
        $("#modalCustId").val("");
        $("#modalDeptId").val("");
        $("#modalManager").val("");
        $("#modalAllocList").val("");
        $("#modalOrderList").val("");
        $("#modalBizAddr").val("");
        $("#modalBizAddrDetail").val("");
        $("#modalMobile").val("");
        $("#modalOrderMemo").val("");
        
        $("#fChangeReq")[0].reset();
        $(".list-unstyled").remove();
    }
    
    $('#fChangeReq').validator().on('submit', function (e) {
    	if (e.isDefaultPrevented()) {
    		alert("항목을 입력해 주세요.");
    		e.preventDefault();
    		return;
    	}
    	
    	var param = {
    		custId: $("#modalCustId").val(),
    		deptId: $("#modalDeptId").val(),
    		manager: $("#modalManager").val(),
    		allocList: $("#modalAllocList").val(),
    		orderList: $("#modalOrderList").val(),
    		bizAddr: $("#modalBizAddr").val(),
    		bizAddrDetail: $("#modalBizAddrDetail").val(),
    		mobile: $("#modalMobile").val(),
    		memo: $("#modalOrderMemo").val(),
    	};
    	
    	if(confirm("화주를 변경하시겠습니까?\n삭제된 정산에 대해서는 화주변경을 할 수 없습니다.")) {
    		// 이벤트 초기화 (submit 동작 중단)
			e.preventDefault();
			$.ajax({
				url: "/contents/calc/data/updateSellChangeReq.do",
				type: "POST",
				dataType: "json",
				data: param,
				success: function(data) {
					if (data.linkMessage.status == 0) {
						alert(data.linkMessage.message);
						getCalcList();
						reqChangeModalClose();
					} else if (data.linkMessage.status == 1) {
						alert(data.linkMessage.message);
					} else {
						alert(data.linkMessage.message);
					}
				}
			});
    	}
    });
    
    /*
     * 거래명세서 Modal
     */
    tranReceiptModal = $("#divTranReceipt");
 	tranReceiptModal.kendoDialog({
 		width: "800px",
 		height: "483px",
 		visible: false,
 		title: "거래명세서",
 		closable: true,
 		modal: true
 	});
    
    function pubTranReceiptOpen() {
    	tranReceiptModal.data("kendoDialog").open();
    }
    
    function pubTranReceiptClose() {
    	tranReceiptModal.data("kendoDialog").close();
    }
 	
  	
 	// 그리드 컨택스트 메뉴 처리
    function onContextMenuSelect(e) {
    	var item = e.item.id;
    	
    	switch (item) {
    	case "cSave":
            setPrivateSaveData("C3120", "grid", userId);
            break;
        case "dSave":
            setPrivatePanel("C3120", "grid", userId);
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
        	break;
        case "cancelDeleteCalc":
        	cancelDeleteCalc();
        	break;
    	}
    }
    
 	// 컬럼
    var columns = [
    	// 체크박스 추가 (order/freightControl.jsp 참고)
    	{ field: "check", width: 70,
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
		{ field: "number", title: "번호", width: 80, editable: function (dataItem){} },
		{ field: "orderId", title: "오더ID", width: 160, editable: function (dataItem){} },
		{ field: "finishYn", title: "마감일", width: 80, editable: function (dataItem){} },
		{ field: "finishUserName", title: "마감원", width: 100, editable: function (dataItem){} },
		{ field: "allocDate", title: "배차일", width: 80, editable: function (dataItem){} },
		{ field: "eDate", title: "하차일", width: 80, editable: function (dataItem){} },
		{ field: "custName", title: "화주(거래처)", width: 140, editable: function (dataItem){} },
		{ field: "bizName", title: "거래처(계산서발행지)", width: 160, editable: function (dataItem){} },
		{ field: "sAddr", title: "상차지", width: 120, editable: function (dataItem){} },
		{ field: "eAddr", title: "하차지", width: 120, editable: function (dataItem){} },
		{ field: "wayPoint", title: "2착지", width: 160, editable: function (dataItem){} 	},
		{ field: "unpaidAmt", title: "매출액(소계)", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.unpaidAmt);
			},
			attributes: { 
				style: "text-align: right" 
			},
			editable: function (dataItem){}
		},
		{ field: "sellCharge", title: "내수운송료", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.sellCharge);
			},
			attributes: {
				style: "text-align: right"
			},
			headerTemplate : '<label class="editHeader">내수운송료</label>'
		},
		{ field: "sellWaypointCharge", title: "경유비", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.sellWaypointCharge);
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">경유비</label>'
		},
		{ field: "sellStayCharge", title: "대기료", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.sellStayCharge);
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">대기료</label>'
		},
		{ field: "sellHandworkCharge", title: "수작업비", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.sellHandworkCharge);
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">수작업비</label>'
		},
		{ field: "sellRoundCharge", title: "회차료", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.sellRoundCharge);
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">회차료</label>'
		},
		{ field: "sellOtheraddCharge", title: "기타추가비", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(dataItem.sellOtheraddCharge);
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
		{ field: "tranReceiptYn", title: "명세서", width: 80, editable: function (dataItem){} },
		{ field: "tranReceiptUserName", title: "발행원", width: 100 },
		{ field: "sellTaxinvYn", title: "계산서", width: 80, editable: function (dataItem){} },
		{ field: "sellTaxinvUserName", title: "발행원", width: 100 },
		{ field: "postsendYn", title: "우편발송", width: 80, editable: function (dataItem){} },
		{ field: "postsendUserName", title: "발송원", width: 100 },
		{ field: "payableAmt", title: "매입액(소계)", width: 100, type: 'number',
			template: function(dataItem) {
		    	return Util.formatNumber(dataItem.payableAmt);
		    },
			attributes: {
				style: "text-align: right" 
			},
			editable: function (dataItem){}
		},
		{ field: "carSctnName", title: "차량구분", width: 90, editable: function (dataItem){} },
		{ field: "buyCustName", title: "차량번호(또는 운송사)", width: 160, editable: function (dataItem){} },
		{ field: "buyCustManager", title: "차주명(또는 담당자)", width: 160, editable: function (dataItem){} },
		{ field: "buyCustMobile", title: "전화번호", width: 130,
			template: function(dataItem) {
				return Util.formatPhone(dataItem.buyCustMobile);
			},
			editable: function (dataItem){}
		},
		{ field: "reqPayYn", title: "빠른지급", width: 100, editable: function (dataItem){} },
		{ field: "receiptYn", title: "인수증", width: 130, editable: function (dataItem){} },
		{ field: "taxinvYn", title: "계산서", width: 130, editable: function (dataItem){} },
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
		{ field: "deleteYn", title: "삭제일", width: 80, editable: function (dataItem){} },
		{ field: "deleteUserName", title: "삭제자", width: 80, editable: function (dataItem){} },
		
		// 숨김항목
		{ field: "mngCustId", hidden: true, editable: function (dataItem){} },
		{ field: "mngDeptId", hidden: true, editable: function (dataItem){} },
		{ field: "sellAllocId", hidden: true, editable: function (dataItem){} },
		{ field: "buyAllocId", hidden: true, editable: function (dataItem){} },
		{ field: "custId", hidden: true, editable: function (dataItem){} },
		{ field: "bizId", hidden: true, editable: function (dataItem){} },
		{ field: "sellChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "sellWaypointChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "sellStayChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "sellHandworkChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "sellRoundChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "sellOtheraddChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "buyChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "buyWaypointChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "buyStayChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "buyHandworkChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "buyRoundChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "buyOtheraddChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "buyAllocfeeChargeId", hidden: true, editable: function (dataItem){} }
	];
</script>