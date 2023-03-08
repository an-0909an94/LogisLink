<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="editor_wrap pop-layer omsCustList" id="layer1">
    <div class="insertClose">
    	<a class="insertCloseButton k-icon k-i-close" onclick="init_popup_close();"></a>
    </div>
    <!-- wrap -->
    <div class="k-tabstrip-wrapper">
        <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
            tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
            <!-- content -->
            <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                aria-expanded="true" style="display: block;">
                <div class="editor">
                    <form id="f" data-toggle="validator" role="form">
                        <fieldset>
                        	<div class="omsCustList_top">
                            	<legend id="addr_legend">운송사 상세</legend>
                            	
		                        <div class="editor_btns" style="text-align:center;">
					        	    <div class="padding">
							            <a onclick="init_popup_close();" class="k-pager-refresh k-button"><b class="btn-g">닫기</b></a>
								    </div>
						    	</div>
                            </div>
                            <div class="form-group row pb30">
                                <label class="col-form-label big-name">운송담당자</label>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong>담당자명</strong>
                                    <input class="form-control form-control-sm readonly" id="manager" readonly>
                                </div>
                                <div class="input-group input-group-sm col">
                                </div>
                                <div class="input-group input-group-sm col">
                                </div>
                            </div>
                                
                            <div class="form-group row gray_box mt5 mr0">
                            	<label class="col-form-label big-name">기본정보</label>
                                <div class="input-group input-group-sm wd80 middle-name form-group">
	                                <strong>거래처 구분</strong>
	                                <input class="form-control form-control-sm readonly" id="sellBuySctnName" readonly>
                                </div>
                                <div class="input-group input-group-sm wd130 middle-name form-group">
                                	<strong>거래처명</strong>
                                    <input type="text" class="form-control form-control-sm readonly" id="custName" readonly>
                                </div>
                                <div class="input-group input-group-sm wd130 mr0 middle-name form-group">
                                <strong>거래처 분류</strong>
                                    <input class="form-control form-control-sm middle-name" id="custTypeName" readonly>
                                </div>
                            
	                           <div class="form-group row mt5 mr0">
	                           	<label class="col-form-label"></label>
	                               <div class="input-group input-group-sm wd80 middle-name form-group">
	                               <strong>사용여부</strong>
	                                   <input class="form-control form-control-sm readonly" id="useYn" readonly>
	                               </div>
	                               <div class="input-group input-group-sm wd130 middle-name form-group">
	                               <strong>등록일자</strong>
	                                   <input type="text" class="form-control form-control-sm readonly" id="regDate" readonly>
	                               </div>
	                               <div class="input-group input-group-sm wd130 mr0 middle-name form-group">
	                               <strong>해지일자</strong>
	                                   <input type="text" class="form-control form-control-sm readonly" id="disuseDate" readonly>
	                               </div>
	                           </div>
                           	</div>
                           	
                            <div class="form-group row gray_box mt5 mr0">
                                <label class="col-form-label big-name">사업자정보</label>
                                <div class="input-group input-group-sm wd140 middle-name form-group">
                                	<strong>상호</strong>
                                    <input type="text" class="form-control form-control-sm readonly" id="bizName" readonly>
                                </div>
                                <div class="input-group input-group-sm wd110 middle-name form-group">
                                <strong>사업자번호</strong>
                                    <input type="text" class="form-control form-control-sm readonly" id="bizNum" maxlength="12" readonly>
                                </div>
                                <div class="input-group input-group-sm wd90 mr0 middle-name form-group" id="divBizNumSub">
                                <strong>종사업장번호</strong>
                                    <input type="text" class="form-control form-control-sm readonly" id="bizNumSub" maxlength="4" readonly>
                                </div>
                           	
                        
	                            <div class="form-group row mt5 mr0">
	                                <label class="col-form-label"></label>
	                                <div class="input-group input-group-sm wd100 middle-name form-group">
	                                <strong>대표자명</strong>
	                                    <input type="text" class="form-control form-control-sm readonly" id="ceo" readonly>
	                                </div>
	                                <div class="input-group input-group-sm wd100 middle-name form-group">
	                                <strong>업태</strong>
	                                    <input type="text" class="form-control form-control-sm readonly" id="bizCond" readonly>
	                                </div>
	                                <div class="input-group input-group-sm wd140 mr0 middle-name form-group">
	                                <strong>업종</strong>
	                                    <input type="text" class="form-control form-control-sm readonly" id="bizKind" readonly>
	                                </div>
	                            </div>
	                            
	                            <div class="form-group row mt5 mr0">
	                                <label class="col-form-label"></label>
	                                <div class="input-group input-group-sm wd100 middle-name form-group">
	                                <strong>사업자구분</strong>
	                                    <input class="form-control form-control-sm readonly" id="bizTypeName" readonly>
	                                </div>
	                               	<div class="input-group input-group-sm wd140 middle-name form-group">
	                                   <strong>은행코드</strong>
	                                    <select class="custom-select col-12" id="bankCode" disabled="disabled"></select>
	                                </div>
	                                <div class="input-group input-group-sm wd100 mr0 middle-name form-group">
	                                <strong>예금주</strong>
	                                    <input type="text" class="form-control form-control-sm" id="bankCnnm" readonly>
	                                </div>
	                            </div>
	                            
	                            <div class="form-group row mt5 mr0">
	                            	<label class="col-form-label"></label>
	                                <div class="input-group input-group-sm wd250 middle-name form-group">
	                                <strong>계좌번호</strong>
	                                    <input type="text" class="form-control form-control-sm" id="bankAccount"  readonly>
	                                </div>
	                            </div>
	
	                            <div class="form-group row mt5 mr0">
	                                <label class="col-form-label big-name"></label>
	                                <div class="input-group input-group-sm wd100 middle-name form-group">
	                                <strong>우편번호</strong>
	                                   	<input type="text" class="form-control form-control-sm readonly" id="bizPost" readonly="readonly">
	                                </div>
	
	                                <div class="input-group input-group-sm wd250 mr0 middle-name form-group">
	                                <strong>주소</strong>
	                                    <input type="text" class="form-control form-control-sm readonly" id="bizAddr" readonly>
	                                </div>
	                            </div>
	                            
	                            <div class="form-group row mt5 mr0">
	                            	<label class="col-form-label"></label>
	                                <div class="input-group input-group-sm wd250 mr0 middle-name form-group">
	                                <strong>상세주소</strong>
	                                    <input type="text" class="form-control form-control-sm readonly" id="bizAddrDetail" readonly>
	                                </div>
	                            </div>
                            </div>
                            
                            <div class="form-group row gray_box mt5 mr0">
                                <label class="col-form-label big-name">운송사 담당자</label>
