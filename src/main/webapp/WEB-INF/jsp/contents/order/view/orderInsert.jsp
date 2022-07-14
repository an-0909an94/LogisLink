<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="priceView" class="editor-warp p-0">
    <div class="modalEditor" id="addCust">
        <div style="padding-left: 30px; padding-right: 30px; padding-top: 20px; text-align: left;">
            <div>
                최저가 : <span id="minFare"></span>원
            </div>
            <div>
                최고가 : <span id="maxFare"></span>원
            </div>
            <div>
                평균가 : <span id="avgFare"></span>원
            </div>
        </div>
    </div>
</div>

<div id="carModal">
    <form class="modalEditor" id="carForm" data-toggle="validator" role="form" autocomplete="off">
        <input type="hidden" name="driverAllocId" id="driverAllocId">
        <input type="hidden" id="vehicId" name="vehicId">
        <input type="hidden" id="driverId" name="driverId">
        <div class="form-group row">
            <label class="col-form-label big-name">차량번호</label>
            <div class="input-group input-group-sm col middle-name form-group">
                <input type="text" class="form-control form-control-sm" id="carNum" pattern="^[가-힣ㄱ-ㅎㅏ-ㅣ\x20]{2}\d{2}[아,바,사,자\x20]\d{4}$" data-pattern-error="차량번호를 확인해 주세요." maxlength="10" required>
                <div class="help-block with-errors" style="position: absolute;"></div>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-form-label big-name">차주성명</label>
            <div class="input-group input-group-sm col middle-name form-group">
                <input type="text" name="driverName" id="driverName" class="form-control form-control-sm" required>
                <div class="help-block with-errors" style="position: absolute;"></div>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-form-label big-name">휴대전화</label>
            <div class="input-group input-group-sm col middle-name form-group">
                <input type="text" name="driverTel" id="driverTel" class="form-control form-control-sm" maxlength="13" required>
                <div class="help-block with-errors" style="position: absolute;"></div>
            </div>
        </div>

        <div class="editor_btns">
            <div class="padding">
                <button type="submit" class="k-pager-refresh k-button">
                    <b class="btn-b"><i class="k-icon k-i-check"></i><strong>배차등록</strong></b>
                </button>
                <a id="closeBtn" onclick="carFormClose();" class="k-pager-refresh k-button">
                    <b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b>
                </a>
            </div>
        </div>
    </form>
</div>

<div id="prveOrderList" class="editor-warp p-0">
    <div>
        <div class="splitter" style="min-width: 800px; min-height: 458px; border: 0;">
            <div id="popGrid"></div>
        </div>
    </div>
</div>

