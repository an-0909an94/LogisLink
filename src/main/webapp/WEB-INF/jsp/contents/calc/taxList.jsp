<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	#taxList .k-grid-content {max-height:calc(100vh - 260px)}

	.etax {color:#0065bd !important;} 
</style>

<div id="divTaxResend" class="editor-warp p-0">
	<div class="enter_form" style="padding-left: 1.875em;padding-right: 1.875em;">
		<form id="fResend" name="fResend" method="post">
			<input type="hidden" name="rInvId" id="rInvId" class="hiddenValue">
			<div class="form-group row gray_box">
				<label class="col-form-label big-name" style="padding-left:10px">대상</label>
				<div class="input-group input-group-sm col radio-or-checkBox">
					<input type="radio" name="sendSignal" id="forSupplier" value="SUPSENDMAIL">
					<label for="forSupplier" class="label-margin">
						<span>공급자</span>
					</label>
				</div>
				<div class="input-group input-group-sm col radio-or-checkBox">
					<input type="radio" name="sendSignal" id="forBuyer" value="SENDMAIL" checked>
					<label for="forBuyer" class="label-margin">
						<span>공급받는자</span>
					</label>
				</div>
			</div>
			<div class="form-group row gray_box">
				<label class="col-form-label big-name" style="padding-left:10px">이메일</label>
				<div class="input-group input-group-sm col middle-name form-group">
					<input id="resendEmail" name="resendEmail" class="form-control form-control-sm wd240"
						   type="text">
				</div>
			</div>
			<div class="padding" style="text-align: center;">
				<a style="height: 30px;" href="javascript:taxResend();"
				   class="k-button btn_b">재전송</a>
				<a style="height: 30px;" href="javascript:taxResendModalClose();"
				   class="k-button btn_black">닫기</a>
			</div>
		</form>
	</div>
</div>

<div id="divTaxCancel" class="editor-warp p-0">
   	<div class="enter_form" style="padding-left: 1.875em;padding-right: 1.875em;">
       	<div class="form-group row gray_box" style="padding-left:10px">
        	<label class="col-form-label big-name">상태변경사유</label>
        	<div class="input-group input-group-sm col middle-name form-group">
	            <input id="statusReason" name="statusReason" class="form-control form-control-sm wd240" type="text">
            </div>
        </div>
      	<div class="padding" style="text-align: center;">
         	<a style="height: 30px;" id="btnChgStatus" class="k-button btn-r">확인</a>
            <a style="height: 30px;" href="javascript:taxCancelModalClose();" class="k-button btn-s">닫기</a>
        </div>
    </div>
</div>

<div id="divTaxInvoice" class="editor-warp p-0">
	<form class="modalEditor" id="fTaxInvoice" data-toggle="validator" role="form"
		  autocomplete="off">
		<input type="hidden" name="supplierCustId" id="supplierCustId" class="hiddenValue">
		<input type="hidden" name="supplierDeptId" id="supplierDeptId" class="hiddenValue">
		<input type="hidden" name="supplierBizName" id="supplierBizName" class="hiddenValue">
		<input type="hidden" name="buyerCustId" id="buyerCustId" class="hiddenValue">
		<input type="hidden" name="buyerDeptId" id="buyerDeptId" class="hiddenValue">
		<input type="hidden" name="buyerBizName" id="buyerBizName" class="hiddenValue">
		<input type="hidden" name="docType" id="docType" class="hiddenValue">
		<input type="hidden" name="invId" id="invId" class="hiddenValue">
		<div class="enter_form" style="padding: 1.875em;">
			<!-- 공급자/공급받는자 정보 -->
			<div id="bizTypeDiv" class="form-group row gray_box" style="width: 48%">
				<label class="col-form-label big-name">과세형태</label>
				<div class="input-group input-group-sm col radio-or-checkBox">
					<input value="01" id="bizTypeCd01" name="bizTypeCd" type="radio" checked>
					<label for="bizTypeCd01" class="label-margin">
						<span>일반과세</span>
					</label>
				</div>
				<div class="input-group input-group-sm col radio-or-checkBox">
					<input value="02" id="bizTypeCd02" name="bizTypeCd" type="radio">
					<label for="bizTypeCd02" class="label-margin">
						<span>간이과세</span>
					</label>
				</div>
			</div>

			<div style="display: inline-block; width: 100%" class="pb30">
				<div style="width: 49%; float: left;padding-right:10px">
					<div id="supplierBizTypeDiv" class="form-group row gray_box">
						<label class="col-form-label big-name">구분</label>
						<div class="input-group input-group-sm wd90 radio-or-checkBox">
							<input value="01" id="supplierBizTypeCd01" name="supplierBizTypeCd"
								   type="radio" checked>
							<label for="supplierBizTypeCd01" class="label-margin">
								<span>거래처</span>
							</label>
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox">
							<input value="02" id="supplierBizTypeCd02" name="supplierBizTypeCd"
								   type="radio">
							<label for="supplierBizTypeCd02" class="label-margin">
								<span>차량</span>
							</label>
						</div>
						<div class="input-group input-group-sm wd90 radio-or-checkBox">
							<input value="03" id="supplierBizTypeCd03" name="supplierBizTypeCd"
								   type="radio">
							<label for="supplierBizTypeCd03" class="label-margin">
								<span>본사</span>
							</label>
						</div>
					</div>

					<div class="gray_box">
						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name">공급자</label>
							<div class="input-group input-group-sm col middle-name form-group">
								<strong class="required">사업자명</strong>
								<input class="wd415" id="supplierList" name="supplierList"
									   type="text" style="width:100%;" required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
						</div>

						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm col middle-name form-group">
								<strong class="required">사업자번호</strong>
								<input type="text" name="supplierBizNo" id="supplierBizNo"
									   class="form-control form-control-sm wd200" readonly required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
							<div class="input-group input-group-sm col middle-name form-group">
								<strong>종사업장번호</strong>
								<input type="text" name="supplierBizSubNo" id="supplierBizSubNo"
									   class="form-control form-control-sm wd200" readonly>
							</div>
						</div>

						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm col middle-name form-group">
								<strong class="required">대표자</strong>
								<input type="text" name="supplierCeo" id="supplierCeo"
									   class="form-control form-control-sm wd200" readonly required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
						</div>

						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm col middle-name form-group">
								<strong class="required">사업장주소</strong>
								<input id="supplierAddr" name="supplierAddr" type="text"
									   class="form-control form-control-sm wd415" readonly required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
						</div>

						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm col middle-name form-group">
								<strong>업태</strong>
								<input type="text" name="supplierBizType" id="supplierBizType"
									   class="form-control form-control-sm wd200" readonly>
							</div>
							<div class="input-group input-group-sm col middle-name form-group">
								<strong>업종</strong>
								<input type="text" name="supplierBizClass" id="supplierBizClass"
									   class="form-control form-control-sm wd200" readonly>
							</div>
						</div>

						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm col middle-name form-group">
								<strong class="required">담당자</strong>
								<input type="text" name="supplierMemName" id="supplierMemName"
									   class="form-control form-control-sm wd200" required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
							<div class="input-group input-group-sm col middle-name form-group">
								<strong class="required">연락처</strong>
								<input type="text" name="supplierMemTel" id="supplierMemTel"
									   class="form-control form-control-sm wd200 maxlength=" 13"
								required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
						</div>

						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm col middle-name form-group">
								<strong class="required">이메일</strong>
								<input type="text" name="supplierMemEmail" id="supplierMemEmail"
									   class="form-control form-control-sm wd415" required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
						</div>
					</div>


				</div>
				<div style="width: 49%; float: right;">
					<div id="buyerBizTypeDiv" class="form-group row gray_box">
						<label class="col-form-label big-name">구분</label>
						<div class="input-group input-group-sm col radio-or-checkBox">
							<input value="01" id="buyerBizTypeCd01" name="buyerBizTypeCd"
								   type="radio" checked>
							<label for="buyerBizTypeCd01" class="label-margin">
								<span>거래처</span>
							</label>
						</div>
						<div class="input-group input-group-sm col radio-or-checkBox">
							<input value="02" id="buyerBizTypeCd02" name="buyerBizTypeCd"
								   type="radio">
							<label for="buyerBizTypeCd02" class="label-margin">
								<span>차량</span>
							</label>
						</div>
						<div class="input-group input-group-sm col radio-or-checkBox">
							<input value="03" id="buyerBizTypeCd03" name="buyerBizTypeCd"
								   type="radio">
							<label for="buyerBizTypeCd03" class="label-margin">
								<span>본사</span>
							</label>
						</div>
					</div>

					<div class="gray_box">
						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name">공급받는자</label>
							<div class="input-group input-group-sm wd415 middle-name form-group">
								<strong class="required">사업자명</strong>
								<input class="wd415" id="buyerList" name="buyerList" type="text"
									   style="width:100%;" required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
						</div>

						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm wd210 middle-name form-group">
								<strong class="required">사업자번호</strong>
								<input type="text" name="buyerBizNo" id="buyerBizNo"
									   class="form-control form-control-sm wd200" readonly required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
							<div class="input-group input-group-sm wd210 middle-name form-group">
								<strong>종사업장번호</strong>
								<input type="text" name="buyerBizSubNo" id="buyerBizSubNo"
									   class="form-control form-control-sm wd200" readonly>
							</div>
						</div>

						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm wd210 middle-name form-group">
								<strong class="required">대표자</strong>
								<input type="text" name="buyerCeo" id="buyerCeo"
									   class="form-control form-control-sm wd200" readonly required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
						</div>

						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm wd210 middle-name form-group">
								<strong class="required">사업장주소</strong>
								<input id="buyerAddr" name="buyerAddr" type="text"
									   class="form-control form-control-sm wd415" readonly required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
						</div>

						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm wd210 middle-name form-group">
								<strong>업태</strong>
								<input type="text" name="buyerBizType" id="buyerBizType"
									   class="form-control form-control-sm wd200" readonly>
							</div>
							<div class="input-group input-group-sm wd210 middle-name form-group">
								<strong>업종</strong>
								<input type="text" name="buyerBizClass" id="buyerBizClass"
									   class="form-control form-control-sm wd200" readonly>
							</div>
						</div>

						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm wd210 middle-name form-group">
								<strong class="required">담당자</strong>
								<input type="text" name="buyerMemName" id="buyerMemName"
									   class="form-control form-control-sm wd200" required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
							<div class="input-group input-group-sm wd210 middle-name form-group">
								<strong class="required">연락처</strong>
								<input type="text" name="buyerMemTel" id="buyerMemTel"
									   class="form-control form-control-sm wd200" maxlength="13"
									   required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
						</div>

						<div style="height: 50px;" class="form-group row">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm wd415 middle-name form-group">
								<strong class="required">이메일</strong>
								<input type="text" name="buyerMemEmail" id="buyerMemEmail"
									   class="form-control form-control-sm wd200" required>
								<div style="float: right;" class="help-block with-errors"></div>
							</div>
						</div>
					</div>
				</div>
				<div id="brokerInfoDiv" style="width: 100%" class="form-group row hd100 gray_box">
					<label class="col-form-label big-name">수탁자</label>
					<div class="input-group input-group-sm col middle-name form-group">
						<textarea name="brokerInfo" id="brokerInfo"
								  class="form-control textarea wd1000" style="height: 100%"
								  readonly="readonly" rows="3"></textarea>
					</div>
				</div>
			</div>

			<!-- 기타 정보 -->
			<div class="col" id="inGridDiv">
				<table class="form_table" style="width:100%; border-collapse: separate">
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
						<td><input type="text" class="col btn_gra_tax" style='text-align:right'
								   id="writeDate" name="writeDate" onkeypress='numberOnly();'
								   maxlength="8"></td>
						<td><input type="text" class="col btn_gra_tax" style='text-align:right'
								   placeholder="0" id="supprice" name="supprice" value="0" readonly
								   style="text-align:right;"></td>
						<td><input type="text" class="col btn_gra_tax" style='text-align:right'
								   placeholder="0" id="tax" name="tax" value="0" readonly
								   style="text-align:right;"></td>
						<td><input type="text" class="col btn_gra_tax" style='text-align:right'
								   placeholder="0" id="totPrice" name="totPrice" value="0" readonly
								   style="text-align:right;"></td>
						<td><input type="text" class="col btn_gra_tax" style='text-align:right'
								   id="remarks" name="remarks"></td>
						<td>
							<div class="form-check-inline btn_gra_tax"
								 style="border-radius: 5px;width: 100%;height:80%">
								<div class="input-group input-group-sm col radio-or-checkBox">
									<input value="01" id="pubForm01" name="pubForm" type="radio"
										   checked>
									<label for="pubForm01" class="label-margin" style="padding-bottom: 0px">
										<span>영수</span>
									</label>
								</div>
								<div class="input-group input-group-sm col radio-or-checkBox" >
									<input value="02" id="pubForm02" name="pubForm" type="radio">
									<label for="pubForm02" class="label-margin" style="padding-bottom: 0px">
										<span>청구</span>
									</label>
								</div>
								<!-- <input type="radio" name="pubForm" value="01"><label>영수</label>
                                <input type="radio" name="pubForm" value="02" checked><label>청구</label> -->
							</div>
						</td>
					</tr>
				</table>
				<div>
					<table class="form_table" style="width:100%; border-collapse: separate"
						   id="taxDtlTbl">
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
			</div><!-- /기타 정보 -->
			<div class="d-flex justify-content-end py-1 mb-3">
				<div class="btn_wrap ml-1">
					<div class="padding" id="btnSave">
						<button style="height: 30px;" class="k-button btn_b" type="submit"
								onclick="readonlyValidator();">발행
						</button>
						<button style="height: 30px;" class="k-button btn_b" type="button"
								onClick="addInGrid();">항목추가
						</button>
						<button style="height: 30px;" class="k-button btn_black" type="button"
								onClick="removeInGrid();">항목삭제
						</button>
					</div>

					<div class="padding" id="btnPrint" style="display:none;">
						<button type="button" class="k-pager-refresh k-button" id="btnTaxResend">
							<strong><b class="btn-b">재전송</b></strong></button>
						<button type="button" class="k-pager-refresh k-button" id="btnTaxCancel"
								onClick="viewTaxStatusModal('CANCELALL', '발행취소')"><strong><b
								class="btn-r">발행취소</b></strong>
						</button>
						<button type="button" class="k-pager-refresh k-button" id="btnTaxAccept"
								onClick="taxStatus('APPROVE', '수신승인')"><strong><b class="btn-x"><i
								class="k-icon k-i-check-outline"></i>수신승인</b></strong></button>
						<button type="button" class="k-pager-refresh k-button" id="btnTaxReject"
								onClick="viewTaxStatusModal('REJECT', '수신거부')"><strong><b
								class="btn-x"><i
								class="k-icon k-i-cancel-outline"></i>수신거부</b></strong></button>
						<button type="button" class="k-pager-refresh k-button" onClick="goPdf();">
							<strong><b class="btn-b">출력</b></strong></button>
						<button type="submit" class="k-pager-refresh k-button"><strong><b
								class="btn-b">수정</b></strong>
						</button>
					</div>
				</div>
			</div>
			<div class="cont_table" id="inGrid">
				<!--grid area-->
			</div>
		</div>
	</form>
</div>

<div class="header">	
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">세금계산서</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" name="fSearch" method="post" class="date-bnt">
				<!-- 검색 1 라인 -->
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
						<input type="radio" name="dateChk" id="today" value="0" checked/>
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
					<div class="input-group input-group-sm wd90 radio-or-checkBox">
						<input type="radio" name="dateChk" id="monthly" value="30"/>
						<label for="monthly" class="label-margin">
							<span>30일</span>
						</label>
					</div>

					<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
						<select class="custom-select wd90" id="pubType" name="pubType">
							<option value="S" selected>매출</option>
							<option value="R">매입</option>
						</select>
					</div>

					<div class="input-group input-group-sm wd100 middle-name div-min-col-1">
						<select class="custom-select wd100" id="sLoadStatus" name="sLoadStatus">
							<option value="" selected>전자발행여부</option>
							<option value="0">일반</option>
							<option value="1">전자</option>
						</select>
					</div>

					<div class="input-group input-group-sm wd90 middle-name div-min-col-1"
						 style="min-width: 100px; max-width: 100px">
						<input type="text" id="s_issueId" name="s_issueId"
							   class="form-control form-control-sm wd100" placeholder="승인번호">
					</div>

					<div class="input-group input-group-sm wd90 middle-name div-min-col-1"
						 style="min-width: 100px; max-width: 100px">
						<input type="text" id="s_mngCarNum" name="s_mngCarNum"
							   class="form-control form-control-sm wd100" placeholder="차량번호">
					</div>
				</div>
				<!-- 검색 2 라인 -->
				<!-- 22.06.22 이건욱 T11 > J40 추가 -->
				<div class="form-group row" style="justify-content: space-between">
					<div class="row">
						<div class="input-group input-group-sm wd190 media190 middle-name div-min-col-1">
							<input type="text" id="supplierName" name="supplierName"
								   style="width:100%;" placeholder="공급자" class="p-input">
						</div>
						<div class="input-group input-group-sm wd190 media190 middle-name div-min-col-1">
							<input type="text" id="buyerName" name="buyerName" style="width:100%;" placeholder="공급받는자" class="p-input">
						</div>
						<div class="input-group input-group-sm wd200 media190 middle-name div-min-col-1">
							<input type="text" id="regCustName" name="regCustName" style="width:100%;" placeholder="발행업체" class="p-input">
						</div>
						<div class="input-group input-group-sm wd210 media190 middle-name div-min-col-1">
							<select class="form-control custom-select wd210 media190" id="regName"
									name="regName"></select>
						</div>
					</div>
					<div class="row">
						<div class="input-group-sm middle-name mr10">
							<button onclick="goList()" type="button" class="form-control-sm btn_58 btn_b">검색</button>
						</div>
					</div>
					<!-- <div style="padding: 1em;" class="input-group input-group-sm col-1"></div> -->
				</div>
			<!-- End -->
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
											<a href="#" class="k-pager-refresh k-button wd100" id="btnTaxDelete" style="display: none;"><b class="btn-r">삭제</b></a>
											<a href="#" class="k-pager-refresh k-button wd100" id="btnTaxInvoice"><b class="btn-b">세금계산서</b></a>
											<a href="#" class="k-pager-refresh k-button wd100" id="btnLoadStatus"><b class="btn-b">전자발행</b></a>
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div style="min-width: 500px;">
							<div style="height:calc(100vh - 260px)" id="taxList"></div>
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
<iframe id="iframe" src="/cmm/taxPrint.do" style="display:none;width:100px;height:100px;"></iframe>

<script type="text/javascript">
var supplierBizList;
var buyerBizList;
var itemTaxList = new Array();

$(document).ready(function() {
 	$("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
	$("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true}); 
	Util.setSearchDateForm();

	$(window).bind("resize", function() {
		$("#taxList").css("height", "calc(100vh - 250px)");

		$("#taxList").data("kendoGrid").resize();
	});

	// 22.06.22 이건욱 T11 > J40 추가
	// 공급자
	Util.setBizName("supplierName", "");
	// 공급받는자
	Util.setBizName("buyerName", "");
	// 발행업체
	Util.setBizName("regCustName", "");
	// 발행자
	Util.setSelectBox("/contents/basic/data/userNameListCust.do", "regName", { custId:$("#regCustName").val() }, "userId", "userName", "", "발행자");
	$("#regCustName").on("change", function(){ 
		Util.setSelectBox("/contents/basic/data/userNameListCust.do", "regName", { custId:$("#regCustName").val() }, "userId", "userName", "", "발행자");
	});
	// End
	
	goList();
	/* 
	var grid = $("#tranList").data("kendoGrid");
	
	grid.tbody.delegate('tr', 'dblclick', function(){
		var dataItem = grid.dataItem($(this));
		
		$.ajax({
			url: "/contents/calc/data/getInvoicePdf.do",
			type: "POST",
			dataType: "json",
			data: {
				receiptId: dataItem.receiptId
			},
			beforeSend: function(xmlHttpRequest) {
				xmlHttpRequest.setRequestHeader("AJAX", "true");
				$("#loading").show();
			},
			success: function(data){
				location.href = "/cmm/downloadInvoice.do?fileName="+data.fileName;
			},
			complete: function() {
				$("#loading").hide();
			}
		});
	}); */
	
	$("#taxList").kendoTooltip({
		filter: "td:nth-child(17)",
		content: function(e) {return e.target.html();},
		width: 300,
		animation: {
        	open: {
        		effects: "zoom",
        		duration: 250
        	}
        },
		content: function(e){
			return e.target.context.innerText;
		}
	});

	//공급자
	supplierBizList = $("#supplierList").kendoMultiColumnComboBox({
		dataTextField: "custName",
		dataValueField: "custName",
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
						useYn : "Y"
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
			{field: "custName", title: "거래처명", width:219.5},
			{field: "deptName", title: "부서명", width:219.5}
		]
	}).data("kendoMultiColumnComboBox");
	
	supplierBizList.bind("select", bizInfo);
	
	//공급받는자
	buyerBizList = $("#buyerList").kendoMultiColumnComboBox({
		dataTextField: "custName",
		dataValueField: "custName",
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
						useYn : "Y"
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
			{field: "custName", title: "거래처명", width:219.5},
			{field: "deptName", title: "부서명", width:219.5}
		]
	}).data("kendoMultiColumnComboBox");
	
	buyerBizList.bind("select", bizInfo);
	
});

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "issueDate", title: "발행일자", width: 120 },
	{ field: "mngCustName", title: "발행업체", width: 120 },
	{ field: "pubType", title: "구분", width: 70,
		template:"#if(pubType == 'S') {# 매출 #} else {# 매입 #} #"
	},
	{ field: "supplierBizName", title: "공급자", width: 120 },
	{ field: "buyerBizName", title: "공급받는자", width: 120 },
	{ field: "totalCnt", title: "건수", width: 70 },
	{ field: "supprice", title: "공급가액", width: 120,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.supprice);
		},
		attributes: { 
			style: "text-align: right" 
		}
	},
	{ field: "tax", title: "부가세액", width: 120,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.tax);
		},
		attributes: { 
			style: "text-align: right" 
		}
	},
	{ field: "totPrice", title: "합계금액", width: 120,
		template: function(dataItem) {
			return Util.formatNumber(dataItem.totPrice);
		},
		attributes: { 
			style: "text-align: right" 
		}
	},
	{ field: "remarks", title: "비고", width: 150 },
	{ field: "issueId", title: "승인번호", width: 170 },
	{ field: "mngCarNum", title: "차량번호", width: 100 },
	{ field: "pubform", title: "발행양식 ", width: 100,
		template:"#if(pubform == '01') {# 영수 #} else {# 청구 #} #"
	},
	{ field: "loadStatus", title: "전자발행여부", width: 120,
		template:"#if(loadStatus == '0') {# 일반 #} else {# 전자 #} #"
	},
	{ field: "result", title: "전송상태", width: 100,
		template:"#if(result == 'N') {# 미전송 #} else if (result == '0') {# 성공 #} else {# 실패 #} #"},
	{ field: "resultDtl", title: "전송상태상세", width: 150 },
	{ field: "dtiStatus", title: "발행상태", width: 100 },
	{ field: "ntsSendStatus", title: "국세청전송상태", width: 120 },
	{ field: "regId", title: "발행자", width: 100 },
	{ field: "writeDate", title: "작성일", width: 100 },
	{ field: "regDate", title: "등록일", width: 100 },
	{ field: "invId", title: "세금계산서ID", hidden: true}
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("taxList");
oGrid.initGrid();
oGrid.setSendUrl("/contents/tax/data/taxList.do");
oGrid.setSelectable("multiple");
oGrid.setPageable(true);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