<!--                                 <div class="input-group input-group-sm col middle-name form-group"> -->
<!--                                 <strong>아이디</strong> -->
<!--                                     <input type="text" class="form-control form-control-sm readonly" id="userId" readonly> -->
<!--                                 </div> -->
                                
                                <div class="input-group input-group-sm wd100 middle-name form-group">
                                <strong>담당자명</strong>
                                    <input type="text" class="form-control form-control-sm readonly" id="userName" readonly>
                                </div>
                                
                                <div class="input-group input-group-sm wd140 middle-name form-group">
                                <strong>전화번호</strong>
                                    <input type="text" class="form-control form-control-sm readonly" id="telNum" readonly>
                                </div>
                            
	                            <div class="form-group row mt5 mr0">
	                                <label class="col-form-label"></label>
	                                <div class="input-group input-group-sm wd80 middle-name form-group">
	                                <strong>직급</strong>
	                                    <input type="text" class="form-control form-control-sm readonly" id="grade" readonly>
	                                </div>
	                                <div class="input-group input-group-sm wd130 middle-name form-group">
	                                <strong>휴대전화</strong>
	                                    <input type="text" class="form-control form-control-sm readonly" id="mobile" readonly>
	                                </div>
	                                <div class="input-group input-group-sm wd130 mr0 middle-name form-group">
	                                <strong>이메일</strong>
	                                    <input type="text" class="form-control form-control-sm readonly" id="email" readonly>
	                                </div>
	                            </div>
                            </div>
                            
                        </fieldset>
                    </form>
                </div>
                <!-- editor -->
            </div>
        </div><!-- content -->
    </div>
</div><!-- wrap -->

<script type="text/javascript">
var g_mode = "";
var g_seq = "";

function init_pop(data) {
	Util.setCmmCode("select", "bankCode", "BANK_CD", "", "선택하세요");
	init();
	Util.setPageData(data);
}

function init() {
	Util.formReset("", [".editor input"], {});
	$(".list-unstyled").remove();
}

function init_popup_close() {
	form_popup_close();
	init();
}
</script>