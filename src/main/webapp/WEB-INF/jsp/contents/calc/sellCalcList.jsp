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
    <form id="fTranReceipt" class="modalEditor" data-toggle="validator" role="form" autocomplete="off">
        <!-- 청구구분 = D: 기사발행, R: 인수증 -->
        <input type="hidden" id="tranMode" name="tranMode" class="hiddenValue">
        <input type="hidden" id="tranCustId" name="tranCustId" class="hiddenValue">
        <input type="hidden" id="tranDeptId" name="tranDeptId" class="hiddenValue">
        <input type="hidden" id="tranOrderList" name="tranOrderList" class="hiddenValue">
        <!-- 공급자 -->
        <input type="hidden" id="tranSupplierCustId" name="tranSupplierCustId" class="hiddenValue">
        <input type="hidden" id="tranSupplierDeptId" name="tranSupplierDeptId" class="hiddenValue">
        <input type="hidden" id="tranSupplierVehicId" name="tranSupplierVehicId" class="hiddenValue">
        <input type="hidden" id="tranSupplierDriverId" name="tranSupplierDriverId" class="hiddenValue">
        <input type="hidden" id="tranSupplierBizName" name="tranSupplierBizName" class="hiddenValue">
        <input type="hidden" id="tranSupplierBizType" name="tranSupplierBizType" class="hiddenValue">
        <input type="hidden" id="tranSupplierBizNo" name="tranSupplierBizNo" class="hiddenValue">
        <input type="hidden" id="tranSupplierBizSubNo" name="tranSupplierBizSubNo" class="hiddenValue">
        <input type="hidden" id="tranSupplierCeo" name="tranSupplierCeo" class="hiddenValue">
        <input type="hidden" id="tranSupplierBizCond" name="tranSupplierBizCond" class="hiddenValue">
        <input type="hidden" id="tranSupplierBizKind" name="tranSupplierBizKind" class="hiddenValue">
        <input type="hidden" id="tranSupplierPost" name="tranSupplierPost" class="hiddenValue">
        <input type="hidden" id="tranSupplierAddr" name="tranSupplierAddr" class="hiddenValue">
        <input type="hidden" id="tranSupplierAddrDetail" name="tranSupplierAddrDetail" class="hiddenValue">
        <input type="hidden" id="tranSupplierBankCode" name="tranSupplierBankCode" class="hiddenValue">
        <input type="hidden" id="tranSupplierBankCnnm" name="tranSupplierBankCnnm" class="hiddenValue">
        <input type="hidden" id="tranSupplierBankAccount" name="tranSupplierBankAccount" class="hiddenValue">
        <input type="hidden" id="tranSupplierBankName" name="tranSupplierBankName" class="hiddenValue">
        <!-- 공급받는자 -->
        <input type="hidden" id="tranBuyerCustId" name="tranBuyerCustId" class="hiddenValue">
        <input type="hidden" id="tranBuyerDeptId" name="tranBuyerDeptId" class="hiddenValue">
        <input type="hidden" id="tranBuyerBizName" name="tranBuyerBizName" class="hiddenValue">
        <input type="hidden" id="tranBuyerBizType" name="tranBuyerBizType" class="hiddenValue">
        <input type="hidden" id="tranBuyerBizNo" name="tranBuyerBizNo" class="hiddenValue">
        <input type="hidden" id="tranBuyerBizSubNo" name="tranBuyerBizSubNo" class="hiddenValue">
        <input type="hidden" id="tranBuyerCeo" name="tranBuyerCeo" class="hiddenValue">
        <input type="hidden" id="tranBuyerBizCond" name="tranBuyerBizCond" class="hiddenValue">
        <input type="hidden" id="tranBuyerBizKind" name="tranBuyerBizKind" class="hiddenValue">
        <input type="hidden" id="tranBuyerPost" name="tranBuyerPost" class="hiddenValue">
        <input type="hidden" id="tranBuyerAddr" name="tranBuyerAddr" class="hiddenValue">
        <input type="hidden" id="tranBuyerAddrDetail" name="tranBuyerAddrDetail" class="hiddenValue">
        <div class="modalHeader">
            <div style="width: 50%; float: left;" class="form-group row">
                <label class="col-form-label modal-big-name">발행 구분</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <select id="tranBizTypeCd" name="tranBizTypeCd" class="custom-select col-12">
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
                    <select id="tranPubForm" name="tranPubForm" class="custom-select col-12" disabled="disabled">
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
                            <select id="tranItemTotalType" name="tranItemTotalType" class="custom-select col-12" disabled="disabled">
                                <option value="0" selected="selected">단건</option>
                                <option value="1">다중</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label class="col-form-label big-name">공급자</label>
                        <div style="text-align: left;" class="input-group input-group-sm col middle-name form-group">
                        <strong class="required">담당자</strong>
                            <input type="text" id="tranSupplierMemName" name="tranSupplierMemName" class="form-control form-control-sm" disabled="disabled">
                            <div  class="help-block with-errors"></div>
                        </div>
                        <div style="text-align: left;" class="input-group input-group-sm col middle-name form-group">
                        <strong class="required">연락처</strong>
                            <input type="text" id="tranSupplierMemTel" name="tranSupplierMemTel" class="form-control form-control-sm" disabled="disabled" maxlength="13">
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
                <!-- 화주명 -->
                <input type="hidden" id="hCustId" name="custId" class="hiddenValue">
                <!-- 담당부서 -->
                <input type="hidden" id="hCustDeptId" name="custDeptId" class="hiddenValue">
                <!-- 거래처명 -->
                <input type="hidden" id="hBizId" name="bizId" class="hiddenValue">
                <!-- 담당부서 -->
                <input type="hidden" id="hBizDeptId" name="bizDeptId" class="hiddenValue">

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
                        <strong>우편발송여부</strong>
                        <select id="sPostYn" name="postYn" class="custom-select col-12">
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
                                                        <a href="#" class="k-pager-refresh k-button" id="deleteCalc" onClick="deleteCalc()">
                                                            <b class="btn-r"> <i class="k-icon k-i-trash"></i>삭제처리
                                                            </b>
                                                        </a>
                                                        <a href="#" class="k-pager-refresh k-button" id="changeReqCust" onClick="reqChangeModalOpen()">
                                                            <b class="btn-b"> <i class="k-icon k-i-user"></i>화주변경
                                                            </b>
                                                        </a>
                                                        <a href="#" class="k-pager-refresh k-button" id="changeSellCharge" onClick="changeSellCharge()">
                                                            <b class="btn-b"> <i class="k-icon k-i-dollar"></i>청구운송비변경
                                                            </b>
                                                        </a>
                                                        <a href="#" class="k-pager-refresh k-button" id="tranReceiptComp" onClick="pubTranReceiptOpen()">
                                                            <b class="btn-b"> <i class="k-icon k-i-paste-plain-text"></i>거래명세서발행
                                                            </b>
                                                        </a>
                                                        <a href="#" class="k-pager-refresh k-button" id="taxinvPostSend" onClick="taxinvPostSend()">
                                                            <b class="btn-b"> <i class="k-icon k-i-txt"> </i>우편발송처리
                                                            </b>
                                                        </a>
                                                        <a href="#" class="k-pager-refresh k-button" id="finishCalc" onClick="calcFinish()">
                                                            <b class="btn-b"> <i class="k-icon k-i-edit"> </i>마감처리
                                                            </b>
                                                        </a>
                                                        <a href="#" class="k-pager-refresh k-button" id="excelDownload" onClick="excelDownload()">
                                                            <b class="btn-x"> <i class="k-icon k-i-file-excel"> </i>엑셀출력
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
                                <li id="copyOrderId">오더아이디 복사</li>
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
    var searchBizName;
    var searchBizDeptName;
    var calcId;
    var taxData;
    var errChk = false;
    
    var userId = '${sessionScope.userInfo.userId}';
    var deptId = "${sessionScope.userInfo.deptId}";
    
    var selectedList = new Map();
    var editedList = [];
    var tranReceiptWithtaxinvList = [];
    
    var sellCalcListCnt;
    var sumUnpaidAmt;
    var sumDepositAmt;
    
    var headerTitle = ($("#headerTitle").text());
   	
    $("#calcListContextMenu").kendoContextMenu({
        target : "#grid",
        filter : "tr[role='row']"
    });

    var contextMenu = $("#calcListContextMenu").data("kendoContextMenu");
    contextMenu.bind("select", onContextMenuSelect);
    
    // 개인화 그리드 설정에서 제외되는 컬럼
    var nonPrivateColumnCheck;

    $(document).ready(function() {
        var dateOption = {
            format : "yyyy-MM-dd",
            value : new Date(),
            dateInput : true
        }
        $("#fromDate").kendoDatePicker(dateOption);
        $("#toDate").kendoDatePicker(dateOption);
        $("#taxDate").kendoDatePicker(dateOption);

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
        $("input:checkbox[id='carryOverYn']").prop("checked", true);
        
     	// 거래처 검색 콤보박스
     	searchCustName = setSearchCustName();
     	
     	// 거래처 검색 조건 셀렉트 박스 이벤트 핸들러
        $("#searchCustType").on("change", function(e) {
        	$(".hiddenValue").val("");
        	
			$("#sCustName").val("");
			$("#sOrderId").val("");
			$("#sCustDeptName").val("");
			
			searchBizName.destroy();
			searchBizName = setSearchBizName();
			searchBizName.value("");
        	
			// 화주명 검색
        	if ($(this).val() == "custName") {
        		searchCustName.destroy();
        		searchCustName = setSearchCustName();
        		searchCustName.value("");
        		
        		$("#searchCustName").show();
                $("#searchOrderId").hide();
        	} else {
        		// 오더ID 검색
        		searchCustName.value("");
        		searchCustName.destroy();
        		
        		$("#searchCustName").hide();
                $("#searchOrderId").show();
        	}
        });
        
        // 사업자 검색 콤보박스
        searchBizName = setSearchBizName();
        
     	// 사업자 검색 조건 셀렉트 박스 이벤트 핸들러
		$("#searchBizType").on("change", function() {
			$(".hiddenValue").val("");
			
			$("#sCustName").val("");
			$("#sOrderId").val("");
			$("#sCustDeptName").val("");
			
			// 사업자 검색 조건 변경시 거래처 검색
        	searchCustName.destroy();
        	searchCustName = setSearchCustName();
        	searchCustName.value("");
			
			searchBizName.destroy();
			searchBizName = setSearchBizName();
			searchBizName.value("");
        });
        
        // 담당부서 컨트롤 이벤트
        $("#sDeptId").on("change", function() {
        	$(".hiddenValue").val("");
        	
			$("#sCustName").val("");
			$("#sOrderId").val("");
			$("#sCustDeptName").val("");
			
			// 담당부서 검색 조건 변경시 거래처 검색, 사업자 검색 콤보 초기화
        	searchCustName.destroy();
        	searchCustName = setSearchCustName();
        	searchCustName.value("");
        	
			searchBizName.destroy();
			searchBizName = setSearchBizName();
			searchBizName.value("");
			
			// 22.07.25 코리아로지스 정산관리내 검색항목 [담당부서명] 변경 시, hiddenValue 모든 값이 초기화되면서 디폴트 01 값 사라짐. 
			$("#bizTypeCd").val("01");
        });
        
        // 거래명세서 발행 모달 세금계산서 발행 컨트롤 이벤트
        $("#taxYn").on("change", function() {
        	if($("#taxYn option:selected").val() == 'Y') {
        		$('#tranPubForm').removeAttr('disabled'); 
        		$('#tranRemarks').removeAttr('disabled'); 
        		$("#fTranReceipt input[name*='Mem']").removeAttr('disabled');
        		$("#tranItemTotalType").removeAttr('disabled');
        		$("#fTranReceipt input[name*='Mem']").attr('required', 'true');
        	} else {
        		$('#tranPubForm').attr('disabled', 'true');
        		$('#tranRemarks').attr('disabled', 'true');
        		$("#fTranReceipt input[name*='Mem']").attr('disabled', 'true');
        		$("#tranItemTotalType").attr('disabled', 'true');
        		$("#fTranReceipt input[name*='Mem']").removeAttr('required');
        	}
        	
        	$("#fTranReceipt").validator('validate');
        });
        
     	// 거래명세서 발행 모달 발행일자 컨트롤 이벤트
        $("#taxDateYn").on("change", function() {
    		var taxDate = $("#taxDate").data("kendoDatePicker");
    		if ($(this).is(":checked")) {
    			taxDate.enable(true);
    		} else {
    			taxDate.enable(false);			
    		}
    	});
     	
        // 리스트 출력
       	goList();
    });
    
    // 거래처 검색 콤보박스 생성 (화주)
    function setSearchCustName() {
    	var searchCustName =  $("#sCustName").kendoMultiColumnComboBox({
            dataTextField: "custName",
            dataValueField: "custId",
            filter: "contains",
            minLength: 2,
            autoBind: true,
            dataSource: {
            	serverFiltering: true,
            	transport: {
            		read : {
            			url: "/contents/basic/data/custList.do",
            			dataType: "json",
            			type: "post",
            			data: {
            				useYn : "Y",
            				sellBuySctn : "01",
            				deptId: $("#sDeptId").val()
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
            	{ field: "custName", title: "거래처명", width: 'auto' },
            	{ field: "deptName", title: "부서명", width: 'auto' }
            ]
		}).data("kendoMultiColumnComboBox");
    	
    	// 거래처 검색 콤보박스 이벤트 핸들러
    	searchCustName.bind("change", function(e) {
    		if (this.value() == "") {
    			$("#hCustId").val("");
    			$("#hCustDeptId").val("");
    			
    			$("#sCustDeptName").val("");
    		} else {
    			var dataItem = $("#sCustName").data("kendoMultiColumnComboBox").dataItem();
    			
    			if (dataItem != null) {
        			$("#hCustId").val(dataItem.custId);
        			$("#hCustDeptId").val(dataItem.deptId);
        			
        			$("#sCustDeptName").val(dataItem.deptName);
    			}
    		}
    	});
		
		return searchCustName;
    }
    
    // 사업자 검색 콤보박스 생성
    function setSearchBizName() {
    	$("#hBizId").val("");
		$("#hBizDeptId").val("");
		
		$("select#sBizDeptName option").remove();
    	
    	var searchBizName = $("#sBizName").kendoMultiColumnComboBox({
            dataTextField: "bizName",
            dataValueField: "custId",
            filter: "contains",
            minLength: 2,
            autoBind: true,
            dataSource: {
                serverFiltering: true,
                transport: {
                    read: {
                        url: "/contents/calc/data/custList.do",
                        dataType: "json",
                        type: "post",
                        data: {
                            searchType: $("#searchBizType").val(),
                            sDeptId: $("#sDeptId").val()
                        },
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
                }
            },
            columns: [
                { field: "bizName", title: "사업자명", width:100 },
                { field: "bizNum", title: "사업자번호", width:100 }
            ]
        }).data("kendoMultiColumnComboBox");
    	
    	// 사업자 검색 콤보박스 이벤트 핸들러
    	searchBizName.bind("change", function(e) {
			if (this.value() == "") {
				$("#hBizId").val("");
    			$("#hBizDeptId").val("");
    			
    			$("select#sBizDeptName option").remove();
    		} else {
				var dataItem = $("#sBizName").data("kendoMultiColumnComboBox").dataItem();
    			
				if (dataItem != null) {
        			$("#hBizId").val(dataItem.custId);
    				$("#hBizDeptId").val("");
        			
    				Util.setSelectBox("/contents/calc/data/deptList.do", "sBizDeptName", { custId : dataItem.custId, sDeptId : $("#sDeptId").val() }, "deptId", "deptName", "", "--부서명--");
				}
    		}
    	});
        
        return searchBizName;
    }
    
    // 그리드 리스트
    function goList() {
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
                    	// Total 반영 시 Summary 항목도 함께 표시
                    	getSummary(response.total, response.sumUnpaidAmt, response.sumDepositAmt);
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
                    if (e.xhr.status == "400") {
                        alert("세션값이 존재하지 않습니다. 로그인 페이지로 이동합니다.");
                        location.href = "/";
                    }
                }
            },
            dataBound: function(e) {
            	nonPrivateColumnCheck = e.sender.columns[0];
            },
            excel: {
                fileName: headerTitle + "(" + new Date().yyyymmdd() + ").xlsx",
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
            	
            	// 에디트 컬럼 선택 시 텍스트 전체 선택
				var editColumn = e.container.find("input");
				setTimeout(function() {
					editColumn.select();
             	}, 1);
        	},
        	save: onEditSave,
            columns: columns,
            noRecords: true,
            scrollable: {
                endless: true
            },
            pageable: false,
            sort: onSortEnd,
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
    	
		if (typeof e.values.sellCharge == "number") {
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
		else if (typeof e.values.sellWaypointCharge == "number") {
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
		else if (typeof e.values.sellStayCharge == "number") {
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
		else if (typeof e.values.sellHandworkCharge == "number") {
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
		else if (typeof e.values.sellRoundCharge == "number") {
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
		else if (typeof e.values.sellOtheraddCharge == "number") {
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
    
    // 초기화 버튼 이벤트 처리
    function fReset() {
    	$("#fSearch")[0].reset();
    	$(".hiddenValue").val("");
    	
    	$("input:checkbox[id='carryOverYn']").prop("checked", true);
    }
    
 	// 헤더에 요약정보 표시
    function getSummary(total, sumUnpaidAmt, sumDepositAmt) {
    	var groupCount = 
			"<i style=\"color: #3f75c1\">매출 : " + Util.nvl(Util.formatNumber(total), '0') + "건 / " + 
			Util.nvl(Util.formatNumber(sumUnpaidAmt), '0') + "원 / " + Util.nvl(Util.formatNumber(sumDepositAmt), '0') + "원</i>"
		
		$("#groupCount").html(groupCount);
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
							goList();
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
							goList();
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
        			url: "/contents/calc/data/updateSellCalcDeleteYn.do",
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
							goList();
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
        			url: "/contents/calc/data/updateSellCalcDeleteYn.do",
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
							goList();
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
  	
 	// 청구운송비 변경
 	function changeSellCharge() {
 		if (editedList.length > 0) {
 			var message = "항목이 변경된  (" + editedList.length + ")건에 대한 운송비 변경을 하시겠습니까?";
 			if (confirm(message)) {
 				
 				var params = {
				   "params": JSON.stringify(editedList)
				}
 				
 				$.ajax({
					url: "/contents/calc/data/setSellCalcCharge.do",
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
						
						goList();
					}
				});
 			}
 		} else {
 			alert("변경된 청구운송비 항목이 없습니다.");
 		}
 	}
 	
 	// 마감처리
 	function calcFinish() {
 		// 청구운송비 변경 건이 존재하는지 체크
 		if (editedList.length > 0) {
 			var message = "청구운송비 변경을 하지 않은 건이 존재합니다.\n변경된 건에 대해 청구운송비 변경을 하지 않으면 기존 금액으로 마감처리 됩니다.\n계속 하시겠습니까?";
 			if (!confirm(message))
 				return;
 		}
 		
 		if (selectedList.size > 0) {
    		var message = "선택된 (" + selectedList.size + ")건에 대한 마감 처리를 하시겠습니까?\n이미 처리된 건은 제외됩니다.";
    		if (confirm(message)) {
    			var calcIdList = [];
    			for (var [key, value] of selectedList) {
    				if ((value.deleteYn == "" || value.deleteYn == "N") &&
    					(value.finishYn == "" || value.finishYn == "N")) {
    					/*
    						sellChargeId
    						sellWaypointChargeId
    						sellStayChargeId
    						sellHandworkChargeId
    						sellRoundChargeId
    						sellOtheraddChargeId
    					*/
    					if (value.sellChargeId != null && value.sellChargeId != "")
    						calcIdList.push(value.sellChargeId);
    					
    					if (value.sellWaypointChargeId != null && value.sellWaypointChargeId != "")
    						calcIdList.push(value.sellWaypointChargeId);
    					
    					if (value.sellStayChargeId != null && value.sellStayChargeId != "")
    						calcIdList.push(value.sellStayChargeId);
    					
    					if (value.sellHandworkChargeId != null && value.sellHandworkChargeId != "")
    						calcIdList.push(value.sellHandworkChargeId);
    					
    					if (value.sellRoundChargeId != null && value.sellRoundChargeId != "")
    						calcIdList.push(value.sellRoundChargeId);
    					
    					if (value.sellOtheraddChargeId != null && value.sellOtheraddChargeId != "")
    						calcIdList.push(value.sellOtheraddChargeId);
    				}
    			}
    			
    			$.ajax({
        			url: "/contents/calc/data/updateSellCalcFinish.do",
        			type: "POST",
        			dataType: "json",
        			data: {
        				mode: "Y",
        				calcIdList: calcIdList.toString()
        			},
        			success: function(data){
        				if (data.linkMessage.status == 0) {
        					// 요청 성공시 내용 기술
							alert(data.linkMessage.message);
							goList();
							//contextMenu.close();
        				} else {
        					alert(data.linkMessage.message);
        				}
        			}
        		});
    		}
    	} else {
    		alert("마감처리할 항목을 선택해 주세요.");
    	}
 	}
 	
 	// 마감취소
 	function calcFinishCancel() {
 		if (selectedList.size > 0) {
    		var message = "선택된 (" + selectedList.size + ")건에 대한 마감 취소를 하시겠습니까?\n이미 처리된 건은 제외됩니다.";
    		if (confirm(message)) {
    			var calcIdList = [];
    			for (var [key, value] of selectedList) {
    				if ((value.deleteYn == "" || value.deleteYn == "N") &&
    					(value.finishYn != "" || value.finishYn != "N")) {
    					/*
    						sellChargeId
    						sellWaypointChargeId
    						sellStayChargeId
    						sellHandworkChargeId
    						sellRoundChargeId
    						sellOtheraddChargeId
    					*/
    					if (value.sellChargeId != null && value.sellChargeId != "")
    						calcIdList.push(value.sellChargeId);
    					
    					if (value.sellWaypointChargeId != null && value.sellWaypointChargeId != "")
    						calcIdList.push(value.sellWaypointChargeId);
    					
    					if (value.sellStayChargeId != null && value.sellStayChargeId != "")
    						calcIdList.push(value.sellStayChargeId);
    					
    					if (value.sellHandworkChargeId != null && value.sellHandworkChargeId != "")
    						calcIdList.push(value.sellHandworkChargeId);
    					
    					if (value.sellRoundChargeId != null && value.sellRoundChargeId != "")
    						calcIdList.push(value.sellRoundChargeId);
    					
    					if (value.sellOtheraddChargeId != null && value.sellOtheraddChargeId != "")
    						calcIdList.push(value.sellOtheraddChargeId);
    				}
    			}
    			
    			$.ajax({
        			url: "/contents/calc/data/updateSellCalcFinish.do",
        			type: "POST",
        			dataType: "json",
        			data: {
        				mode: "N",
        				calcIdList: calcIdList.toString()
        			},
        			success: function(data){
        				if (data.linkMessage.status == 0) {
        					// 요청 성공시 내용 기술
							alert(data.linkMessage.message);
							goList();
							//contextMenu.close();
        				} else {
        					alert(data.linkMessage.message);
        				}
        			}
        		});
    		}
    	} else {
    		alert("마감처리할 항목을 선택해 주세요.");
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
 		// 기존코드 : 검색조건의 거래처 구분으로 되어 있음. 화주 검색으로 조건 변경
//  		searchModalCustName = MultiColumnComboBox.setCustName("sModal", $("#custType").val(), $("#sDeptId").val());
 		searchModalCustName = MultiColumnComboBox.setCustName("sModal", "01", $("#sDeptId").val());
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
    	
    	if (confirm("화주를 변경하시겠습니까?\n삭제된 정산에 대해서는 화주변경을 할 수 없습니다.")) {
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
						goList();
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
    
 	/*
     * 거래명세서 창 Open
     */
    function pubTranReceiptOpen() {
 		// 기존 세팅값 초기화
    	$("#fTranReceipt")[0].reset();
    	
    	/*
    	 * 거래명세서 발행 시 체크 항목
    	 * 	선택된 항목들이 모두 동일한 화주인지.
    	 *	기사발행건은 별도 처리 (uniqueChargeType.indexOf('03')???)
    	 *	매출만.
    	 *	이미 발행한 거래명세서, 세금계산서건은 제외
    	 */
    	if (selectedList.size <= 0) {
    		alert("거래명세서를 발행할 항목을 선택해 주세요.");
    		return;
    	}
    	
//     	var targetList = [];
		tranReceiptWithtaxinvList.splice(0, tranReceiptWithtaxinvList.length);
    	
    	// 유효성 체크 및 타겟 리스트 설정
    	var beforeCustId = "";
    	var beforeDeptId = "";
    	var beforeMngCustId = "";
    	var beforeMngDeptId = "";
    	var beforeChargeTypeCode = "";
    	var beforeDriverId = "";
    	var beforeCarNum = "";
    	for (var [key, value] of selectedList) {
    		var afterCustId = value.bizId;
			var afterDeptId = value.deptId;
			var afterMngCustId = value.mngCustId;
			var afterMngDeptId = value.mngDeptId;
			var afterChargeTypeCode = value.chargeTypeCode;
			var afterDriverId = value.driverId;
			var afterCarNum = value.carNum;
			
			// 체크 항목이 동일한 화주만 처리
			if (beforeCustId != "" && beforeCustId != afterCustId) {
    			alert("동일한 화주 건에 대해서만 거래명세서 일괄발행이 가능합니다.");
    			return;
    		} else {
    			beforeCustId = afterCustId;
    			beforeDeptId = afterDeptId;
    			beforeMngCustId = afterMngCustId;
    			beforeMngDeptId = afterMngDeptId;
    		}
			
			// 체크 항목이 동일한 운임구분만 처리
			if (beforeChargeTypeCode != "" && beforeChargeTypeCode != afterChargeTypeCode) {
				alert("동일한 운임구분 건에 대해서만 거래명세서 일괄발행이 가능합니다.");
				return;
			} else {
				beforeChargeTypeCode = afterChargeTypeCode;
				// 기사 발행건에서 동일한 기사건만 처리
				if (beforeChargeTypeCode == "03") {
					if (beforeDriverId != "" && beforeDriverId != afterDriverId) {
						alert("기사발행의 경우 동일한 차주 건에 대해서만 거래명세서 일괄발행이 가능합니다.");
						return;
					} else {
						beforeDriverId = afterDriverId;
						beforeCarNum = afterCarNum;
					}
				} else if (beforeChargeTypeCode == "02") {
					// 선착불의 경우 처리하지 않음.
					alert("선착불의 경우 거래명세서 발행이 불가능합니다.");
					return;
				}
			}
			
			// 이미 발행된 건 제외
//     		if (value.tranReceiptYn == "N" && value.sellTaxinvYn == "N") {
//     			tranReceiptWithtaxinvList.push(value);
//     		}
			tranReceiptWithtaxinvList.push(value);
    	}
    	
    	var custId = beforeCustId;
    	var deptId = beforeDeptId;
    	var mngCustId = beforeMngCustId;
    	var mngDeptId = beforeMngDeptId;
    	var chargeTypeCode = beforeChargeTypeCode;
    	var driverId = beforeDriverId;
    	var carNum = beforeCarNum;
    	
    	var loginCustId = "${sessionScope.userInfo.custId}";
    	var loginDeptId = "${sessionScope.userInfo.deptId}";
    	
    	// 거래처 상세를 조회하여 모달 항목 입력
    	if (chargeTypeCode == "01") {
    		// 인수증
    		setTaxBizInfo(custId, deptId, loginCustId, loginDeptId);
    	} else if (chargeTypeCode == "03") {
    		// 기사발행
    		setTaxDriverInfo(custId, deptId, loginCustId, loginDeptId, driverId);
//     		setTaxDriverInfo(custId, deptId, mngCustId, mngDeptId, driverId);
    	}
    	
    	tranReceiptModal.data("kendoDialog").open();
    }
    
 	/*
     * 거래명세서 창 Close
     */
    function pubTranReceiptClose() {
    	tranReceiptModal.data("kendoDialog").close();
    }
    
    /*
     * 거래명세서 발행 버튼 클릭 이벤트
     */
    $('#fTranReceipt').validator().on('submit', function(e) {
    	if (e.isDefaultPrevented()) {
    		alert("항목을 입력해 주세요.");
    		e.preventDefault();
    		return;
    	}
    	
    	// 세금계산서 연계 발행
    	if ($("#taxYn option:selected").val() == 'Y') {
    		// 이메일 유효성 체크
    		var emailRule = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i;
			if (!emailRule.test($("#tranSupplierMemEmail").val())) {
				alert("공급자 이메일이 형식에 맞지 않습니다.");
				e.preventDefault();
				return;
			}
			if (!emailRule.test($("#tranBuyerMemEmail").val())) {
				alert("공급받는자 이메일이 형식에 맞지 않습니다.");
				e.preventDefault();
				return;
			}
			
			// 발행일자 유효성 체크
			var toDay = new Date().yyyymmdd();
			var pubTaxinvDay = $("#taxDate").data("kendoDatePicker").value().yyyymmdd();
			if (toDay < pubTaxinvDay) {
				alert("발행일자를 미래일자로 설정하면 세금계산서를 발행할 수 없습니다.");
				e.preventDefault();
				return;
			}
    	}
    	
    	// 거래명세서 및 세금계산서 발행건이 없음. -> 이미 발행된 건인지 뒤에서 확인
		if (tranReceiptWithtaxinvList.length <= 0) {
			alert("새로 발행될 거래명세서, 세금계산서건이 없습니다.\n이미 처리된 건인지 확인하세요.");
			e.preventDefault();
			return;
		}
    	
    	if (confirm("거래명세서를 발행하시겠습니까?\n이미 발행한 거래명세서, 세금계산서는 발행되지 않습니다.")) {
    		e.preventDefault();
    		
    		var param = {};
    		if ($("#taxYn option:selected").val() == 'Y') {
    			// 세금계산서 연계 발행
    			param.taxYn = "Y";
    			
				if ($("#tranMode").val() == "R") {
    				// 인수증
					param.supplierCustId = $("#tranSupplierCustId").val();
        			param.supplierDeptId = $("#tranSupplierDeptId").val();
        			
        			param.tranSupplierMemName = $("#tranSupplierMemName").val();
        			param.tranSupplierMemTel = $("#tranSupplierMemTel").val();
        			param.tranSupplierMemEmail = $("#tranSupplierMemEmail").val();
        			
        			param.pubForm = $("#tranPubForm").val();
        			
        			// 계좌정보 설정
        			var bankName = $("#tranSupplierBankName").val();
        			var bankAccount = $("#tranSupplierBankAccount").val();
        			var bankCnnm = $("#tranSupplierBankCnnm").val();
        			var bizname = $("#tranSupplierBizName").val();
        			if (bankName != "" && bankAccount != "" && bankCnnm != "" && bizname != "") {
        				param.remarks = bankName + " " + bankAccount + " " + bankCnnm + " " + bizname;
        			} else {
        				param.remarks = "";
        			}
    			} else {
    				// 기사발행
    				param.driverId = $("#tranSupplierDriverId").val();
        			param.vehicId = $("#tranSupplierVehicId").val();
    				
    				param.tranSupplierMemName = $("#tranSupplierMemName").val();
    				param.tranSupplierMemTel = $("#tranSupplierMemTel").val();
    				param.tranSupplierMemEmail = $("#tranSupplierMemEmail").val();
    				
    				param.pubForm = $("#tranPubForm").val();
    				
    				// 계좌정보 설정
        			var bankName = $("#tranSupplierBankName").val();
        			var bankAccount = $("#tranSupplierBankAccount").val();
        			var bankCnnm = $("#tranSupplierBankCnnm").val();
        			var bizName = $("#tranSupplierBizName").val();
        			if (bankName != "" && bankAccount != "" && bankCnnm != "" && bizName != "") {
        				param.remarks = bankName + " " + bankAccount + " " + bankCnnm + " " + bizName;
        			} else {
        				param.remarks = "";
        			}
    			}
				
				// 공급받는자
				param.custId = $("#tranBuyerCustId").val();
    			param.deptId = $("#tranBuyerDeptId").val();
    			param.bizTypeCd = $("#tranBuyerBizType").val();
    			
    			param.tranBuyerMemName = $("#tranBuyerMemName").val();
    			param.tranBuyerMemTel = $("#tranBuyerMemTel").val();
    			param.tranBuyerMemEmail = $("#tranBuyerMemEmail").val();
    			
    			// 단건, 다중
    			param.itemTotalType = $("#tranItemTotalType").val();
    		} else {
    			// 거래명세서만 발행
    			param.taxYn = "N";
    			
    			if ($("#tranMode").val() == "R") {
    				// 공급자 (인수증)
        			param.supplierCustId = $("#tranSupplierCustId").val();
        			param.supplierDeptId = $("#tranSupplierDeptId").val();
    			} else {
    				// 공급자 (기사발행)
    				param.driverId = $("#tranSupplierDriverId").val();
        			param.vehicId = $("#tranSupplierVehicId").val();
    			}
    			
    			// 공급받는자
    			param.custId = $("#tranBuyerCustId").val();
    			param.deptId = $("#tranBuyerDeptId").val();
    			param.bizTypeCd = $("#tranBuyerBizType").val();
    		}
    		
    		/*
    		 * 거래명세서, 세금계산서 발행 공통항목
    		 */
    		 
    		// 발행인 정보
    		param.loginCustId = "${sessionScope.userInfo.custId}";
			param.loginDeptId = "${sessionScope.userInfo.deptId}";
			param.loginUserId = "${sessionScope.userInfo.userId}";
			
			// 관리부서
			param.mngDeptId = $("#sDeptId").val()
			
    		param.tranMode = $("#tranMode").val();
    		param.sellBuySctn = "01";
    		param.taxDate = $("#taxDate").val();
    		param.orderList = JSON.stringify(tranReceiptWithtaxinvList);
    		
    		// 거래명세서, 세금게산서 발행
    		setTranReceiptWithTaxinv(param);
    	}
    });
    
    /*
     * 거래처정보 조회
     */
    function setTaxBizInfo(custId, deptId, mngCustId, mngDeptId) {
		$.ajax({
			url: "/contents/calc/data/getTaxBizInfo.do",
			type: "POST",
			dataType: "json",
			data: {
				custId: custId,
				deptId: deptId,
				mngCustId: mngCustId,
				mngDeptId: mngDeptId
			},
			success: function(data){
				if(data.linkMessage.status == 0) {
					$("#tranMode").val("R");
					if (data.linkMessage.data.data != null && data.linkMessage.data.data != "") {
    					$("#tranCustId").val(data.linkMessage.data.data.buyerCustId);
    					$("#tranDeptId").val(data.linkMessage.data.data.buyerDeptId);
    					
    					// 공급자 정보
    					$("#tranSupplierCustId").val(data.linkMessage.data.data.supplierCustId);
    					$("#tranSupplierDeptId").val(data.linkMessage.data.data.supplierDeptId);
    					$("#tranSupplierBizName").val(data.linkMessage.data.data.supplierBizName);
    					$("#tranSupplierBizType").val(data.linkMessage.data.data.supplierBizTypeCode);
        				$("#tranSupplierMemName").val(data.linkMessage.data.data.supplierMemName);
        				$("#tranSupplierMemTel").val(Util.formatPhone(data.linkMessage.data.data.supplierMemTel));
        				$("#tranSupplierMemEmail").val(data.linkMessage.data.data.supplierMemEmail);
        				$("#tranSupplierBankName").val(data.linkMessage.data.data.supplierBankName);
    					$("#tranSupplierBankCnnm").val(data.linkMessage.data.data.supplierBankCnnm);
    					$("#tranSupplierBankAccount").val(data.linkMessage.data.data.supplierBankAccount);
        				
        				// 공급받는자 정보
        				$("#tranBuyerCustId").val(data.linkMessage.data.data.buyerCustId);
    					$("#tranBuyerDeptId").val(data.linkMessage.data.data.buyerDeptId);
    					$("#tranBuyerBizName").val(data.linkMessage.data.data.buyerBizName);
    					$("#tranBuyerBizType").val(data.linkMessage.data.data.buyerBizTypeCode);
        				$("#tranBuyerMemName").val(data.linkMessage.data.data.buyerMemName);
        				$("#tranBuyerMemTel").val(Util.formatPhone(data.linkMessage.data.data.buyerMemTel));
        				$("#tranBuyerMemEmail").val(data.linkMessage.data.data.buyerMemEmail);
        				
        				// 공급받는자 주소
        				$("#tranBuyerPostalPost").val(data.linkMessage.data.data.buyerPostalPost);
        				$("#tranBuyerPostalAddr").val(data.linkMessage.data.data.buyerPostalAddr);
        				$("#tranBuyerPostalAddrDetail").val(data.linkMessage.data.data.buyerPostalAddrDetail);
					}
				}
			}
		});
    }
    
    // 기사정보 조회
    function setTaxDriverInfo(custId, deptId, mngCustId, mngDeptId, driverId) {
    	$.ajax({
			url: "/contents/calc/data/getSupplierTaxDriverInfo.do",	
			type: "POST",
			dataType: "json",
			data: {
				driverId: driverId
			},
			success: function(data){
				if(data.linkMessage.status == 0) {
					$("#tranMode").val("E");
					if (data.linkMessage.data.data != null && data.linkMessage.data.data != "") {
    					// 공급자 정보
    					$("#tranSupplierDriverId").val(data.linkMessage.data.data.supplierDriverId);
        				$("#tranSupplierVehicId").val(data.linkMessage.data.data.supplierVehicId);
        				$("#tranSupplierMemName").val(data.linkMessage.data.data.supplierDriverName);
        				$("#tranSupplierMemTel").val(Util.formatPhone(data.linkMessage.data.data.supplierDriverTel));
        				$("#tranSupplierMemEmail").val(data.linkMessage.data.data.supplierDriverEmail);
        				$("#tranSupplierBankName").val(data.linkMessage.data.data.supplierDriverBankName);
    					$("#tranSupplierBankCnnm").val(data.linkMessage.data.data.supplierDriverBankCnnm);
    					$("#tranSupplierBankAccount").val(data.linkMessage.data.data.supplierDriverBankAccount);
					}
				}
			}
		});

// 		$.ajax({
//     		url: "/contents/basic/data/carList.do",	
//     		type: "POST",
//     		dataType: "json",
//     		data: {
//     			useYn: "Y",
//     			carNum : carNum,
//     		},
//     		success: function(data){
//     			if(data.result) {
//     				$("#tranSupplierDriverId").val(data.data[0].driverId);
//     				$("#tranSupplierVehicId").val(data.data[0].vehicId);
//     				$("#tranSupplierMemName").val(data.data[0].driverName);
//     				$("#tranSupplierMemTel").val(data.data[0].mobile);
//     				$("#tranSupplierMemEmail").val(data.data[0].driverEmail);
//     				$("#tranSupplierBankName").val(data.data[0].bankName);
// 					$("#tranSupplierBankCnnm").val(data.data[0].bankCnnm);
// 					$("#tranSupplierBankAccount").val(data.data[0].bankAccount);
					
//     				if(data.data[0].bankName != '' && data.data[0].bankAccount != '' && data.data[0].bankCnnm != '' && data.data[0].bizName != ''){
//     	 				$("#tranRemarksDefault").val(data.data[0].bankName+' '+data.data[0].bankAccount+' '+data.data[0].bankCnnm+' '+data.data[0].bizName);
//     				}else{
//     					$("#tranRemarksDefault").val('');
//     				}
//     			}
//     		}
//     	});
    	
    	$.ajax({
			url: "/contents/calc/data/getTaxBizInfo.do",	
			type: "POST",
			dataType: "json",
			data: {
				custId: custId,
				deptId: deptId,
				mngCustId: mngCustId,
				mngDeptId: mngDeptId
			},
			success: function(data){
				if(data.linkMessage.status == 0) {
					$("#tranMode").val("E");
					if (data.linkMessage.data.data != null && data.linkMessage.data.data != "") {
    					$("#tranCustId").val(data.linkMessage.data.data.buyerCustId);
    					$("#tranDeptId").val(data.linkMessage.data.data.buyerDeptId);
    					
    					// 공급받는자 정보
        				$("#tranBuyerCustId").val(data.linkMessage.data.data.buyerCustId);
    					$("#tranBuyerDeptId").val(data.linkMessage.data.data.buyerDeptId);
    					$("#tranBuyerBizName").val(data.linkMessage.data.data.buyerBizName);
    					$("#tranBuyerBizType").val(data.linkMessage.data.data.buyerBizTypeCode);
        				$("#tranBuyerMemName").val(data.linkMessage.data.data.buyerMemName);
        				$("#tranBuyerMemTel").val(Util.formatPhone(data.linkMessage.data.data.buyerMemTel));
        				$("#tranBuyerMemEmail").val(data.linkMessage.data.data.buyerMemEmail);
        				
        				// 공급받는자 주소
        				$("#tranBuyerPostalPost").val(data.linkMessage.data.data.buyerPostalPost);
        				$("#tranBuyerPostalAddr").val(data.linkMessage.data.data.buyerPostalAddr);
        				$("#tranBuyerPostalAddrDetail").val(data.linkMessage.data.data.buyerPostalAddrDetail);
					}
				}
			}
		});
    }
    
    // 거래명세서, 세금계산서 발행 
    function setTranReceiptWithTaxinv(param) {
    	$.ajax({
    		url: "/contents/calc/data/setTranReceiptWithTaxinv.do",
    		type: "POST",
    		dataType: "json",
    		data: param,
    		async: false,
    		success: function(data){
    			if (data.linkMessage.status == 0) {
    				alert(data.linkMessage.message);
    				pubTranReceiptClose();
    				goList();
    			} else {
    				alert(data.linkMessage.message + "\n" + "(" + data.linkMessage.detailMessage + ")");
    			}
    		}
    	}); 
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
			   return Util.formatNumber(Util.nvl(dataItem.unpaidAmt, "0"));
			},
			attributes: { 
				style: "text-align: right" 
			},
			editable: function (dataItem){}
		},
		{ field: "sellCharge", title: "내수운송료", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.sellCharge, "0"));
			},
			attributes: {
				style: "text-align: right"
			},
			headerTemplate : '<label class="editHeader">내수운송료</label>'
		},
		{ field: "sellWaypointCharge", title: "경유비", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.sellWaypointCharge, "0"));
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">경유비</label>'
		},
		{ field: "sellStayCharge", title: "대기료", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.sellStayCharge, "0"));
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">대기료</label>'
		},
		{ field: "sellHandworkCharge", title: "수작업비", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.sellHandworkCharge, "0"));
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">수작업비</label>'
		},
		{ field: "sellRoundCharge", title: "회차료", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.sellRoundCharge, "0"));
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">회차료</label>'
		},
		{ field: "sellOtheraddCharge", title: "기타추가비", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.sellOtheraddCharge, "0"));
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
			   return Util.formatNumber(Util.nvl(dataItem.unitPrice, "0"));
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
		       return Util.formatNumber(Util.nvl(dataItem.allocFee, "0"));
		    },
			attributes: { 
				style: "text-align: right" 
			},
			editable: function (dataItem){}
		},
		{ field: "depositAmt", title: "입금액", width: 100, type: 'number',
			template: function(dataItem) {
		       return Util.formatNumber(Util.nvl(dataItem.depositAmt, "0"));
		    },
			attributes: { 
				style: "text-align: right" 
			},
			editable: function (dataItem){}
		},
		{ field: "tranReceiptYn", title: "명세서", width: 80, editable: function (dataItem){} },
		{ field: "tranReceiptUserName", title: "발행원", width: 100, editable: function (dataItem){} },
		{ field: "sellTaxinvYn", title: "계산서", width: 80, editable: function (dataItem){} },
		{ field: "sellTaxinvUserName", title: "발행원", width: 100, editable: function (dataItem){} },
		{ field: "postsendYn", title: "우편발송", width: 80, editable: function (dataItem){} },
		{ field: "postsendUserName", title: "발송원", width: 100, editable: function (dataItem){} },
		{ field: "finishMemo", title: "마감 시 메모", width: 160, editable: function (dataItem){} },
		{ field: "refContent1", title: "참고 내용1", width: 160, editable: function (dataItem){} },
		{ field: "refContent2", title: "참고 내용2", width: 160, editable: function (dataItem){} },
		{ field: "mngDeptName", title: "담당부서", width: 120, editable: function (dataItem){} },
		{ field: "mngUserName", title: "배차원", width: 100, editable: function (dataItem){} },
		{ field: "deleteYn", title: "삭제일", width: 80, editable: function (dataItem){} },
		{ field: "deleteUserName", title: "삭제자", width: 80, editable: function (dataItem){} },
		
		// 숨김항목
		{ field: "mngCustId", hidden: true, editable: function (dataItem){} },
		{ field: "mngDeptId", hidden: true, editable: function (dataItem){} },
		{ field: "sellAllocId", hidden: true, editable: function (dataItem){} },
		{ field: "custId", hidden: true, editable: function (dataItem){} },
		{ field: "bizId", hidden: true, editable: function (dataItem){} },
		{ field: "sellChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "sellWaypointChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "sellStayChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "sellHandworkChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "sellRoundChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "sellOtheraddChargeId", hidden: true, editable: function (dataItem){} },
	];
</script>