<div id="popDriverState" class="editor-warp p-0">
    <div>
        <div class="modalEditor" id="addDept">
            <div class="modalHeader">
                <div class="form-group row">
                    <label class="col-form-label modal-big-name">입차시간</label>
                    <div class="input-group input-group-sm col middle-name form-group">
                        <input type="text" style="padding: 0px; width: 100%;" id="enterDatePicker" name="enterDatePicker">
                    </div>
                </div>
            </div>
            <div class="editor_btns">
                <div class="padding">
                    <a onclick="popDriverStateModalSubmit()" class="k-pager-refresh k-button">
                        <b class="btn-b"><i class="k-icon k-i-check"></i>저장</b>
                    </a>
                    <a id="closeBtn" onclick="popDriverStateModalClose()" class="k-pager-refresh k-button">
                        <b class="btn-b"><i class="k-icon k-i-cancel"></i>닫기</b>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="pop-layer">
    <div class="editor_wrap pop-layer" id="layer1">
        <div class="insertClose">
            <a class="insertCloseButton k-icon k-i-close" onclick="init_popup_close();"></a>
        </div>
        <!-- wrap -->
        <div class="k-tabstrip-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip" tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel" aria-expanded="true" style="display: block;">
                    <div class="editor">
                        <form id="f" data-toggle="validator" role="form" autocomplete="off">
                            <input type="hidden" name="orderId" id="orderId">
                            <input type="hidden" name="sellAllocId" id="sellAllocId">
                            <input type="hidden" name="allocId" id="allocId">
                            <input type="hidden" id="mode" name="mode" value="N">
                            <input type="hidden" id="allocState" name="allocState">
                            <input type="hidden" id="orderState" name="orderState">
                            <fieldset>
                                <legend id="order_legend">오더 등록</legend>
                                <div class="form-group row">
                                    <label class="col-form-label big-name">담당부서</label>
                                    <div class="input-group input-group-sm col-3 middle-name form-group">
                                        <strong class="required">담당부서</strong>
                                        <select id="deptId" name="deptId" class="custom-select col-12" required></select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-form-label big-name big-name-div">
                                        <div>화주</div>
                                        <a id="owner" class="k-pager-refresh k-button openCloseBtn">화주추가열기</a>
                                    </div>
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong class="required">거래처명</strong>
                                        <input type="hidden" id="sellCustId" name="sellCustId">
                                        <input type="hidden" id="sellDeptId" name="sellDeptId">
                                        <input type="hidden" id="custPayType" name="custPayType">
                                        <input style="width: 17.5rem;" name="sellCustName" id="sellCustName" type="text" required>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                    <!-- 22.07.05 이건욱 거래처명 선택시 부서명 -> 대표자명으로 변경 -->
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong>대표자명</strong>
                                        <input type="text" name="reqCeo" id="reqCeo" class="form-control form-control-sm" readonly>
                                    </div>
                                    <div id="prevDiv" style="display: contents;" class="input-group input-group-sm col middle-name form-group">
                                        <a id="prevOrder" href="javascript:popGridList();" style="margin-top: 20px; height: 31px; margin-top: 24px; height: 31px; background: #fff; border-radius: 4px; box-shadow: 0px 0px 2px 0px; color: #0A8DFF; font-weight: bolder;" class="k-pager-refresh k-button">이전거래</a>
                                    </div>
                                </div>
                                <!-- 화주 접기, 열기 부분 -->
                                <div>
                                    <div id="ownerOpenClose" class="openCloseDiv">
                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>거래처등급</strong>
                                                <input type="text" name="custMngCodeName" id="custMngCodeName" class="form-control form-control-sm" readonly>
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>거래처등급사유</strong>
                                                <input type="text" name="custMngMemo" id="custMngMemo" class="form-control form-control-sm" readonly>
                                            </div>
                                        </div>


                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>주소</strong>
                                                <div class="textBox-in-icon">
                                                    <input style="width: 17.5rem;" onclick="popSearchPost('reqAddr');" type="text" name="reqAddr" id="reqAddr" class="form-control form-control-sm addr-text-box" readonly>
                                                    <i><img onclick="popSearchPost('reqAddr');" src="/images/icon/search.png"></i>
                                                </div>
                                            </div>


                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>상세주소</strong>
                                                <input type="text" name="reqAddrDetail" id="reqAddrDetail" class="form-control form-control-sm addr-text-box">
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label big-name"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>담당자</strong>
                                                <input type="hidden" name="sellStaffId" id="sellStaffId">
                                                <input style="width: 100%;" type="text" name="sellStaff" id="sellStaff">
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>연락처</strong>
                                                <input type="text" name="reqTel" id="reqTel" maxlength="13" class="form-control form-control-sm">
                                                <div class="help-block with-errors"></div>
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label big-name"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>사업자번호</strong>
                                                <input type="text" name="reqBizNum" id="reqBizNum" class="form-control form-control-sm" readonly>
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>상호</strong>
                                                <input type="text" name="reqBizName" id="reqBizName" class="form-control form-control-sm" readonly>
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label big-name"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <!-- 22.07.05 이건욱 거래처명 선택시 부서명 -> 대표자명으로 변경 -->
                                                <strong>담당부서</strong>
                                                <input type="text" name="sellDeptName" id="sellDeptName" class="form-control form-control-sm" readonly>
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>사업자주소</strong>
                                                <input type="text" name="reqBizAddr" id="reqBizAddr" class="form-control form-control-sm" readonly>
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label big-name"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>세금계산서 담당자</strong>
                                                <input type="text" name="reqTaxStaffName" id="reqTaxStaffName" class="form-control form-control-sm" readonly>
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>세금계산서 전화번호</strong>
                                                <input type="text" name="reqTaxTelNum" id="reqTaxTelNum" class="form-control form-control-sm" readonly>
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>세금계산서 이메일</strong>
                                                <input type="text" name="reqTaxEmail" id="reqTaxEmail" class="form-control form-control-sm" readonly>
                                            </div>
                                            <div class="col input-group middle-name form-group">
                                                <strong>요청사항</strong>
                                                <input type="text" id="reqMemo" name="reqMemo" class="form-control form-control-sm">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 화주 접기, 열기 부분 -->

                                <div class="form-group row">
                                    <div class="col-form-label big-name big-name-div">
                                        <div>상차</div>
                                        <a id="startAddr" class="k-pager-refresh k-button openCloseBtn">상차추가열기</a>
                                    </div>
                                    <input type="hidden" name="sLat" id="sLat">
                                    <input type="hidden" name="sLon" id="sLon">
                                    <input type="hidden" name="sSido" id="sSido">
                                    <input type="hidden" name="sGungu" id="sGungu">
                                    <input type="hidden" name="sDong" id="sDong">
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong class="required">상차지명</strong>
                                        <input style="width: 100%;" type="text" id="sComName" name="sComName" required>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                    <div class="col input-group middle-name form-group">
                                        <strong class="required">상차 일시</strong>
                                        <input style="padding: 0;" type="text" id="sDateDay" name="sDateDay" class="col-12" required>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                    <div class="col input-group middle-name form-group" id="sTimeDiv">
                                        <strong class="required">상차 시간</strong>
                                        <input style="padding: 0;" type="text" id="sDateTime" name="sDateTime" class="col-12" required>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label big-name"></label>
                                    <div class="col input-group middle-name form-group">
                                        <strong class="required">주소</strong>
                                        <div class="textBox-in-icon">
                                            <input style="width: 17.5rem;" onclick="dummyPopSearchPost('sAddr');" id="sAddr" name="sAddr" type="text" class="form-control form-control-sm addr-text-box" required readonly="readonly">
                                            <i><img onclick="dummyPopSearchPost('sAddr');" src="/images/icon/search.png"></i>
                                            <!-- 											<input style="width:17.5rem;" onclick="popSearchPost('sAddr');" id="sAddr" name="sAddr" type="text" class="form-control form-control-sm addr-text-box" required readonly="readonly"> -->
                                            <!-- 											<i><img onclick="popSearchPost('sAddr');" src="/images/icon/search.png"></i> -->
                                        </div>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                    <div class="col input-group middle-name form-group">
                                        <strong>상세주소</strong>
                                        <input type="text" id="sAddrDetail" name="sAddrDetail" class="form-control form-control-sm addr-text-box">
                                    </div>
                                </div>

                                <!-- 상차지 접기, 열기 부분 -->
                                <div>
                                    <div id="startAddrOpenClose" class="openCloseDiv">
                                        <div class="form-group row">
                                            <label class="col-form-label big-name"></label>
                                            <div class="col input-group middle-name form-group">
                                                <strong>담당자</strong>
                                                <input type="text" id="sStaff" name="sStaff" class="form-control form-control-sm">
                                            </div>
                                            <div class="col input-group middle-name form-group">
                                                <strong>연락처</strong>
                                                <input type="text" id="sTel" name="sTel" maxlength="13" class="form-control form-control-sm">
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="col input-group middle-name form-group">
                                                <strong>상차지 메모</strong>
                                                <input type="text" id="sMemo" name="sMemo" class="form-control form-control-sm">
                                            </div>
                                            <c:if test="${addrAuth.writeYn eq 'Y'}">
                                                <div class="col input-group radio-or-checkBox sAreaSave">
                                                    <input id="sAreaSave" name="sAreaSave" type="checkbox" onclick="btnChk(this)">
                                                    <label for="sAreaSave" class="insert-label"> <span>주소지 저장</span>
                                                    </label>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <!-- 상차지 접기, 열기 부분 -->

                                <div class="form-group row ">
                                    <input type="hidden" name="orderStopData" id="orderStopData">
                                    <label class="col-form-label big-name">경유지</label>
                                    <div class="col input-group i-name">
                                        <i style="font-size: large;" id="iStopTxt"></i>
                                    </div>
                                    <div class="col-3 input-group btn-name">
                                        <a style="background: #fff; border-radius: 4px; box-shadow: 0px 0px 2px 0px; color: #0A8DFF; font-weight: bolder;" onClick="popOrderStopDetail();" class="k-pager-refresh k-button">자세히보기</a>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <div class="col-form-label big-name big-name-div">
                                        <div>하차</div>
                                        <a id="endAddr" class="k-pager-refresh k-button openCloseBtn">하차추가열기</a>
                                    </div>
                                    <input type="hidden" name="eLat" id="eLat">
                                    <input type="hidden" name="eLon" id="eLon">
                                    <input type="hidden" name="eSido" id="eSido">
                                    <input type="hidden" name="eGungu" id="eGungu">
                                    <input type="hidden" name="eDong" id="eDong">
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong class="required">하차지명</strong>
                                        <input style="width: 100%;" type="text" id="eComName" name="eComName" required>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                    <div class="col input-group middle-name form-group">
                                        <strong class="required">하차 일시</strong>
                                        <input style="padding: 0;" type="text" id="eDateDay" name="eDateDay" class="col-12" required>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                    <div class="col input-group middle-name form-group" id="eTimeDiv">
                                        <strong class="required">하차 시간</strong>
                                        <input style="padding: 0;" type="text" id="eDateTime" name="eDateTime" class="col-12" required>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label big-name"></label>
                                    <div class="col input-group middle-name form-group">
                                        <strong class="required">주소</strong>
                                        <div class="textBox-in-icon">
                                            <input style="width: 17.5rem;" onClick="dummyPopSearchPost('eAddr');" id="eAddr" name="eAddr" type="text" class="form-control form-control-sm addr-text-box" readonly="readonly" required>
                                            <i><img onclick="dummyPopSearchPost('eAddr');" src="/images/icon/search.png"></i>
                                            <!-- 											<input style="width:17.5rem;" onClick="" id="eAddr" name="eAddr" type="text" class="form-control form-control-sm addr-text-box" readonly="readonly" required> -->
                                            <!-- 											<i><img onclick="popSearchPost('eAddr');" src="/images/icon/search.png"></i> -->
                                        </div>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                    <div class="col input-group middle-name form-group">
                                        <strong>상세주소</strong>
                                        <input type="text" id="eAddrDetail" name="eAddrDetail" class="form-control form-control-sm addr-text-box">
                                    </div>
                                </div>

                                <!-- 하차지 접기, 열기 부분 -->
                                <div>
                                    <div id="endAddrOpenClose" class="openCloseDiv">
                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="col input-group middle-name form-group">
                                                <strong>담당자</strong>
                                                <input type="text" id="eStaff" name="eStaff" class="form-control form-control-sm">
                                            </div>
                                            <div class="col input-group middle-name form-group">
                                                <strong>연락처</strong>
                                                <input type="text" id="eTel" name="eTel" maxlength="13" class="form-control form-control-sm">
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="col input-group middle-name form-group">
                                                <strong>하차지 메모</strong>
                                                <input type="text" id="eMemo" name="eMemo" class="form-control form-control-sm">
                                            </div>
                                            <c:if test="${addrAuth.writeYn eq 'Y'}">
                                                <div class="col input-group radio-or-checkBox eAreaSave">
                                                    <input id="eAreaSave" name="eAreaSave" type="checkbox" onclick="btnChk(this)">
                                                    <label for="eAreaSave" class="insert-label"> <span>주소지 저장</span>
                                                    </label>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <!-- 하차지 접기, 열기 부분 -->

                                <div class="form-group row">
                                    <div class="col-form-label big-name big-name-div">
                                        <div>화물</div>
                                        <a id="cargo" class="k-pager-refresh k-button openCloseBtn">화물추가열기</a>
                                    </div>
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong class="required">요청차종</strong>
                                        <select class="custom-select col-12" id="carTypeCode" name="carTypeCode" required></select>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong class="required">요청톤수</strong>
                                        <select class="custom-select col-12" id="carTonCode" name="carTonCode" required></select>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label big-name"></label>
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong class="required">화물정보</strong>
                                        <input style="width: 212.13px;" type="text" class="form-control form-control-sm" id="goodsName" name="goodsName" required>
                                        <div class="help-block with-errors"></div>
                                    </div>

                                    <div class="col middle-name form-group">
                                        <strong>중량</strong>
                                        <input type="text" class="form-control form-control-sm" id="goodsWeight" name="goodsWeight" pattern="^(\d*)[\.]?(\d{1,})?$" data-pattern-error='숫자와 "." 기호만 사용할 수 있습니다.'>
                                        <!-- <div class="help-block with-errors"></div> -->
                                    </div>
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong> </strong>
                                        <!-- <select class="custom-select col-12" id="weightUnitCode" name="weightUnitCode" required></select> -->
                                        <input class="form-control form-control-sm" id="weightUnitCode" name="weightUnitCode" value="TON" readonly>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                </div>

                                <!-- 화물 접기, 열기부분 -->
                                <div>
                                    <div id="cargoOpenClose" class="openCloseDiv">
                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong class="required">수출입구분</strong>
                                                <select id="inOutSctn" name="inOutSctn" class="custom-select col-12" required></select>
                                                <div class="help-block with-errors"></div>
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong class="required">운송유형</strong>
                                                <select id="truckTypeCode" name="truckTypeCode" class="custom-select col-12" required></select>
                                                <div class="help-block with-errors"></div>
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>운송품목</strong>
                                                <select style="width: 212.13px;" class="custom-select col-12" id="itemCode" name="itemCode"></select>
                                            </div>

                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>수량</strong>
                                                <input type="text" class="form-control form-control-sm" id="goodsQty" name="goodsQty">
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong> </strong>
                                                <select class="custom-select col-12" id="qtyUnitCode" name="qtyUnitCode"></select>
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong class="required">상차방법</strong>
                                                <select class="custom-select col-12" id="sWayCode" name="sWayCode" required></select>
                                                <div class="help-block with-errors"></div>
                                            </div>

                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong class="required">하차방법</strong>
                                                <select class="custom-select col-12" id="eWayCode" name="eWayCode" required></select>
                                                <div class="help-block with-errors"></div>
                                            </div>

                                            <div class="input-group input-group-sm col radio-or-checkBox form-group">
                                                <input type="checkbox" id="mixYn" name="mixYn" onclick="btnChk(this)">
                                                <label for="mixYn" class="insert-label"> <span>혼적</span>
                                                </label>
                                            </div>

                                            <div class="input-group input-group-sm col middle-name form-group form-group">
                                                <strong>혼적크기</strong>
                                                <select class="custom-select col-12" id="mixSize" name="mixSize"></select>
                                            </div>

                                            <div class="input-group input-group-sm col radio-or-checkBox form-group">
                                                <input type="checkbox" id="returnYn" name="returnYn" onclick="btnChk(this)">
                                                <label for="returnYn" class="insert-label"> <span>왕복</span>
                                                </label>
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div style="display: block; text-align: left; margin: 0.3em;" class="input-group input-group-sm col radio-or-checkBox form-group">
                                                <input type="checkbox" id="dangerGoodsYn" name="dangerGoodsYn" onclick="btnChk(this)">
                                                <label for="dangerGoodsYn" class="insert-label"> <span>위험물</span>
                                                </label>
                                            </div>

                                            <div style="display: block; text-align: center; margin: 0.3em;" class="input-group input-group-sm col radio-or-checkBox form-group">
                                                <input type="checkbox" id="chemicalsYn" name="chemicalsYn" onclick="btnChk(this)">
                                                <label for="chemicalsYn" class="insert-label"> <span>유해물</span>
                                                </label>
                                            </div>

                                            <div style="display: block; text-align: right; margin: 0.3em;" class="input-group input-group-sm col radio-or-checkBox form-group">
                                                <input type="checkbox" id="foreignLicenseYn" name="foreignLicenseYn" onclick="btnChk(this)">
                                                <label for="foreignLicenseYn" class="insert-label"> <span>보세운송</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 화물 접기, 열기부분 -->

                                <!--                                 <div class="form-group row"> -->
                                <!--                                 	<label class="col-form-label big-name">운임</label> -->
                                <!--                                     <div class="input-group input-group-sm col middle-name"> -->
                                <!-- 	                                    <div class="input-group input-group-sm col radio-or-checkBox"> -->
                                <!-- 	                                    	<input value="01" id="chargeType01" name="chargeType" type="radio" checked> -->
                                <!-- 	                                    	<label for="chargeType01" class="label-margin"> -->
                                <!-- 	                                    	<span>인수증</span> -->
                                <!-- 	                                    	</label> -->
                                <!-- 	                                    </div> -->
                                <!-- 	                                    <div class="input-group input-group-sm col radio-or-checkBox"> -->
                                <!-- 	                                    	<input value="02" id="chargeType02" name="chargeType" type="radio"> -->
                                <!-- 	                                    	<label for="chargeType02" class="label-margin"> -->
                                <!-- 	                                    	<span>선/착불</span> -->
                                <!-- 	                                    	</label> -->
                                <!-- 	                                    </div> -->
                                <!-- 	                                </div> -->

                                <!--                                     <div class="input-group input-group-sm col middle-name"> -->
                                <!-- 	                                    <div class="input-group input-group-sm col radio-or-checkBox"> -->
                                <!-- 	                                    	<input value="01" id="unitPriceType01" name="unitPriceType" type="radio" checked> -->
                                <!-- 	                                    	<label for="unitPriceType01" class="label-margin"> -->
                                <!-- 	                                    	<span>대당단가</span> -->
                                <!-- 	                                    	</label> -->
                                <!-- 	                                    </div> -->
                                <!-- 	                                    <div class="input-group input-group-sm col radio-or-checkBox"> -->
                                <!-- 	                                    	<input value="02" id="unitPriceType02" name="unitPriceType" type="radio"> -->
                                <!-- 	                                    	<label for="unitPriceType02" class="label-margin"> -->
                                <!-- 	                                    	<span>톤당단가</span> -->
                                <!-- 	                                    	</label> -->
                                <!-- 	                                    </div> -->
                                <!--                                     </div> -->
                                <!--                                 </div> -->

                                <!-- 기사발행 부분 -->
                                <div class="form-group row">
                                    <label class="col-form-label big-name">운임</label>
                                    <div class="input-group input-group-sm col middle-name">
                                        <div class="input-group input-group-sm col radio-or-checkBox">
                                            <input value="01" id="chargeType01" name="chargeType" type="radio" checked>
                                            <label for="chargeType01" class="label-margin"> <span style="font-size: 0.89rem;">인수증</span>
                                            </label>
                                        </div>
                                        <div class="input-group input-group-sm col radio-or-checkBox">
                                            <input value="02" id="chargeType02" name="chargeType" type="radio">
                                            <label for="chargeType02" class="label-margin"> <span style="font-size: 0.89rem;">선/착불</span>
                                            </label>
                                        </div>
                                        <div class="input-group input-group-sm col radio-or-checkBox">
                                            <input value="03" id="chargeType03" name="chargeType" type="radio">
                                            <label for="chargeType03" class="label-margin"> <span style="font-size: 0.89rem;">기사발행</span>
                                            </label>
                                        </div>
                                        <div class="input-group input-group-sm col radio-or-checkBox">
                                            <input value="01" id="unitPriceType01" name="unitPriceType" type="radio" checked>
                                            <label for="unitPriceType01" class="label-margin"> <span style="font-size: 0.89rem;">대당단가</span>
                                            </label>
                                        </div>
                                        <div class="input-group input-group-sm col radio-or-checkBox">
                                            <input value="02" id="unitPriceType02" name="unitPriceType" type="radio">
                                            <label for="unitPriceType02" class="label-margin"> <span style="font-size: 0.89rem;">톤당단가</span>
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label"></label>
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong>단가입력</strong>
                                        <input id="unitCharge" name="unitCharge" type="text" class="form-control form-control-sm">
                                    </div>
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong class="required">기본운임(청구)</strong>
                                        <input id="sellCharge" name="sellCharge" type="text" class="form-control form-control-sm" onchange="sellSumCharge()" required>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label"></label>
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong>청구중량(ton)</strong>
                                        <input id="sellWeight" name="sellWeight" type="text" class="form-control form-control-sm">
                                    </div>
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong class="priceCommission">수수료</strong>
                                        <input id="sellFee" name="sellFee" type="text" class="form-control form-control-sm priceCommission" readonly>
                                        <input id="sellFeeBack" type="hidden">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label"></label>
                                    <div class="input-group input-group-sm col">
                                        <a style="width: 100%; height: 23px;" id="sellOtherChargeBtn" class="k-button btn-s" href="javascript:sellOtherChargeOpen()"></a>
                                    </div>
                                </div>

                                <div>
                                    <div id="sellOtherCharge" style="display: none;">
                                        <input type="hidden" id="addSellMemoList" name="addSellMemoList" value="">
                                        <input type="hidden" id="addSellCodeList" name="addSellCodeList" value="">
                                        <input type="hidden" id="addSellChargeList" name="addSellChargeList" value="">

                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>경유비(청구)</strong>
                                                <input id="sellWayPointCharge" name="addSellCharge" type="text" class="form-control form-control-sm" pattern="^\d*[\d|,]*\d$" data-pattern-error="숫자만 입력해 주세요." onchange='sellSumCharge()'>
                                                <div class="help-block with-errors"></div>
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>경유비 메모</strong>
                                                <input id="sellWayPointMemo" name="addSellMemo" type="text" class="form-control form-control-sm">
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>대기료(청구)</strong>
                                                <input id="sellStayCharge" name="addSellCharge" type="text" class="form-control form-control-sm" pattern="^\d*[\d|,]*\d$" data-pattern-error="숫자만 입력해 주세요." onchange='sellSumCharge()'>
                                                <div class="help-block with-errors"></div>
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>대기료 메모</strong>
                                                <input id="sellStayMemo" name="addSellMemo" type="text" class="form-control form-control-sm">
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>수작업비(청구)</strong>
                                                <input id="sellHandWorkCharge" name="addSellCharge" type="text" class="form-control form-control-sm" pattern="^\d*[\d|,]*\d$" data-pattern-error="숫자만 입력해 주세요." onchange='sellSumCharge()'>
                                                <div class="help-block with-errors"></div>
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>수작업비 메모</strong>
                                                <input id="sellHandWorkMemo" name="addSellMemo" type="text" class="form-control form-control-sm">
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>회차료(청구)</strong>
                                                <input id="sellRoundCharge" name="addSellCharge" type="text" class="form-control form-control-sm" pattern="^\d*[\d|,]*\d$" data-pattern-error="숫자만 입력해 주세요." onchange='sellSumCharge()'>
                                                <div class="help-block with-errors"></div>
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>회차료 메모</strong>
                                                <input id="sellRoundMemo" name="addSellMemo" type="text" class="form-control form-control-sm">
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>기타추가비(청구)</strong>
                                                <input id="sellOtherAddCharge" name="addSellCharge" type="text" class="form-control form-control-sm" pattern="^\d*[\d|,]*\d$" data-pattern-error="숫자만 입력해 주세요." onchange='sellSumCharge()'>
                                                <div class="help-block with-errors"></div>
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>기타추가비 메모</strong>
                                                <input id="sellOtherAddMemo" name="addSellMemo" type="text" class="form-control form-control-sm">
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>청구운임(소계)</strong>
                                                <input id="addSumSellCharge" name="addSumSellCharge" type="text" class="form-control form-control-sm noColorReadonly" readonly>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <div class="col-form-label big-name big-name-div">
                                        <div>배차</div>
                                        <a id="allocD" class="k-pager-refresh k-button openCloseBtn">배차추가열기</a>
                                        <a id="allocC" style="display: none;" class="k-pager-refresh k-button openCloseBtn">배차추가열기</a>
                                    </div>
                                    <div class="input-group input-group-sm col radio-or-checkBox">
                                        <input id="car" name="allocKind" type="radio" value="D" checked="checked">
                                        <label for="car" class="label-margin"> <span>직접배차</span>
                                        </label>
                                    </div>
                                    <div class="input-group input-group-sm col radio-or-checkBox">
                                        <input id="carrier" name="allocKind" type="radio" value="C">
                                        <label for="carrier" class="label-margin"> <span>운송사지정</span>
                                        </label>
                                    </div>
                                    <div class="input-group input-group-sm col" id="allocButtons" style="display: none; align-self: flex-end;">
                                        <a class="k-button" href="javascript:updateAllocState('D', '21')">실행취소</a>
                                    </div>
                                    <div class="input-group input-group-sm col" id="driverProposal" style="align-self: flex-end;">
                                        <a id="driverProposalBtn" class="k-button">추천차주</a>
                                    </div>
                                </div>

                                <!-- 운송사지정 열기, 접기부분 미정-->
                                <div id="divAllocC">
                                    <div class="form-group row">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <input type="hidden" name="buyCustId" id="buyCustId">
                                            <input type="hidden" name="buyDeptId" id="buyDeptId">

                                            <strong>운송사</strong>
                                            <input style="width: 100%;" type="text" name="buyCustName" id="buyCustName">
                                        </div>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>담당부서</strong>
                                            <input type="text" name="buyDeptName" id="buyDeptName" class="form-control form-control-sm" readonly>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>담당자</strong>
                                            <input type="hidden" name="buyStaffId" id="buyStaffId">
                                            <input style="width: 100%;" type="text" name="buyStaff" id="buyStaff">
                                        </div>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>연락처</strong>
                                            <input type="text" name="buyStaffTel" id="buyStaffTel" maxlength="13" class="form-control form-control-sm">
                                        </div>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>지불운임</strong>
                                            <input id="buyChargeC" name="buyCharge" type="text" class="form-control form-control-sm" onchange="sumCharge()">
                                        </div>
                                    </div>
                                </div>
                                <!-- 운송사지정 열기, 접기부분 -->

                                <div id="divAllocD" style="display: none;">
                                    <div class="form-group row">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <input type="hidden" name="buyLinkYn" id="buyLinkYn">
                                            <input type="hidden" name="linkType" id="linkType">
                                            <input type="hidden" id="buyVehicId" name="buyVehicId">
                                            <input type="hidden" id="buyDriverId" name="buyDriverId">
                                            <input type="hidden" id="carPayType" name="carPayType">
                                            <strong>차량번호</strong>
                                            <input style="width: 100%;" type="text" name="buyCarNum" id="buyCarNum" pattern="^[가-힣ㄱ-ㅎㅏ-ㅣ\x20]{2}\d{2}[아,바,사,자\x20]\d{4}$" data-pattern-error="차량번호를 확인해 주세요." maxlength="10" placeholder="서울XX아XXXX">
                                            <div class="help-block with-errors"></div>
                                        </div>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>차량구분</strong>
                                            <select class="custom-select col-12" id="carSctnCode" name="carSctnCode"></select>
                                        </div>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>정보망배차</strong>
                                            <select class="custom-select col-12" id="linkSelect" name="linkSelect"></select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>차주성명</strong>
                                            <input type="text" name="buyDriverName" id="buyDriverName" class="form-control form-control-sm">
                                        </div>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>휴대전화</strong>
                                            <input type="text" name="buyDriverTel" id="buyDriverTel" class="form-control form-control-sm" maxlength="13">
                                        </div>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>지불운임</strong>
                                            <a id="priceDetail" class="k-pager-refresh k-button" style="margin-top: -5px; height: 19px; width: 19px;"> ? </a>
                                            <input id="buyChargeD" name="buyCharge" type="text" class="form-control form-control-sm" onchange="sumCharge()">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>차주 차종</strong>
                                            <select class="custom-select col-12" id="buyCarTypeCode" name="buyCarTypeCode"></select>
                                        </div>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>차주 톤수</strong>
                                            <select class="custom-select col-12" id="buyCarTonCode" name="buyCarTonCode"></select>
                                        </div>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>빠른지급여부</strong>
                                            <select class="custom-select col-12" id="payType" name="payType"></select>
                                        </div>
                                    </div>
                                    <!-- 직접배차 열기, 접기부분 미정-->
                                    <div id="allocDOpenClose" class="openCloseDiv">
                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>차주 등급</strong>
                                                <select class="custom-select col-12" id="carMngCode" name="carMngCode"></select>
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>차주등급사유</strong>
                                                <input type="text" class="form-control form-control-sm" id="carMngMemo" name="carMngMemo">
                                            </div>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>적재함길이</strong>
                                                <input type="text" class="form-control form-control-sm" id="buyCargoBox" name="buyCargoBox" maxlength="30">
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 직접배차 열기, 접기부분 미정-->
                                </div>

                                <!-- 배차 기타 정보 열기, 접기부분 -->
                                <div id="driverOtherOpenClose" class="openCloseDiv">
                                    <div class="form-group row">
                                        <label class="col-form-label"></label>
                                        <div class="col input-group middle-name form-group">
                                            <strong>차주확인사항</strong>
                                            <input id="driverMemo" name="driverMemo" type="text" class="form-control form-control-sm">
                                        </div>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>배차일자</strong>
                                            <input type="text" style="padding: 0px; width: 100%;" id="allocDate" name="allocDate">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-form-label"></label>
                                        <div class="input-group input-group-sm col">
                                            <a style="width: 100%; height: 23px;" id="otherChargeBtn" class="k-button btn-s" href="javascript:otherChargeOpen()"></a>
                                        </div>
                                    </div>

                                    <div>
                                        <div id="otherCharge" style="display: none;">
                                            <input type="hidden" id="addMemoList" name="addMemoList" value="">
                                            <input type="hidden" id="addCodeList" name="addCodeList" value="">
                                            <input type="hidden" id="addChargeList" name="addChargeList" value="">
                                            <div class="form-group row">
                                                <label class="col-form-label"></label>
                                                <div class="input-group input-group-sm col middle-name form-group">
                                                    <strong>경유비(지불)</strong>
                                                    <input id="wayPointCharge" name="addCharge" type="text" class="form-control form-control-sm" pattern="^\d*[\d|,]*\d$" data-pattern-error="숫자만 입력해 주세요." onchange='sumCharge()'>
                                                    <div class="help-block with-errors"></div>
                                                </div>
                                                <div class="input-group input-group-sm col middle-name form-group">
                                                    <strong>경유비 메모</strong>
                                                    <input id="wayPointMemo" name="addMemo" type="text" class="form-control form-control-sm">
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label class="col-form-label"></label>
                                                <div class="input-group input-group-sm col middle-name form-group">
                                                    <strong>대기료(지불)</strong>
                                                    <input id="stayCharge" name="addCharge" type="text" class="form-control form-control-sm" pattern="^\d*[\d|,]*\d$" data-pattern-error="숫자만 입력해 주세요." onchange='sumCharge()'>
                                                    <div class="help-block with-errors"></div>
                                                </div>
                                                <div class="input-group input-group-sm col middle-name form-group">
                                                    <strong>대기료 메모</strong>
                                                    <input id="stayMemo" name="addMemo" type="text" class="form-control form-control-sm">
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label class="col-form-label"></label>
                                                <div class="input-group input-group-sm col middle-name form-group">
                                                    <strong>수작업비(지불)</strong>
                                                    <input id="handWorkCharge" name="addCharge" type="text" class="form-control form-control-sm" pattern="^\d*[\d|,]*\d$" data-pattern-error="숫자만 입력해 주세요." onchange='sumCharge()'>
                                                    <div class="help-block with-errors"></div>
                                                </div>
                                                <div class="input-group input-group-sm col middle-name form-group">
                                                    <strong>수작업비 메모</strong>
                                                    <input id="handWorkMemo" name="addMemo" type="text" class="form-control form-control-sm">
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label class="col-form-label"></label>
                                                <div class="input-group input-group-sm col middle-name form-group">
                                                    <strong>회차료(지불)</strong>
                                                    <input id="roundCharge" name="addCharge" type="text" class="form-control form-control-sm" pattern="^\d*[\d|,]*\d$" data-pattern-error="숫자만 입력해 주세요." onchange='sumCharge()'>
                                                    <div class="help-block with-errors"></div>
                                                </div>
                                                <div class="input-group input-group-sm col middle-name form-group">
                                                    <strong>회차료 메모</strong>
                                                    <input id="roundMemo" name="addMemo" type="text" class="form-control form-control-sm">
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label class="col-form-label"></label>
                                                <div class="input-group input-group-sm col middle-name form-group">
                                                    <strong>기타추가비(지불)</strong>
                                                    <input id="otherAddCharge" name="addCharge" type="text" class="form-control form-control-sm" pattern="^\d*[\d|,]*\d$" data-pattern-error="숫자만 입력해 주세요." onchange='sumCharge()'>
                                                    <div class="help-block with-errors"></div>
                                                </div>
                                                <div class="input-group input-group-sm col middle-name form-group">
                                                    <strong>기타추가비 메모</strong>
                                                    <input id="otherAddMemo" name="addMemo" type="text" class="form-control form-control-sm">
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label class="col-form-label"></label>
                                                <div class="input-group input-group-sm col middle-name form-group">
                                                    <strong>지불운임(소계)</strong>
                                                    <input id="addSumCharge" name="addSumCharge" type="text" class="form-control form-control-sm noColorReadonly" readonly>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div id="driverKind" class="form-group row">
                                        <label class="col-form-label big-name">차량</label>
                                        <div id="carModalBtnDiv" class="col input-group btn-name">
                                            <a style="background: #fff; border-radius: 4px; box-shadow: 0px 0px 2px 0px; color: #0A8DFF; font-weight: bolder;" id="carModalBtn" class="k-pager-refresh k-button">운송사 차량 직접 배차</a>
                                        </div>

                                        <div id="carNumDataDiv" class="input-group input-group-sm col middle-name form-group">
                                            <strong>차량번호</strong>
                                            <input type="text" id="carNumData" class="form-control form-control-sm" readonly>
                                        </div>
                                        <div id="driverNameDataDiv" class="input-group input-group-sm col middle-name form-group">
                                            <strong>차주성명</strong>
                                            <input type="text" id="driverNameData" class="form-control form-control-sm" readonly>
                                        </div>
                                        <div id="driverTelDataDiv" class="input-group input-group-sm col middle-name form-group">
                                            <strong>휴대전화</strong>
                                            <input type="text" id="driverTelData" class="form-control form-control-sm" readonly>
                                        </div>
                                    </div>

                                    <div id="driverStateDiv" class="form-group row">
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>차량상태</strong>
                                            <select id="driverState" name="driverState" class="custom-select col-12"></select>
                                        </div>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>입차시간</strong>
                                            <input id="enterDate" name="enterDate" type="text" class="form-control form-control-sm" readonly>
                                        </div>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>출발시간</strong>
                                            <input id="startDate" name="startDate" type="text" class="form-control form-control-sm" readonly>
                                        </div>
                                        <div class="input-group input-group-sm col middle-name form-group">
                                            <strong>도착시간</strong>
                                            <input id="finishDate" name="finishDate" type="text" class="form-control form-control-sm" readonly>
                                        </div>
                                    </div>
                                </div>
                                <!-- 배차 기타 정보 열기, 접기부분 -->

                                <div class="form-group row">
                                    <div class="col-form-label big-name big-name-div">
                                        <div>기타</div>
                                        <a id="other" class="k-pager-refresh k-button openCloseBtn">기타추가열기</a>
                                    </div>
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong>거리(km)</strong>
                                        <input id="distance" name="distance" type="text" class="form-control form-control-sm" readonly>
                                    </div>
                                    <div class="input-group input-group-sm col middle-name form-group">
                                        <strong>시간</strong>
                                        <input id="time" name="time" type="hidden" class="form-control form-control-sm" readonly>
                                        <input id="timeTxt" name="timeTxt" type="text" class="form-control form-control-sm" readonly>
                                    </div>
                                    <div class="input-group input-group-sm col middle-name form-group"></div>
                                </div>

                                <div>
                                    <div id="otherOpenClose" class="openCloseDiv">
                                        <div class="form-group row">
                                            <label class="col-form-label"></label>
                                            <div class="input-group input-group-sm col middle-name form-group">
                                                <strong>메모</strong>
                                                <textarea rows="4" id="memo" name="memo" class="form-control form-control-sm textarea"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                            <div class="editor_btns" style="text-align: center;">
                                <div class="padding">
                                    <a id="orderDelete" onclick="updateOrderState('09')" class="k-pager-refresh k-button">
                                        <b class="btn-r"><span id="btn_state"><i class="k-icon k-i-delete"></i>오더취소</span></b>
                                    </a>
                                    <button type="submit" onclick="readonlyValidator();" class="k-pager-refresh k-button" id="btnSubmit">
                                        <b class="btn-b"><i class="k-icon k-i-check"></i><strong id="btn_save">저장</strong></b>
                                    </button>
                                    <a id="orderCopy" onclick="orderCopy();" class="k-pager-refresh k-button">
                                        <b class="btn-b"><i class="k-icon k-i-file"></i>복사</b>
                                    </a>
                                    <a onclick="form_popup_close();" class="k-pager-refresh k-button">
                                        <b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b>
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- editor -->
                </div>
            </div>
            <!-- content -->
        </div>
    </div>
    <!-- wrap -->
    <div id="divOrderStop"></div>
    <div id="driverProposalView"></div>
    <div id="linkDriverView"></div>