function goList() {
	var grid = $("#taxList").data("kendoGrid");
	
	var param = $("#fSearch").serializeObject();
	
	// 22.06.22 이건욱 T11 > J40 추가
	param["supplierId"] = $("#supplierName").val();
	param["buyerId"] = $("#buyerName").val();
	param["regCustId"] = $("#regCustName").val();
	param["regId"] = $("#regName").val();
	
	// test
	console.log("supplierId: " + param["supplierId"]);
	console.log("buyerId: " + param["buyerId"]);
	console.log("regCustId: " + param["regCustId"]);
	console.log("regId: " + param["regId"]);
	// End
	
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#taxList").data("kendoGrid");
		grid.bind("change", onChange);
		grid.tbody.delegate('tr', 'dblclick', function(){
			var grid = $("#taxList").data("kendoGrid");
			var row = grid.select();
			selectedData = grid.dataItem(row);
			taxInvoiceDetail(selectedData);

		});
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
	grid.bind("dataBound", grid_dataBound);
}

function grid_dataBound(e) {
	var rows = e.sender.tbody.children();
	var row_len = rows.length;
	for (var j = 0; j < row_len; j++) {
	    var row = $(rows[j]);
	    var dataItem = e.sender.dataItem(row);
	  	var cells = row.children();	  	
	  	
	    if (dataItem.get("loadStatus") == "1") {
	    	cells.each(function(i){
	    		cells.addClass("etax");
	    	}); 
	    }
	}
    
}
function onChange(e){
	var row = this.select();
	var data = this.dataItem(row);
	
	if(row.length > 0){
		$("#btnTaxDelete").show();
	}else{
		$("#btnTaxDelete").hide();
	}
}

