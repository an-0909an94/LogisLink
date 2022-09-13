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

<!-- 매입처 변경 Modal -->
<div id="divChangeRes" class="editor-warp p-0">
    <form id="fChangeRes" class="modalEditor" role="form" autocomplete="off" data-toggle="validator">
        <input type="hidden" id="changeResModalOrderList" name="changeResModalOrderList" class="hiddenValue">
        <input type="hidden" id="changeResModalAllocList" name="changeResModalAllocList" class="hiddenValue">
        
        <div class="modalHeader">
            <div class="form-group row">
                <div class="input-group input-group-sm col middle-name form-group">
                
                    <div class="input-group input-group-sm col radio-or-checkBox">
                        <input type="radio" id="changeResModalVehic" name="modalChangeResType" value="v" checked>
                        <label for="changeResModalVehic" class="label-margin"> <span>차량</span> </label>
                    </div>
                    <div class="input-group input-group-sm col radio-or-checkBox">
                        <input type="radio" id="changeResModalCust" name="modalChangeResType" value="c">
                        <label for="changeResModalCust" class="label-margin"> <span>운송사</span> </label>
                    </div>
                    
                    <!-- 차량 선택 -->
                    <div id="divChangeResV">
                        <input type="hidden" id="changeResModalVehicId" name="changeResModalVehicId" class="hiddenValue">
                        <input type="hidden" id="changeResModalDriverId" name="changeResModalDriverId" class="hiddenValue">
                        <div class="form-group row">
                            <div class="input-group input-group-sm col middle-name form-group">
                                <label class="col-form-label modal-big-name required">차량번호</label>
                                <input type="text" id="changeResModalVehicNo" name="changeResModalVehicNo" style="width: 100%;" required>
                                <div class="help-block with-errors"></div>
                            </div>
                            <div class="input-group input-group-sm col middle-name form-group">
                                <label class="col-form-label modal-big-name">차주명</label>
                                <input type="text" id="changeResModalDriverName" name="changeResModalDriverName" class="form-control form-control-sm" readonly>
                            </div>
                            <div class="input-group input-group-sm col middle-name form-group">
                                <label class="col-form-label modal-big-name">연락처</label>
                                <input type="text" id="changeResModalDriverMobile" name="changeResModalDriverMobile" class="form-control form-control-sm" readonly>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 운송사 선택 -->
                    <div id="divChangeResC" style="display: none;">
                        <input type="hidden" id="changeResModalBuyCustId" name="changeResModalBuyCustId" class="hiddenValue">
                        <input type="hidden" id="changeResModalBuyDeptId" name="changeResModalBuyDeptId" class="hiddenValue">
                        <div class="form-group row">
                            <div class="input-group input-group-sm col middle-name form-group">
                                <label class="col-form-label modal-big-name required">운송사</label>
                                <input type="text" id="buyCustName" name="buyCustName" style="width: 100%;" required>
                                <div class="help-block with-errors"></div>
                            </div>
                            <div class="input-group input-group-sm col middle-name form-group">
                                <label class="col-form-label modal-big-name">담당자명</label>
                                <input type="text" id="changeResModalManagerName" name="changeResModalManagerName" class="form-control form-control-sm" readonly>
                            </div>
                            <div class="input-group input-group-sm col middle-name form-group">
                                <label class="col-form-label modal-big-name">연락처</label>
                                <input type="text" id="changeResModalManagerMobile" name="changeResModalManagerMobile" class="form-control form-control-sm" readonly>
                            </div>
                        </div>  
                    </div>
                    
                </div>
            </div>
        </div>
            
        <div class="editor_btns">
            <div class="padding">
                <button type="submit" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i><strong>변경</strong></b></button>
                <a id="closeBtn" onclick="changeResModalClose();" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
            </div>
        </div>
        
    </form>
</div>
<!-- 매입처 변경 Modal End -->

<!-- 매입계산서 보기 Modal -->
<div id="divTaxInvoice" class="editor-warp p-0">
    <form class="modalEditor" id="fTaxInvoice" data-toggle="validator" role="form" autocomplete="off">
       <div class="enter_form" style="padding: 1.875em;">
          <!-- 공급자/공급받는자 정보 -->
          <div style="display: inline-block; width: 100%">
          
              <!-- 공급자 -->
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
              
              <!-- 공급받는자 -->
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
              
              <!-- 수탁자 -->
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
          <table class="form_table" style="width: 100%" id="taxDtlTbl">
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
<!-- 매입계산서 보기 Modal End -->