</div>
<script type="text/javascript">
var sellCustName, buyCustName;
var reqStaff, buyStaff;
var sComName, eComName;
var carNum, buyCarNum;
var g_mode = "";
var win = null;
var lastDeptSeleted;
var popColumns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "sellCustName", title: "거래처명", width: 100 },
	{ field: "allocStateName", title: "상태", width: 100 },
	{ field: "sComName", title: "상차지", width: 100 },
	{ field: "sDateDay", title: "상차일자", width: 100 },
	{ field: "sDateTime", title: "상차시간", width: 100 },
	{ field: "sTel", title: "상차지연락처", width: 130,
		template: function(dataItem) {
			return Util.formatPhone(dataItem.sTel);
		}
	},
	{ field: "eComName", title: "하차지", width: 100 },
	{ field: "eDateDay", title: "하차일자", width: 100 },
	{ field: "eDateTime", title: "하차시간", width: 100 },
	{ field: "eTel", title: "하차지연락처", width: 130,
		template: function(dataItem) {
			return Util.formatPhone(dataItem.eTel);
		}
	},
	{ field: "regdate", title: "등록일자", width: 150 },
];

var oPopGrid = null;
oPopGrid = new gridData("popGrid");
oPopGrid.initGrid();
oPopGrid.setEditable(false);
oPopGrid.setSortable(false);
oPopGrid.setSelectable(true);
oPopGrid.setSendUrl("/contents/order/data/orderList.do");
oPopGrid.setGrid(popColumns); 