$("#btnTaxDelete").click(function(e) {
	var grid = $("#taxList").data("kendoGrid");
	var row = grid.select();		
	var multiSelectedData = [];
	var loadStatusData = [];
	if(row.length < 1) {
		alert("세금계산서를 선택해주세요.");
		return;
	}
	if(confirm("세금계산서를 삭제 하시겠습니까?")) {
		for(var i = 0; i < row.length; i++) {
			multiSelectedData.push(grid.dataItem(row[i]).invId);
			if(grid.dataItem(row[i]).loadStatus == '1'){
				alert("전자 발행하지 않은 계산서만 선택해 주세요.");
				return;
			}
		}
		$.ajax({
			url: "/contents/tax/data/taxDelete.do",
			type: "POST",
			dataType: "json",
			data: {
				multiSelectedData: multiSelectedData.toString()
			},
			success: function(data){
				if (data.result) {
					alert(data.retMsg);
					goList();
				}else {
					alert(data.retMsg);
				}
			}
		});
	}
});


//excel download
function goExcel(){
	$("#loading").show();
	var grid = $("#taxList").data("kendoGrid");
	grid.saveAsExcel();
}
taxModal = $("#divTaxInvoice");

taxModal.kendoDialog({
	width: "1200px",
	height: "900px",
	visible: false,
	title: "세금계산서",
	closable: true,
	modal: false,
	close: function(){
		$("#btnTaxInvoice").fadeIn();
		$("#fTaxInvoice")[0].reset();
		$(".hiddenValue").val("");
		$("#taxDtlTbl tr:not(:first)").remove();
	}
});

