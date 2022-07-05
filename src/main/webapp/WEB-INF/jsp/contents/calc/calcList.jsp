<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#calcList .k-grid-content {max-height:calc(100vh - 452px)}
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

<div id="divChangeAmt" class="editor-warp p-0">
	<form class="modalEditor" id="fChangeAmt" data-toggle="validator" role="form" autocomplete="off">
		<input type="hidden" name="allocList" id="allocList">
		<div class="modalHeader">
<!-- 			<div class="form-group row">
               <label class="col-form-label modal-big-name">운송사명</label>
               <div class="input-group input-group-sm col middle-name form-group">
                   <input type="text" id="modalCarrierName" class="form-control form-control-sm" type="text" readonly>
               </div>
           </div>
           <div class="form-group row">
               <label class="col-form-label modal-big-name">기간</label>
               <div style="display: inline-block; text-align: left;" class="input-group input-group-sm col middle-name form-group">
                   <span style="display: inline; vertical-align: sub;" class="col-12" id="modalFromDate"></span>
                   <span style="display: inline; vertical-align: sub;">&nbsp;~&nbsp;</span>
                   <span style="display: inline; vertical-align: sub;" class="col-12" id="modalToDate"></span>
               </div>
           </div> -->
           <div class="form-group row">
               <label class="col-form-label modal-big-name">운송비</label>
               <div class="input-group input-group-sm col middle-name form-group">
                   <input type="text" id="modalAllocCharge" class="form-control form-control-sm" type="text" required>
				   <div class="help-block with-errors" ></div>
               </div>
           </div>
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <button type="submit"  class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i><strong>변경</strong></b></button>
		        <a id="closeBtn" onclick="modalClose()" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
	        </div>
	    </div>
    </form>
</div>

<div id="divCalcInsert" class="editor_wrap p-0">
	<form class="modalEditor" id="fCalc" data-toggle="validator" role="form" autocomplete="off">
		<input type="hidden" name="fCalcMode" id="fCalcMode" class="hiddenValue">
		<div class="modalHeader">
			<div class="form-group row">
                <label class="col-form-label modal-big-name">운송비항목</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <!-- <input type="text" class="form-control form-control-sm" type="text"> -->
                    <select name="calcTypeCode" id="calcTypeCode" class="custom-select col-12" required></select>
					<div class="help-block with-errors" ></div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name">정산금액</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" type="text" id="calcCharge" required>
					<div class="help-block with-errors" ></div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name">메모</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" type="text" id="memo" required>
					<div class="help-block with-errors" ></div>
                </div>
            </div>
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <button type="submit" id="fCalcSubmitBtn" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i><strong>저장</strong></b></button>
		        <a onclick="calcModalClose()" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
	        </div>
	    </div>
	</form>
</div>

<div id="divCalcDetail" class="editor_wrap p-0">
	<form class="modalEditor" id="calcDetailForm" data-toggle="validator" role="form" autocomplete="off">
		<input type="hidden" name="detailFormCalcId" id="detailFormCalcId" class="hiddenValue">
		<div class="modalHeader">
            <div class="form-group row">
                <label class="col-form-label modal-big-name" style="width: 130px">어플명</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" name="appName" id="appName">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name" style="width: 130px">마감 시 메모</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" name="finishMemo" id="finishMemo">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name" style="width: 130px">참고내용1</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" name="refContent1" id="refContent1">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name" style="width: 130px">참고내용2</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" name="refContent2" id="refContent2">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name" style="width: 130px">신고용 사업자번호</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" name="reportBizNum" id="reportBizNum" maxlength="12">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-form-label modal-big-name" style="width: 130px">신고용 사업자명</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" name="reportBizName" id="reportBizName">
                </div>
            </div>
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <button type="button" onclick="detailCalcUpdate()" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i><strong>저장</strong></b></button>
		        <a onclick="calcDetailClose()" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
	        </div>
	    </div>
	</form>
</div>

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
		        <a onclick="tranReceiptcalcModalClose()" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
	        </div>
	    </div>
	</form>
</div>

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
                   <input type="text" id="sModalCustName" name="sModalCustName" style="width:100%;" required>
				   <div class="help-block with-errors" ></div>
               </div>
               <div class="input-group input-group-sm col middle-name form-group">
                   <input type="text" name="sModalSubName" id="sModalSubName" class="form-control form-control-sm" readonly>
               </div>
           </div>
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <button type="submit"  class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i><strong>변경</strong></b></button>
		        <a id="closeBtn" onclick="reqModalClose();" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
	        </div>
	    </div>
    </form>
</div>

<div class="header">
	<div style="justify-content: space-between; display: flex;" class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">정산관리</P>
		</div>
		<div id="summaryData" style="height: 30px;">
			<div style="display: contents;" class="col input-group i-name">
            	<i style="font-size: larger;" id="groupCount"></i>
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
			<div class="form-group row">
				<div class="input-group input-group-sm col-1 middle-name">
				<strong>배차일자</strong>
				    <input style="padding: 0;" type="text" id="fromDate" name="fromDate" class="col-12">
				</div>
				<span style="margin-top: 31px;">~</span>
				<div class="input-group input-group-sm col-1 middle-name">  
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
				<strong>운송비항목</strong>
				    <select class="custom-select col-12" id="sCalcTypeCode" name="calcTypeCode"></select>
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>정산마감여부</strong>
				    <select class="custom-select col-12" id="sFinishYn" name="finishYn">
				        <option value="">--항목선택--</option>
				        <option value="Y">Y</option>
				        <option value="N">N</option>
				    </select>
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>빠른지급여부</strong>
				    <select class="custom-select col-12" id="sReqPayYn" name="reqPayYn">
				        <option value="">--항목선택--</option>
				        <option value="Y">Y</option>
				        <option value="N">N</option>
				    </select>
				</div>
                
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>담당부서명</strong>
				    <select class="form-control" class="custom-select col-12" id="sDeptId" name="sDeptId">
				    	<option>--부서명--</option>
				    </select>
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>배차담당자</strong>
				    <select class="form-control" class="custom-select col-12" id="sUserId" name="sUserId">
				    	<option>--담당자--</option>
				    </select>
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>청구구분</strong>
				    <select class="form-control" class="custom-select col-12" id="sChargeType" name="chargeType">
				    	<option>--담당자--</option>
				    </select>
				</div>
			</div>
			<div class="form-group row">
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>부서별검색</strong>
				    <select class="custom-select col-12" id="custType" name="custType">
				        <option value="01">화주명</option>
				        <option value="02">운송/주선사명</option>
				        <option value="99">차량번호</option>
				        <option value="orderId">오더ID</option>
				    </select>
				</div>
				<div id="searchDiv" class="input-group input-group-sm col-2 middle-name">
				<strong>&nbsp;</strong>
				    <input type="text" id="sCustName" name="sCustName" style="width:100%;">
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
				    <input type="text" id="bizName" name="bizName" style="width:100%;">
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
                	<select name="sSubDept" id="sSubDept" class="custom-select"></select>
                </div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>매출입항목</strong>
				    <select class="custom-select col-12" id="sSellBuySctn" name="sellBuySctn"></select>
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>운임구분</strong>
				    <select class="custom-select col-12" id="sUnitPriceType" name="unitPriceType">
				    	<option value="">--항목선택--</option>
				    	<option value="01">대당단가</option>
				    	<option value="02">톤당단가</option>
				    </select>
				</div>
				
				<div class="input-group input-group-sm col-1 middle-name" style="max-width:90px;min-width:90px;">
				<strong>　</strong>
				    <button onclick="goList()" type="button" style="border-radius:4px" class="form-control form-control-sm middle-button-dark"><i class="k-icon k-i-search"></i>검색</button>
				</div>
				<div class="input-group input-group-sm col-1 middle-name" style="max-width:90px;min-width:90px;">
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
			 			                  	<c:if test="${menuAuth.printYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button" id="vReceipt" style="display: none;"><b class="btn-b"><i class="k-icon k-i-txt"></i>인수증 보기</b></a>
											</c:if>
			 			                  	<c:if test="${menuAuth.printYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button" id="vTax" style="display: none;"><b class="btn-b"><i class="k-icon k-i-txt"></i>세금계산서 보기</b></a>
											</c:if>
			 			                  	<c:if test="${menuAuth.editYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button" id="btnChangeReq"><b class="btn-b"><i class="k-icon k-i-user"></i>화주변경</b></a>
											</c:if>
			 			                  	<c:if test="${menuAuth.editYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button" id="btnFinishCalc"><b class="btn-b"><i class="k-icon k-i-edit"></i>정산마감</b></a>
											</c:if>
											<c:if test="${menuAuth.editYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button" id="btnChangeAmt"><b class="btn-b"><i class="k-icon k-i-dollar"></i>운송비 변경</b></a>
											</c:if>
											<c:if test="${menuAuth.editYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button" id="btnTranReceipt"><b class="btn-b"><i class="k-icon k-i-paste-plain-text"></i>거래명세서</b></a>
											</c:if>
											<c:if test="${menuAuth.printYn eq 'Y'}">
												<a href="#" class="k-pager-refresh k-button" onClick="goExcel();"><b class="btn-x"><i class="k-icon k-i-file-excel"></i>엑셀출력</b></a>
											</c:if>
											<c:if test="${menuAuth.writeYn eq 'Y'}">
												<a href="#" id="calcInsert" class="k-pager-refresh k-button"><b class="btn-h"><i class="k-icon k-i-plus"></i>운송비추가등록</b></a>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div style="min-width: 500px;">
							<div style="height:calc(100vh - 409px)" id="calcList"></div>
							
							<ul id="calcListContextMenu">
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
var searchCustName;
var bizName;
var calcId;
var taxData;
var errChk = false;