var carTypeData = Util.getComCode("CAR_TYPE_CD");
var carTonData = Util.getComCode("CAR_TON_CD");
var truckTypeData = Util.getComCode("TRUCK_TYPE_CD");

var dataSource = new kendo.data.DataSource({
	serverFiltering: true,
	type: "json",
	transport: {
		read : {
			url: "/contents/basic/data/userList.do",
			dataType: "json",
			type: "post",
			data: {
				useYn : "Y",
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
});


$(document).ready(function(){
	Util.setCmmCode("select", "inOutSctn", "IN_OUT_SCTN", "01", "선택하세요");
	Util.setCmmCode("select", "qtyUnitCode", "QTY_UNIT_CD", "", "선택하세요");
	Util.setCmmCode("select", "sWayCode", "WAY_TYPE_CD", "지", "선택하세요");
	Util.setCmmCode("select", "eWayCode", "WAY_TYPE_CD", "지", "선택하세요");
	Util.setCmmCode("select", "mixSize", "MIX_SIZE_CD", "", "선택하세요");
	Util.setCmmCode("select", "itemCode", "ITEM_CD", "", "선택하세요");
	Util.setCmmCode("select", "driverState", "ALLOC_STATE_CD", "00", "");
	Util.setCmmCode("select", "carSctnCode", "CARGO_TRAN_CAR_SCTN_CD", "11", "선택하세요");
    Util.setCmmCode("select", "linkSelect", "LINK_CD", "", "직접배차");
    Util.setCmmCode("select", "payType", "PAY_TYPE_CD", "N", "선택하세요");
	$("[name='driverState'] option").not("[value='01']").not("[value='04']")
	.not("[value='05']").not("[value='12']").not("[value='21']").remove();
	

	setFrtSelect(truckTypeData, "truckTypeCode", "01", "TR");
	setFrtSelect(carTypeData, "carTypeCode", "TR", "");
	setFrtSelect(carTonData, "carTonCode", "TR", "");
	setFrtSelect(carTypeData, "buyCarTypeCode", "", "");
	setFrtSelect(carTonData, "buyCarTonCode", "", "");
	
	$("#sDateDay").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
	$("#eDateDay").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
	
	var sDateDay = $("#sDateDay").data("kendoDatePicker");
	var eDateDay = $("#eDateDay").data("kendoDatePicker");
	var allocDate = $("#allocDate").data("kendoDatePicker");
	sDateDay.bind("change", function() {
		eDateDay.min(new Date($("#sDateDay").val()));
		eDateDay.value(new Date($("#sDateDay").val()));
	});
	$("#sDateTime, #eDateTime").kendoTimePicker({format: "HH:mm", value : new Date(), dateInput: true});
	$("#enterDatePicker").kendoDateTimePicker({format: "yyyy-MM-dd HH:mm:ss", timeFormat: "HH:mm:ss", value : new Date(), dateInput: true});
	$("#allocDate").kendoDateTimePicker({format: "yyyy-MM-dd HH:mm:ss", timeFormat: "HH:mm:ss", value : new Date(), dateInput: true});
	
	$("input[data-role='datepicker']").on("focus", function(e) {
		var id = e.target.id;
		switch (id) {
			case "sDateDay" :
				sDateDayChangeFocusFlag = 0;
				break;

			case "eDateDay" :
				eDateDayChangeFocusFlag = 0;
				break;
			default :
				break;
		}
	});

	$("input[data-role='timepicker']").on("focus", function(e) {
		var id = e.target.id;
		switch (id) {
			case "sDateTime" :
				sDateTimeChangeFocusFlag = 0;
				break;

			case "eDateTime" :
				eDateTimeChangeFocusFlag = 0;
				break;
			default :
				break;
		}
	});
	
    $("input[data-role='datepicker']").on("keydown", function(e) {
        if ($.isNumeric(e.key)) {
            var id = e.target.id;

            switch (id) {
                case "sDateDay":
                	sDateDayChangeFocusFlag++;
                    if (sDateDayChangeFocusFlag === 4 || sDateDayChangeFocusFlag === 6) {
                    	//sDateDayChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                case "eDateDay":
                	eDateDayChangeFocusFlag++;
                    if (eDateDayChangeFocusFlag === 4 || eDateDayChangeFocusFlag === 6) {
                    	//sDateDayChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                default:
                    break;
            }
        }
    });

    $("input[data-role='timepicker']").on("keydown", function(e) {
        if ($.isNumeric(e.key)) {
            var id = e.target.id;
            switch (id) {
                case "sDateTime":
                	sDateTimeChangeFocusFlag++;
                    if (sDateTimeChangeFocusFlag === 2) {
                    	sDateTimeChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                case "eDateTime":
                	eDateTimeChangeFocusFlag++;
                    if (eDateTimeChangeFocusFlag === 2) {
                    	eDateTimeChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                default:
                    break;
            }
        }
    });
	
	$("#driverKind").hide();
	$("#allocButtons").hide();
	$("#driverStateDiv").hide();
	$("#car").prop("disabled",  false);
	$("#carrier").prop("disabled", false);

	$(".splitter").kendoSplitter({  
        orientation: "vertical",
        panes: [{resizable:true}, {resizable:true}]
    }); 
	
	$("#inOutSctn").on("change", function(){
		setFrtSelect(truckTypeData, "truckTypeCode", $(this).val(), "");
	});
	
	$("#truckTypeCode").on("change", function(){
		setFrtSelect(carTypeData, "carTypeCode", $(this).val(), "");
		setFrtSelect(carTonData, "carTonCode", $(this).val(), "");		
	});

	$("input[name='chargeType']:radio").on("change", function(){
		payTypeChk();
		var chargeTypeValue = this.value;
		
		if(chargeTypeValue == "01"){
			$(".priceCommission").attr("readonly",true);
			if($("#sellFee").val() != ""){
				$("#sellFee").val("");
			}
		}else {
			$(".priceCommission").removeAttr("readonly");
			if($("#sellFeeBack").val() != ""){
				$("#sellFee").val($("#sellFeeBack").val());
			}
			$("#sellFee").val(Util.formatNumberInput($("#sellFee").val()))
		}
	});

	priceModal = $("#priceView");
	priceDetail = $("#priceDetail");
	
	priceDetail.click(function() {
		var sGungu = $("#sGungu").val().split(' ')[0];
		var eGungu = $("#eGungu").val().split(' ')[0];
		var param = {
			sSido: $("#sSido").val(),
			sGungu: sGungu,
			eSido: $("#eSido").val(),
			eGungu: eGungu,
			carTonCode: $("#carTonCode").val()
		}
		
		$.ajax({
			url: "/contents/order/data/priceDetail.do",
			type: "POST",
			dataType: "json",
			data: param,				
			success: function(data){
				$("#minFare").html(Util.nvl(Util.formatNumber(data.data.minFare),'0'));
				$("#maxFare").html(Util.nvl(Util.formatNumber(data.data.maxFare),'0'));
				$("#avgFare").html(Util.nvl(Util.formatNumber(data.data.avgFare),'0'));
			}
		})
		priceModal.data("kendoDialog").open();
	});

	priceModal.kendoDialog({
		width: "200px",
		height: "150px",
		visible: false,
		closable: true,
		title: "운임비용",
		modal: false,
		close: function(){priceModal.fadeIn();}
	});
	
	prevModal = $("#prveOrderList");
	prevOrder = $("#prevOrder");
	
	prevOrder.click(function() {
		prevModal.data("kendoDialog").open();
	});
	
	prevModal.kendoDialog({
		width: "800px",
		height: "503px",
		visible: false,
		closable: true,
		title: "이전거래",
		modal: false,
		close: function(){prevOrder.fadeIn();}
	});

	carModal = $("#carModal");
	carModalBtn = $("#carModalBtn");
	
	carModalBtn.click(function() {
		carModal.data("kendoDialog").open();
	})
	
	carModal.kendoDialog({
		width: "450px",
		height: "341px",
		visible: false,
		closable: true,
		title: "배차등록",
		modal: false,
		close: function(){carModalBtn.fadeIn();}
	});
	
	popDriverStateModal = $("#popDriverState");
	
	popDriverStateModal.kendoDialog({
		width: "350px",
		height: "230px",
		visible: false,
		title: "입차",
		closable: true,
		modal: false,
		close: function(){popDriverStateModal.fadeIn();}
	})
	
	$("#driverProposalBtn").on("click", function(){
		if(!$("#eSido").val() != '' && !$("#eGungu").val() != '' && !$("#eDong").val() != ''
		&& !$("#sSido").val() != '' && !$("#sGungu").val() != '' && !$("#sDong").val() != ''){
			alert("상차지, 하차지를 입력해 주세요.")	;
			return;
		}
		if(!$("#inOutSctn").val()){
			alert("수출입구분을 선택해 주세요.");
			return;
		}
		if(!$("#truckTypeCode").val()){
			alert("운송유형을 선택해 주세요.");
			return;
		}
		if(!$("#carTypeCode").val()){
			alert("요청차종을 선택해 주세요.");
			return;
		}
		if(!$("#carTonCode").val()){
			alert("요청톤수를 선택해 주세요.");
			return;
		}
		driverProposalView();
	});

	$("#divAllocC").find("input, select").attr("disabled",true);
	$("#divAllocD").find("input, select").removeAttr("disabled");
	$("#f input[name=allocKind]").on("click", function(){
		if($(this).val() == "C") {
			$("#divAllocC").show();
			$("#divAllocD").hide();
			$("#divAllocD").find("input, select").attr("disabled",true);
			$("#divAllocC").find("input, select").removeAttr("disabled");
			$("#driverProposal").hide();
			$("#allocC").show();
			$("#allocD").hide();
			$("#allocDOpenClose").hide();
			$("#driverOtherOpenClose").hide();
			$("#allocC").html("배차추가열기");
			if(!$("#buyCustId").val()) {
				buyCustName.enable(true);	
			}
		} else {
			$("#divAllocD").show();
			$("#divAllocC").hide();
			$("#divAllocC").find("input, select").attr("disabled",true);
			$("#divAllocD").find("input, select").removeAttr("disabled");
			$("#driverProposal").show();
			$("#allocD").show();
			$("#allocC").hide();
			$("#allocCOpenClose").hide();
			$("#driverOtherOpenClose").hide();
			$("#allocD").html("배차추가열기");
		}
	});
	
	// 부서 선택 기본값 : session dept_id
	lastDeptSeleted = "${sessionScope.userInfo.deptId}";
	$("#deptId").val(lastDeptSeleted);
	//상하차지 자동완성
	sComName = MultiColumnComboBox.setComName("s", lastDeptSeleted);
	eComName = MultiColumnComboBox.setComName("e", lastDeptSeleted);

	// 22.07.05 이건욱 T1 > 거래처 조회시 부서명 제외하고 대표명으로 조회 (화주용)
	//거래처 자동완성
	sellCustName = MultiColumnComboBox.setCustNameWithCeoName("sell", "01", lastDeptSeleted);
	sellCustName.bind("select", changeSellCust);
	sellCustName.bind("change", searchSellCustSelectTrigger);
	sellCustName.bind("select", payTypeChk);

	//담당직원 자동완성	
	reqStaff = 	MultiColumnComboBox.setStaff("sell");
		
	//운송사 자동완성
	buyCustName = MultiColumnComboBox.setCustName("buy", "02", lastDeptSeleted);
	buyCustName.bind("select", changeBuyCust);
	buyCustName.bind("change", searchBuyCustSelectTrigger);

	//담당직원 자동완성	
	buyStaff = 	MultiColumnComboBox.setStaff("buy");
	//차량
	buyCarNum = MultiColumnComboBox.setCarNum("buyCarNum", lastDeptSeleted, "");
	buyCarNum.bind("select", changeBuyCarNum);
	buyCarNum.bind("change", searchCarNumSelectTrigger);
	buyCarNum.bind("select", payTypeChk);
	buyCarNum.bind("select", driverCodeChk);
	
	if("${addrAuth.writeYn}" == "Y") {
		// 주소지 체크
		$('#sComName, #sAddrDetail, #sStaff, #sTel').on('change', function() {
			checkCustAddr('s');
		})

		$('#eComName, #eAddrDetail, #eStaff, #eTel').on('change', function() {
			checkCustAddr('e');
		})
	}
	
	sComName.bind("select", addrLatLonValidation);
	eComName.bind("select", addrLatLonValidation);

	$('#carTonCode').change(function(){
		var carTonCode = $(this).val();
		
		if(carTonCode != "") {
			getCharge("S"); 
		}
	});

	$("#buyCustName").change(function() {
		var buyDeptName = $(this).val();
		
		if(buyDeptName != "") {
			getCharge("B");
		}
	});
	
	//담당부서 변경 시, 기초 데이터 초기화
	$("#deptId").change(function() {
		lastDeptSeleted = $(this).val();	
		sComName.destroy();
		sComName = MultiColumnComboBox.setComName("s", lastDeptSeleted);
		
		eComName.destroy();
		eComName = MultiColumnComboBox.setComName("e", lastDeptSeleted);
		
		// 22.07.05 이건욱 T1 > 거래처 조회시 부서명 제외하고 대표명으로 조회 (화주용)
		// 거래처 자동완성
		sellCustName.destroy();
		sellCustName = MultiColumnComboBox.setCustNameWithCeoName("sell", "01", lastDeptSeleted);
		sellCustName.bind("select", changeSellCust);
		sellCustName.bind("change", searchSellCustSelectTrigger);

		sellCustName.value('');
		
		reqStaff.destroy();
		reqStaff = 	MultiColumnComboBox.setStaff("sell");
			
		//운송사 자동완성
		buyCustName.destroy();
		buyCustName = MultiColumnComboBox.setCustName("buy", "02", lastDeptSeleted);
		buyCustName.bind("select", changeBuyCust);
		buyCustName.bind("change", searchBuyCustSelectTrigger);

		//담당직원 자동완성	
		buyStaff.destroy();
		buyStaff = 	MultiColumnComboBox.setStaff("buy");

		buyCarNum.destroy();
		buyCarNum = MultiColumnComboBox.setCarNum("buyCarNum", lastDeptSeleted, "");
		buyCarNum.bind("select", changeBuyCarNum);
		buyCarNum.bind("change", searchCarNumSelectTrigger);
	});
});

function gridDataSet(data) {
	//init();
	buyCarNum.value('');
	sellCustName.enable(false);
	$("#reqAddr").attr("disabled", true); 
	$("#reqAddr").next("i").children('img').attr("onclick", "");
	$("#reqAddrDetail").attr("disabled", true);
	$("input[name^='reqAddr']").removeAttr("required");

	if("${menuAuth.editYn}" != "Y")	$("#btnSubmit").hide();
	if("${menuAuth.writeYn}" != "Y")	$("#orderCopy").hide();
	
	//더미 상/하차지 위도경도 세팅
	if(data.sLat == ""){
		data.sLat = "0.0"
	}
	if(data.sLon == ""){
		data.sLon = "0.0"
	}
	if(data.eLat == ""){
		data.eLat = "0.0"
	}
	if(data.eLon == ""){
		data.eLon = "0.0"
	}

	//거래처명 세팅
	Util.setPageData(data);
	if(data.allocDate == null){
		$("#allocDate").val(new Date(+new Date() + 3240 * 10000).toISOString().replace("T", " ").replace(/\..*/, ''));
	}else{
		$("#allocDate").val(data.allocDate);
	}
	//배차일자
	var eDateTime = $("#eDateTime").data("kendoTimePicker");
	var sDateTime = $("#sDateTime").data("kendoTimePicker");
	sDateTime.value(data.sDateTime);
	eDateTime.value(data.eDateTime);
	if(data.carMngCode == null){
		$("#carMngCode").val("01").prop("selected", true);
	}
	$("#sellFeeBack").val(data.sellFee);
	
	if (lastDeptSeleted != data.deptId) {
		lastDeptSeleted = data.deptId;
		$("#deptId").trigger("change");		
	} 

	$("#deptId").prop("disabled", true);
	setTimeout(function(){
		var name = data.sellCustName;
		sellCustName.select(function(dataItem) {
		    return dataItem.custName === name;
		});
		sellCustName.value(name);
		sellCustName.trigger("change");

		reqStaff= $("#sellStaff").data("kendoMultiColumnComboBox");
		reqStaff.refresh();
		//화주담당자 세팅
		reqStaff.value(data.reqStaff);
		
		//상차지명 세팅
		sComName.value(data.sComName);
		
		//하차지명 세팅
		eComName.value(data.eComName);
		
		//배차거래처 세팅
		var name = data.buyCustName;
		buyCustName.select(function(dataItem) {
		    return dataItem.custName === name;
		});
		//배차담당자 세팅
		
		buyStaff= $("#buyStaff").data("kendoMultiColumnComboBox");
		buyStaff.refresh();
		buyStaff.value(data.buyStaff);
		
		
	}, 50);
	
	$("#sellFee").val(Util.formatNumberInput($("#sellFee").val()))
	
	//차량 세팅
	//carNum.value(data.carNum);
	
	//checkBox 별도 세팅	
	$("input[name=mixYn]:input[value=" + data.mixYn + "]").prop("checked", true);
	btnChkData('mixYn');
	$("input[name=returnYn]:input[value=" + data.returnYn + "]").prop("checked", true);
	btnChkData('returnYn');
	
	$("input[name=dangerGoodsYn]:input[value=" + data.dangerGoodsYn + "]").prop("checked", true);
	btnChkData('dangerGoodsYn');
	
	$("input[name=chemicalsYn]:input[value=" + data.chemicalsYn + "]").prop("checked", true);
	btnChkData('chemicalsYn');
	
	$("input[name=foreignLicenseYn]:input[value=" + data.foreignLicenseYn + "]").prop("checked", true);
	btnChkData('foreignLicenseYn');
	
	$("#car").attr("disabled", false);
	$("#carrier").attr("disabled", false);
	//radio button 별도 세팅
	$("#f input[name=chargeType]:input[value=" + data.chargeType + "]").prop("checked", true);
	$("#f input[name=allocKind]:input[value=" + data.allocKind + "]").prop("checked", true);
	$("#f input[name=allocKind]:input[value=" + data.allocKind + "]").trigger("click");
	$("#f input[name=unitPriceType]:input[value=" + data.unitPriceType + "]").prop("checked", true);
	
	//운임상태가 인수증이 아니면 수수료 readonly속성 삭제 
	if (data.chargeType == "01"){
		$(".priceCommission").attr("readonly",true); 
	} else{
		$(".priceCommission").removeAttr("readonly");
	}
	
	if(Util.nvl(data.linkType,'') == '99'){
		$("#linkSelect").val('')
	}else if(Util.nvl(data.linkType,'') != ''){
		$("#linkSelect").val(data.linkType)
	}else{
		$("#linkSelect").val('')
	}
	$("#driverKind").hide();
	buyCarNum.readonly(false);
	if($("#f [name='driverState'] option[value='21']").length == 0) {
		$("#f [name='driverState']").append("<option value='21'>취소</option>");
	}
	
	$("input[name=buyCarNum_input]").off("click");

	$("#buyCharge" + data.allocKind).val(Util.formatNumber(data.buyCharge));

	if(data.wayPointMemo || data.wayPointCharge || data.stayMemo || data.stayCharge || data.handWorkMemo || 
	   data.handWorkCharge || data.roundMemo || data.roundCharge || data.otherAddMemo || data.otherAddCharge != null || ""){
		otherChargeOpen();
		sumCharge();
	}else{
		otherChargeClose();
		$("#addSumCharge").val("");
	}
	
	if(data.sellWayPointMemo || data.sellWayPointCharge || data.sellStayMemo || data.sellStayCharge || data.sellHandWorkMemo || 
	   data.sellHandWorkCharge || data.sellRoundMemo || data.sellRoundCharge || data.sellOtherAddMemo || data.sellOtherAddCharge != null || ""){
		sellOtherChargeOpen();
		sellSumCharge();
	}else{
		sellOtherChargeClose();
		$("#addSumSellCharge").val("");
	}

	$("#buyDriverName,#buyDriverTel").removeAttr("readonly");
	$("#buyDriverName,#buyDriverTel").removeClass("noColorReadonly");
	
	if (data.allocState == '10' ){		//운송사 지정 상태
		$("#driverKind").show();
		$("#car").prop("disabled",  true);
		buyCustName.enable(false);
		$("#divAllocC").show();
		$("#divAllocD").hide();
		$("#allocButtons").show();
		$("#driverProposal").hide();
		$("#allocC").show();
		$("#allocD").hide();
		if(data.wayPointMemo || data.wayPointCharge || data.stayMemo || data.stayCharge || data.handWorkMemo || 
		   data.handWorkCharge || data.roundMemo || data.roundCharge || data.otherAddMemo || data.otherAddCharge != null || ""){
			otherChargeOpen();
			$("#allocC").trigger("click");
		}else{
			otherChargeClose();
		}
	} else if (data.allocState == '00') {	//접수상태
		$("#driverKind").hide();
		$("#car").prop("disabled",  false);
		$("#divAllocC").hide();
		$("#divAllocD").show();
		$("#allocButtons").hide();
		$("#driverProposal").show();
		$("#allocC").hide();
		$("#allocD").show();
	} else if (data.allocState == '11') {	//정보망접수
		$("#driverKind").hide();
		$("#car").prop("disabled",  false);
		$("#divAllocC").hide();
		$("#divAllocD").show();
		$("#allocButtons").hide();
		$("#driverProposal").hide();
		$("#allocC").hide();
		$("#allocD").show();
	} else if (data.allocState == '09') {	//정보망접수
		$("#driverProposal").hide();
	} else {
		if(data.driverKind == 'Y'){			// 차주 지정 상태
			$("#carrier").prop("disabled",  true);
			buyCustName.enable(false);
			$("#divAllocD").show();
			$("#divAllocC").hide();
			$("#allocButtons").show();
			$("#driverProposal").hide();
			$("#allocD").show();
			$("#allocC").hide();
			buyCarNum.readonly(true);
			$("#buyDriverName,#buyDriverTel").addClass("noColorReadonly");
			$("#buyDriverName,#buyDriverTel").attr("readonly", true);
			buyCarNum.value(data.buyCarNum);
			$("input[name=buyCarNum_input]").on("click", function(){
				if(data.buyLinkYn == 'Y' && data.linkType == '03' && data.orderState == '01'){
					linkDriverView();
				}else{
					alert("배차 취소 후 가능합니다");
				}
			});
			$("#buyDriverName,#buyDriverTel").off().on("click", function(){
				if($("#buyDriverName,#buyDriverTel").hasClass("noColorReadonly") === true){
					alert("배차 취소 후 가능합니다");
				}
			});
			
			$("[name='driverState'] option[value='21']").remove();
			
			if(data.wayPointMemo || data.wayPointCharge || data.stayMemo || data.stayCharge || data.handWorkMemo || 
			   data.handWorkCharge || data.roundMemo || data.roundCharge || data.otherAddMemo || data.otherAddCharge != null || ""){
				otherChargeOpen();
				$("#allocD").trigger("click");
			}else{
				otherChargeClose();
			}
		} 
	}
	
	$("#driverStateDiv").hide();
	if(data.driverKind == 'Y'){	
		//차량 상태 show
		$("#driverStateDiv").show();
	}
	
	if(data.driverTel, data.driverName, data.carNum != null && !""){
		$("#carNumData").val(data.carNum);
		$("#driverNameData").val(data.driverName);
		$("#driverTelData").val(data.driverTel);
		
		$("#carNumDataDiv").show();
		$("#driverNameDataDiv").show();
		$("#driverTelDataDiv").show();
		$("#carModalBtnDiv").hide();
	}else{
		$("#carNumData").val("");
		$("#driverNameData").val("");
		$("#driverTelData").val("");
		
		$("#carNumDataDiv").hide();
		$("#driverNameDataDiv").hide();
		$("#driverTelDataDiv").hide();
		$("#carModalBtnDiv").show();
	}
	//수출입 구분, 운송유형, 차종, 톤수 세팅
	
 	$("#inOutSctn").val(data.inOutSctn);	
	setFrtSelect(truckTypeData, "truckTypeCode", data.inOutSctn, data.truckTypeCode);
	setFrtSelect(carTypeData, "carTypeCode", data.truckTypeCode, data.carTypeCode);
	setFrtSelect(carTonData, "carTonCode", data.truckTypeCode, data.carTonCode);

	if(data.buyCarTypeCode == null) {
		$("#buyCarTypeCode").val(data.carTypeCode);
	}

	if(data.buyCarTonCode == null) {
		$("#buyCarTonCode").val(data.carTonCode);
	}
	
	
	// 경유지 값 세팅	
	var comName = "";
	var stopCount = parseInt(data.stopCount, 10);
	comName = data.stopName;
	if(stopCount > 1)	comName  += " 외 " + (stopCount-1) + "곳";
	
	if(comName != "") $("#iStopTxt").html(comName);

	//시간 세팅
	var time = data.time;
	var timeTxt = "";
	if(time > 60) {
		timeTxt = parseInt(time / 60) + "시간 " + (time%60) + "분"; 
	}else {
		timeTxt = time + "분";
	}
	$("#timeTxt").val(timeTxt);
	driverCodeChk();
}
 
//이전거래
function popGridList() {
	var popGrid = $("#popGrid").data("kendoGrid");
	
	var param = {
			reqCustId : $("#sellCustId").val(),
			reqDeptId : $("#sellDeptId").val()
	};
	oPopGrid.setSearchData(param);
	popGrid.setDataSource(oPopGrid.gridOption.dataSource);
	
	popGrid.tbody.delegate('tr', 'dblclick', function(){		
		var dataItem = popGrid.dataItem($(this));
		$.ajax({
			url: "/contents/order/data/orderDetail.do",
			type: "POST",
			dataType: "json",
			data: "orderId=" + dataItem.orderId + "&sellAllocId=" + dataItem.sellAllocId + "&allocId=" + dataItem.allocId,
			success: function(data) {
				if(data.result) {
					data.data.orderId = "";
			 		data.data.allocId = "";
			 		data.data.sellAllocId = "";
			 		data.data.driverAllocId = "";
			 		data.data.buyDriverId = "";
			 		data.data.buyVehicId = "";
			 		data.data.buyDriverName = "";
			 		data.data.buyDriverTel = "";
			 		data.data.carNum = "";
			 		data.data.carSctnCode = "";
			 		data.data.allocDate = "";
			 		data.data.buyCarNum = "";
			 		data.data.buyCargoBox = "";
			 		data.data.buyCarTonCode = "";
			 		data.data.buyCarTypeCode = "";
			 		data.data.linkType = "";
			 		data.data.buyLinkYn = "";
			 		data.data.carMngCode = "";
			 		data.data.allocState = "00";
			 		data.data.driverKind = 'N';
			 		data.data.allocKind = 'D';
			 		data.data.driverNameData = "";
			 		data.data.driverTelData = "";
			 		data.data.buyCustName = "";
			 		data.data.buyDeptName = "";
			 		data.data.buyStaff = "";
			 		data.data.buyStaffTel = "";
			 		data.data.buyCustId = "";
			 		data.data.buyDeptId = "";
			 		data.data.driverMemo = "";
					gridDataSet(data.data);
				}
			}
		});
		prevModal.data("kendoDialog").close();
		$("#weightUnitCode").val("TON");
	});
}

function init(){
	sellCustName.enable(true);
	$("#deptId").prop("disabled", false);
	$('#sellCustName, #sellDeptName').on('change', function() {	
		if($("#sellCustName, #sellDeptName").val() != ''){
			$("#prevDiv").css("display","contents");
		}
	});
	$("#f")[0].reset();
	$("input[name=buyCarNum_input]").off("click");
	$("input[type=hidden]").val('');
	$("#f input[name=chargeType]:input[value=01]").prop("checked", true);
	$(".priceCommission").attr("readonly",true); 
	$("#f input[name=allocKind]:input[value=D]").prop("checked", true);
	$("#divAllocC").hide();
	$("#divAllocD").show();
	$("#prevDiv").css("display","none");
	$("#sellCustName").attr("disabled", false);
	$("#reqAddr").attr("disabled", false);
	$("#reqAddr").next("i").children('img').attr("onclick", "popSearchPost('reqAddr')");
	$("#reqAddrDetail").attr("disabled", false);

	$("#sDateDay").data("kendoDatePicker").value(new Date());
	$("#eDateDay").data("kendoDatePicker").value(new Date());
	
	// form 초기화 시, timepicker data 사라짐 -> 다시 생성
	var sDateTime = "<strong class=\"required\">상차 시간</strong> " +
        			"<input style=\"padding: 0;\" type=\"text\" id=\"sDateTime\" name=\"sDateTime\" class=\"col-12\" required>" +
        			"<div class=\"help-block with-errors\"></div>" +
    				"</div>";

	var eDateTime = "<strong class=\"required\">하차 시간</strong> " +
        			"<input style=\"padding: 0;\" type=\"text\" id=\"eDateTime\" name=\"eDateTime\" class=\"col-12\" required>" +
        			"<div class=\"help-block with-errors\"></div>" +
    				"</div>";
			
	var ceil = 1000 * 60 * 60;
    var date = new Date()
    var ceiled = new Date(Math.ceil(date.getTime() / ceil) * ceil)
    $("#sTimeDiv").html(sDateTime);
    $("#eTimeDiv").html(eDateTime);
	$("#sDateTime, #eDateTime").kendoTimePicker({format: "HH:mm", value : ceiled, dateInput: true});
	
	$("input[data-role='timepicker']").on("focus", function(e) {
		var id = e.target.id;
		switch (id) {
			case "sDateTime" :
				sDateTimeChangeFocusFlag = 0;
				break;

			case "eDateTime" :
				eDateTimeChangeFocusFlag = 0;
				break;
			default :
				break;
		}
	});

    $("input[data-role='timepicker']").on("keydown", function(e) {
        if ($.isNumeric(e.key)) {
            var id = e.target.id;
            switch (id) {
                case "sDateTime":
                	sDateTimeChangeFocusFlag++;
                    if (sDateTimeChangeFocusFlag === 2) {
                    	sDateTimeChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                case "eDateTime":
                	eDateTimeChangeFocusFlag++;
                    if (eDateTimeChangeFocusFlag === 2) {
                    	eDateTimeChangeFocusFlag = 0;
                        changeDatePickerFocus(id);
                    }
                    break;
                default:
                    break;
            }
        }
    });
	
	//자기부서로 초기화
	$("#deptId").val("${sessionScope.userInfo.deptId}");
	if(lastDeptSeleted != "${sessionScope.userInfo.deptId}") {
		$("#deptId").trigger("change");
	}
	
	sellCustName.value('');
	reqStaff.value('');
	sComName.value('');
	eComName.value('');
	buyCustName.value('');
	buyStaff.value('');
	buyCarNum.value('');
	$("#iStopTxt").html("");
	
	btnChkData('mixYn');
	btnChkData('returnYn'); 
	
	btnChkData('dangerGoodsYn'); 
	btnChkData('chemicalsYn'); 
	btnChkData('foreignLicenseYn'); 
	$(".list-unstyled").remove();

	$("#car").attr("disabled", false);
	$("#carrier").attr("disabled", false);
	
	if("${menuAuth.writeYn}" != "Y")	$("#btnSubmit").hide();

	$("#driverMemo").css("color","");
	$("#payType").css("color","");
	$("#buyChargeD").css("color","");
	$("input[name=buyCarNum_input]").css("color","");
	
	//등록 모드로 변경
	$("#mode").val("N");
	$("#driverStateDiv").hide();
	buyCarNum.readonly(false);
	otherChargeClose();
	sellOtherChargeClose();
	reqStaff.enable(false);
	
	// 업무 초기값 불러오기
	getUserOption();
}

function getUserOption(){
	$.ajax({
		url: "/contents/basic/data/getUserOption.do",
		type: "POST",
		dataType: "json",
		data: $("#fUserOption").serialize(),				
		success: function(data){
			if(data.result) {
				var data = data.data;
				if(data != null){
					
					//수출입 구분, 운송유형, 차종, 톤수 세팅
					setFrtSelect(truckTypeData, "truckTypeCode", data.defaultInOutSctn, data.truckTypeCode);
					setFrtSelect(carTypeData, "carTypeCode", data.defaultTruckTypeCode, data.defaultCarTypeCode);
					setFrtSelect(carTonData, "carTonCode", data.defaultTruckTypeCode, data.defaultCarTonCode);
					setFrtSelect(carTypeData, "buyCarTypeCode", data.defaultTruckTypeCode, data.defaultCarTypeCode);
					setFrtSelect(carTonData, "buyCarTonCode", data.defaultTruckTypeCode, data.defaultCarTonCode);
					
					$("#sellCustId").val(data.defaultReqCustId);
					$("#sellDeptId").val(data.defaultReqDeptId);
					$("#sellStaffId").val(data.defaultReqStaffId);
					$("#sellDeptName").val(data.defaultReqDeptName);
					$("#reqAddr").val(data.defaultReqAddr);
					$("#reqAddrDetail").val(data.defaultReqAddrDetail);
					$("#reqTel").val(Util.formatPhone(data.defaultReqTel));
					$("#reqMemo").val(data.defaultReqMemo);
					 
					$("#sLat").val(data.defaultSLat);
					$("#sLon").val(data.defaultSLon);
					$("#sSido").val(data.defaultSSido);
					$("#sGungu").val(data.defaultSGungu);
					$("#sDong").val(data.defaultSDong);
					$("#sAddr").val(data.defaultSAddr);
					$("#sAddrDetail").val(data.defaultSAddrDetail);
					$("#sStaff").val(data.defaultSStaff);
					$("#sTel").val(Util.formatPhone(data.defaultSTel));
					$("#sMemo").val(data.defaultSMemo);
	
				 	$("#inOutSctn").val(data.defaultInOutSctn);	
					$("#truckTypeCode").val(data.defaultTruckTypeCode);
					$("#carTypeCode").val(data.defaultCarTypeCode);
					$("#carTonCode").val(data.defaultCarTonCode);
					$("#buyCarTypeCode").val(data.defaultCarTypeCode);
					$("#buyCarTonCode").val(data.defaultCarTonCode);
					$("#goodsName").val(data.defaultGoodsName);
					$("#goodsWeight").val(data.defaultGoodsWeight);
					$("#itemCode").val(data.defaultItemCode);
					$("#sWayCode").val(data.defaultSWayCode);
					$("#eWayCode").val(data.defaultEWayCode);
					$("#unitCharge").val(Util.formatNumberInput(data.defaultUnitCharge));
					$("#sellCharge").val(Util.formatNumberInput(data.defaultSellCharge));
					$("input[name='buyCharge']").val(Util.formatNumberInput(data.defaultBuyCharge));
					$("#driverMemo").val(data.defaultDriverMemo);
					$("#custPayType").val(data.defaultReqCustPayType);

					if(data.unitPriceType != null){
						$("#f input[name=unitPriceType]:input[value=" + data.defaultUnitPriceType + "]").prop("checked", true);
					}else{
						$("#f input[name=unitPriceType]:input[value=01]").prop("checked", true);
					}
					 
					setTimeout(function(){
						var sellCustSelect = data.defaultReqCustName;
						var reqStaffSelect = data.defaultReqStaffName;
						var sComSelect = data.defaultSComName;
						sellCustName.select(function(dataItem) {
							$("#custMngCodeName").val(dataItem.custMngName);
							$("#custMngMemo").val(dataItem.custMngMemo);
						    return dataItem.custName === sellCustSelect;
						});
						reqStaff.value(data.defaultReqStaffName);
						sComName.value(data.defaultSComName);
					}, 50);
				}
			}
		}
	});
}

function btnChk(id){
	if(id.checked == true){
		$(id).val("Y")
	}else{
		$(id).val("N")
	}
}

function btnChkData(id){
	if($("#"+id).val() == "N"){
		$("input:checkbox[id='"+id+"']").prop("checked", false);
	}else{
		$("input:checkbox[id='"+id+"']").prop("checked", true);
	}
}

function readonlyValidator(){
	$("input[name$='Addr']").removeAttr('readonly');
}

$('#f').validator().on('submit', function (e) {
	$("input[name$='Addr']").attr('readonly', true);
	if (e.isDefaultPrevented()) {
		alert("항목을 입력해 주세요.")
	} else {
		//매입추가비용
		$("#wayPointCharge").val($("#wayPointCharge").val().replace(/,/g, ""));
		$("#stayCharge").val($("#stayCharge").val().replace(/,/g, ""));
		$("#handWorkCharge").val($("#handWorkCharge").val().replace(/,/g, ""));
		$("#roundCharge").val($("#roundCharge").val().replace(/,/g, ""));
		$("#otherAddCharge").val($("#otherAddCharge").val().replace(/,/g, ""));
		$("#unitCharge").val($("#unitCharge").val().replace(/,/g, ""));
		var addCode = "0023╊0025╊0371╊0372╊0294";
		var addCharge = "";
		var addMemo = "";
				
		$("input[name=addCharge]").each(function(){
			var charge = $(this).val(); 
			if(charge == ""){
				addCharge += charge + "0╊";
			}else{
				addCharge += charge + "╊";
			}
		});
		
		$("input[name=addMemo]").each(function(){
			var memo = $(this).val(); 
			if(memo == ""){
				addMemo += memo + "　╊";
			}else{
				addMemo += memo + "╊";
			}
			
		});
		
		addCharge = addCharge.substring(0, addCharge.length - 1);
		addMemo = addMemo.substring(0, addMemo.length - 1);
		
		$("#addCodeList").val(addCode);
		$("#addChargeList").val(addCharge);
		$("#addMemoList").val(addMemo);
		
		//매출추가비용
		$("#sellWayPointCharge").val($("#sellWayPointCharge").val().replace(/,/g, ""));
		$("#sellStayCharge").val($("#sellStayCharge").val().replace(/,/g, ""));
		$("#sellHandWorkCharge").val($("#sellHandWorkCharge").val().replace(/,/g, ""));
		$("#sellRoundCharge").val($("#sellRoundCharge").val().replace(/,/g, ""));
		$("#sellOtherAddCharge").val($("#sellOtherAddCharge").val().replace(/,/g, ""));
		var addSellCode = "0023╊0025╊0371╊0372╊0294";
		var addSellCharge = "";
		var addSellMemo = "";
		
		$("input[name=addSellCharge]").each(function(){
			var charge = $(this).val(); 
			if(charge == ""){
				addSellCharge += charge + "0╊";
			}else{
				addSellCharge += charge + "╊";
			}
		});
		
		$("input[name=addSellMemo]").each(function(){
			var memo = $(this).val(); 
			if(memo == ""){
				addSellMemo += memo + "　╊";
			}else{
				addSellMemo += memo + "╊";
			}
			
		});
		
		addSellCharge = addSellCharge.substring(0, addSellCharge.length - 1);
		addSellMemo = addSellMemo.substring(0, addSellMemo.length - 1);
		
		$("#addSellCodeList").val(addSellCode);
		$("#addSellChargeList").val(addSellCharge);
		$("#addSellMemoList").val(addSellMemo);
		
		$("#sellCharge").val($("#sellCharge").val().replace(/,/g, ""));
		$("#sellFee").val($("#sellFee").val().replace(/,/g, ""));
		var allocKind = $("#f input[name=allocKind]:checked").val();
		$("#buyCharge" + allocKind).val($("#buyCharge" + allocKind).val().replace(/,/g, ""));
		
		$("#driverTel").val($("#driverTel").val().replace(/\-/g, ""));
		$("#reqTel").val($("#reqTel").val().replace(/\-/g, ""));
		$("#sTel").val($("#sTel").val().replace(/\-/g, ""));
		$("#eTel").val($("#eTel").val().replace(/\-/g, ""));
		$("#buyStaffTel").val($("#buyStaffTel").val().replace(/\-/g, ""));
		$("#buyDriverTel").val($("#buyDriverTel").val().replace(/\-/g, ""));
		$("#deptId").prop("disabled", false);
		if($("#sellFee").val() == ""){
			$("#sellFee").val("0");
		} 
		
		//오더가 취소상태이면 재접수 후 수정 가능하도록 
		if ($("#orderState").val() == "09") {
			alert("오더 재접수 후 배차해주세요.");
			return false;
		}
		
		if($("#allocState").val() == "11" && $("#buyCarNum").val()){
			var orderId = $("#orderId").val();
			var allocId = $("#allocId").val();
			if(!confirm('정보망에 접수되어있는 오더입니다. \n정보망 취소를 원하시면 "확인" 버튼을 클릭해주세요.')){
				return false;
			}
			// 이벤트 초기화 (submit 동작 중단)
			e.preventDefault();
			$.ajax({
				url: "/contents/order/data/linkCancelOrder.do",
				type: "POST",
				dataType: "json",
				data: {
					orderId: orderId,
					allocId: allocId
				},		
				success: function(data){
					if(data.result) {
						$.ajax({
							url: "/contents/order/data/orderWrite.do",
							type: "POST",
							dataType: "json",
							data: $("#f").serialize(),				
							success: function(data){
								if(data.result) {
									alert(data.msg);
									init_popup_close();
									goList();
								} else {
									alert(data.msg);
								}
							}
						})
					}
				}
			})
		}else {
			// 이벤트 초기화 (submit 동작 중단)
			e.preventDefault();
			$.ajax({
				url: "/contents/order/data/orderWrite.do",
				type: "POST",
				dataType: "json",
				data: $("#f").serialize(),				
				success: function(data){
					if(data.result) {
						alert(data.msg);
						init_popup_close();
						goList();
					} else {
						alert(data.msg);
					}
				}
			})
		}
	}
})

function popOrderStopDetail(){
	var orderId = $("#orderId").val();
	var deptId = $("#deptId").val();
	
	win = $("#divOrderStop").data("kendoWindow");
	if(win == null) {
		win = $("#divOrderStop").kendoWindow({
			width: 850,
			height: 729,
			content: {
				url: "/contents/order/view/orderStopDetail.do?orderId=" + orderId + "&deptId=" + deptId
			},
			iframe: true,
			visible:false
		}).data("kendoWindow");	
	} else {
		win.refresh("/contents/order/view/orderStopDetail.do?orderId=" + orderId + "&deptId=" + deptId);
	}	
	

	win.center().open();
}

function modalClose(){
	$("#bizNo").val("");
	modal.data("kendoDialog").close();
}

function carFormClose(){
	$("#carNum").val("");
	$("#driverName").val("");
	$("#driverTel").val("");
	carModal.data("kendoDialog").close();
}

function init_popup_close() {
	form_popup_close();
	init();
}

// 경유지 팝업창에서 호출
function setOrderStopData(data) {
	$("#orderStopData").val(data);
	var jsonData = JSON.parse(data);
	var size = 0;
	var comName = "";
	
	for(var item, i=0; item=jsonData[i]; i++) {
		if(item.useYn != "N") {
			if (comName ==  "") comName = item.eComName;
			size ++;
		}
	}
	if(size > 1)	comName  += " 외 " + (size-1) + "곳";

	$("#iStopTxt").html(comName);
}
//배차 상태 변경
function updateAllocState(type, state) {
	var allocId = $("#allocId").val();
	var orderId = $("#orderId").val();
	
	if(type == "C") allocId = $("#driverAllocId").val();	//type D: 직배차, C: 운송사배차
	
	if($("#buyLinkYn").val() == "Y" && state == '21') {
// 		if(!confirm("정보망에서 배차된 오더입니다. 배차를 취소하시겠습니까?")) {
// 			return false;
// 		} else {
// 			$.ajax({
// 				url: "/contents/order/data/linkWrite.do",
// 				type: "POST",
// 				dataType: "json",
// 				data: {
// 					linkType: $("#linkType").val(),
// 					orderId: orderId,
// 					allocId: allocId,
// 					command: "CANCELALLOC"
// 				},		
// 				success: function(data){
// 					if(data.result) {
// 						alert(data.msg);
// 						init_popup_close();
// 						goList();
// 					} else {
// 						alert(data.msg);
// 					}
// 				}
// 			})
// 		}
		alert("정보망에서 배차된 오더는 정보망 팝업창에서 배차취소 되어야 합니다.");
	} else {

		
		$.ajax({
			url: "/contents/order/data/allocState.do",
			type: "POST",
			dataType: "json",
			data: "orderId=" + $("#orderId").val() + "&allocId=" + allocId + "&allocState=" + state,
			success: function(data){
				if(data.result) {
					alert(data.msg);
					init_popup_close();
					goList();
				} else {
					alert(data.msg);
				}
			}
		});
	}
}
//오더 상태 변경

function updateOrderState(state) {
	var orderId = $("#orderId").val();
	
	$.ajax({
		url: "/contents/order/data/orderState.do",
		type: "POST",
		dataType: "json",
		data: "orderId=" + $("#orderId").val() + "&orderState=" + state,
		success: function(data){
			if(data.result) {
				alert(data.msg);
				init_popup_close();
				goList();
			} else {
				alert(data.msg);
			}
		}
	});
}

//운송사 대신 배차
$('#carForm').validator().on('submit', function (e) {	
	if (e.isDefaultPrevented()) {
		alert("항목을 입력해 주세요.")
	} else {
		// 이벤트 초기화 (submit 동작 중단)
		e.preventDefault();
		var orderId = $("#orderId").val()
		var param = {
				orderId : orderId,
				custId : $("#buyCustId").val(),
				deptId : $("#buyDeptId").val(),
				staffId : $("#buyStaffId").val(),
				vehicId : $("#vehicId").val(),
				driverId : $("#driverId").val(),
				carNum : $("#carNum").val(),
				driverName : $("#driverName").val(),
				driverTel : $("#driverTel").val().replace(/\-/g, ""),
				linkSelect : "99",
		}
		$.ajax({
			url: "/contents/order/data/orderAlloc.do",
			type: "POST",
			dataType: "json",
			data: param,
			success: function(data){
				if(data.result) {
					alert(data.msg);
					carFormClose();
					goList();
					getOrderData(orderId, $("#sellAllocId").val());
				} else {
					alert(data.msg);
				}
			}
		});
	}
});



$("#driverState").on('focus', function () {
	previous = this.value;
}).change(function() { 
	var type = $("#f input[name=allocKind]:checked").val();
	var driverState = $("#driverState").val();
	var result = confirm("차량상태를 변경 하시겠습니까?");
	if(type == "C"){
		allocId = $("#driverAllocId").val();	//type D: 직배차, C: 운송사배차
	}else{
		allocId = $("#allocId").val();	
	}
	 
	if(driverState == "04") {
		if($("#enterDate").val() == ""){
			alert("입차처리가 되지않은 오더입니다.");
			$("#driverState").val(previous).prop("selected", true); //이전값으로 돌리기
			return;
		}else if($("#startDate").val() != ""){
			alert("출발처리를 완료한 오더입니다.");
			$("#driverState").val(previous).prop("selected", true); //이전값으로 돌리기
			return;
		}
	}else if(driverState == "05"){
		if($("#startDate").val() == ""){
			alert("출발처리가 되지않은 오더입니다.");
			$("#driverState").val(previous).prop("selected", true); //이전값으로 돌리기
			return;
		}else if($("#finishDate").val() != ""){
			alert("도착처리를 완료한 오더입니다.");
			$("#driverState").val(previous).prop("selected", true); //이전값으로 돌리기
			return;
		}
	}else if(driverState == "12"){
		if($("#enterDate").val() != ""){
			alert("입차처리를 완료한 오더입니다.");
			$("#driverState").val(previous).prop("selected", true); //이전값으로 돌리기
			return;
		}
	}else if(driverState == "01"){
		if($("#enterDate").val() != "" || $("#startDate").val() != "" || $("#finishDate").val() != "" ){
			alert("배차처리를 완료한 오더입니다.");
			$("#driverState").val(previous).prop("selected", true); //이전값으로 돌리기
			return;
		}
	}
	
	var orderId = $("#orderId").val();
	if(result){
		if(driverState == '12'){
			popDriverStateModal.data("kendoDialog").open();
			return
		}
		$.ajax({
			url: "/contents/order/data/allocState.do",
			type: "POST",
			dataType: "json",
			data: "orderId=" + orderId + "&allocId=" + allocId + "&allocState=" + driverState,
			success: function(data){
				if(data.result) {
					alert(data.msg);
					goList();
					getOrderData(orderId, $("#sellAllocId").val());
				} else {
					alert(data.msg);
				}
			}
		});
	}else{
		$("#driverState").val(previous).prop("selected", true); //이전값으로 돌리기
	}
});


function popDriverStateModalSubmit(){
	var type = $("#f input[name=allocKind]:checked").val();
	var driverState = $("#driverState").val();
	var orderId = $("#orderId").val();
	var enterDate = $("#enterDatePicker").val();
	if(type == "C"){
		allocId = $("#driverAllocId").val();	//type D: 직배차, C: 운송사배차
	}else{
		allocId = $("#allocId").val();	
	}
	var param = {
			orderId : orderId,
			enterDate : enterDate,
			allocId : allocId,
			allocState : driverState
	};

	$.ajax({
		url: "/contents/order/data/allocState.do",
		type: "POST",
		dataType: "json",
		data: param,
		success: function(data){
			if(data.result) {
				alert(data.msg);
				goList();
				getOrderData(orderId, $("#sellAllocId").val());
				popDriverStateModalClose();
			} else {
				alert(data.msg);
			}
		}
	});
}


function getOrderData(orderId, sellAllocId, allocId){
	$.ajax({
		url: "/contents/order/data/orderDetail.do",
		type: "POST",
		dataType: "json",
		data: "orderId=" + orderId + "&sellAllocId=" + sellAllocId + "&allocId=" + allocId,
		success: function(data) {
			if(data.result) {
				gridDataSet(data.data);
				
			}
		}
	});
}

function popSearchPost(mode){
	Util.popSearchPost(mode);
}

function setSearchAddressInfo(data) {
	
	//var addr = data.roadAddr; // 주소 변수
	var addr = data.jibunAddr; // 주소 변수
	var sido = data.siNm;
	var gungu = data.sggNm;
    var dong = data.emdNm;
    var mode = data.mode;
    
	$.ajax({
		url: "/contents/basic/data/getLatLon.do",
		type: "POST",
		dataType: "json",
		data: {
			searchAddress: addr,
			size: 10
		},
		success: function(apiData){
			if(apiData.result){
				var localData = JSON.parse(apiData.data);
				var lat = '';
    			var lon = '';
    			lon = localData.documents[0].x;
				lat = localData.documents[0].y;
				var addressData = localData.documents[0].address;
				
				$("#"+mode).val(addr);
				if(mode == "sAddr"){
	                $("#sSido").val(addressData.region_1depth_name);
	                $("#sGungu").val(addressData.region_2depth_name);
	                $("#sDong").val(addressData.region_3depth_name);
                    $("#sLon").val(lon);
                    $("#sLat").val(lat);
				} else if(mode == "eAddr"){
	                $("#eSido").val(addressData.region_1depth_name);
	                $("#eGungu").val(addressData.region_2depth_name);
	                $("#eDong").val(addressData.region_3depth_name);
                    $("#eLon").val(lon);
                    $("#eLat").val(lat);                    
				}

				getRoute();				
                $("#"+mode+"Detail").focus();

			} else {
				if(mode == "sAddr"){
					$("#sAddr").val(addr);
					$("#sSido").val(sido);
                    $("#sGungu").val(gungu);
                    $("#sDong").val(dong);
				} else if(mode == "eAddr"){
					$("#eAddr").val(addr);
					$("#eSido").val(sido);
                    $("#eGungu").val(gungu);
                    $("#eDong").val(dong);                    
				}
			}
		}
	});
}

function dummyAddressInfo(data) {
	$.ajax({
		url: "/contents/basic/data/getLatLon.do",
		type: "POST",
		dataType: "json",
		data: {
			searchAddress: data.sido+" "+data.gungu,
			size: 10
		},
		success: function(apiData){
			if(apiData.result){
				var localData = JSON.parse(apiData.data);
				var lat = '';
    			var lon = '';
    			lon = localData.documents[0].x;
				lat = localData.documents[0].y;
				var addressData = localData.documents[0].address;
				if(data.mode == "sAddr"){
					$("#sAddr").val(data.sido+" "+data.gungu);
	                $("#sSido").val(addressData.region_1depth_name);
	                $("#sGungu").val(addressData.region_2depth_name);
                    $("#sLon").val(lon);
                    $("#sLat").val(lat);
                    
            		$("input:checkbox[id='sAreaSave']").prop("checked", true);
            		$("input:checkbox[id='sAreaSave']").val("Y")
            		$("#sAreaSave").parent(".radio-or-checkBox").css("display", "contents");
	                $("#sAddrDetail").focus();
				} else if(data.mode == "eAddr"){
					$("#eAddr").val(data.sido+" "+data.gungu);
					$("#eSido").val(data.sido);
				    $("#eGungu").val(data.gungu);
				    $("#eDong").val("");
                    $("#eLon").val(lon);
                    $("#eLat").val(lat);                

            		$("input:checkbox[id='eAreaSave']").prop("checked", true);
            		$("input:checkbox[id='eAreaSave']").val("Y")
            		$("#eAreaSave").parent(".radio-or-checkBox").css("display", "contents");
	                $("#eAddrDetail").focus();
				}

				getRoute();				

			} else {
				if(mode == "sAddr"){
					$("#sAddr").val(data.sido+" "+data.gungu);
					$("#sSido").val(data.sido);
                    $("#sGungu").val(data.gungu);
                    $("#sDong").val("");
				} else if(mode == "eAddr"){
					$("#eAddr").val(data.sido+" "+data.gungu);
					$("#eSido").val(data.sido);
                    $("#eGungu").val(data.gungu);
                    $("#eDong").val("");                    
				}
			}
		}
	});
	/* 
	$("#distance").val("");
	$("#time").val("");
	$("#timeTxt").val(""); */
}

/**
 * 오더 복사
 * @returns
 */
function orderCopy() {
	$("#mode").val("C");
	var allocKind = $("#f input[name=allocKind]:checked").val();
	$("#buyCharge" + allocKind).val($("#buyCharge" + allocKind).val().replace(/,/g, ""));
	$("#sellCharge").val($("#sellCharge").val().replace(/,/g, ""));
	$("#driverTel").val($("#driverTel").val().replace(/\-/g, ""));
	$("#reqTel").val($("#reqTel").val().replace(/\-/g, ""));
	$("#sTel").val($("#sTel").val().replace(/\-/g, ""));
	$("#eTel").val($("#eTel").val().replace(/\-/g, ""));
	$("#buyStaffTel").val($("#buyStaffTel").val().replace(/\-/g, ""));
	$("#buyDriverTel").val($("#buyDriverTel").val().replace(/\-/g, ""));
	$("#unitCharge").val($("#unitCharge").val().replace(/,/g, ""));
	$("#deptId").prop("disabled", false);
	$("#sellFee").val($("#sellFee").val().replace(/,/g, ""));
	if($("#sellFee").val() == ""){
		$("#sellFee").val("0");
	} 
	$.ajax({
		url: "/contents/order/data/orderWrite.do",
		type: "POST",
		dataType: "json",
		data: $("#f").serialize(),				
		success: function(data){
			if(data.result) {
				alert(data.msg);
				init_popup_close();
				goList();
			}
		}
	})
}

function otherChargeOpen(){
	$("#otherCharge").show();
	$("#otherChargeBtn").attr("href", "javascript:otherChargeClose()");
	$("#otherChargeBtn").html("지불추가접기");
}

function otherChargeClose(){
	$("#otherCharge").hide();
	$("#otherChargeBtn").attr("href", "javascript:otherChargeOpen()");
	$("#otherChargeBtn").html("지불추가열기");
}

function sellOtherChargeOpen(){
	$("#sellOtherCharge").show();
	$("#sellOtherChargeBtn").attr("href", "javascript:sellOtherChargeClose()");
	$("#sellOtherChargeBtn").html("청구추가접기");
}

function sellOtherChargeClose(){
	$("#sellOtherCharge").hide();
	$("#sellOtherChargeBtn").attr("href", "javascript:sellOtherChargeOpen()");
	$("#sellOtherChargeBtn").html("청구추가열기");
}

function popDriverStateModalClose() {
	popDriverStateModal.data("kendoDialog").close();
} 

$('#unitCharge').on("input", function() {
	var unitCharge = /^\d*$/;
	if(!unitCharge.test($("#unitCharge").val().replace(/,/g, ""))){
	    alert("\"단가입력\"에 숫자를 입력하시기 바랍니다.");
	    $("#unitCharge").val("")
	    return;
	}
	if($('input[name="unitPriceType"]:checked').val() == "02"){
		var charge = $("#sellWeight").val() * $("#unitCharge").val().replace(/,/g, "");
		var sellCharge = charge.toString().split(".");
		$("#sellCharge").val(Util.formatNumberInput(sellCharge[0]));
	}else{
		$("#sellCharge").val(Util.formatNumberInput($("#unitCharge").val()));
	}
});

$('#sellWeight').on("input", function() {
	if($('input[name="unitPriceType"]:checked').val() == "02"){
		var sellWeight = /^(\d*)[\.]?(\d{1,})?$/;
		if(!sellWeight.test($("#sellWeight").val())){
		    alert("\"청구중량\"에 숫자를 입력하시기 바랍니다.");
		    $("#sellWeight").val("")
		    return;
		}
		var charge = $("#sellWeight").val() * $("#unitCharge").val().replace(/,/g, "");
		var sellCharge = charge.toString().split(".");
		$("#sellCharge").val(Util.formatNumberInput(sellCharge[0]));
	}else{
		$("#sellCharge").val(Util.formatNumberInput($("#unitCharge").val()));
	}
});

$('input[name="unitPriceType"]').on("input", function() {
	if($('input[name="unitPriceType"]:checked').val() == "02"){
		$("#sellWeight").val($("#goodsWeight").val());
		var sellWeight = /^(\d*)[\.]?(\d{1,})?$/;
		if(!sellWeight.test($("#sellWeight").val())){
		    alert("\"청구중량\"에 숫자를 입력하시기 바랍니다.");
		    $("#sellWeight").val("")
		    return;
		}
		var charge = $("#sellWeight").val() * $("#unitCharge").val().replace(/,/g, "");
		var sellCharge = charge.toString().split(".");
		$("#sellCharge").val(Util.formatNumberInput(sellCharge[0]));
	}else{
		$("#sellCharge").val(Util.formatNumberInput($("#unitCharge").val()));
	}
});

$("#goodsWeight").on("input", function(){
	if($('input[name="unitPriceType"]:checked').val() == "02"){
		$("#sellWeight").val($(this).val());
	}
})

$("#linkSelect").on('focus', function () {
	previous = this.value;
}).change(function() { 
	if($("#allocState").val() != '00' && $("#mode").val() != 'N'){
		alert("접수상태일 때만 변경 가능합니다.");
		$("#linkSelect").val(previous).prop("selected", true); //이전값으로 돌리기
		return;
	}
});

$(".openCloseBtn").on('click', function (){
	var divId = $(this).context.id;
	var btnText = "";
	if(divId == 'owner'){
		btnText = '화주추가';
	}else if (divId == 'startAddr'){
		btnText = '상차추가';
	}else if (divId == 'endAddr'){
		btnText = '하차추가';
	}else if (divId == 'cargo'){
		btnText = '화물추가';
	}else if (divId == 'allocD' || divId == 'allocC'){
		btnText = '배차추가';
	}else if (divId == 'other'){
		btnText = '기타추가';
	}
	
	if(divId == "allocC" || divId == "allocD"){
		/* 직접배차, 운송사지정 추가정보 접기버튼 */
		if($("#driverOtherOpenClose").css("display") == "none"){
			$("#driverOtherOpenClose").show();
			$("#"+divId+"OpenClose").show();
			$("#"+divId).html(btnText+"접기");
		}else{
			$("#driverOtherOpenClose").hide();
			$("#"+divId+"OpenClose").hide();
			$("#"+divId).html(btnText+"열기");
		}
	} else {
		if($("#"+divId+"OpenClose").css("display") == "none"){
			$("#"+divId+"OpenClose").show();
			$("#"+divId).html(btnText+"접기");
		}else{
			$("#"+divId+"OpenClose").hide();
			$("#"+divId).html(btnText+"열기");
		}		
	}
	
});

function payTypeChk(){
	var carPayType = $("#carPayType").val();
	var custPayType = $("#custPayType").val();
	var buyDriverId = $("#buyDriverId").val();
	var buyVehicId = $("#buyVehicId").val();
	var chargeType = $('input[name="chargeType"]:checked').val();
	
	if(chargeType == "01"){
		if(carPayType == 'P' && custPayType == 'Y'){
			$("#payType option[value*='Y']").prop('disabled',false);
			$("#payType").val('Y').prop("selected", true);
		}else if(custPayType == 'P' && carPayType == 'Y'){
			$("#payType option[value*='Y']").prop('disabled',false);
			$("#payType").val('Y').prop("selected", true);
		}else if(custPayType == 'Y' && carPayType == 'Y'){
			$("#payType option[value*='Y']").prop('disabled',false);
			$("#payType").val('Y').prop("selected", true);
		}else{
			$("#payType option[value*='Y']").prop('disabled',true);
			$("#payType").val('N').prop("selected", true);
		}
		//신규차량 등록시 빠른지급여부 미지급으로 
		if(buyDriverId == '' && buyVehicId == ''){
			$("#payType option[value*='Y']").prop('disabled',false);
			$("#payType").val('N').prop("selected", true);
		}
	}else{
		$("#payType option[value*='Y']").prop('disabled',true);
		$("#payType").val('N').prop("selected", true);
	}
}

function driverCodeChk(){
	var driverCode = $("#carMngCode").val();
	
	if(driverCode == '02'){
		$("#driverMemo").css("color","rgba(255, 0, 0, 100%)");
		$("#payType").css("color","rgba(255, 0, 0, 100%)");
		$("#buyChargeD").css("color","rgba(255, 0, 0, 100%)");
		$("input[name=buyCarNum_input]").css("color","rgba(255, 0, 0, 100%)");
	}else{
		$("#driverMemo").css("color","");
		$("#payType").css("color","");
		$("#buyChargeD").css("color","");
		$("input[name=buyCarNum_input]").css("color","");
	}
}

function sumCharge(){
	var allocKind = $("#f input[name=allocKind]:checked").val();
 	var addCharge = $("input[name='addCharge']");
	var addSumCharge = Number($("#buyCharge"+allocKind).val().replace(/,/g, ""));
 	
 	for(i=0; i<addCharge.length; i++){
 		addSumCharge += Number(addCharge[i].value.replace(/,/g, ""));
 	}
 	$("#addSumCharge").val(Util.formatNumber(addSumCharge));
}

function sellSumCharge(){
 	var addSellCharge = $("input[name='addSellCharge']");
	var addSumSellCharge = Number($("#sellCharge").val().replace(/,/g, ""));
 	
 	for(i=0; i<addSellCharge.length; i++){
 		addSumSellCharge += Number(addSellCharge[i].value.replace(/,/g, ""));
 	}
 	$("#addSumSellCharge").val(Util.formatNumber(addSumSellCharge));
}

function dummyPopSearchPost(mode){
	Util.dummyPopSearchPost(mode);
}

function addrLatLonValidation(){
	if($("#sLat").val() == "0E-13")
	$("#sLat").val("0.0");
	
	if($("#eLat").val() == "0E-13")
	$("#eLat").val("0.0");
	
	if($("#sLon").val() == "0E-12")
	$("#sLon").val("0.0");
	
	if($("#eLon").val() == "0E-12")
	$("#eLon").val("0.0");
}

function searchBuyCustSelectTrigger(e) {
	if(this.value() != ""){
		buyCustName.trigger("select");
	}else{
		$("#custId").val("");
		$("#deptId").val("");
		$("#buyDeptName").val("");
	}
}

function searchSellCustSelectTrigger(e) {
	if(this.value() != ""){
		buyCustName.trigger("select");
	}else{
		$("#sellCustId").val("");
		$("#sellDeptId").val("");
		$("#sellDeptName").val("");
		$("#reqAddr").val("");
		$("#reqAddrDetail").val("");
		$("#reqMemo").val("");
		$("#itemCode").val("");
		$("#custMngMemo").val("");
		$("#custPayType").val("");
		$("#custMngCodeName").val("");
	}
}

function searchCarNumSelectTrigger(e) {
	if(this.value() != ""){
		buyCarNum.trigger("select");
	}else{
		$("#buyDriverName").val("");
		$("#buyDriverTel").val("");
		$("#buyVehicId").val("");
		$("#buyDriverId").val("");
		$("#carSctnCode").val("");
		$("#buyCarTypeCode").val("");
		$("#buyCarTonCode").val("");
		$("#buyCargoBox").val("");
		$("#carMngCode").val("");
		$("#carMngMemo").val("");
		$("#carPayType").val("");
	}
}

$("#sellCharge, #buyChargeC, #buyChargeD, #sellFee, input[name='addCharge'], input[name='addSellCharge'], #unitCharge").on("input", function(){
	$(this).val(Util.formatNumberInput($(this).val()));
});

$("#driverTel, #reqTel, #sTel, #eTel, #buyStaffTel, #buyDriverTel").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});

// 신규등록, 접수상태인 오더의 요청차종/톤수 선택시, 차량차종/톤급 같이 변경되게 
$("#carTypeCode, #carTonCode").on("change", function(){
	
	if($("#orderState").val() == "00" || $("#orderState").val() == ""){
		$("#buyCarTypeCode").val($("#carTypeCode").val());
		$("#buyCarTonCode").val($("#carTonCode").val());
	}
});

</script>