taxCancelModal = $("#divTaxCancel")

taxCancelModal.kendoDialog({
	width: "500px",
	height: "250px",
	visible: false,
	title: "발행취소",
	closable: true,
	modal: false,
	close: function(){
		$("#btnTaxCancel").fadeIn();
	}
});

taxResendModal = $("#divTaxResend")

taxResendModal.kendoDialog({
	width: "500px",
	height: "230px",
	visible: false,
	title: "재전송",
	closable: true,
	modal: false,
	close: function(){
		$("#btnTaxResend").fadeIn();
	}
});

$("#btnTaxResend").click(function() {
	/* var emailRule = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i;
	if(!emailRule.test($("#"resendEmail"").val())) {
		alert("이메일이 형식에 맞지않습니다.");
		return;
	}  */
	$("#resendEmail").val($("#buyerMemEmail").val())
	taxResendModal.data("kendoDialog").open();
});

$("#fResend input[name=sendSignal]").click(function(){
	if($(this).val() == 'SENDMAIL') {
		$("#resendEmail").val($("#buyerMemEmail").val())
	} else {
		$("#resendEmail").val($("#supplierMemEmail").val())
	}
});

function viewTaxStatusModal(statusSignal, statusName) {
	var grid = $("#taxList").data("kendoGrid");
	var selectedItem = grid.dataItem(grid.select());


	if(statusSignal == "CANCELALL") {
		/* if(selectedItem.ntsSendStatus != "미전송" && selectedItem.dtiStatus != "수신미승인") {
			alert("해당 세금계산서는 발행취소를 할 수 업습니다.");
			return ;	
		} */
		
		if(selectedItem.ntsSendStatus == "전송중" || selectedItem.ntsSendStatus == "국세청 처리중" || selectedItem.ntsSendStatus == "전송완료" || selectedItem.dtiStatus == "수신승인") {
			alert("해당 세금계산서는 발행취소를 할 수 없어 수정세금계산서가 발행됩니다.\n\n빠른지급신청 건인 경우 차주에게 재신청 안내바랍니다.");		
			taxModify();
			return;
		}
		
		alert("매입 전자세금계산서 취소 시 차주운임 등이 달라질 수 있어 빠른지급신청도 초기화됩니다.\n\n빠른지급신청 건인 경우 차주에게 재신청 안내바랍니다.");
	}
	taxCancelModal.data("kendoDialog").open();
	
	$("#btnChgStatus").attr("href", "javascript:taxStatus('" + statusSignal+ "', '" + statusName + "')");
}