$("#calcListContextMenu").kendoContextMenu({
	target: "#calcList",
	filter: "tr[role='row']"
});

var contextMenu = $("#calcListContextMenu").data("kendoContextMenu");
contextMenu.bind("select", onContextMenuSelect);

$(document).ready(function(){
	$("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
	$("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true}); 
	$("#taxDate").kendoDatePicker({format:"yyyyMMdd", value : new Date(), dateInput: true});
	
	Util.setSelectBox("/contents/basic/data/compDeptList.do", "sDeptId", {custId:'${custId}', deptId: "${sessionScope.userInfo.deptId}", useYn:'Y'}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "--부서명--");
	//Util.setSelectBox("/contents/basic/data/custList.do", "modalReqList", {useYn :"Y", sellBuySctn: $("#custType").val()}, "custId", "custName", "", "선택해주세요.");
	searchModalCustName = $("#sModalCustName").data("kendoMultiColumnComboBox");
	searchModalCustName = MultiColumnComboBox.setCustName("sModal", $("#custType").val(), $("#sDeptId").val());
	searchModalCustName.bind("select", changeSearchModalCust);	
	searchModalCustName.bind("change", searchModalCustSelectTrigger);	
    
	Util.setSearchDateForm();

    Util.setCmmCode("select", "listSSido", "SIDO", "", "--항목선택--");
    Util.setCmmCode("select", "listESido", "SIDO", "", "--항목선택--");
	Util.setCmmCode("select", "sCalcTypeCode", "CALC_TYPE_CD", "", "--항목선택--");
	Util.setCmmCode("select", "sSellBuySctn", "SELL_BUY_SCTN", "", "--항목선택--");
	Util.setCmmCode("select", "sChargeType", "CHARGE_TYPE_CD", "", "--항목선택--");
	var $options = $("#sCalcTypeCode > option").clone();
	$('#calcTypeCode').append($options);
	$("#calcTypeCode option[value='0002']").remove();
	
	Util.setSelectBox("/contents/basic/data/userNameList.do", "sUserId", {deptId:$(this).val()}, "userId", "userName", "", "선택하세요");
	$("#sDeptId").on("change", function(){
		Util.setSelectBox("/contents/basic/data/userNameList.do", "sUserId", {deptId:$(this).val()}, "userId", "userName", "", "선택하세요");
	});
	
	goList();

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
	
	detailModal = $("#divCalcDetail");

	detailModal.kendoDialog({
		width: "446px",
		height: "510px",
		visible: false,
		title: "정산수정",
		closable: true,
		modal: false
	});
	
	//신규등록 modal
	calcModal = $("#divCalcInsert");
 	calcModalButton = $("#calcInsert");

	calcModalButton.click(function () {
		var grid = $("#calcList").data("kendoGrid");
		var row = grid.select();		
		var allocId = [];
		
		if(row.length != 1) {
			alert("하나의 정산내역을 선택해주세요.");
			return;
		}
		
		allocId.push(grid.dataItem(row));
		
		$.ajax({
			url: "/contents/calc/data/calcAllocIdChk.do",
			type: "POST",
			dataType: "json",
			data: {
				allocId: allocId[0].allocId
			},
			success: function(data){
				if (data.result) {
					$("#fCalcSubmitBtn").html($("#fCalcSubmitBtn").html().replace('수정', '저장'));
					$("#calcTypeCode").attr("disabled", false);
					$("#fCalcMode").val("N");
					$("#fCalc")[0].reset();
					$("#divCalcInsert").parents("div").find(".k-window-title").html("정산등록");
					calcModal.data("kendoDialog").open();
				}else{
					alert(data.msg);
				}
			}
		});
	});
	
	calcModal.kendoDialog({
		width: "446px",
		height: "350px",
		visible: false,
		title: "정산등록",
		closable: true,
		modal: false,
		close: function(){calcModalButton.fadeIn();}
	});
	
	//거래명세서 modal
	tranReceiptModal = $("#divTranReceipt");
	tranReceiptModalButton = $("#btnTranReceipt");

	tranReceiptModal.kendoDialog({
		width: "800px",
		height: "483px",
		visible: false,
		title: "거래명세서",
		closable: true,
		modal: false,
		close: function(){tranReceiptModalButton.fadeIn();}
	});
	
	//거래처 자동완성
	searchCustName = MultiColumnComboBox.setCustName("s", $("#custType").val(), $("#sDeptId").val());
	searchCustName.bind("select", changeSearchCust);
	searchCustName.bind("change", searchCustSelectTrigger);

	bizName = getSearchBiz();	

	$("#sDeptId").on("change", function(){
		setSearchForm();
	});
	
	$("#searchType").on("change", function(){
		bizName.destroy();
		bizName = getSearchBiz();
		bizName.value('');
	})
	
	$("#taxYn").on("change", function(){
		if($("#taxYn option:selected").val() == 'Y'){
			$('#tranPubForm').removeAttr('disabled'); 
			$('#tranRemarks').removeAttr('disabled'); 
			$("#fTranReceipt input[name*='Mem']").removeAttr('disabled');
			$("#itemTotalType").removeAttr('disabled');
			$("#fTranReceipt input[name*='Mem']").attr('required', 'true');
			if($("#tranMode").val() != "D"){
				$("#tranSupplierMemName").val("${sessionScope.userInfo.userName}");
				$("#tranSupplierMemTel").val("${sessionScope.userInfo.mobile}");
				$("#tranSupplierMemEmail").val("${sessionScope.userInfo.email}");
			}
		}else{
			$('#tranPubForm').attr('disabled', 'true');
			$('#tranRemarks').attr('disabled', 'true');
			$("#fTranReceipt input[name*='Mem']").attr('disabled', 'true');
			$("#itemTotalType").attr('disabled', 'true');
			$("#fTranReceipt input[name*='Mem']").removeAttr('required');
			if($("#tranMode").val() != "D"){
				$("#tranSupplierMemName").val("");
				$("#tranSupplierMemTel").val("");
				$("#tranSupplierMemEmail").val("");
			}
		}
		$("#fTranReceipt").validator('validate');
	})
	
	$("#tranBizTypeCd").on("change", function(){
		if($("#tranBizTypeCd option:selected").val() == '01'){
			$('#bizTypeCd').val("01"); 
		}else{
			$('#bizTypeCd').val("02");
		}
	})
	
	
	$("#taxDateYn").on("change", function(){
		var taxDate = $("#taxDate").data("kendoDatePicker");
		if($(this).is(":checked") == true){
			taxDate.enable(true);
		}else{
			taxDate.enable(false);			
		}
	});
	
	function preventPost(e) {
    	if (e.keyCode === 13) {
    		goList();
    	}
    }
	
	searchCustName.input.keydown(preventPost);
	bizName.input.keydown(preventPost);
});

var columns = [
	{ field: "number", title: "No", width: 50 },
	// 22.06.29 이건욱 T5 > J20 컬럼 순서 변경
	{ field: "orderId", title: "오더ID", width: 160 },
	// End
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
	{ field: "chargeType", title: "청구구분", width: 100 },
	{ field: "unpaidAmt", title: "매출액", width: 100, 
		template: function(dataItem) {
		   return Util.formatNumber(dataItem.unpaidAmt);
		},
		attributes: { 
			style: "text-align: right" 
		}
	},  
	{ field: "allocFee", title: "수수료", width: 100, 
		template: function(dataItem) {
		       return Util.formatNumber(dataItem.allocFee);
		    },
			attributes: { 
				style: "text-align: right" 
			}
		},  
	{ field: "depositAmt", title: "입금액", width: 100, 
		template: function(dataItem) {
	       return Util.formatNumber(dataItem.depositAmt);
	    },
		attributes: { 
			style: "text-align: right" 
		}
	},  
	{ field: "tranYn", title: "명세서", width: 80,
		template: "#if(tranYn == 'Y') {# #=tranDate# #} else {# N #} #"
	},
	{ field: "carSctnName", title: "차량구분", width: 90 },
	{ field: "carNum", title: "차량번호", width: 120 },
	{ field: "driverName", title: "차주명", width: 100 },
	{ field: "driverTel", title: "전화번호", width: 130,
		template: function(dataItem) {
			return Util.formatPhone(dataItem.driverTel);
		} 
	},
	{ field: "unitPriceType", title: "단가구분", width: 100 },
	{ field: "sellWeight", title: "청구중량", width: 100 },
	{ field: "goodsWeight", title: "중량", width: 100 },
	{ field: "calcTypeName", title: "정산항목", width: 100 },
	{ field: "payableAmt", title: "매입액", width: 100, 
		template: function(dataItem) {
	    	return Util.formatNumber(dataItem.payableAmt);
	    },
		attributes: { 
			style: "text-align: right" 
		}
	},  
	{ field: "withdrawalAmt", title: "지급액", width: 100, 
		template: function(dataItem) {
		   return Util.formatNumber(dataItem.withdrawalAmt);
		},
		attributes: { 
			style: "text-align: right" 
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
	{ field: "taxinvDate", title: "계산서(전/실)", width: 130},
	{ field: "custName", title: "화주(거래처)", width: 150 },
	{ title: "거래처(계산서발행지)", width: 160,
		template: function(dataItem) {
		   if(dataItem.driverId == '' || dataItem.driverId == null){
			   return (Util.nvl(dataItem.reqBizName,''));
		   }else{
			   return (Util.nvl(dataItem.driverBizName,''));
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
	{ field: "payReturnMemo", title: "지급반려사유", width: 160 },
	{ field: "allocId", hidden: true },
	{ field: "invId", hidden: true }
];

var headerTitle = ($("#headerTitle").text());
// var oGrid = null;	
// oGrid = new gridData("calcList");
// oGrid.initGrid();
// oGrid.setSendUrl("/contents/calc/data/calcList.do");
// oGrid.setSelectable("multiple");
// oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

function setSearchForm () {
	searchCustName = $("#sCustName").data("kendoMultiColumnComboBox");
	searchCustName.value("");
	searchCustName.refresh();
	searchCustName.destroy();
	$("#orderId").val("")
	$(".hiddenValue").val("");
	$("#sSubName").val("");
	var sellBuySctn = $("#custType").val();
	if(sellBuySctn == "99") {	//차량번호 선택
		searchCustName = MultiColumnComboBox.setSearchCarNum("sCustName", $("#sDeptId").val(), "");
		searchCustName.bind("select", changeSearchCarNum);
		searchCustName.bind("change", searchCarNumSelectTrigger);
		$("#searchDiv").show();
		$("#orderSearch").hide(); 
	} else if(sellBuySctn == "orderId") {
		searchCustName = $("#sCustName").kendoMultiColumnComboBox({});
		$("#searchDiv").hide();
		$("#orderSearch").show();
	} else {
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
	$("#calcList").text("");
	$("#calcList").kendoGrid({
		dataSource : {
			transport : {
				read : {
					url : "/contents/calc/data/calcList.do",
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
        selectable: 'multiple',
		sortable : true,
        resizable: true,
        editable : false,
		columns : columns,
    	noRecords: true,
    	scrollable: {
            endless: true
        },
        pageable : false,
// 		pageable : true,
	  	messages: {
			noRecords: "조회된 데이터가 없습니다."
	  	}
	});
	var grid = $("#calcList").data("kendoGrid");
	grid.bind("change", onChange);
	grid.tbody.delegate('tr', 'dblclick', function(){
		var grid = $("#calcList").data("kendoGrid");
		var row = grid.select();
		selectedData = grid.dataItem(row);
		if(selectedData.finishYn == 'N'){
			$("#detailFormCalcId").val(selectedData.calcId);
			$("#appName").val(selectedData.appName);
			$("#finishMemo").val(selectedData.finishMemo);
			$("#refContent1").val(selectedData.refContent1);
			$("#refContent2").val(selectedData.refContent2);
			$("#reportBizNum").val(Util.formatBizNum(selectedData.reportBizNum));
			$("#reportBizName").val(selectedData.reportBizName);
			detailModal.data("kendoDialog").open();
		}else if(selectedData.finishYn == 'Y'){
			alert("정산마감된 정산은 변경할 수 없습니다.");
		}else if(selectedData.calcTypeCode == '0002'){
			alert("내수운송료는 변경할 수 없습니다.");	
		}else{
			$("#calcTypeCode").val(selectedData.calcTypeCode);
			$("#memo").val(selectedData.memo);
			if(selectedData.sellBuySctn != "01"){
				$("#calcCharge").val(selectedData.payableAmt);
			}else{
				$("#calcCharge").val(selectedData.unpaidAmt);
			}
			$("#fCalcSubmitBtn").html($("#fCalcSubmitBtn").html().replace('저장', '수정'));
			$("#calcTypeCode").attr("disabled", true);
			$("#fCalcMode").val("E");
			$("#calcCharge").val(Util.formatNumberInput($("#calcCharge").val()));
			$("#divCalcInsert").parents("div").find(".k-window-title").html("정산수정");
			calcModal.data("kendoDialog").open();
		}
	});	
	getSummary();
}

function getSummary() {

	var param = $("#fSearch").serializeObject();
	
	$.ajax({
		url: "/contents/calc/data/calcSummary.do",
		type: "POST",
		dataType: "json",
		data: param,
		success: function(data){
			if(data.result == true) {
				var	groupCount = ""
				groupCount = "<i style=\"color: #3f75c1\">매출 : " + Util.nvl(Util.formatNumber(data.data.sellCnt), '0') + "건 / " + 
							Util.nvl(Util.formatNumber(data.data.unpaidAmt), '0') + "원 / " + Util.nvl(Util.formatNumber(data.data.depositAmt), '0') + "원</i> | " +
							 "<i style=\"color: #000000\">매입 " +  Util.nvl(Util.formatNumber(data.data.buyCnt), '0') + "건 / " + 
							 Util.nvl(Util.formatNumber(data.data.payableAmt), '0') + "원 / " + Util.nvl(Util.formatNumber(data.data.withdrawAmt), '0') + "원</i> ";
				$("#groupCount").html(groupCount);	
			}
			
		}
	});
	
}

function onContextMenuSelect(e) {
	var grid = $("#calcList").data("kendoGrid");
	var data = grid.dataItem(e.target);
	var row = grid.select();
	var multiSelectedData = [];
	var item = e.item.id;
	
	for(var i = 0; i < row.length; i++) {
		multiSelectedData.push(grid.dataItem(row[i]));
	}
	
	switch (item) {
	case "vCopyId" :
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

//거래처추가 modal
modal = $("#divChangeAmt");
modalButton = $("#btnChangeAmt");

modalButton.click(function() {
	//var selectedItem = chkCarrierName();
	var grid = $("#calcList").data("kendoGrid");
	var row = grid.select();
	var allocList = [];
	var selectedData = {};
	selectedData = grid.dataItem(row);

	if(row.length < 1) {
		alert("변경할 내역을 선택해주세요.");
		return;
	}
	if(selectedData.finishYn == 'Y'){
		alert("정산마감된 정산은 변경할 수 없습니다.");
		return;
	}
	
	for(var i = 0; i < row.length; i++) {
		allocList.push(grid.dataItem(row[i]).allocId);
	}
	
	modal.data("kendoDialog").open();
	/* $("#modalCarrierName").val($("#hCustName").val());
	$("#modalFromDate").text($("#fromDate").val());
	$("#modalToDate").text($("#toDate").val()); */
	$("#allocList").val(allocList);
});

modal.kendoDialog({
	width: "450px",
	height: "250px",
	visible: false,
	closable: false,
	title: "운송비 변경",
	modal: false,
	close: function(){modalButton.fadeIn();}
});

function modalClose(){
	modal.data("kendoDialog").close();
	$("#modalCarrierName").val("");
	$("#modalAllocCharge").val("");
	$("#modalFromDate").text("");
	$("#modalToDate").text("");
	$(".list-unstyled").remove();
}

function tranReceiptcalcModalClose() {
	var taxDate = $("#taxDate").data("kendoDatePicker");
	tranReceiptModal.data("kendoDialog").close();
	$("#fTranReceipt")[0].reset();
	$("input[name^='tranSupplier']").val("");
	$("input[name^='tranBuyer']").val("");
	$("#tranMode").val("");
	$("#tranCustId").val("");
	$("#tranDeptId").val("");
	$("#tranRemarks").val("");
	$("#tranRemarksDefault").val("");
	$('#tranPubForm').attr('disabled', 'true');
	$('#tranRemarks').attr('disabled', 'true');
	$('#itemTotalType').attr('disabled', 'true');
	$("#fTranReceipt input[name*='Mem']").attr('disabled', 'true');
	$("#fTranReceipt input[name*='Mem']").removeAttr('required');
	$("#orderList").val("");
	taxDate.enable(false);
}


//화주변경 modal
reqChangeModal = $("#divChangeReq");
reqChangeModalButton = $("#btnChangeReq");

reqChangeModalButton.click(function () {
	if(!$("#sDeptId").val()) {
		alert("담당부서를 선택해주세요.");
		return;
	}
	
	var grid = $("#calcList").data("kendoGrid");
	var row = grid.select();
	var allocList = [];
	var orderList = [];
	var sellBuySctnList = [];

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
		alert("매입항목은 화주를 변경할 수 없습니다.");
		return
	}

	reqChangeModal.data("kendoDialog").open();
	$("#modalAllocList").val(allocList);
	$("#modalOrderList").val(orderList);
	
	searchModalCustName.destroy();
	searchModalCustName = MultiColumnComboBox.setCustName("sModal", $("#custType").val(), $("#sDeptId").val());
	searchModalCustName.bind("select", changeSearchModalCust);
	searchModalCustName.bind("change", searchModalCustSelectTrigger);	
});

	reqChangeModal.kendoDialog({
	width: "500px",
	height: "240px",
	visible: false,
	title: "화주변경",
	closable: true,
	modal: false,
	close: function(){reqChangeModalButton.fadeIn();}
});

function reqModalClose() { 
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

function changeBizName(e){
	var dataItem = e.dataItem;	

	if (dataItem == null) {
		$(".hiddenValue").val("");
	} else {
		$("#custId").val(dataItem.custId);
		$("#deptId").val("");
		$("#sSubName").val("");
		searchCustName.value("");
		Util.setSelectBox("/contents/calc/data/deptList.do", "sSubDept", {custId : dataItem.custId, sDeptId : $("#sDeptId").val()}, "deptId", "deptName", "", "--부서명--");
	}
}
/* 
function chkCarrierName() {	
	var f = true;
	
	if($("#custType").val() != "02") {
		f = false; 
	} else {
		if( $("#sCustName").val().length == 0) f = false;
	}
	
	if(f) {
		return {
			isSelected: true,
			item: {
				carrierName: $("#sCustName").val(),
				fromDate: $("#fromDate").val(),
				toDate: $("#toDate").val()
			}
		};
	} else {
		alert("대상 운송사를 선택해 주세요.");
		return {
			isSelected: false,
			item: null
		};
	}
}
 */
$('#fChangeAmt').validator().on('submit', function (e) {	
	var param = {
		/* custId: $("#custId").val(),
		deptId: $("#deptId").val(), */
		allocList: $("#allocList").val(),
		allocCharge: $("#modalAllocCharge").val().replace(/,/g, "")
/* 		fromDate: $("#fromDate").val(),
		toDate: $("#toDate").val() */
	}; 

	if(confirm("운송비를 변경하시겠습니까?")) {
		if (e.isDefaultPrevented()) {
			alert("항목을 입력해 주세요.");
		} else {
			// 이벤트 초기화 (submit 동작 중단)
			e.preventDefault();
					
			$.ajax({
				url: "/contents/calc/data/updateCarrierAmt.do",
				type: "POST",
				dataType: "json",
				data: param,
				success: function(data){
					if (data.result) {
						alert(data.msg);
						$("#allocList").val("");
						$("#fChangeAmt")[0].reset();
						modal.data("kendoDialog").close();
						goList();
					}else {
						alert(data.msg);
					}
				}
			});
		}
	} else {
		e.preventDefault();
	}
});

$('#fChangeReq').validator().on('submit', function (e) {	
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
	
	if(confirm("화주를 변경하시겠습니까?")) {
		if (e.isDefaultPrevented()) {
			alert("항목을 입력해 주세요.");
		} else {
			// 이벤트 초기화 (submit 동작 중단)
			e.preventDefault();
			$.ajax({
				url: "/contents/calc/data/updateChangeReq.do",
				type: "POST",
				dataType: "json",
				data: param,
				success: function(data){
					if (data.result) {
						alert(data.msg);
						goList();
						reqModalClose();
					}else {
						alert(data.msg);
					}
				}
			});
		}
	}
});

$('#fTranReceipt').validator().on('submit', function (e) {
	var grid = $("#calcList").data("kendoGrid");	
	var orderList = '';
	for(var i = 0; i < grid._data.length; i++){
		if(grid._data[i].tranYn == 'N'){
			orderList += grid._data[i].orderId +"," 
		}
	}
	orderList = orderList.substring(0, orderList.length - 1);
	if($("#orderList").val() == ""){
		$("#orderList").val(orderList)
		var param = $("#fSearch, #fTranReceipt").serializeObject();
		if($("#taxYn").val() == 'Y'){
			var items = [];
			var totPrice = 0;
			var tax = 0;
			var supprice = 0;
			var gridData = $("#calcList").data("kendoGrid")._data
			if($("#sSellBuySctn").val() == '01'){
				for(var i = 0; i < gridData.length; i++){
					var item = {};
					if(gridData[i].taxinvYn == 'N'){
						item.seq = i+1;
						item.itemRemarks = gridData[i].eDate + ' (' +grid._data[i].orderId+ ')'
						item.itemPrice = (gridData[i].unpaidAmt) + (gridData[i].unpaidAmt/10)
						item.itemQty = '1'
						item.itemType = gridData[i].goodsWeight
						if(gridData[i].reqPayDate != 'Y'){item.itemName = gridData[i].calcTypeName}else{item.itemName = "(빠른지급) "+gridData[i].calcTypeName}
						item.itemDate = new moment(gridData[i].regDate).format("YYYYMMDD"),
						item.itemTax = gridData[i].unpaidAmt/10
						item.itemSupprice = gridData[i].unpaidAmt
						item.orderId = grid._data[i].orderId
						item.allocId = grid._data[i].allocId
						if($("#tranBizTypeCd").val() != '01'){item.itemTax = '0'; item.itemSupprice = gridData[i].payableAmt;}
						items.push(item);
						totPrice += item.itemPrice;
						tax += item.itemTax;
						supprice += item.itemSupprice;
					}
				}
			}else{
				for(var i = 0; i < gridData.length; i++){
					var item = {};
					if(gridData[i].taxinvYn == 'N'){
						item.seq = i+1;
						item.itemRemarks = gridData[i].eDate + ' (' +grid._data[i].orderId+ ')'
						item.itemPrice = (gridData[i].payableAmt) + (gridData[i].payableAmt/10)
						item.itemQty = '1'
						item.itemType = gridData[i].goodsWeight
						if(gridData[i].reqPayDate != 'Y'){item.itemName = gridData[i].calcTypeName}else{item.itemName = "(빠른지급) "+gridData[i].calcTypeName}
						item.itemDate = new moment(gridData[i].regDate).format("YYYYMMDD"),
						item.itemTax = gridData[i].payableAmt/10
						item.itemSupprice = gridData[i].payableAmt
						if($("#tranBizTypeCd").val() != '01'){item.itemTax = '0'; item.itemSupprice = gridData[i].payableAmt;}
						items.push(item);
						totPrice += item.itemPrice;
						tax += item.itemTax;
						supprice += item.itemSupprice;
					}
				}
			}		
		}
	}else{
		var param = $("#fSearch, #fTranReceipt").serializeObject();
		param.sellBuySctn = '01';
		if($("#taxYn").val() == 'Y'){
			var items = [];
			var totPrice = 0;
			var tax = 0;
			var supprice = 0;
			var gridData = $("#calcList").data("kendoGrid")._data
			var orderIdList = $("#orderList").val().split(',');
			for(var i = 0; i < gridData.length; i++){
				var item = {};
				if(gridData[i].taxinvYn == 'N'){
					for(var j = 0; j < orderIdList.length; j++){
						if(gridData[i].orderId == orderIdList[j] && gridData[i].sellBuySctn == "01"){
							item.seq = i+1;
							item.itemRemarks = gridData[i].eDate + ' (' +grid._data[i].orderId+ ')'
							item.itemPrice = (gridData[i].unpaidAmt) + (gridData[i].unpaidAmt/10)
							item.itemQty = '1'
							item.itemType = gridData[i].goodsWeight
							if(gridData[i].reqPayDate != 'Y'){item.itemName = gridData[i].calcTypeName}else{item.itemName = "(빠른지급) "+gridData[i].calcTypeName}
							item.itemDate = new moment(gridData[i].regDate).format("YYYYMMDD"),
							item.itemTax = gridData[i].unpaidAmt/10
							item.itemSupprice = gridData[i].unpaidAmt
							item.orderId = grid._data[i].orderId
							item.allocId = grid._data[i].allocId
							if($("#tranBizTypeCd").val() != '01'){item.itemTax = '0'; item.itemSupprice = gridData[i].payableAmt;}
							items.push(item);
							totPrice += item.itemPrice;
							tax += item.itemTax;
							supprice += item.itemSupprice;
						}
					}
				}
			}
		}
	}
	
	if(confirm("거래명세서를 발행하시겠습니까?\n이미 발행한 세금계산서, 거래명세서는 발행되지 않습니다.")) {
		if (e.isDefaultPrevented()) {		
			alert("항목을 입력해 주세요.");
			e.preventDefault();
		} else {
			// 이벤트 초기화 (submit 동작 중단)
			e.preventDefault();
			if($("#taxYn option:selected").val() == 'Y'){
				var emailRule = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i;
				if(!emailRule.test($("#tranSupplierMemEmail").val())) {
					alert("공급자 이메일이 형식에 맞지않습니다.");
					return;
				}
				if(!emailRule.test($("#tranBuyerMemEmail").val())) {
					alert("공급받는자 이메일이 형식에 맞지않습니다.");
					return;
				}
				if(param.orderList != ''){
					if(errChk == false){
						insertTranReceipt(param);
					}else{
						return;
					}
				}else{
					alert("거래명세서를 발행할 수 없습니다. \n거래명세서 미발행 정산데이터를 확인해주세요.");
					tranReceiptcalcModalClose();
					return;
				}
			}else{
				if(param.orderList != ''){
					insertTranReceipt(param);
				}else{
					alert("거래명세서를 발행할 수 없습니다. \n거래명세서 미발행 정산데이터를 확인해주세요.");
					tranReceiptcalcModalClose();
					return;
				}
			}
		}
	} 
	e.preventDefault();
});

function insertTranReceipt(param){
	$.ajax({
		url: "/contents/calc/data/regTranReceipt.do",
		type: "POST",
		dataType: "json",
		data: param,
		async: false,
		success: function(data){
			if (data.result) {
				alert(data.msg);
				tranReceiptcalcModalClose();
				goList();
			} else {
				alert(data.msg);
			}
		}
	}); 
}

function changeSearchCust(e) {
	var dataItem = e.dataItem;
	if (dataItem != null) {
		$("#custId").val(dataItem.custId);
		$("#deptId").val(dataItem.deptId);
		$("#hCustName").val(dataItem.custName);
		$("#sSubName").val(dataItem.deptName);	
		taxData = dataItem;
	}else{
		if(e.sender.selectedIndex != -1){
			searchCustName.select(e.sender.selectedIndex);
			var data = e.sender.listView._view[e.sender.selectedIndex];
			$("#custId").val(data.item.custId);
			$("#deptId").val(data.item.deptId);
			$("#hCustName").val(data.item.custName);
			$("#sSubName").val(data.item.deptName);	
			taxData = data.item;
		}
	}
}

function searchCustSelectTrigger(e) {
	if(this.value() != ""){
		searchCustName.trigger("select");
	}else{
		$("#custId").val("");
		$("#deptId").val("");
		$("#hCustName").val("");
		$("#sSubName").val("");	
		bizName.value('');
	}
}

function changeSearchModalCust(e) {
	var dataItem = e.dataItem;
	if(dataItem != null){
		$("#modalCustId").val(dataItem.custId);
		$("#modalDeptId").val(dataItem.deptId);
		$("#sModalSubName").val(dataItem.deptName);
		$("#modalManager").val(dataItem.userId);
		$("#modalBizAddr").val(dataItem.bizAddr);	
		$("#modalBizAddrDetail").val(dataItem.bizAddrDetail);	
		$("#modalMobile").val(dataItem.mobile);	
		$("#modalOrderMemo").val(dataItem.orderMemo);	
		taxData = dataItem;
	}else{
		if(e.sender.selectedIndex != -1){
			searchModalCustName.select(e.sender.selectedIndex);
			var data = e.sender.listView._view[e.sender.selectedIndex];
			$("#modalCustId").val(data.item.custId);
			$("#modalDeptId").val(data.item.deptId);
			$("#sModalSubName").val(data.item.deptName);
			$("#modalManager").val(data.item.userId);
			$("#modalBizAddr").val(data.item.bizAddr);	
			$("#modalBizAddrDetail").val(data.item.bizAddrDetail);	
			$("#modalMobile").val(data.item.mobile);	
			$("#modalOrderMemo").val(data.item.orderMemo);	
			taxData = data.item;
		}
	}
}

function searchModalCustSelectTrigger(e) {
	if(this.value() != ""){
		searchModalCustName.trigger("select");
	}else{
		$("#modalCustId").val("");
		$("#modalDeptId").val("");
		$("#sModalSubName").val("");
		$("#modalManager").val("");
		$("#modalBizAddr").val("");	
		$("#modalBizAddrDetail").val("");	
		$("#modalMobile").val("");	
		$("#modalOrderMemo").val("");
	}
}

function changeSearchCarNum(e) {
	var dataItem = e.dataItem;	
	if(dataItem != null) {
		$("#vehicId").val(dataItem.vehicId);
		$("#driverId").val(dataItem.driverId);
		$("#hCarNum").val(dataItem.carNum);
		$("#sSubName").val(dataItem.driverName);	
		taxData = dataItem;
	}else{
		if(e.sender.selectedIndex != -1){
			searchCustName.select(e.sender.selectedIndex);
			var data = e.sender.listView._view[e.sender.selectedIndex];
			$("#vehicId").val(data.item.vehicId);
			$("#driverId").val(data.item.driverId);
			$("#hCarNum").val(data.item.carNum);
			$("#sSubName").val(data.item.driverName);	
			taxData = data.item;
		}
	}
}

function searchCarNumSelectTrigger(e) {
	if(this.value() != ""){
		searchCustName.trigger("select");
	}else{
	 	bizName.value('');
		$("#vehicId").val("");
		$("#driverId").val("");
		$("#hCarNum").val("");
		$("#sSubName").val("");
	}
}

function calcModalClose() { 
	calcModal.data("kendoDialog").close();
	$("#fCalc")[0].reset();
	$(".list-unstyled").remove();
}

function calcDetailClose(){
	detailModal.data("kendoDialog").close();
	$("#calcDetailForm")[0].reset();
}

$("#calcTypeCode").on('focus', function () {
	previous = this.value;
}).change(function() { 	
	var grid = $("#calcList").data("kendoGrid");
	var row = grid.select();
	var selectedData = {};
	selectedData = grid.dataItem(row);
	
	var param = {
		orderId : selectedData.orderId,
		allocId : selectedData.allocId,
		sellBuySctn : selectedData.sellBuySctn,
		calcTypeCode : $(this).val()
	}
	
	$.ajax({
		url: "/contents/calc/data/calcCheck.do",
		type: "POST",
		dataType: "json",
		data: param,
		success: function(data){
			if (data.result) {
				if(!confirm('이미 등록되어있는 운송비 항목 입니다. \n수정 하시려면 "확인" 버튼을 클릭해주세요.')){
					$("#calcTypeCode").val(previous).prop("selected", true); //이전값으로 돌리기
					return;
				}else{
					$("#fCalcMode").val("NE")
					$("#calcCharge").val(data.data.calcCharge);
					$("#memo").val(data.data.memo);
					calcId = data.data.calcId;
					$("#calcCharge").val(Util.formatNumberInput($("#calcCharge").val()));
					$("#divCalcInsert").parents("div").find(".k-window-title").html("정산수정");
					$("#fCalcSubmitBtn").html($("#fCalcSubmitBtn").html().replace('저장', '수정'));
				}
			}else{
				$("#divCalcInsert").parents("div").find(".k-window-title").html("정산등록");
				$("#calcCharge").val("");
				$("#memo").val("");
				$("#fCalcMode").val("N");
				$("#fCalcSubmitBtn").html($("#fCalcSubmitBtn").html().replace('수정', '저장'));
			}
		}
	});
})

$('#fCalc').validator().on('submit', function (e) {	
	$("#calcCharge").val($("#calcCharge").val().replace(/,/g, ""));
	var grid = $("#calcList").data("kendoGrid");
	var row = grid.select();
	var selectedData = {};
	
	if(row.length > 1) {
		alert("하나의 정산내역만 선택해주세요.");
		return;
	}
	
	selectedData = grid.dataItem(row);
	if (e.isDefaultPrevented()) {
		alert("항목을 입력해 주세요.");
	} else {
		// 이벤트 초기화 (submit 동작 중단)
		e.preventDefault();
		if($("#fCalcMode").val() == "E"){
			var param = {
				calcId: selectedData.calcId,
				calcTypeCode : selectedData.calcTypeCode,
				calcCharge: $("#calcCharge").val(),
				memo: $("#memo").val(),
				sellBuySctn : selectedData.sellBuySctn,
				orderId : selectedData.orderId,
				allocId : selectedData.allocId,
				mode: 'E'
			}
		} else if($("#fCalcMode").val() == "N"){
			var param = {
				calcId: selectedData.calcId,
				calcTypeCode: $("#calcTypeCode").val(),
				calcCharge: $("#calcCharge").val(),
				memo: $("#memo").val(),
				orderId : selectedData.orderId,
				allocId : selectedData.allocId,
				mode: 'N'
			}
		} else if($("#fCalcMode").val() == "NE"){
			var param = {
				calcId: calcId,
				calcTypeCode: $("#calcTypeCode").val(),
				calcCharge: $("#calcCharge").val(),
				memo: $("#memo").val(),
				sellBuySctn : selectedData.sellBuySctn,
				orderId : selectedData.orderId,
				allocId : selectedData.allocId,
				mode: 'E'
			}
		}
		
		$.ajax({
			url: "/contents/calc/data/newCalcCharge.do",
			type: "POST",
			dataType: "json",
			data: param,
			success: function(data){
				if (data.result) {
					alert(data.msg);
					goList();
					calcModalClose();
				}else {
					alert(data.msg);
				}
			}
		});
	}
});	

$("#btnTranReceipt").click(function() {
	if(!$("#custId").val()) {
		if(!$("#vehicId").val()) {
			alert("거래처를 조회해주세요.");
			return;	
		}
	}
	if(!$("#sSellBuySctn").val()) {
		alert("매출입항목을 선택해주세요.");
		return;
	}
	
	/* var param = {
		custId: $("#custId").val(),
		deptId: $("#deptId").val(),
		vehicId: $("#vehicId").val(),
		driverId: $("#driverId").val(),
		fromDate: $("#fromDate").val(),
		toDate: $("#toDate").val()
	}; */
	var gridData = $("#calcList").data("kendoGrid")._data
	var sum = 0;
	if(!gridData.length != '0'){
		alert("조회된 데이터가 없습니다.");
		return;
	}
	if($("#sSellBuySctn").val() == '01'){
		for(var i = 0; i < gridData.length; i++){
			sum += gridData[i].unpaidAmt
		}
	}else{
		for(var i = 0; i < gridData.length; i++){
			sum += gridData[i].payableAmt
		}
	}

	var custId = '${sessionScope.userInfo.custId}';
	var deptId = '${sessionScope.userInfo.deptId}';
	tranBizInfoSet(custId, deptId);
	
	tranReceiptModal.data("kendoDialog").open();
});

function tranBizInfoSet(custId, deptId){
	$("#tranMode").val("R");
	$.ajax({
		url: "/contents/basic/data/compList.do",	
		type: "POST",
		dataType: "json",
		data: {
			useYn: "Y",
			custId : custId,
			deptId : deptId
		},
		success: function(data){
			if(data.result) {
				//세금계산서 데이터 세팅
				if($("#sSellBuySctn").val() != '01'){
					var gbn = 'Supplier';
					var gbn2 = 'Buyer';
				}else{
					var gbn = 'Buyer';
					var gbn2 = 'Supplier';
				}
				if($("#orderList").val() != ''){
					var gbn = 'Buyer';
					var gbn2 = 'Supplier';
				}
				
				$("#tran"+gbn2+"CustId").val(data.data.custId)
				$("#tran"+gbn2+"DeptId").val(data.data.deptId)
				$("#tran"+gbn2+"BizName").val(data.data.bizName)
				$("#tran"+gbn2+"BizNo").val(data.data.bizNum)
				$("#tran"+gbn2+"BizSubNo").val(data.data.bizNumSub)
				$("#tran"+gbn2+"Ceo").val(data.data.ceo)
				$("#tran"+gbn2+"Addr").val(data.data.bizAddr)
				$("#tran"+gbn2+"BizType").val(data.data.bizCond)
				$("#tran"+gbn2+"BizClass").val(data.data.bizKind)
				$("#tran"+gbn+"CustId").val(taxData.custId)
				$("#tran"+gbn+"DeptId").val(taxData.deptId)
				$("#tran"+gbn+"BizName").val(taxData.custName)
				$("#tran"+gbn+"BizNo").val(taxData.bizNum)
				$("#tran"+gbn+"BizSubNo").val(taxData.bizNumSub)
				$("#tran"+gbn+"Ceo").val(taxData.ceo)
				$("#tran"+gbn+"Addr").val(taxData.bizAddr)
				$("#tran"+gbn+"BizType").val(taxData.bizCond)
				$("#tran"+gbn+"BizClass").val(taxData.bizKind)
				$("#tran"+gbn+"MemName").val(taxData.taxStaffName)
				$("#tran"+gbn+"MemTel").val(Util.formatPhone(taxData.taxTelNum))
				$("#tran"+gbn+"MemEmail").val(taxData.taxEmail)
				$("#tran"+gbn+"PostalPost").val(taxData.postalPost)
				$("#tran"+gbn+"PostalAddr").val(taxData.postalAddr)
				$("#tran"+gbn+"PostalAddrDetail").val(taxData.postalAddrDetail)
				tranRemarksDefaultSet($("#tranSupplierBizNo").val())
			}
		}
	});
}

function tranBizInfoSetForDrivers(carNum, custId, deptId){
	$("#tranMode").val("D");
	$.ajax({
		url: "/contents/basic/data/carList.do",	
		type: "POST",
		dataType: "json",
		data: {
			useYn: "Y",
			carNum : carNum,
		},
		success: function(data){
			if(data.result) {
				//공급자를 차주로 세팅
// 				$("#tranSupplierCustId").val(data.data[0].custId);
// 				$("#tranSupplierDeptId").val(data.data[0].deptId);
				$("#tranSupplierVehicId").val(data.data[0].vehicId);
				$("#tranSupplierDriverId").val(data.data[0].driverId);
				$("#tranSupplierBizName").val(data.data[0].bizName);
				$("#tranSupplierBizNo").val(data.data[0].bizNum);
				$("#tranSupplierBizSubNo").val(data.data[0].subBizNum);
				$("#tranSupplierCeo").val(data.data[0].ceo);
				$("#tranSupplierAddr").val(data.data[0].bizAddr);
				$("#tranSupplierBizType").val(data.data[0].bizCond);
				$("#tranSupplierBizClass").val(data.data[0].bizKind);
				$("#tranSupplierMemName").val(data.data[0].driverName);
				$("#tranSupplierMemTel").val(data.data[0].mobile);
				$("#tranSupplierMemEmail").val(data.data[0].driverEmail);
				

				if(data.data[0].bankName != '' && data.data[0].bankAccount != '' && data.data[0].bankCnnm != '' && data.data[0].bizName != ''){
	 				$("#tranRemarksDefault").val(data.data[0].bankName+' '+data.data[0].bankAccount+' '+data.data[0].bankCnnm+' '+data.data[0].bizName);
				}else{
					$("#tranRemarksDefault").val('');
				}
			}
		}
	});
	
	$.ajax({
		url: "/contents/basic/data/compList.do",	
		type: "POST",
		dataType: "json",
		data: {
			useYn: "Y",
			custId : custId,
			deptId : deptId
		},
		success: function(data){
			if(data.result) {
				//공급받는자를 거래처로 세팅
				$("#tranBuyerCustId").val(taxData.custId)
				$("#tranBuyerDeptId").val(taxData.deptId)
				$("#tranBuyerBizName").val(taxData.custName)
				$("#tranBuyerBizNo").val(taxData.bizNum)
				$("#tranBuyerBizSubNo").val(taxData.bizNumSub)
				$("#tranBuyerCeo").val(taxData.ceo)
				$("#tranBuyerAddr").val(taxData.bizAddr)
				$("#tranBuyerBizType").val(taxData.bizCond)
				$("#tranBuyerBizClass").val(taxData.bizKind)
				$("#tranBuyerMemName").val(taxData.taxStaffName)
				$("#tranBuyerMemTel").val(Util.formatPhone(taxData.taxTelNum))
				$("#tranBuyerMemEmail").val(taxData.taxEmail)
				$("#tranBuyerPostalPost").val(taxData.postalPost)
				$("#tranBuyerPostalAddr").val(taxData.postalAddr)
				$("#tranBuyerPostalAddrDetail").val(taxData.postalAddrDetail)
			}
		}
	});
}

function tranRemarksDefaultSet(bizNum){
	$.ajax({
		url: "/contents/basic/data/getCustInfo.do",	
		type: "POST",
		dataType: "json",
		data: {
			bizNum : bizNum
		},
		success: function(data){
			if(data.result) {
				var bankName = Util.nvl(data.data[0].bankName, '');
				var	bankAccount = Util.nvl(data.data[0].bankAccount, '');
				var bankCnnm = Util.nvl(data.data[0].bankCnnm, '');
				var bizName = Util.nvl(data.data[0].bizName, '');
				if(bankName != '' && bankAccount != '' && bankCnnm != '' && bizName != ''){
					$("#tranRemarksDefault").val(bankName+' '+bankAccount+' '+bankCnnm+' '+bizName);
				}else{
					$("#tranRemarksDefault").val('');
				}
			}
		}
	});
}

$("#btnFinishCalc").click(function() {
	if(!$("#custId").val() && !$("#vehicId").val()) {
		alert("거래처나 차량을 조회해주세요.");
		return;
	}
	//매입일 경우에 운송비지급 관련 프로세스가 처리됨.
 	if(!$("#sSellBuySctn").val()) {
 		alert("매출입항목을 선택하여 조회해주세요.");
 		return;
 	}
	
	if(confirm("마감처리를 하시겠습니까?")) {
		var param = $("#fSearch").serializeObject();
		$.ajax({
			url: "/contents/calc/data/custFinishCalc.do",
			type: "POST",
			dataType: "json",
			data: param,
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

function deleteClac(datas){
	var calcTypeCodeArr = [];
	var calcIdArr = [];
	var allocIdArr = [];
	var calcTypeCodeArr = [];
	
	for(var i = 0; i < datas.length; i++) {
		allocIdArr.push(datas[i].allocId);
		calcTypeCodeArr.push(datas[i].calcTypeCode);
		calcIdArr.push(datas[i].calcId);
	}
	
	function codeCheck(calcTypeCodeArr){
		if(calcTypeCodeArr === '0002'){
			return true;
		}
	}
	
 	if(confirm("정산을 삭제하시겠습니까?")) {

		if(calcTypeCodeArr.find(codeCheck) == '0002'){
			alert("내수운송료는 삭제할 수 없습니다.")
		}else {		
			$.ajax({
				url: "/contents/calc/data/multiDeleteCalc.do",
				type: "POST",
				dataType: "json",
				data: {
					calcIdArr: calcIdArr.toString(),
					allocIdArr: allocIdArr.toString(),
					calcTypeCodeArr: calcTypeCodeArr.toString()
				},
				success: function(data){
					if (data.result) {
						alert(data.msg);
						goList();
						contextMenu.close();
					}else {
						alert(data.msg);
					}
				}
			}); 
		}
	} 
}

function multiFinishCalc(datas, mode) {
	var calcIdArr = [];
	var txt = "마감처리를 하시겠습니까?";
	if (mode == "N") txt = "마감을 취소하겠습니까?";
	
	if(confirm(txt)) {

		for(var i = 0; i < datas.length; i++) {
			calcIdArr.push(datas[i].calcId);
			if(mode == "Y" && datas[i].finishYn == "Y"){
				alert("이미 마감 처리된 정산이 포함되어 있습니다.");
				return;
			}
		}
		
		$.ajax({
			url: "/contents/calc/data/multiFinishCalc.do",
			type: "POST",
			dataType: "json",
			data: {
				calcIdArr: calcIdArr.toString(),
				mode : mode
			},
			success: function(data){
				if (data.result) {
					alert(data.msg);
					goList();
					contextMenu.close();
				}else {
					alert(data.msg);
				}
			}
		});
	}
}

function multPaperReceipt(datas, mode) {
	var orderIdArr = [];
	for(var i = 0; i < datas.length; i++) {
		orderIdArr.push(datas[i].orderId);
	}
	
	$.ajax({
		url: "/contents/calc/data/multPaperReceipt.do",
		type: "POST",
		dataType: "json",
		data: {
			orderIdArr: orderIdArr.toString(),
			mode : mode
		},
		success: function(data){
			if (data.result) {
				alert(data.msg);
				goList();
				contextMenu.close();
			}else {
				alert(data.msg);
			}
		}
	});
}

function multPaperTax(datas, mode) {
	var calcIdArr = [];
	
	for(var i = 0; i < datas.length; i++) {
		calcIdArr.push(datas[i].calcId);
		if(mode == "Y"){
			if(datas[i].taxinvYn != 'N'){
				alert("세금계산서가 존재합니다.");
				return
			}	
		}else{
			if(datas[i].taxinvYn == 'N'){
				alert("세금계산서가 존재하지 않습니다.");
				return
			}else if(datas[i].taxinvYn == 'Y'){
				alert("세금계산서가 존재합니다.");
				return
			}
		}
	}
	$.ajax({
		url: "/contents/calc/data/multPaperTax.do",
		type: "POST",
		dataType: "json",
		data: {
			calcIdArr: calcIdArr.toString(),
			mode : mode
		},
		success: function(data){
			if (data.result) {
				alert(data.msg);
				goList();
				contextMenu.close();
			}else {
				alert(data.msg);
			}
		}
	});
}

//excel download
function goExcel(){
	$("#loading").show();
	var grid = $("#calcList").data("kendoGrid");
	grid.saveAsExcel();
}

function fReset(){
	$("#fSearch")[0].reset();
	$(".hiddenValue").val("");
	$("#vTax").hide();
	$("#vReceipt").hide();
}

function copyOrderId(orderId){
	var grid = $("#calcList").data("kendoGrid");
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

function copyToClipboard(html) {
    var textarea = document.createElement('textarea');
    $(textarea).addClass('k-spreadsheet-clipboard').val(html).appendTo(document.body).focus().select();
    document.execCommand('copy');
    $(textarea).remove();
}

function detailCalcUpdate(){
	$("#reportBizNum").val($("#reportBizNum").val().replace(/\-/g, ''));
	$.ajax({
		url: "/contents/calc/data/detailCalcUpdate.do",
		type: "POST",
		dataType: "json",
		data: $("#calcDetailForm").serialize(),	
		success: function(data){
			if (data.result) {
				alert(data.msg);
				goList();
				calcDetailClose();
			}else {
				alert(data.msg);
			}
		}
	});
}

function tranModalShow(orderList, allocList){
	$.ajax({
		url: "/contents/order/data/serchCustDeptInfo.do",
		type: "POST",
		dataType: "json",
		data: {
			orderList: orderList.toString(),
			allocList: allocList.toString()
		},
		success: function(data){
			if(data.result) {
				var custList = [];
				var deptList = [];
				var chargeTypeList = [];
				var uniqueCustId = [];
				var uniqueDeptId = [];
				var uniqueChargeType = [];
				for(var i = 0; i<data.data.length; i++){
					custList.push(data.data[i].custId);
					deptList.push(data.data[i].deptId);
					chargeTypeList.push(data.data[i].chargeType);
				}
				$.each(custList,function(i,value){
				    if(uniqueCustId.indexOf(value) == -1 ) 
				    	uniqueCustId.push(value);
				});
				$.each(deptList,function(i,value){
				    if(uniqueDeptId.indexOf(value) == -1 ) 
				    	uniqueDeptId.push(value);
				});
				$.each(chargeTypeList,function(i,value){
				    if(uniqueChargeType.indexOf(value) == -1 )
				    	uniqueChargeType.push(value);
				});
				
				if(uniqueCustId.length != 1 || uniqueDeptId.length != 1){
					alert("동일한 거래처의 정산만 선택해 주세요.");
					return
				}

				$("#fTranReceipt")[0].reset();
				$("input[name^='tranSupplier']").val("");
				$("input[name^='tranBuyer']").val("");
				$("#tranMode").val("");
				$("#tranCustId").val("");
				$("#tranDeptId").val("");
				$("#tranRemarks").val("");
				$("#tranRemarksDefault").val("");

				var grid = $("#calcList").data("kendoGrid");
				var row = grid.select();
				var data = grid.dataItem(row);
				searchCustName.select(function(dataItem) {
					$("#tranCustId").val(dataItem.custId);
					$("#tranDeptId").val(dataItem.deptId);
// 					$("#hCustName").val(dataItem.custName);
// 					$("#sSubName").val(dataItem.deptName);	
					taxData = dataItem;
				    return dataItem.deptId === uniqueDeptId.toString();
				});
				
				if($("#custId").val() == "" && $("#deptId").val() == ""){
					searchCustName.value("");
				}
				
				if(uniqueChargeType.indexOf('03') != -1){
					if(uniqueChargeType.length != 1){
						alert("기사발행한 정산은 별도로 처리해 주세요.");
						return
					}
					if(row.length != 1) {
						alert("하나의 정산내역을 선택해주세요.");
						return;
					}else{
						tranBizInfoSetForDrivers(data.carNum, data.custId, data.deptId);
					}
				}else{
					tranBizInfoSet('${sessionScope.userInfo.custId}', '${sessionScope.userInfo.deptId}');
				}
				
				var selectClacOrderId = [];
				
				for(var i = 0; i < row.length; i++) {
					selectClacOrderId.push(grid.dataItem(row[i]).orderId);
				}
				
				$("#orderList").val(selectClacOrderId);
				tranReceiptModal.data("kendoDialog").open();
				
			}
		}
	});	
}

function onChange(e){
	var grid = $("#calcList").data("kendoGrid");
	var data = grid.dataItem(e.target);
	var row = grid.select();
	var multiSelectedData = [];
	
	for(var i = 0; i < row.length; i++) {
		multiSelectedData.push(grid.dataItem(row[i]));
	}
	
	if(multiSelectedData.length != '1'){
		/* 인수증, 세금계산서 버튼 숨기기 */
		$("#vTax").hide();
		$("#vReceipt").hide();
	}else{
		/* 인수증, 세금계산서 버튼 표시 */
		$("#vTax").show();
		$("#vReceipt").show();
	}
}

$('#vTax, #vReceipt').click(function(){
	var grid = $("#calcList").data("kendoGrid");
	var row = grid.select();
	var data = grid.dataItem(row);
	if(this.id == 'vTax'){
 		viewTax(data.invId, data.taxinvYn, data.orderId, data.allocId);
	}else{
	 	viewReceipt(data.receiptYn, data.orderId);
	}
	
});

$("#calcCharge, #modalAllocCharge").on("input", function(){
	$(this).val(Util.formatNumberInput($(this).val()));
});


$("#tranSupplierMemTel, #tranBuyerMemTel").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});

$("#reportBizNum").on("input", function(){
	$(this).val(Util.formatBizNum($(this).val()));
});
</script>