<!-- 매입정산관리 페이지 -->
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
                <!-- 화주명 -->
                <input type="hidden" id="hCustId" name="custId" class="hiddenValue">
                <!-- 담당부서 -->
                <input type="hidden" id="hCustDeptId" name="custDeptId" class="hiddenValue">
                <!-- 거래처명 -->
                <input type="hidden" id="hBizId" name="bizId" class="hiddenValue">
                <!-- 담당부서 -->
                <input type="hidden" id="hBizDeptId" name="bizDeptId" class="hiddenValue">
                <!-- 차량ID -->
                <input type="hidden" id="hVehicId" name="vehicId" class="hiddenValue">
                <!-- 차주ID -->
                <input type="hidden" id="hDriverId" name="driverId" class="hiddenValue">
            
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
                        <strong>매입처검색</strong>
                        <select id="searchCustType" name="searchCustType" class="custom-select col-12">
                            <!-- 공통코드로 구분함. -->
                            <option value="carNum" selected>차량번호</option>
                            <option value="custName">운송/주선사명</option>
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
                                                        <a href="#" class="k-pager-refresh k-button" id="deleteCalc" onClick="deleteCalc()">
                                                            <b class="btn-r"> <i class="k-icon k-i-trash"></i>삭제처리
                                                            </b>
                                                        </a>
                                                        <a href="#" class="k-pager-refresh k-button" id="resChange" onClick="changeResModalOpen()">
                                                            <b class="btn-b"> <i class="k-icon k-i-user"></i>매입처변경
                                                            </b>
                                                        </a>
                                                        <a href="#" class="k-pager-refresh k-button" id="changeBuyCharge" onClick="changeBuyCharge()">
                                                            <b class="btn-b"> <i class="k-icon k-i-dollar"> </i>지불운송비변경
                                                            </b>
                                                        </a>
                                                        <a href="#" class="k-pager-refresh k-button" id="paperReceiptSub" onClick="paperReceiptSub()">
                                                            <b class="btn-b"> <i class="k-icon k-i-paste-plain-text"> </i>실물인수증수령
                                                            </b>
                                                        </a>
                                                        <a href="#" class="k-pager-refresh k-button" id="paperTaxinvSub" onClick="paperTaxinvSub()">
                                                            <b class="btn-b"> <i class="k-icon k-i-paste-plain-text"> </i>실물계산서수령
                                                            </b>
                                                        </a>
                                                        <a href="#" class="k-pager-refresh k-button" id="etcTaxinvSub" onClick="etcTaxinvSub()">
                                                            <b class="btn-b"> <i class="k-icon k-i-paste-plain-text"> </i>타사계산서수령
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
                                <li id="vReceipt">인수증 보기</li>
                                <li class="k-separator"></li>
                                <li id="vTaxinv">매입계산서 보기</li>
                                <li class="k-separator"></li>
                                <li id="cancelPaperReceiptSub">실물인수증 수령 취소</li>
                                <li class="k-separator"></li>
                                <li id="cancelPaperTaxinvSub">실물계산서 수령 취소</li>
                                <li class="k-separator"></li>
                                <li id="cancelEtcTaxinvSub">타사계산서 수령 취소</li>
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

    var userId = '${sessionScope.userInfo.userId}';
    var deptId = "${sessionScope.userInfo.deptId}";
    
    var selectedList = new Map();
    var editedList = [];
    
	var headerTitle = ($("#headerTitle").text());
   	
    $("#calcListContextMenu").kendoContextMenu({
        target : "#grid",
        filter : "tr[role='row']"
    });

    var contextMenu = $("#calcListContextMenu").data("kendoContextMenu");
    contextMenu.bind("select", onContextMenuSelect);
    
	// 개인화 그리드 설정에서 제외되는 컬럼
    var nonPrivateColumnCheck;
	
	// 매입처 변경 Modal -> 차량번호
	var changeResModalVehic;
	// 매입처 변경 Modal -> 운송사
	var changeResModalCust;

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
     	$("input:checkbox[id='carryOverYn']").prop("checked", true);
     	
     	// 매입처 검색 콤보박스
     	searchCustName = setSearchCustName();
     	
     	// 매입처 검색 조건 셀렉트 박스 이벤트 핸들러
        $("#searchCustType").on("change", function(e) {
			$(".hiddenValue").val("");
        	
			$("#sCustName").val("");
			$("#sOrderId").val("");
			$("#sCustDeptName").val("");
			
			searchBizName.destroy();
			searchBizName = setSearchBizName();
			searchBizName.value("");
			
			if ($(this).val() == "orderId") {
				// 오더ID 검색
        		searchCustName.value("");
        		searchCustName.destroy();
        		
        		$("#searchCustName").hide();
                $("#searchOrderId").show();
			} else {
				// 그 외 조건
				searchCustName.destroy();
        		searchCustName = setSearchCustName();
        		searchCustName.value("");
        		
        		$("#searchCustName").show();
                $("#searchOrderId").hide();
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
        });

		// 매입처 변경 Modal -> 매입처 선택 구분 이벤트 핸들러
		$("input[name='modalChangeResType']:radio").on("click", function() {
			if ($(this).val() == "v") {
				// 차량
				if (typeof changeResModalVehic != "undefined" && changeResModalVehic != null) {
					changeResModalVehic.value("");
				}
				$("#changeResModalManagerName").val("");
				$("#changeResModalManagerMobile").val("");
				
				$("#divChangeResV").show();
				$("#divChangeResC").hide();
			} else {
				// 운송사
				if (typeof changeResModalCust != "undefined" && changeResModalCust != null) {
					changeResModalCust.value("");
				}
				$("#changeResModalDriverName").val("");
				$("#changeResModalDriverMobile").val("");
				
				$("#divChangeResC").show();
				$("#divChangeResV").hide();
			}
		});
		
		// 매입처 변경 Modal -> 차량번호 콤보
		changeResModalVehic = MultiColumnComboBox.setCarNum("changeResModalVehicNo", deptId, "");
		changeResModalVehic.bind("change", function() {
			var dataItem = $("#changeResModalVehicNo").data("kendoMultiColumnComboBox").dataItem();
			if (dataItem != null) {
				$("#changeResModalVehicId").val(dataItem.vehicId);
				$("#changeResModalDriverId").val(dataItem.driverId);
				$("#changeResModalDriverName").val(dataItem.driverName);
				$("#changeResModalDriverMobile").val(dataItem.mobile);
			} else {
				$("#changeResModalVehicId").val("");
				$("#changeResModalDriverId").val("");
				$("#changeResModalDriverName").val("");
				$("#changeResModalDriverMobile").val("");
			}
		});
		
		// 매입처 변경 Modal -> 운송사 콤보
		changeResModalCust = MultiColumnComboBox.setCustName("buy", "02", deptId);
		changeResModalCust.bind("change", function() {
			var dataItem = $("#buyCustName").data("kendoMultiColumnComboBox").dataItem();
			if (dataItem != null) {
				$("#changeResModalBuyCustId").val(dataItem.custId);
				$("#changeResModalBuyDeptId").val(dataItem.deptId);
				$("#changeResModalManagerName").val(dataItem.managerName);
				$("#changeResModalManagerMobile").val(dataItem.mobile);
			} else {
				$("#changeResModalBuyCustId").val("");
				$("#changeResModalBuyDeptId").val("");
				$("#changeResModalManagerName").val("");
				$("#changeResModalManagerMobile").val("");
			}
		});
		
     	// 리스트 출력
       	goList();
    });
    
 	// 매입처 검색 콤보박스 생성
    function setSearchCustName() {
    	var searchCustName;
    	var searchCustType = $("#searchCustType").val();
    	if (searchCustType == "carNum")
    		searchCustName = setComboCarNum();
    	else
    		searchCustName = setComboCustName();
		
		return searchCustName;
    }
 	
 	// 거래처 검색 콤보박스 생성 (주선/운송사)
 	function setComboCustName() {
 		var comboCustName =  $("#sCustName").kendoMultiColumnComboBox({
 			dataTextField: "custName",
 			dataValueField: "custId",
 			filter: "contains",
 			minLength: 2,
 			autoBind: true,
 			dataSource: {
 				serverFiltering: true,
 				transport: {
 					read: {
 						url: "/contents/basic/data/custList.do",
 						dataType: "json",
 						type: "post",
 						data: {
 							useYn : "Y",
 							sellBuySctn : "02",
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
 		comboCustName.bind("change", function(e) {
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
 		
 		return comboCustName;
 	}
 	
 	// 차량 검색 콤보박스 생성 
 	function setComboCarNum() {
 		var comboCarNum = MultiColumnComboBox.setSearchCarNum("sCustName", $("#sDeptId").val(), "");
 		
 		// 거래처 검색 콤보박스 이벤트 핸들러
 		comboCarNum.bind("change", function(e) {
 			if (this.value() == "") {
 				$("#hVehicId").val("");
 				$("#hDriverId").val("");
 				
 				$("#sCustDeptName").val("");
 			} else {
 				var dataItem = $("#sCustName").data("kendoMultiColumnComboBox").dataItem();
 				
 				if (dataItem != null) {
 					$("#hVehicId").val(dataItem.vehicId);
 					$("#hDriverId").val(dataItem.driverId);
 					
 					$("#sCustDeptName").val(dataItem.driverName);
 				}
 			}
 		});
 		
 		return comboCarNum;
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
    	
    	columns = setPrivateData("C3130", "grid", userId, columns);
		
    	var grid = $("#grid").kendoGrid({
            dataSource: {
                transport: {
                    read: {
                        url: "/contents/calc/data/buyCalcList.do",
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
                    	getSummary(response.total, response.sumPayableAmt, response.sumWithdrawalAmt);
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
			selectable: "cell",
			persistSelection: true,
            editable: true,
            edit: function(e) {
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
    	
    	setOptionActive("C3130", "grid", userId);
    	
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
		var payableAmtVal = Number(e.model.get("payableAmt"));
    	
		if (typeof e.values.buyCharge == "number") {
			payableAmtVal -= Number(e.model.get("buyCharge"));
			payableAmtVal += Number(e.values.buyCharge);
			
			var orderId = e.model.get("orderId");
			var allocId = e.model.get("buyAllocId");
			var calcId = e.model.get("buyChargeId");
			var chargeCode = "0002";
			var value = e.values.buyCharge;
			var insert = false;
			
			editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert);
		}
		else if (typeof e.values.buyWaypointCharge == "number") {
			payableAmtVal -= Number(e.model.get("buyWaypointCharge"));
			payableAmtVal += Number(e.values.buyWaypointCharge);
			
			var orderId = e.model.get("orderId");
			var allocId = e.model.get("buyAllocId");
			var calcId = (e.model.get("buyWaypointChargeId") == '') ? e.model.get("buyChargeId") : e.model.get("buyWaypointChargeId");
			var chargeCode = "0023";
			var value = e.values.buyWaypointCharge;
			var insert = (e.model.get("buyWaypointChargeId") == '') ? true : false
			
			editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert);
		}
		else if (typeof e.values.buyStayCharge == "number") {
			payableAmtVal -= Number(e.model.get("buyStayCharge"));
			payableAmtVal += Number(e.values.buyStayCharge);
			
			var orderId = e.model.get("orderId");
			var allocId = e.model.get("buyAllocId");
			var calcId = (e.model.get("buyStayChargeId") == '') ? e.model.get("buyChargeId") : e.model.get("buyStayChargeId");
			var chargeCode = "0025";
			var value = e.values.buyStayCharge;
			var insert = (e.model.get("buyStayChargeId") == '') ? true : false
			
			editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert);
		}
		else if (typeof e.values.buyHandworkCharge == "number") {
			payableAmtVal -= Number(e.model.get("buyHandworkCharge"));
			payableAmtVal += Number(e.values.buyHandworkCharge);
			
			var orderId = e.model.get("orderId");
			var allocId = e.model.get("buyAllocId");
			var calcId = (e.model.get("buyHandworkChargeId") == '') ? e.model.get("buyChargeId") : e.model.get("buyHandworkChargeId");
			var chargeCode = "0371";
			var value = e.values.buyHandworkCharge;
			var insert = (e.model.get("buyHandworkChargeId") == '') ? true : false
			
			editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert);
		}
		else if (typeof e.values.buyRoundCharge == "number") {
			payableAmtVal -= Number(e.model.get("buyRoundCharge"));
			payableAmtVal += Number(e.values.buyRoundCharge);
			
			var orderId = e.model.get("orderId");
			var allocId = e.model.get("buyAllocId");
			var calcId = (e.model.get("buyRoundChargeId") == '') ? e.model.get("buyChargeId") : e.model.get("buyRoundChargeId");
			var chargeCode = "0372";
			var value = e.values.buyRoundCharge;
			var insert = (e.model.get("buyRoundChargeId") == '') ? true : false
			
			editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert);
		}
		else if (typeof e.values.buyOtheraddCharge == "number") {
			payableAmtVal -= Number(e.model.get("buyOtheraddCharge"));
			payableAmtVal += Number(e.values.buyOtheraddCharge);
			
			var orderId = e.model.get("orderId");
			var allocId = e.model.get("buyAllocId");
			var calcId = (e.model.get("buyOtheraddChargeId") == '') ? e.model.get("buyChargeId") : e.model.get("buyOtheraddChargeId");
			var chargeCode = "0294";
			var value = e.values.buyOtheraddCharge;
			var insert = (e.model.get("buyOtheraddChargeId") == '') ? true : false;
			
			editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert);
		}
		else if (typeof e.values.buyServiceFeeCharge == "number") {
			// Validation 체크 (입력된 값이 0이상(+)일 경우 0으로 재설정 -> 이후 계산하지 않음.)
			if (Number(e.values.buyServiceFeeCharge) > 0) {
				e.preventDefault();
			}
			
			payableAmtVal -= Number(e.model.get("buyServiceFeeCharge"));
			payableAmtVal += Number(e.values.buyServiceFeeCharge);
			
			var orderId = e.model.get("orderId");
			var allocId = e.model.get("buyAllocId");
			var calcId = (e.model.get("buyServiceFeeChargeId") == '') ? e.model.get("buyChargeId") : e.model.get("buyServiceFeeChargeId");
			var chargeCode = "0901";
			var value = e.values.buyServiceFeeCharge;
			var insert = (e.model.get("buyServiceFeeChargeId") == '') ? true : false;
			
			editListInsertItem(orderId, allocId, calcId, chargeCode, value, insert);
		}
		else {
			// null일 경우 이벤트 처리 안함.
			e.preventDefault();
		}
		
		e.model.set("payableAmt", payableAmtVal);
		
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
    function getSummary(total, sumPayableAmt, sumWithdrawalAmt) {
    	var groupCount = 
			"<i style=\"color: #3f75c1\">매입 : " + Util.nvl(Util.formatNumber(total), '0') + "건 / " + 
			Util.nvl(Util.formatNumber(sumPayableAmt), '0') + "원 / " + Util.nvl(Util.formatNumber(sumWithdrawalAmt), '0') + "원</i>"
		
		$("#groupCount").html(groupCount);
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
                			allocIdList.push(value.buyAllocId);
        				}
        			}
            	}
        		
        		$.ajax({
        			url: "/contents/calc/data/setBuyCalcDeleteYn.do",
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
            			allocIdList.push(value.buyAllocId);	
        			}
            	}
        		
        		$.ajax({
        			url: "/contents/calc/data/setBuyCalcDeleteYn.do",
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
 	
 	// 마감처리
 	function calcFinish() {
 		// 운송비 변경 건이 존재하는지 체크
 		if (editedList.length > 0) {
 			var message = "지불운송비 변경을 하지 않은 건이 존재합니다.\n변경된 건에 대해 지불운송비 변경을 하지 않으면 기존 금액으로 마감처리 됩니다.\n계속 하시겠습니까?";
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
    						buyChargeId
    						buyWaypointChargeId
    						buyStayChargeId
    						buyHandworkChargeId
    						buyRoundChargeId
    						buyOtheraddChargeId
    						buyServiceFeeChargeId
    					*/
    					if (value.buyChargeId != null && value.buyChargeId != "")
    						calcIdList.push(value.buyChargeId);
    					
    					if (value.buyWaypointChargeId != null && value.buyWaypointChargeId != "")
    						calcIdList.push(value.buyWaypointChargeId);
    					
    					if (value.buyStayChargeId != null && value.buyStayChargeId != "")
    						calcIdList.push(value.buyStayChargeId);
    					
    					if (value.buyHandworkChargeId != null && value.buyHandworkChargeId != "")
    						calcIdList.push(value.buyHandworkChargeId);
    					
    					if (value.buyRoundChargeId != null && value.buyRoundChargeId != "")
    						calcIdList.push(value.buyRoundChargeId);
    					
    					if (value.buyOtheraddChargeId != null && value.buyOtheraddChargeId != "")
    						calcIdList.push(value.buyOtheraddChargeId);
    					
    					if (value.buyServiceFeeChargeId != null && value.buyServiceFeeChargeId != "")
    						calcIdList.push(value.buyServiceFeeChargeId);
    				}
    			}
    			
    			$.ajax({
        			url: "/contents/calc/data/setBuyCalcFinish.do",
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
    						buyChargeId
    						buyWaypointChargeId
    						buyStayChargeId
    						buyHandworkChargeId
    						buyRoundChargeId
    						buyOtheraddChargeId
    						buyServiceFeeChargeId
    					*/
    					if (value.buyChargeId != null && value.buyChargeId != "")
    						calcIdList.push(value.buyChargeId);
    					
    					if (value.buyWaypointChargeId != null && value.buyWaypointChargeId != "")
    						calcIdList.push(value.buyWaypointChargeId);
    					
    					if (value.buyStayChargeId != null && value.buyStayChargeId != "")
    						calcIdList.push(value.buyStayChargeId);
    					
    					if (value.buyHandworkChargeId != null && value.buyHandworkChargeId != "")
    						calcIdList.push(value.buyHandworkChargeId);
    					
    					if (value.buyRoundChargeId != null && value.buyRoundChargeId != "")
    						calcIdList.push(value.buyRoundChargeId);
    					
    					if (value.buyOtheraddChargeId != null && value.buyOtheraddChargeId != "")
    						calcIdList.push(value.buyOtheraddChargeId);
    					
    					if (value.buyServiceFeeChargeId != null && value.buyServiceFeeChargeId != "")
    						calcIdList.push(value.buyServiceFeeChargeId);
    				}
    			}
    			
    			$.ajax({
        			url: "/contents/calc/data/setBuyCalcFinish.do",
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
     * 세금계산서 Modal
     */
    taxinvModal = $("#divTaxInvoice");
    taxinvModal.kendoDialog({
		width: "1200px",
		height: "900px",
		visible: false,
		title: "매입계산서",
		closable: true,
		modal: true,
		close: function(){
			$("#fTaxInvoice")[0].reset();
		}
	});
    
    // 세금계산서 창 Open
    function taxinvModalOpen(orderId, allocId, taxinvYn, taxinvId) {
    	if (taxinvYn == "N") {
    		alert("등록된 세금계산서가 없습니다.");
    		return;
    	} else if (!taxinvYn.includes("전자")) {
    		alert(taxinvYn + "으로 등록된 세금계산서입니다.");
    		return;
    	}
    	
    	$.ajax({
    		url: "/contents/calc/data/getTaxinv.do",
    		type: "POST",
    		dataType: "json",
    		data: {
    			orderId: orderId,
    			allocId: allocId,
    			taxinvId: taxinvId
    		},
    		success: function(data) {
    			var supplierMemTel = Util.formatPhone(data.taxinv.supplierMemTel);
    			var supplierBizNo = Util.formatBizNum(data.taxinv.supplierBizNo);
    			var buyerMemTel = Util.formatPhone(data.taxinv.buyerMemTel);
    			var buyerBizNo = Util.formatBizNum(data.taxinv.buyerBizNo);
    			Util.setPageData(data.taxinv);
    			
    			// 위수탁 정보
    			var brokerStr = "";
    			brokerStr = 
    				"수탁자 주소 : (" + data.taxinv.brokerAddr + "), 수탁자 업태 : (" + data.taxinv.brokerBizType + "), 수탁자 업종 : (" + data.taxinv.brokerBizClass + ")\n" +
    				"수탁자 사업자명 : (" + data.taxinv.brokerBizName + "), 수탁자 사업자 번호 : (" + Util.formatBizNum(data.taxinv.brokerBizNo) + "), 수탁 대표자 : (" + data.taxinv.brokerCeo + ")\n" +
    				"수탁 담당자 : (" + data.taxinv.brokerMemName + "), 수탁자 연락처 : (" + Util.formatPhone(data.taxinv.brokerMemTel) + "), 수탁자 이메일 : (" + data.taxinv.brokerMemEmail + ")";
				$("#brokerInfo").val(brokerStr);
    			
    			// 세금계산서 항목
    			var tax = 0;
    			var supprice = 0;
    			$('#taxDtlTbl tr:gt(0)').remove();
    			for (var i = 0; i < data.taxinvDetailList.length; i++) {
    				var str = "";
    				str +=
    				"<tr>" +
    					"<td><input type='text' class='col' id='itemDate' name='itemDate' value='" + data.taxinvDetailList[i].itemDate + "' readonly></td>" +
    			        "<td><input type='text' class='col' id='itemName' name='itemName' value='" + data.taxinvDetailList[i].itemName + "' readonly></td>" +
    			        "<td><input type='text' class='col' id='itemType' name='itemType' value='" + data.taxinvDetailList[i].itemType + "' readonly></td>" +
    			        "<td><input type='text' class='col' id='itemQty' name='itemQty' value='" + data.taxinvDetailList[i].itemQty + "' readonly></td>" +
    			        "<td><input type='text' class='col' id='itemPrice' name='itemPrice' value='" + Util.formatNumber(data.taxinvDetailList[i].itemSupprice) + "' readonly></td>" +
    			        "<td><input type='text' class='col' id='itemSupprice' name='itemSupprice' value='" + Util.formatNumber(data.taxinvDetailList[i].itemSupprice) + "' readonly></td>" +
    			        "<td><input type='text' class='col' id='itemTax' name='itemTax' value='" + Util.formatNumber(data.taxinvDetailList[i].itemTax) + "' readonly></td>" +
    			        "<td><input type='text' class='col' id='itemRemarks' name='itemRemarks' value='" + data.taxinvDetailList[i].itemRemarks + "' readonly></td>" +
    			    "</tr>";
    			    tax += data.taxinvDetailList[i].itemTax;
    			    supprice += data.taxinvDetailList[i].itemSupprice;
    				$("#taxDtlTbl").append(str);
    			}
    			
    			$("#tax").val(Util.formatNumber(tax));
    			$("#supprice").val(Util.formatNumber(supprice));
    			$("#totPrice").val(Util.formatNumber(tax + supprice));
    			$("input:radio[name='pubForm']:input[value=" + data.taxinv.pubForm + "]").prop("checked", true);

    			taxinvModal.data("kendoDialog").open();
    		}
    	});
    }
    
    // 세금계산서 창 Close
//     function taxinvModalClose() {
//     	taxinvModal.data("kendoDialog").close();
//     }
    
    // 실물 인수증 수령
    function paperReceiptSub() {
    	if (selectedList.size > 0) {
    		var message = "선택된 (" + selectedList.size + ")건에 대한 실물 인수증 수령을 처리 하시겠습니까?\n전자 인수증 처리된 경우 제외됩니다.";
    		if (confirm(message)) {
    			var mode = "P";
    			var orderIdList = [];
    			for (var [key, value] of selectedList) {
    				// 전자 인수증 수령 건 제외
    				if (!value.receiptYn.includes("전자"))
    					orderIdList.push(value.orderId);
    			}
    			
    			$.ajax({
    				url: "/contents/calc/data/setReceiptSub.do",
    				type: "POST",
    				dataType: "json",
    				data: {
    					orderIdList: orderIdList.toString(),
    					mode: mode
    				},
    				success: function(data){
    					if (data.linkMessage.status == 0) {
    						alert(data.linkMessage.message);
    						goList();
    					} else {
    						alert(data.linkMessage.message);
    					}
    				}
    			});
    		}
    	}
    	else {
    		alert("실물 인수증 수령을 처리할 항목을 선택해 주세요.");
    	}
    }
    
    // 실물 인수증 수령 취소
    function cancelPaperReceiptSub() {
		if (selectedList.size > 0) {
			var message = "선택된 (" + selectedList.size + ")건에 대한 실물 인수증 수령을 취소 하시겠습니까?";
			if (confirm(message)) {
				var mode = "N";
    			var orderIdList = [];
    			for (var [key, value] of selectedList) {
    				orderIdList.push(value.orderId);
    			}
    			
    			$.ajax({
    				url: "/contents/calc/data/setReceiptSub.do",
    				type: "POST",
    				dataType: "json",
    				data: {
    					orderIdList: orderIdList.toString(),
    					mode: mode
    				},
    				success: function(data){
    					if (data.linkMessage.status == 0) {
    						alert(data.linkMessage.message);
    						goList();
    					} else {
    						alert(data.linkMessage.message);
    					}
    				}
    			});
    		}
    	}
    	else {
    		alert("실물 인수증 수령을 취소할 항목을 선택해 주세요.");
    	}
    }
    
    // 실물 거래명세서 수령
    function paperTaxinvSub() {
		if (selectedList.size > 0) {
			var message = "선택된 (" + selectedList.size + ")건에 대한 실물 거래명세서 수령을 처리 하시겠습니까?";
			if (confirm(message)) {
				var mode = "P";
				var allocIdList = [];
    			for (var [key, value] of selectedList) {
    				// CalcId 건별로 처리하는게 아닌 AllocId로 한번에 처리함.
    				// * 기존에는 CalcId 건별로 처리하는 방식
    				// 전자 계산서 수령 건 제외
    				if (!value.taxinvYn.includes("전자"))
    					allocIdList.push(value.buyAllocId);
    				
    				// CalcId로 처리 시. 
//     				if (typeof value.buyChargeId != "ubdefined" && value.buyChargeId != null && value.buyChargeId != "")
//     					calcIdList.push(value.buyChargeId);
    			}
    			
    			$.ajax({
    				url: "/contents/calc/data/setTaxinvSub.do",
    				type: "POST",
    				dataType: "json",
    				data: {
    					allocIdList: allocIdList.toString(),
    					mode: mode
    				},
    				success: function(data){
    					if (data.linkMessage.status == 0) {
    						alert(data.linkMessage.message);
    						goList();
    					} else {
    						alert(data.linkMessage.message);
    					}
    				}
    			});
    		}
    	}
    	else {
    		alert("실물 거래명세서 수령을 처리할 항목을 선택해 주세요.");
    	}
    }
    
    // 실물 거래명세서 수령 취소
    function cancelPaperTaxinvSub() {
		if (selectedList.size > 0) {
			var message = "선택된 (" + selectedList.size + ")건에 대한 실물 거래명세서 수령을 취소 하시겠습니까?";
			if (confirm(message)) {
				var mode = "N";
				var allocIdList = [];
    			for (var [key, value] of selectedList) {
    				// CalcId 건별로 처리하는게 아닌 AllocId로 한번에 처리함.
    				// * 기존에는 CalcId 건별로 처리하는 방식
    				allocIdList.push(value.buyAllocId);
    				
    				// CalcId로 처리 시. 
//     				if (typeof value.buyChargeId != "ubdefined" && value.buyChargeId != null && value.buyChargeId != "")
//     					calcIdList.push(value.buyChargeId);
    			}
    			
    			$.ajax({
    				url: "/contents/calc/data/setTaxinvSub.do",
    				type: "POST",
    				dataType: "json",
    				data: {
    					allocIdList: allocIdList.toString(),
    					mode: mode
    				},
    				success: function(data){
    					if (data.linkMessage.status == 0) {
    						alert(data.linkMessage.message);
    						goList();
    						contextMenu.close();
    					} else {
    						alert(data.linkMessage.message);
    					}
    				}
    			});
    		}
    	}
    	else {
    		alert("실물 거래명세서 수령을 취소할 항목을 선택해 주세요.");
    	}
    }
    
    // 타사 거래명세서 수령
    function etcTaxinvSub() {
		if (selectedList.size > 0) {
			var message = "선택된 (" + selectedList.size + ")건에 대한 타사 거래명세서 수령을 처리 하시겠습니까?";
			if (confirm(message)) {
				var mode = "E";
				var allocIdList = [];
    			for (var [key, value] of selectedList) {
    				// CalcId 건별로 처리하는게 아닌 AllocId로 한번에 처리함.
    				// * 기존에는 CalcId 건별로 처리하는 방식
    				// 전자 계산서 수령 건 제외
    				if (!value.taxinvYn.includes("전자"))
    					allocIdList.push(value.buyAllocId);
    				
    				// CalcId로 처리 시. 
//     				if (typeof value.buyChargeId != "ubdefined" && value.buyChargeId != null && value.buyChargeId != "")
//     					calcIdList.push(value.buyChargeId);
    			}
    			
    			$.ajax({
    				url: "/contents/calc/data/setTaxinvSub.do",
    				type: "POST",
    				dataType: "json",
    				data: {
    					allocIdList: allocIdList.toString(),
    					mode: mode
    				},
    				success: function(data){
    					if (data.linkMessage.status == 0) {
    						alert(data.linkMessage.message);
    						goList();
    					} else {
    						alert(data.linkMessage.message);
    					}
    				}
    			});
    		}
    	}
    	else {
    		alert("타사 거래명세서 수령을 처리할 항목을 선택해 주세요.");
    	}
    }
    
    // 타사 거래명세서 수령 취소
    function cancelEtcTaxinvSub() {
		if (selectedList.size > 0) {
			var message = "선택된 (" + selectedList.size + ")건에 대한 타사 거래명세서 수령을 취소 하시겠습니까?";
			if (confirm(message)) {
				var mode = "N";
				var allocIdList = [];
    			for (var [key, value] of selectedList) {
    				// CalcId 건별로 처리하는게 아닌 AllocId로 한번에 처리함.
    				// * 기존에는 CalcId 건별로 처리하는 방식
    				allocIdList.push(value.buyAllocId);
    				
    				// CalcId로 처리 시. 
//     				if (typeof value.buyChargeId != "ubdefined" && value.buyChargeId != null && value.buyChargeId != "")
//     					calcIdList.push(value.buyChargeId);
    			}
    			
    			$.ajax({
    				url: "/contents/calc/data/setTaxinvSub.do",
    				type: "POST",
    				dataType: "json",
    				data: {
    					allocIdList: allocIdList.toString(),
    					mode: mode
    				},
    				success: function(data){
    					if (data.linkMessage.status == 0) {
    						alert(data.linkMessage.message);
    						goList();
    						contextMenu.close();
    					} else {
    						alert(data.linkMessage.message);
    					}
    				}
    			});
    		}
    	}
    	else {
    		alert("타사 거래명세서 수령을 취소할 항목을 선택해 주세요.");
    	}
    }
    
    // 지불운송비 변경
    function changeBuyCharge() {
    	if (editedList.length > 0) {
    		var message = "항목이 변경된  (" + editedList.length + ")건에 대한 운송비 변경을 하시겠습니까?";
    		if (confirm(message)) {
    			
    			var params = {
				   "params": JSON.stringify(editedList)
				}
    			
    			$.ajax({
					url: "/contents/calc/data/setBuyCalcCharge.do",
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
 			alert("변경된 지불운송비 항목이 없습니다.");
 		}
    }
    
    /*
     * 매입처 변경 Modal
     */
     changeResModal = $("#divChangeRes");
     changeResModal.kendoDialog({
         width: "640px",
         height: "480px",
         visible: false,
         title: "매입처 변경",
         closable: true,
         modal: true
     });
     
     function changeResModalOpen() {
    	 if (selectedList.size <= 0) {
    		 alert("매입처를 변경할 항목을 선택해 주세요.");
    		 return;
    	 }
    	 
    	 if (selectedList.size > 0) {
    		 var orderIdList = [];
    		 var allocIdList = [];
    		 for (var [key, value] of selectedList) {
    			 // 마감처리된 건은 제외 추가?
    			 if (value.deleteYn != "" && value.deleteYn != "Y") {
    				 orderIdList.push(value.orderId);
    				 allocIdList.push(value.buyAllocId);
    			 }
    		 }
    	 }
    	 
    	 $("#changeResModalOrderList").val(orderIdList);
    	 $("#changeResModalAllocList").val(allocIdList);
    	 
    	 changeResModal.data("kendoDialog").open();
     }
     
     function changeResModalClose() {
    	 // 팝업 컨트롤 초기화
    	 $("#fChangeRes")[0].reset();
    	 $(".hiddenValue").val("");
    	 
    	 $("#changeResModalDriverName").val("");
    	 $("#changeResModalDriverMobile").val("");
    	 
    	 $("#changeResModalManagerName").val("");
    	 $("#changeResModalManagerMobile").val("");
    	 
    	 changeResModal.data("kendoDialog").close();
     }
     
     $('#fChangeRes').validator().on('submit', function(e) {
    	 if (e.isDefaultPrevented()) {
    		 alert("항목을 입력해 주세요.");
    		 e.preventDefault();
    		 return;
    	 }
     });
    
 	// 그리드 컨택스트 메뉴 처리
    function onContextMenuSelect(e) {
    	var item = e.item.id;
    	
    	switch (item) {
    	case "cSave":
            setPrivateSaveData("C3130", "grid", userId);
            break;
        case "dSave":
            setPrivatePanel("C3130", "grid", userId);
            break;
        case "copyOrderId":
        	// 클립보드 복사
        	var grid = $("#grid").data("kendoGrid");
        	var dataItem = grid.dataItem(e.target);
        	if (typeof dataItem != "undefined" && dataItem != null)
        		copyOrderId(dataItem.orderId);
        	else
        		alert("선택된 오더가 없습니다.");
        	break;
        case "vReceipt":
        	var grid = $("#grid").data("kendoGrid");
        	var dataItem = grid.dataItem(e.target);
        	if (typeof dataItem != "undefined" && dataItem != null)
        		viewReceipt(dataItem.receiptYn, dataItem.orderId);
        	else
        		alert("선택된 오더가 없습니다.");
        	break;
        case "vTaxinv":
        	var grid = $("#grid").data("kendoGrid");
        	var dataItem = grid.dataItem(e.target);
        	if (typeof dataItem != "undefined" && dataItem != null)
        		taxinvModalOpen(dataItem.orderId, dataItem.buyAllocId, dataItem.taxinvYn, dataItem.taxinvId);
        	else
        		alert("선택된 오더가 없습니다.");
        	break;
        case "cancelPaperReceiptSub":
        	cancelPaperReceiptSub();
        	break;
        case "cancelPaperTaxinvSub":
        	cancelPaperTaxinvSub();
        	break;
        case "cancelEtcTaxinvSub":
        	cancelEtcTaxinvSub();
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
    	// 체크박스 추가
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
		{ field: "driverCarrierName", title: "소속운송사", width: 100, editable: function (dataItem){} },
		{ field: "buyCustName", title: "차량번호(운송사)", width: 140, editable: function (dataItem){} },
		{ field: "buyManagerName", title: "차주명(담당자)", width: 140, editable: function (dataItem){} },
		{ field: "buyManagerTel", title: "전화번호", width: 120,
			template: function(dataItem) {
			   return Util.formatPhone(dataItem.buyManagerTel);
			},
			editable: function (dataItem){}
		},
		{ field: "carSctnName", title: "차량구분", width: 90, editable: function (dataItem){} },
		{ field: "fastPayYn", title: "빠른지급신청", width: 120, editable: function (dataItem){} },
		{ field: "receiptYn", title: "인수증", width: 130, editable: function (dataItem){} },
		{ field: "taxinvYn", title: "계산서", width: 130, editable: function (dataItem){} },
		{ field: "sAddr", title: "상차지", width: 120, editable: function (dataItem){} },
		{ field: "eAddr", title: "하차지", width: 120, editable: function (dataItem){} },
		{ field: "wayPoint", title: "2착지", width: 160, editable: function (dataItem){} 	},
		{ field: "payableAmt", title: "매입액(소계)", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.payableAmt, "0"));
			},
			attributes: { 
				style: "text-align: right" 
			},
			editable: function (dataItem){}
		},
		{ field: "buyCharge", title: "내수운송료", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.buyCharge, "0"));
			},
			attributes: {
				style: "text-align: right"
			},
			headerTemplate : '<label class="editHeader">내수운송료</label>'
		},
		{ field: "buyWaypointCharge", title: "경유비", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.buyWaypointCharge, "0"));
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">경유비</label>'
		},
		{ field: "buyStayCharge", title: "대기료", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.buyStayCharge, "0"));
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">대기료</label>'
		},
		{ field: "buyHandworkCharge", title: "수작업비", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.buyHandworkCharge, "0"));
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">수작업비</label>'
		},
		{ field: "buyRoundCharge", title: "회차료", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.buyRoundCharge, "0"));
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">회차료</label>'
		},
		{ field: "buyOtheraddCharge", title: "기타추가비", width: 100, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.buyOtheraddCharge, "0"));
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">기타추가비</label>'
		},
		{ field: "buyServiceFeeCharge", title: "서비스수수료(-)", width: 120, type: 'number',
			template: function(dataItem) {
			   return Util.formatNumber(Util.nvl(dataItem.buyServiceFeeCharge, "0"));
			},
			attributes: { 
				style: "text-align: right" 
			},
			headerTemplate : '<label class="editHeader">서비스수수료(-)</label>'
		},
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
		{ field: "withdrawallAmt", title: "지급액", width: 100, type: 'number',
			template: function(dataItem) {
		       return Util.formatNumber(Util.nvl(dataItem.withdrawallAmt, "0"));
		    },
			attributes: { 
				style: "text-align: right" 
			},
			editable: function (dataItem){}
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
		{ field: "custName", title: "화주(거래처)", width: 140, editable: function (dataItem){} },
		{ field: "bizName", title: "거래처(계산서발행지)", width: 160, editable: function (dataItem){} },
		{ field: "appName", title: "어플명", width: 100, editable: function (dataItem){} },
		{ field: "finishMemo", title: "마감 시 메모", width: 160, editable: function (dataItem){} },
		{ field: "refContent1", title: "참고 내용1", width: 160, editable: function (dataItem){} },
		{ field: "refContent2", title: "참고 내용2", width: 160, editable: function (dataItem){} },
		{ field: "reportBizNum", title: "신고용사업자번호", width: 160, editable: function (dataItem){} },
		{ field: "reportBizName", title: "신고용사업자명", width: 160, editable: function (dataItem){} },
		{ field: "mngDeptName", title: "담당부서", width: 120, editable: function (dataItem){} },
		{ field: "mngUserName", title: "배차원", width: 100, editable: function (dataItem){} },
		{ field: "deleteYn", title: "삭제일", width: 80, editable: function (dataItem){} },
		{ field: "deleteUserName", title: "삭제자", width: 80, editable: function (dataItem){} },
		
		// 숨김항목
		{ field: "mngCustId", hidden: true, editable: function (dataItem){} },
		{ field: "mngDeptId", hidden: true, editable: function (dataItem){} },
		{ field: "custId", hidden: true, editable: function (dataItem){} },
		{ field: "deptId", hidden: true, editable: function (dataItem){} },
		{ field: "reqCustId", hidden: true, editable: function (dataItem){} },
		{ field: "reqDeptId", hidden: true, editable: function (dataItem){} },
		
		{ field: "buyAllocId", hidden: true, editable: function (dataItem){} },
		{ field: "buyChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "buyWaypointChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "buyStayChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "buyHandworkChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "buyRoundChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "buyOtheraddChargeId", hidden: true, editable: function (dataItem){} },
		{ field: "buyServiceFeeChargeId", hidden: true, editable: function (dataItem){} },
		
		{ field: "allocState", hidden: true, editable: function (dataItem){} },
		{ field: "allocDateFull", hidden: true, editable: function (dataItem){} },
		{ field: "sDateFull", hidden: true, editable: function (dataItem){} },
		{ field: "eDateFull", hidden: true, editable: function (dataItem){} }
    ]
</script>