/* $("#btnTaxCancel").click(function() {
	var grid = $("#taxList").data("kendoGrid");
	grid.tbody.delegate('tr', 'dblclick', function(){
		var row = grid.select();	
		selectedData = grid.dataItem(row);
	});
	if(selectedData.ntsSendStatus != '미전송' && selectedData.dtiStatus != '수신미승인'){
		alert("해당 세금계산서는 발행취소를 할 수 업습니다.");
		return 
	}
	taxCancelModal.data("kendoDialog").open();
});
 */
$("#btnTaxInvoice").click(function() {
	$("#divTaxInvoice").parents("div").css("height", '880px');
	$("#divTaxInvoice").css("height", '740px');
	$("#taxDtlTbl tr:not(:first)").remove();
	$('#fTaxInvoice')[0].reset();
	supplierBizList.readonly(false);
	buyerBizList.readonly(false);
	$("#btnSave").show();
	$("#btnPrint").hide();
	$("#taxDtlTbl").show();
	$("#supplierBizTypeDiv").show();
	$("#buyerBizTypeDiv").show();
	$("#bizTypeDiv").show();
	$("#brokerInfoDiv").hide();
	$("input[name='pubForm']").attr('disabled',false);
	$("#remarks").attr("readonly", false);
	$("#writeDate").attr("readonly", false);
	$("#supplierMemName").attr("readonly", false);
	$("#supplierMemTel").attr("readonly", false);
	$("#supplierMemEmail").attr("readonly", false);
	$("#buyerMemName").attr("readonly", false);
	$("#buyerMemTel").attr("readonly", false);
	$("#buyerMemEmail").attr("readonly", false);
	$("#divTaxInvoice").parents("div").find(".k-window-title").html("세금계산서");
	var param = $("#fSearch").serializeObject();
	taxModal.data("kendoDialog").open();
	$("#writeDate").val(new moment().format("YYYYMMDD"));
	addTaxDetail();
	
});

function addTaxDetail() {
	/*작성일자(메인), 비고(메인), 등록일자(상세o), 품목(상세o), 비고(상세o) 
    - 품목, 비고(메인), 비고(상세) : 빈칸으로 하고 담당자가 쳐넣게
    * 수기로 세금계산서 발행 시도 똑같이 수정 가능하게 */ 
	var str = "";
	str += "<tr>" + 
        "<td><input type='text' class='col btn_gra_tax' id='itemDate'       style='text-align:right;'	name='itemDate' value='" + new moment().format("YYYYMMDD") 		+ "'onkeypress='numberOnly();' maxlength='8'></td>" +
        "<td><input type='text' class='col btn_gra_tax' id='itemName'       style='text-align:right;'	name='itemName'    ></td>" +
        "<td><input type='text' class='col btn_gra_tax' id='itemType'       style='text-align:right;'	name='itemType'    ></td>" +
        "<td><input type='text' class='col btn_gra_tax' id='itemQty'        style='text-align:right;'	name='itemQty'       onchange='calcSupprice(event)'   onkeypress='numberOnly();'></td>" +
        "<td><input type='text' class='col btn_gra_tax' id='itemPrice'      style='text-align:right;'	name='itemPrice'     onchange='calcSupprice(event)'   onkeypress='numberOnly();'></td>" +
        "<td><input type='text' class='col btn_gra_tax' id='itemSupprice'   style='text-align:right;'	name='itemSupprice'     value='0' onkeypress='numberOnly();' readonly></td>" +
        "<td><input type='text' class='col btn_gra_tax' id='itemTax'  		style='text-align:right;'	name='itemTax'   		value='0' onkeypress='numberOnly();' readonly></td>" +
        "<td><input type='text' class='col btn_gra_tax' id='itemRemarks'    style='text-align:right;'	name='itemRemarks' ></td>" +
     "</tr>";
     
	$("#taxDtlTbl").append(str);
}

function addInGrid() {
	addTaxDetail();
}

function removeInGrid() {
	
	if ($("#taxDtlTbl tr").length < 3) {
		alert("항목을 삭제할 수 없습니다.");
	} else {
		$("#taxDtlTbl tr:last").remove();
		setPrice();	
	}
}

function numberOnly(){
    if((event.keyCode!=45) && (event.keyCode<48)||(event.keyCode>57)){
       event.returnValue=false;
    }else{
    	$("#itemQty, #itemPrice").on("input", function(){
    		$(this).val(Util.formatNumberInput($(this).val()));
    	});
    }
}

function calcSupprice(e) {
	
	var t = e.target.parentNode.parentNode;
	var qty = t.children[3].children[0].value.replace(/,/g, "");
	var price = t.children[4].children[0].value.replace(/,/g, "");
	
	if(qty == '') qty = 0;
	if(price == '') price = 0;
	
	t.children[5].children[0].value = qty*price;
	t.children[6].children[0].value = (qty*price) / 10;
	var itemTax = t.children[6].children[0].value.split('.');
	t.children[6].children[0].value = itemTax[0];
	
	var p = getPrice(e.target.parentNode.parentNode.parentNode);
	
	$("#supprice").val(p.supprice);
	$("#tax").val(p.tax);
	$("#totPrice").val(p.totPrice);
	
	$("#supprice").val(Util.formatNumber($("#supprice").val()));
	$("#tax").val(Util.formatNumber($("#tax").val()));
	$("#totPrice").val(Util.formatNumber($("#totPrice").val()));
	 
	t.children[5].children[0].value = Util.formatNumber(t.children[5].children[0].value);
	t.children[6].children[0].value = Util.formatNumber(t.children[6].children[0].value);  
}

$("input[name='bizTypeCd']:radio").change(setPrice);

function setPrice() {
	var val = this.value;
	var p = getPrice(document.getElementById("taxDtlTbl").children[0]);
	var sum = 0;
	
	if(val == '02') {
		$("input[name=itemTax]").each(function(index, item){
			itemTaxList.push($(item).val());
	    });
		$("#supprice").val(Util.formatNumber(p.supprice));
		$("#tax").val(0);
		$("input[name=itemTax]").val(0);
		$("#totPrice").val(Util.formatNumber(p.supprice));
	} else {
		$("input[name=itemTax]").each(function(index, item){
		    $(item).val(itemTaxList[index]);
		    sum += Number($(this).val().replace(/,/g, ""));
	    });
		$("#supprice").val(Util.formatNumber(p.supprice));
		$("#tax").val(Util.formatNumber(sum));
		$("#totPrice").val(Util.formatNumber(p.totPrice+sum));
		itemTaxList = new Array();
	}
}

function getPrice(e) {
	var trs = e.children;
	var supprice = 0;
	var tax = 0;
	var totPrice = 0;
	if(supprice == '') supprice = 0;
	if(tax == '') tax = 0;
	if(totPrice == '') totPrice = 0;
	
	for(var i = 1; i < trs.length; i++) {
		supprice += parseInt(trs[i].children[5].children[0].value.replace(/,/g, ""));
		tax += parseInt(trs[i].children[6].children[0].value.replace(/,/g, ""));
		totPrice = supprice + tax;
	}
	
	return {
		supprice: supprice,
		tax: tax,
		totPrice: totPrice
	}
}
function readonlyValidator(){
	$("#fTaxInvoice input[name$='BizNo']").removeAttr('readonly');
	$("#fTaxInvoice input[name$='Ceo']").removeAttr('readonly');
	$("#fTaxInvoice input[name$='Addr']").removeAttr('readonly');
}

$('#fTaxInvoice').validator().on('submit', function (e) {
	$("#fTaxInvoice input[name$='BizNo']").attr('readonly', true);
	$("#fTaxInvoice input[name$='Ceo']").attr('readonly', true);
	$("#fTaxInvoice input[name$='Addr']").attr('readonly', true);
	if (e.isDefaultPrevented()) {
	   alert("항목을 입력해 주세요.")
	} else {
	    e.preventDefault();
	    var confirmText = ""
	    if($("#invId").val() != ""){
	    	confirmText = '세금계산서를 수정 하시겠습니까?';
	    }else{
	    	confirmText = '세금계산서를 발행 하시겠습니까?';
	    }
		if(confirm(confirmText)) {
			if($("#buyerMemEmail").val() == '') {
				alert("공급받는자 이메일을 입력해주세요.");
				return;
			}
			var emailRule = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i;
			if(!emailRule.test($("#supplierMemEmail").val())) {
				alert("공급자 이메일이 형식에 맞지않습니다.");
				return;
			}
			if(!emailRule.test($("#buyerMemEmail").val())) {
				alert("공급받는자 이메일이 형식에 맞지않습니다.");
				return;
			}
			var items = [];
			var tbl = document.getElementById("taxDtlTbl").children[0]
			var trs = tbl.children;
			
			for(var i = 1; i < trs.length; i++) {
				var item = {};
				item.seq = i;
				item.itemRemarks = trs[i].children[7].children[0].value;
				item.itemSupprice = trs[i].children[5].children[0].value.replace(/,/g, "");
				item.itemQty = trs[i].children[3].children[0].value.replace(/,/g, "");
				item.itemType = trs[i].children[2].children[0].value;
				item.itemName = trs[i].children[1].children[0].value;
				item.itemDate = trs[i].children[0].children[0].value;
				item.itemTax = trs[i].children[6].children[0].value.replace(/,/g, "");
				item.itemPrice = trs[i].children[4].children[0].value.replace(/,/g, "");
				items.push(item);
			}
			
			var param = {
				invId : $("#invId").val(),
				pubType: $("#sSellBuySctn").val == '01' ? 'S' : 'R',
				pubForm: $("input[name='pubForm']:checked").val(),
				supplierCustId: $("#supplierCustId").val(),
				supplierDeptId: $("#supplierDeptId").val(),
				supplierVehicId: $("#supplierVehicId").val(),
				supplierDriverId: $("#supplierDriverId").val(),
				supplierBizName: $("#supplierBizName").val(),
				supplierBizNo: $("#supplierBizNo").val().replace(/\-/g, ''),
				supplierBizSubNo: $("#supplierBizSubNo").val(),
				supplierCeo: $("#supplierCeo").val(),
				supplierAddr: $("#supplierAddr").val(),
				supplierBizType: $("#supplierBizType").val(),
				supplierBizClass: $("#supplierBizClass").val(),
				supplierMemName: $("#supplierMemName").val(),
				supplierMemTel: $("#supplierMemTel").val().replace(/\-/g, ''),
				supplierMemEmail: $("#supplierMemEmail").val(),
				buyerCustId: $("#buyerCustId").val(),
				buyerDeptId: $("#buyerDeptId").val(),
				buyerBizName: $("#buyerBizName").val(),
				buyerBizNo: $("#buyerBizNo").val().replace(/\-/g, ''),
				buyerBizSubNo: $("#buyerBizSubNo").val(),
				buyerCeo: $("#buyerCeo").val(),
				buyerAddr: $("#buyerAddr").val(),
				buyerBizType: $("#buyerBizType").val(),
				buyerBizClass: $("#buyerBizClass").val(),
				buyerBizNoType: "01",
				buyerMemName: $("#buyerMemName").val(),
				buyerMemTel: $("#buyerMemTel").val().replace(/\-/g, ''),
				buyerMemEmail: $("#buyerMemEmail").val(),
				writeDate: $("#writeDate").val(),
				supprice: $("#supprice").val().replace(/,/g, ""),
				tax: $("#tax").val().replace(/,/g, ""),
				totPrice: $("#totPrice").val().replace(/,/g, ""),
				remarks: $("#remarks").val(),
				items: JSON.stringify(items)
			};
			
			$.ajax({
				url: "/contents/tax/data/insertTaxInvoice.do",
				type: "POST",
				dataType: "json",
				data: param,
				success: function(data){
					if (data.result) {
						alert(data.retMsg);
						taxModal.data("kendoDialog").close();
						goList();
					}
				}
			}); 
		}
	}
});

// 공급자
$("input[name=supplierBizTypeCd]").change(function(){
	$("#supplierCustId").val("");
	$("#supplierDeptId").val("");
	$("#supplierBizName").val("");
	$("#supplierBizNo").val("");
	$("#supplierBizSubNo").val("");
	$("#supplierCeo").val("");
	$("#supplierAddr").val("");
	$("#supplierBizType").val("");
	$("#supplierBizClass").val("");
	$("#supplierMemName").val("");
	$("#supplierMemTel").val("");
	$("#supplierMemEmail").val("");
	supplierBizList.value("");
	supplierBizList.refresh();
	supplierBizList.destroy();
	if($("input[name=supplierBizTypeCd]:checked").val() == '01'){
		supplierBizList = $("#supplierList").kendoMultiColumnComboBox({
			dataTextField: "custName",
			dataValueField: "custName",
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
							useYn : "Y"
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
				{field: "custName", title: "거래처명", width: "auto"},
				{field: "deptName", title: "부서명", width: "auto"}
				
			]
		}).data("kendoMultiColumnComboBox");
	}else if($("input[name=supplierBizTypeCd]:checked").val() == '02'){
		supplierBizList = $("#supplierList").kendoMultiColumnComboBox({
			dataTextField: "carNum",
			dataValueField: "carNum",
			filter: "contains",
			minLength: 2,
			autoBind: true,
			dataSource: {
				serverFiltering: true,
				transport: {
					read : {
						url: "/contents/basic/data/carList.do",
						dataType: "json",
						type: "post",
						data: {
							useYn : "Y"
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
				{field: "bizName", title: "거래처명", width: "auto",
					//template: "#if(bizName == null) {# 미정 #} #"
				},
				{field: "carNum", title: "차량번호", width: "auto"},
				{field: "driverName", title: "차주명", width: "auto"},
				{field: "mobile", title: "휴대전화", width: "auto",
					template: function(dataItem) {
						return Util.formatPhone(dataItem.mobile);
					}
				},
				
			]
		}).data("kendoMultiColumnComboBox");
	}else if($("input[name=supplierBizTypeCd]:checked").val() == '03'){
		$.ajax({
			url: "/contents/basic/data/compList.do",	
			type: "POST",
			dataType: "json",
			data: {
				useYn: "Y",
				custId : '${sessionScope.userInfo.custId}',
				deptId : '${sessionScope.userInfo.deptId}'
			},
			success: function(data){
				if(data.result) {
					supplierBizList.value(data.data.bizName);
					$("#supplierCustId").val(data.data.custId);
					$("#supplierDeptId").val(data.data.deptId);
					$("#supplierBizName").val(data.data.bizName);
					$("#supplierBizNo").val(Util.formatBizNum(data.data.bizNum));
					$("#supplierBizSubNo").val(data.data.bizNumSub);
					$("#supplierCeo").val(data.data.ceo);
					$("#supplierAddr").val(data.data.bizAddr);
					$("#supplierBizType").val(data.data.bizCond);
					$("#supplierBizClass").val(data.data.bizKind);
				}
			}
		});
	}
	supplierBizList.bind("select", bizInfo);
});

//공급받는자
$("input[name=buyerBizTypeCd]").change(function(){
	$("#buyerCustId").val("");
	$("#buyerDeptId").val("");
	$("#buyerBizName").val("");
	$("#buyerBizNo").val("");
	$("#buyerBizSubNo").val("");
	$("#buyerCeo").val("");
	$("#buyerAddr").val("");
	$("#buyerBizType").val("");
	$("#buyerBizClass").val("");
	$("#buyerMemName").val("");
	$("#buyerMemTel").val("");
	$("#buyerMemEmail").val("");
	buyerBizList.value("");
	buyerBizList.refresh();
	buyerBizList.destroy();
	if($("input[name=buyerBizTypeCd]:checked").val() == '01'){
		buyerBizList = $("#buyerList").kendoMultiColumnComboBox({
			dataTextField: "custName",
			dataValueField: "custName",
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
							useYn : "Y"
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
				{field: "custName", title: "거래처명", width: "auto"},
				{field: "deptName", title: "부서명", width: "auto"}
			]
		}).data("kendoMultiColumnComboBox");
	}else if($("input[name=buyerBizTypeCd]:checked").val() == '02'){
		buyerBizList = $("#buyerList").kendoMultiColumnComboBox({
			dataTextField: "carNum",
			dataValueField: "carNum",
			filter: "contains",
			minLength: 2,
			autoBind: true,
			dataSource: {
				serverFiltering: true,
				transport: {
					read : {
						url: "/contents/basic/data/carList.do",
						dataType: "json",
						type: "post",
						data: {
							useYn : "Y"
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
				{field: "bizName", title: "거래처명", width: "auto"},
				{field: "carNum", title: "차량번호", width: "auto"},
				{field: "driverName", title: "차주명", width: "auto"},
				{field: "mobile", title: "휴대전화", width: "auto",
					template: function(dataItem) {
						return Util.formatPhone(dataItem.mobile);
					}
				},
				
			]
		}).data("kendoMultiColumnComboBox");
	}else if($("input[name=buyerBizTypeCd]:checked").val() == '03'){
		$.ajax({
			url: "/contents/basic/data/compList.do",	
			type: "POST",
			dataType: "json",
			data: {
				useYn: "Y",
				custId : '${sessionScope.userInfo.custId}',
				deptId : '${sessionScope.userInfo.deptId}'
			},
			success: function(data){
				if(data.result) {
					buyerBizList.value(data.data.bizName);
					$("#buyerCustId").val(data.data.custId);
					$("#buyerDeptId").val(data.data.deptId);
					$("#buyerBizName").val(data.data.bizName);
					$("#buyerBizNo").val(Util.formatBizNum(data.data.bizNum));
					$("#buyerBizSubNo").val(data.data.bizNumSub);
					$("#buyerCeo").val(data.data.ceo);
					$("#buyerAddr").val(data.data.bizAddr);
					$("#buyerBizType").val(data.data.bizCond);
					$("#buyerBizClass").val(data.data.bizKind);
				}
			}
		});
	}
	buyerBizList.bind("select", bizInfo);
});

function taxInvoiceDetail(data){ 
	$.ajax({
		url: "/contents/tax/data/viewTaxItem.do",
		type: "POST",
		dataType: "json",
		data: {
			invId: data.invId,
		},
		success: function(data){
			$('#taxDtlTbl tr:gt(0)').remove();
			for(var i=0; i<data.data.length; i++){
				var str = "";
				str += "<tr>" + 
			        "<td><input type='text' class='col btn_gra_tax' id='itemDate'       style='text-align:right;' name='itemDate'     value='" + data.data[i].itemDate + "' onkeypress='numberOnly();' maxlength='8'></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemName'       style='text-align:right;' name='itemName'     value='" + data.data[i].itemName + "'></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemType'       style='text-align:right;' name='itemType'     value='" + data.data[i].itemType + "'readonly></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemQty'        style='text-align:right;' name='itemQty'      value='" + data.data[i].itemQty + "'readonly></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemPrice'      style='text-align:right;' name='itemPrice'    value='" + Util.formatNumber(data.data[i].itemSupprice) + "'	readonly></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemSupprice'   style='text-align:right;' name='itemSupprice' value='" + Util.formatNumber(data.data[i].itemSupprice) + "'	readonly></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemTax'  		style='text-align:right;' name='itemTax'      value='" + Util.formatNumber(data.data[i].itemTax) + "'		readonly></td>" +
			        "<td><input type='text' class='col btn_gra_tax' id='itemRemarks'    style='text-align:right;' name='itemRemarks'  value='" + data.data[i].itemRemarks + "'></td>" +
			     "</tr>";
			    tax += data.data[i].itemTax;
			    supprice += data.data[i].itemSupprice;
				$("#taxDtlTbl").append(str);
			}
		}
	});
	if(data.loadStatus == '1'){
		$("#btnTaxResend").show();
		$("#btnTaxCancel").show();
	}else{
		$("#btnTaxResend").hide();
		$("#btnTaxCancel").hide();
	}
/* 	if(data.ntsSendStatus == '미전송' && data.dtiStatus == '수신미승인'){
		$("#btnTaxCancel").show();
	}else{
		$("#btnTaxCancel").hide();
	} */
	
	if(data.buyerCustId == '${sessionScope.userInfo.custId}' && '${sessionScope.userInfo.custId}' == '${brokerCustId}') {
		if(data.dtiStatus == '수신승인' || data.dtiStatus == '수신거부' || data.dtiStatus == null) {
			$("#btnTaxAccept").hide();
			$("#btnTaxReject").hide();
		} else {
			$("#btnTaxAccept").show();
			$("#btnTaxReject").show();
		}
		
	} else {
		$("#btnTaxAccept").hide();
		$("#btnTaxReject").hide();
	}

	supplierBizList.readonly(true);
	buyerBizList.readonly(true);
	buyerBizList.value(data.buyerBizName);
	supplierBizList.value(data.supplierBizName);
	Util.setPageData(data);
	$("#supplierBizNo").val(Util.formatBizNum($("#supplierBizNo").val()));
	$("#buyerBizNo").val(Util.formatBizNum($("#buyerBizNo").val()));
	$("#supprice").val(Util.formatNumber($("#supprice").val()));
	$("#tax").val(Util.formatNumber($("#tax").val()));
	$("#totPrice").val(Util.formatNumber($("#totPrice").val()));
	$("#fTaxInvoice").find("input").attr("readonly", true);
	$("#writeDate").attr("readonly", false);
	$("#remarks").attr("readonly", false);
	$("#btnSave").hide();
	$("#btnPrint").show();
	$("#supplierBizTypeDiv").hide();
	$("#buyerBizTypeDiv").hide();
	$("#bizTypeDiv").hide();
	//radio button 별도 세팅
	$("#fTaxInvoice input[name=pubForm]:input[value=" + data.pubform + "]").prop("checked", true);
	$("input[name='pubForm']").attr('disabled',true);
	if(data.billKind == 01){
		$("#divTaxInvoice").parents("div").css("height", '800px');
		$("#divTaxInvoice").css("height", '800px');
		taxModal.data("kendoDialog").open();
		$("#divTaxInvoice").parents("div").find(".k-window-title").html("일반세금계산서");
		$("#brokerInfoDiv").hide();
	/*}else if(data.billKind == 02){
		$("#divTaxInvoice").parents("div").css("height", '643px');
		$("#divTaxInvoice").css("height", '550px');
		taxModal.data("kendoDialog").open();
		$("#divTaxInvoice").parents("div").find(".k-window-title").html("중개세금계산서");
		$("#brokerInfoDiv").hide();*/
	}else if(data.billKind == 03){
		$("#brokerInfoDiv").show();
		$("#divTaxInvoice").parents("div").css("height", '800px');
		$("#divTaxInvoice").css("height", '800px');
		taxModal.data("kendoDialog").open();
		$("#divTaxInvoice").parents("div").find(".k-window-title").html("위수탁세금계산서");
		var str = "수탁자 주소 : ("+data.brokerAddr+"), 수탁자 업태 : ("+data.brokerBizType+"), 수탁자 업종 : ("+data.brokerBizClass+")"
				+ "\n수탁자 사업자명 : ("+data.brokerBizName+"), 수탁자 사업자 번호 ("+Util.formatBizNum(data.brokerBizNo)+"), 수탁 대표자 : ("+data.brokerCeo+")";
				//+ "\n수탁 담당자 : ("+data.brokerMemName+"), 수탁자 연락처 : ("+Util.formatPhone(data.brokerMemTel)+"), 수탁자 이메일 : ("+data.brokerMememail+")";
		$("#brokerInfo").val(str);
	}
}

function bizInfo(e) {
	var dataItem = e.dataItem;
	if(e.sender.input.context.id != "supplierList"){
		var gbn = 'buyer';
	}else{
		var gbn = 'supplier';
	}
	$("#"+gbn+"CustId").val(dataItem.custId);
	$("#"+gbn+"DeptId").val(dataItem.deptId);
	$("#"+gbn+"BizName").val(dataItem.bizName);
	$("#"+gbn+"BizNo").val(Util.formatBizNum(dataItem.bizNum));
	$("#"+gbn+"BizSubNo").val(dataItem.bizNumSub);
	$("#"+gbn+"Ceo").val(dataItem.ceo);
	$("#"+gbn+"Addr").val(dataItem.bizAddr);
	$("#"+gbn+"BizType").val(dataItem.bizCond);
	$("#"+gbn+"BizClass").val(dataItem.bizKind);
	$("#"+gbn+"MemName").val(dataItem.userName);
	$("#"+gbn+"MemTel").val(Util.formatPhone(dataItem.mobile));
	$("#"+gbn+"MemEmail").val(dataItem.taxEmail);
}

$("#btnLoadStatus").click(function(e) {
	var grid = $("#taxList").data("kendoGrid");
	var row = grid.select();		
	var multiSelectedData = [];
	var loadStatusData = [];
	if(row.length < 1) {
		alert("세금계산서를 선택해주세요.");
		return;
	}
	if(confirm("전자발행을 하시겠습니까?")) {
		for(var i = 0; i < row.length; i++) {
			multiSelectedData.push(grid.dataItem(row[i]).invId);
			if(grid.dataItem(row[i]).loadStatus == '1'){
				alert("전자 발행하지 않은 계산서만 선택해 주세요.");
				return;
			}
		}
		$.ajax({
			url: "/contents/tax/data/issueEtax.do",
			type: "POST",
			dataType: "json",
			data: {
				multiSelectedData: multiSelectedData.toString()
			},
			success: function(data){
				if (data.result) {
					alert(data.retMsg);
					goList();
				}else {
					alert(data.retMsg);
				}
			}
		});
	}
});

$("#supplierMemTel, #buyerMemTel").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});

var signedXML = ""
function goPdf(){
	var xslForm = "/xsl/taxform_";
	if($("#supplierCustId").val() == "${sessionScope.userInfo.custId}") {
		xslForm += "supplier";
	} else {
		xslForm += "buyer";
	}
	xslForm += $("#docType").val() + ".xsl";
	$.ajax({
		url: "/contents/tax/data/getTaxXml.do",
		type: "POST",
		dataType: "json",
		data: "invId=" + $("#invId").val(),
		success: function(data) {
			if(data.result) {
				
				$("#iframe").show();
				$("#iframe")[0].contentWindow.signedXML = data.data.sendXml;
				$("#iframe")[0].contentWindow.xslForm = xslForm;
				$("#iframe")[0].contentWindow.init();
				$("#iframe")[0].contentWindow.printPdf();
			} else {
				alert(data.msg);
			}
		}
	})
}

function taxStatus(statusSignal, statusName){
	if(!confirm('세금계산서 ' + statusName + ' 처리 하시겠습니까?')){
		return false;
	}else{
		$.ajax({
			url: "/contents/tax/data/taxStatus.do",
			type: "POST",
			dataType: "json",
			data: {
				statusReason: $("#statusReason").val(),
				statusSignal: statusSignal,
				invId: $("#invId").val()
			},
			success: function(data){
				if(data.result) {
					alert(data.msg)
					taxCancelModalClose();
				}
			}
		});
	}
}

function taxCancelModalClose() {
	taxCancelModal.data("kendoDialog").close();
}

function taxResend(){
	if(!confirm('이메일을 재전송 하시겠습니까?')){
		return false;
	}else{
		var emailRule = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i;
		if(!emailRule.test($("#resendEmail").val())) {
			alert("이메일이 형식에 맞지않습니다.");
			return;
		}
		$("#rInvId").val($("#invId").val());
		$.ajax({
			url: "/contents/tax/data/taxResend.do",
			type: "POST",
			dataType: "json",
			data: $("#fResend").serialize(),
			success: function(data){
				if(data.result) {
					alert(data.msg)
					taxResendModalClose();
				}
			}
		});
	}
}

function taxChgStatus() {
	var statusSignal = arguments[0];
	
	if(!confirm('세금계산서 상태를 변경하시겠습니까?')){
		return false;
	}else{
		$.ajax({
			url: "/contents/tax/data/taxStatus.do",
			type: "POST",
			dataType: "json",
			data: {
				statusReason: $("#statusReason").val(),
				invId: $("#invId").val(),
				signal: "CHGSTATUS",
				statusSignal: statusSignal
			},
			success: function(data){
				if(data.result) {
					alert(data.msg)
					taxResendModalClose();
				}
			}
		});
	}	
}

function taxModify() {
	$.ajax({
		url: "/contents/tax/data/taxModify.do",
		type: "POST",
		dataType: "json",
		data: {
			invId: $("#invId").val(),
			writeDate: $("#writeDate").val()
		},
		success: function(data){
			if(data.result) {
				alert(data.msg)
				taxResendModalClose();
			}
		}
	});
}

function taxResendModalClose() {
	taxResendModal.data("kendoDialog").close();
}
function savePdf() {
	$("#iframe").show();
	$("#iframe")[0].contentWindow.printPdf();
}
</script>
