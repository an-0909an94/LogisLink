<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .cancel {color:#e54524 !important;}
    /*.accept {color:#0065bd !important;}*/
    .myOrder {background: #fdf3cf}
    .isMemo {background: #f08080}

    #grid .k-grid-content {max-height:100vh}
    .width6_5{
        width: 6.5%;
        align-self: center;

    }
</style>
<div class="insert_pop" style="display: none;">
    <%@ include file="./view/orderInsert.jsp" %>
</div>

<div class="header orderList">
    <div class="summary">
        <div class="hdr-tit" style ="font-weight:bold;">
            <P id="headerTitle">배차관리</P>
        </div>
        <div id="orderSimpleData">
            <span style="font-size: 16px; font-weight:bold; margin-right: 6px;">배차진행건수 </span>
            <div style="display: contents;" class="col input-group i-name">
                <i id="groupCount"></i>
            </div>
        </div>
    </div>
    <div class="contents">
        <div id="group-list" class="cont-wrapper-page-grid">
            <form id="fSearch" class="date-bnt">
                <input type="hidden" name="locationSLat" id="locationSLat">
                <input type="hidden" name="locationSLon" id="locationSLon">
                <input type="hidden" name="locationELat" id="locationELat">
                <input type="hidden" name="locationELon" id="locationELon">
                <input type="hidden" name="locationCarNum" id="locationCarNum">
                <input type="hidden" name="locationDriverName" id="locationDriverName">
                <input type="hidden" name="locationDriverTel" id="locationDriverTel">
                <input type="hidden" name="locationSComName" id="locationSComName">
                <input type="hidden" name="locationEComName" id="locationEComName">
                <input type="hidden" name="locationSAddr" id="locationSAddr">
                <input type="hidden" name="locationEAddr" id="locationEAddr">
                <input type="hidden" name="locationSAddrDetail" id="locationSAddrDetail">
                <input type="hidden" name="locationEAddrDetail" id="locationEAddrDetail">
                <div class="form-group row mt0">
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        
                        <select class="custom-select col-12" name="searchDate" id="searchDate">
                            <option value="sDate" selected>상차일자</option>
                            <option value="regdate">등록일자</option>
                        </select>
                    </div>
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1" style="margin-right: 0px;">
                        
                        <input style="padding: 0;" type="text" id="fromDate" name="fromDate" class="col-12">
                    </div>
                    <span style="margin-top: 4px;">~</span>
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        
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
                        
                        <select class="form-control" class="custom-select col-12" id="sMixYn" name="sMixYn">
                            <option value="">-독차/혼적-</option>
                            <option value="N">독차</option>
                            <option value="Y">혼적</option>
                        </select>
                    </div>
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        
                        <select class="form-control" class="custom-select col-12" id="sAllocState" name="sAllocState">
                            <option>-배차상태-</option>
                        </select>
                    </div>
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        
                        <select class="form-control" class="custom-select col-12" id="sDeptId" name="sDeptId">
                            <option>--부서명--</option>
                        </select>
                    </div>
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        
                        <select class="form-control" class="custom-select col-12" id="userId" name="userId"></select>
                    </div>

                    <div class="input-group input-group-sm col radio-or-checkBox ">
                        <input id="notCancel" name="notCancel" type="checkbox" onclick="btnChk(this)" value="N">
                        <label for="notCancel" class="label-margin">
                            <span>취소건 제외</span>
                        </label>
                    </div>
                </div>
                <div class="form-group row" style="justify-content: space-between;">
	                <div class="row">
	                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1 wd90">
	                        
	                        <select class="custom-select col-12" id="searchColumn" name="searchColumn">
	                            <option value="sellCustName">거래처명</option>
	                            <option value="buyCustName">주선/운송사명</option>
	                            <option value="sComName">상차지명</option>
	                            <option value="eComName">하차지명</option>
	                            <option value="orderId">오더ID</option>
	                            <option value="externalInformation">외부참고정보</option>
	                        </select>
	                    </div>
	                    <div class="input-group input-group-sm middle-name wd190 div-min-col-1">
	                        
	                        <input type="text" id="searchValue" name="searchValue" class="wd190 form-control form-control-sm searchValue">
	                    </div>
	                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1 wd90">
	                        
	                        <select class="custom-select col-12 wd90" id="searchDriver" name="searchDriver">
	                            <option value="carNum">차량번호</option>
	                            <option value="driverName">차주명</option>
	                        </select>
	                    </div>
	                    <div class="input-group input-group-sm middle-name div-min-col-1 wd190">
	                        
	                        <input type="text" id="driverValue" name="driverValue" class="wd190 form-control form-control-sm searchValue">
	                    </div>
	
	                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1 wd90">
	                        
	                        <select class="form-control" class="wd90 custom-select col-12" id="listSSido" name="listSSido">
	                            <option>상차지</option>
	                        </select>
	                    </div>
	
	                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
	                        
	                        <select class="form-control" class="custom-select col-12" id="listESido" name="listESido">
	                            <option>하차지</option>
	                        </select>
	                    </div>
	
	                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
	                        
	                        <select class="custom-select col-12" id="orderStopYn" name="orderStopYn">
	                            <option value="">경유지 여부</option>
	                            <option value="Y">있음</option>
	                            <option value="N">없음</option>
	                        </select>
	                    </div>
	
	                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
	                        
	                        <select class="custom-select col-12" id="sLinkSettleYn" name="sLinkSettleYn">
	                            <option value="">정보망 확정여부</option>
	                            <option value="Y">확정</option>
	                            <option value="N">미확정</option>
	                        </select>
	                    </div>
	                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
	                        
	                        <select class="custom-select col-12" id="searchChargeType" name="searchChargeType">
	                            <option value="">운임정보</option>
	                            <option value="01">인수증</option>
	                            <option value="02">선/착불</option>
	                            <option value="03">기사발행</option>
	                        </select>
	                    </div>
	                    <div class="input-group input-group-sm col radio-or-checkBox ">
	                        <input id="myOrder" name="myOrder" type="checkbox" onclick="btnChk(this)" value="N">
	                        <label for="myOrder" class="label-margin">
	                            <span>내거래 보기</span>
	                        </label>
	                    </div>
                    </div>
					<div class="row">
	                    <div class="btn_58 input-group-sm middle-name mr7">
	                        <button onclick="goList()" type="button" class="btn_58 btn_b">검색</button>
	                    </div>
	                    <div class="btn_58 input-group input-group-sm middle-name mr0">
	                        <button onclick="searchReset()" type="button" class="btn_58 btn_black">초기화</button>
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
                                <div class="btn-row" style="float:left;">
                                    <div class="tool_group" style ="font-size: 12px;">자동새로고침
                                        <input type="checkbox" id="autoRefresh" name="autoRefresh" class="input_on-off">
                                        <label for="autoRefresh" class="label_on-off"  style="vertical-align:middle;margin: 0 0 0 7px;">
                                            <span class="marble"></span>
                                            <span class="on">ON</span>
                                            <span class="off" >OFF</span>
                                        </label>
                                    </div>
                                </div>
                                <div class="btn-row">
                                    <div class="tool_group">
                                        <div class="padding">
                                            <c:if test="${mainCustId eq sessionScope.userInfo.custId }">
                                                <a href="#" class="k-pager-refresh k-button" onclick="openSendLinkPop();"><b class="btn-b">정보망 전송</b></a>
                                            </c:if>
                                            <!-- <a href="#" class="k-pager-refresh k-button" onclick="openTalkPop();"><b class="btn-b"><i class="k-icon k-i-email"></i>알림톡 전송</b></a> -->
                                            <a href="#" class="k-pager-refresh k-button" onclick="popOrderViewLocation();"><b class="btn-b">위치관제</b></a>
                                            <a href="#" class="k-pager-refresh k-button" onclick="orderHistory();"><b class="btn-b">수정이력</b></a>
                                            <c:if test="${menuAuth.printYn eq 'Y'}">
                                                <a href="#" class="k-pager-refresh k-button" onclick="goExcel();"><b class="btn-x">엑셀출력</b></a>
                                            </c:if>
                                            <c:if test="${menuAuth.writeYn eq 'Y'}">
                                                <a href="#" class="k-pager-refresh k-button" onclick="form_popup('N', {});"><b class="btn-h">신규등록</b></a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div><!-- /toolbar -->
                        <div style="width: 100%">
                        	<!-- /그리드반응형 -->
                            <div style="height:calc(100vh - 320px)" id="grid"></div>

                            <!-- 22.07.15 이건욱 그리드 개인화 설정 -->
                            <ul id="gridContextMenu">
                                <li id="cSave" class="privateRClick">리스트 현재설정 저장</li>
                                <li class="k-separator privateRClick"></li>
                                <li id="dSave" class="privateRClick">리스트 세부설정 변경</li>
                                <li class="k-separator privateRClick"></li>
                                <li id="custMod" class="privateRClick">화주변경</li>
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
    <div id="divViewLocation"></div>
    <div id="divSendLink"></div>
    <div id="divOrderHistory"></div>
</div>
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
<script type="text/javascript">
    var viewLocation = null;

    // 22.07.15 이건욱 그리드 개인화 설정 -> 접속 사용자 아이디 세션 get
    var userId = '${sessionScope.userInfo.userId}';

    $("#gridContextMenu").kendoContextMenu({
        target: "#grid",
        filter: "tr[role='row']"
    });

    var contextMenu = $("#gridContextMenu").data("kendoContextMenu");
    contextMenu.bind("select", onContextMenuSelect);

    var headerTitle = ($("#headerTitle").text());

    var refresh_timer;
    var autoRefresh;
    $(document).ready(function(){

        $(window).bind("resize", function() {
            //그리드반응형 $("#grid").css("height", "calc(100vh - 235px)");
            $("#grid").css("height", "calc(100vh - 330px)");

            $("#grid").data("kendoGrid").resize();
        });


        Util.setCmmCode("select", "listSSido", "SIDO", "", "상차지");
        Util.setCmmCode("select", "listESido", "SIDO", "", "하차지");
        Util.setCmmCode("select", "sOrderState", "ORDER_STATE_CD", "", "--오더상태--");
        Util.setCmmCode("select", "sAllocState", "ALLOC_STATE_CD", "", "-배차상태-");

        $("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
        $("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
        Util.setSearchDateForm();

        Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", {deptId:$(this).val()}, "userId", "userName", "", "전체");
        $('#sDeptId').on('change', function() {
            Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", {deptId:$(this).val()}, "userId", "userName", "", "전체");
        });

        Util.setSelectBox("/contents/basic/data/compDeptList.do", "sDeptId", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn :'Y'}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "-담당부서-");

        var $options = $("#sDeptId > option").clone();
        $('#deptId').append($options);
        $("#deptId option[value='']").remove();

        var $options2 = $("#sCarMngCode > option").clone();
        $('#carMngCode').append($options2);
        $("#carMngCode option[value='']").remove();

        goList();

        //자동 새로고침 기본 10초
        var rCookie = $.cookie("autoRefresh");
        if(rCookie == null) {
            $.cookie("autoRefresh", 30000, {expires:10000,path:"/"});
            rCookie = $.cookie("autoRefresh");
        }

        if(rCookie != "0") {
            startInterval();
            $("#autoRefresh").prop("checked", true);
        } else {
            $("#autoRefresh").prop("checked", false);
        }

        //자동 새로고침 기능 on/off
        $("#autoRefresh").on("click", function(){
            if($(this).is(":checked")) {
                $.cookie("autoRefresh", 30000, {expires:9999,path:"/"});
                startInterval();
            } else {
                $.cookie("autoRefresh", 0, {expires:9999,path:"/"});
                stopInterval();
            }
        });
    });

    // 22.07.18 이건욱 그리드 개인화 설정 -> 숫자 형태의 컬럼 타입을 Number로 바꿔 정렬 시 올바르게 정렬 되도록 추가
    var columns = [
        { field: "number", title: "No", width: 50 },
        { field: "allocStateName", title: "상태", width: 120},
        { field: "sellCustName", title: "거래처명", width: 150 },
        { field: "sComName", title: "상차지명", width: 150 },
        { field: "sAddr", title: "상차지주소", width: 150 },
        { field: "sTel", title: "상차지연락처", width: 120,
            template: function(dataItem) {
                return Util.formatPhone(dataItem.sTel);
            }
        },
        { field: "eComName", title: "하차지명", width: 150 },
        { field: "eAddr", title: "하차지주소", width: 150 },
        { field: "eTel", title: "하차지연락처", width: 120,
            template: function(dataItem) {
                return Util.formatPhone(dataItem.eTel);
            }
        },
        { field: "orderCarTonName", title: "요청톤수", width:90},
        { field: "carNum", title: "차량번호", width: 120 },
        { field: "goodsWeight", title: "중량", width: 70 },
        { field: "goodsName", title: "화물정보", width: 120 },
        { field: "chargeType", title: "운임구분", width: 120 },
        { field: "sellAmt", title: "청구운임(소계)", width: 120, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.sellAmt);
            },
            attributes: {
                style: "text-align: right"
            }
        },
        { field: "buyAmt", title: "지불운임(소계)", width: 120, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.buyAmt);
            },
            attributes: {
                style: "text-align: right"
            }
        },

        { field: "sellCharge", title: "기본운임(청구)", width: 120, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.sellCharge);
            },
            attributes: {
                style: "text-align: right"
            }
        },
        { field: "sellWayPointCharge", title: "경유비(청구)", width: 130, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.sellWayPointCharge);
            },
            attributes: {
                style: "text-align: right"
            }
        },
        { field: "sellStayCharge", title: "대기료(청구)", width: 130, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.sellStayCharge);
            },
            attributes: {
                style: "text-align: right"
            }
        },
        { field: "sellHandWorkCharge", title: "수작업비(청구)", width: 130, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.sellHandWorkCharge);
            },
            attributes: {
                style: "text-align: right"
            }
        },
        { field: "sellRoundCharge", title: "회차비(청구)", width: 130, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.sellRoundCharge);
            },
            attributes: {
                style: "text-align: right"
            }
        },
        { field: "sellOtherAddCharge", title: "기타추가비(청구)", width: 130, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.sellOtherAddCharge);
            },
            attributes: {
                style: "text-align: right"
            }
        },
        { field: "sellWeight", title: "청구중량", width: 100 },
        { field: "payType", title: "빠른지급대상", width: 120 },
        { field: "reqPayDate", title: "빠른지급신청", width: 120 },
        { field: "buyCharge", title: "기본운임(지불)", width: 130, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.buyCharge);
            },
            attributes: {
                style: "text-align: right"
            }
        },
        { field: "wayPointCharge", title: "경유비(지불)", width: 130, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.wayPointCharge);
            },
            attributes: {
                style: "text-align: right"
            }
        },
        { field: "stayCharge", title: "대기료(지불)", width: 130, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.stayCharge);
            },
            attributes: {
                style: "text-align: right"
            }
        },
        { field: "handWorkCharge", title: "수작업비(지불)", width: 130, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.handWorkCharge);
            },
            attributes: {
                style: "text-align: right"
            }
        },
        { field: "roundCharge", title: "회차비(지불)", width: 130, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.roundCharge);
            },
            attributes: {
                style: "text-align: right"
            }
        },
        { field: "otherAddCharge", title: "기타추가비(지불)", width: 130, type: 'number',
            template: function(dataItem) {
                return Util.formatNumber(dataItem.otherAddCharge);
            },
            attributes: {
                style: "text-align: right"
            }
        },
        { field: "receiptYn", title: "인수증(전/실)", width: 120 },
        { field: "carSctnName", title: "차량구분", width: 100 },
        { field: "driverName", title: "차주명", width: 100 },
        { field: "driverTel", title: "차주연락처", width: 120,
            template: function(dataItem) {
                return Util.formatPhone(dataItem.driverTel);
            }
        },
        { title: "배차정보망", width: 120,
            template: "#if(buyLinkYn == 'S') {# 정보망직접배차 #} else if(buyLinkYn == 'Y') {# 정보망전송 #} #"
        },
        { field: "buyCustName", title: "운송사명", width: 150 },
        { field: "reqTel", title: "화주연락처", width: 120,
            template: function(dataItem) {
                return Util.formatPhone(dataItem.reqTel);
            }
        },
        { field: "sDateDay", title: "상차일자", width: 100 },
        { field: "sDateTime", title: "상차시간", width: 80 },
        { field: "eDateDay", title: "하차일자", width: 100 },
        { field: "eDateTime", title: "하차시간", width: 80 },
        { field: "mixYn", title: "혼적", width: 70,
            template: "#if(mixYn == 'Y') {# 혼적 #} else {# 독차 #} #"
        },
        { field: "stopCount", title: "경유지", width: 70,
            template: "#if(stopCount == '0') {# 없음 #} else {# #: stopCount #곳 #} #"
        },
        { field: "reqStaffName", title: "화주담당자", width: 100 },
        { field: "reqStaffTel", title: "화주연락처",width: 120,
            template: function(dataItem) {
                return Util.formatPhone(dataItem.reqStaffTel);
            }
        },
        { field: "custMngName", title: "거래처등급", width: 110},
        { field: "carMngName", title: "차주등급", width: 110},
        { field: "linkName", title: "정보망종류", width: 100 },
        { field: "linkSettleYn", title: "정보망확정여부", width: 120,
            template: "#if(linkSettleYn == 'Y') {# 확정 #} else {# 미확정 #} #"
        },
        { field: "deptName", title: " ", width: 160 },
        { field: "staffName", title: "배차원", width: 80 },
        { field: "regname", title: "최초등록자", width: 110 },
        { field: "orderId", title: "오더ID", width: 160 },
        { field: "regdate", title: "등록일자", width: 150 },
        { field: "sellOtherAddMemo", title: "기타추가비(청구)메모", width: 150 },
        { field: "otherAddMemo", title: "기타추가비(지불)메모", width: 150 },
        { field: "memo", title: "메모", width: 150 },
        { field: "profitCommission", title: "이익(수수료)", width: 100,
            template: function(dataItem) {
                if(dataItem.chargeType =='인수증'){
                    if(dataItem.sellAmt ==''){
                        dataItem.sellAmt = 0;
                    }
                    if(dataItem.buyAmt ==''){
                        dataItem.buyAmt = 0;
                    }
                   var sellAmt = dataItem.sellAmt - dataItem.buyAmt;
                    if(sellAmt == 0){
                        return "0";
                    }else{
                        return Util.formatNumber(sellAmt)+"";
                    }

                }else{

                    if(dataItem.sellFee ==0){
                        return "0";
                    }else{
                        return Util.formatNumber(dataItem.sellFee)+"";
                    }

                }

            }
        },
        { field: "profitRate", title: "이익률(%)", width: 100,
            template: function(dataItem) {

                if(dataItem.chargeType =='인수증'){
                    if(dataItem.sellAmt ==''){
                        dataItem.sellAmt = 0;
                        return "확인필요";
                    }else{
                        if(dataItem.buyAmt ==''){
                            dataItem.buyAmt = 0;
                        }
                        var sellAmt = dataItem.sellAmt - dataItem.buyAmt;
                        if(sellAmt =="0"){
                            return "확인필요";
                        }else{
                            var profitRate =  (sellAmt/dataItem.sellAmt)*100;
                            profitRate= profitRate.toFixed(1) ;
                            profitRate = profitRate.replace(/(.?0+$)/, "");
                            return profitRate+"%";
                        }
                    }
                }else{
                    //dataItem.sellFee = -100;
                    if(dataItem.sellFee > 0 ){
                        return "100%";
                    }else if(dataItem.sellFee == 0 ){
                        return "0%";
                    } else{
                        return "-100%";
                    }
                }
            }
        },
        { field: "modId", title: "최종수정자", width: 150 },
        { field: "modDate", title: "최종수정일", width: 150 },
        { field: "externalInformation", title: "외부참고정보", width: 150 },
        { field: "driverStateName", hidden:true},
        { field: "orderState", hidden:true},
        { field: "orderStateName", hidden:true},
        { field: "staffId", hidden:true},
        { field: "regid", hidden:true},
        { field: "carMngMemo", hidden:true},
        { field: "custMngMemo", hidden:true},
        { field: "salesFinish", hidden:true},
        { field: "salesTaxinv", hidden:true},
        { field: "purchaseFinish", hidden:true},
        { field: "purchaseTaxinv", hidden:true}
    ];

    function goList() {
        // 22.07.15 이건욱 그리드 개인화 설정 -> 메뉴코드, 그리드아이디, 접속사용자아이디, 기존 컬럼정보 전달
        columns = setPrivateData("B2110", "grid", userId, columns);

        $("#grid").text("");
        $("#grid").kendoGrid({
            dataSource : {
                transport : {
                    read : {
                        url : "/contents/order/data/orderList.do",
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
                        if(response.summary != null){
                            var	groupCount = ""
                            groupCount = "<i class=\"btn_b\">접수 " + response.summary.registerOrderCount + "건</i> " +
                                "<i class=\"btn_g\">배차 " + response.summary.dispatchOrderCount + "건</i>" +
                                "<i class=\"btn_gray\">취소 " + response.summary.cancelOrderCount + "건</i> " +
                                "<i class=\"sumSellCharge\">매출" +  Util.nvl(Util.formatNumber(response.summary.sumSellCharge),"<span style=\"color: #dc3545; font-weight: bold; font-style: initial; font-size: 14px; \">0</span>")  + "원,</i>" + 
                                "<i class=\"sumBuyCharge\">매입 " + Util.nvl(Util.formatNumber(response.summary.sumBuyCharge), "<span style=\"color: #dc3545; font-weight: bold; font-style: initial; font-size: 14px; \">0</span>") + "원</i>, " +
                                "<i class=\"profitAndLoss\">손익 " + Util.nvl(Util.formatNumber(response.summary.profitAndLoss),"<span style=\"color: #dc3545; font-weight: bold; font-style: initial; font-size: 14px; \">0</span>") + "원</i>";
                            $("#groupCount").html(groupCount);
                        }
                        return response.data;
                    },
                    total : function(response) {
                        return response.total;
                    }
                },
                pageSize : 50,
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
            selectable: true,
            sortable : false,
            pageable : true,
            resizable: true,
            scrollable: true,
            editable : false,
            columns : columns,
            noRecords: true,
            messages: {
                noRecords: "조회된 데이터가 없습니다."
            },
            // 22.07.15 이건욱 그리드 개인화 설정
            reorderable: true, // 컬럼 위치 변경
            columnReorder: onReorderEnd, // 컬럼 위치 변경 이벤트
            columnResize: onResizeEnd, // 컬럼 사이즈 변경 이벤트
        });

        // 22.07.15 이건욱 그리드 개인화 설정 -> 그리드 옵션 활성화 여부 처리
        // 추가로 페이지에서 적용되는 이벤트가 있는 경우
        // 그 이벤트 앞에 아래 함수 호출 부분이 적용되어야 함
        setOptionActive("B2110", "grid", userId);

        var grid = $("#grid").data("kendoGrid");
        grid.bind("change", onChange);
        grid.tbody.delegate('tr', 'dblclick', function(){
            var dataItem = grid.dataItem($(this));
            form_popup("E", dataItem);
        });

        grid.bind("dataBound", grid_dataBound);
    }

    function onChange(e){
        var row = this.select();
        var data = this.dataItem(row);
        $("#locationSLat").val(data.sLat);
        $("#locationSLon").val(data.sLon);
        $("#locationELat").val(data.eLat);
        $("#locationELon").val(data.eLon);
        $("#locationCarNum").val(Util.nvl(data.buyCarNum,data.carNum));
        $("#locationDriverName").val(Util.nvl(data.buyDriverName,data.driverName));
        $("#locationDriverTel").val(Util.nvl(data.buyDriverTel,data.driverTel));
        $("#locationSComName").val(data.sComName);
        $("#locationEComName").val(data.eComName);
        $("#locationSAddr").val(data.sAddr);
        $("#locationEAddr").val(data.eAddr);
        $("#locationSAddrDetail").val(data.sAddrDetail);
        $("#locationEAddrDetail").val(data.eAddrDetail);
    }

    function grid_dataBound(e) {
        var rows = e.sender.tbody.children();
        var row_len = rows.length;
        var userId = "${sessionScope.userInfo.userId}"
        for (var j = 0; j < row_len; j++) {
            var row = $(rows[j]);
            var dataItem = e.sender.dataItem(row);
            var cells = row.children();

            if (dataItem.get("orderState") == "09") {
                cells.each(function(i){
                    cells.addClass("cancel");
                });
            } else if (dataItem.get("driverStateName") == null){
                cells.each(function(i){
                    cells.addClass("accept");
                });
            }

            if (dataItem.get("regid") == userId){
                cells.each(function(i){
                    cells.addClass("myOrder");
                });
            }

            if (dataItem.get("memo") != "" && dataItem.get("memo") != null){
                var col = cells.eq(0);
                col.addClass("isMemo");
            }
        }

    }

    function form_popup(mode, data) {
        /*20220819 popDiv 수정*/

        if ($('.insert_pop').css('display') == 'none') {
            $('.insert_pop').css('display', 'block');
        }

        //Util.insertCloseButton();
        $('#mixYn').val("N");
        $('#returnYn').val("N");
        $('#dangerGoodsYn').val("N");
        $('#chemicalsYn').val("N");
        $('#foreignLicenseYn').val("N");
        $('#group-list').addClass("block");
        $('.insert_pop').addClass("block");
        $('.insertClose').addClass("block");
        $("#buyDriverName,#buyDriverTel").removeAttr("readonly");
        $("#buyDriverName,#buyDriverTel").removeClass("noColorReadonly");

        $("#btnSubmit").show();
        $("#orderDelete").css("display","none");
        if(mode == "E" ) {
            $("#order_legend").text("오더 수정");
            $("#btn_save").html($("#btn_save").html().replace('저장', '적용'));
            $("#orderCopy").css("display","");
            $("#orderDelete").css("display","");
            if(data.orderState == "09") {
                $("#btn_state").html("<i class=\"k-icon k-i-upload\"></i>오더접수");
                $("#orderDelete").attr("onClick", "updateOrderState('00')");
            } else {
                $("#btn_state").html("<i class=\"k-icon k-i-delete\"></i>오더취소");
                $("#orderDelete").attr("onClick", "updateOrderState('09')");
            }
            $("#sAreaSave").parent(".radio-or-checkBox").css("display", "none");
            $("#eAreaSave").parent(".radio-or-checkBox").css("display", "none");

            //수정 모드로 변경
            $("#mode").val("E");
            $(".openCloseDiv").hide();
            $("#endAddrOpenClose").show();
            $("#owner").html("화주추가열기");
            $("#startAddr").html("상차추가열기");
            /* 하차div 따로세팅 */
            $("#endAddr").html("하차추가접기");
            $("#cargo").html("화물추가열기");
            $("#allocD").html("배차추가열기");
            $("#allocC").html("배차추가열기");
            $("#other").html("기타추가열기");
            getOrderData(data.orderId, data.sellAllocId, data.allocId);
        } else {
            $("#order_legend").text("오더 등록");
            $("#btn_save").html($("#btn_save").html().replace('적용', '저장'));
            $("#orderCopy").css("display","none");
            $("#sAreaSave").parent(".radio-or-checkBox").css("display", "contents");
            $("#eAreaSave").parent(".radio-or-checkBox").css("display", "contents");
            $("#mode").val("N");
            $("#driverProposal").show();
            $("#allocButtons").hide();
            $(".openCloseDiv").hide();
            $("#endAddrOpenClose").show();
            $("#owner").html("화주추가열기");
            $("#startAddr").html("상차추가열기");
            /* 하차div 따로세팅 */
            $("#endAddr").html("하차추가접기");
            $("#cargo").html("화물추가열기");
            $("#allocD").html("배차추가열기");
            $("#allocC").html("배차추가열기");
            $("#other").html("기타추가열기");
            init();
            //09-21 사용자 talk 사용여부 정보 추가
            //userTalkYn();
        }

    }

    function form_popup_close() {
        $('#group-list').removeClass("block");
        $('.insert_pop').removeClass("block");
        $('.insertClose').removeClass("block");
        $(".openCloseDiv").hide();
        $(".openCloseBtn").html("추가정보열기");
    }

    //excel download
    function goExcel(){
        $("#loading").show();
        var grid = $("#grid").data("kendoGrid");
        grid.saveAsExcel();
    }

    function openSendLinkPop() {
        if($("#locationSLat").val() == "0" || $("#locationSLon").val() == "0" || $("#locationELat").val() == "0" || $("#locationELon").val() == "0"){
            alert("더미 상/하차지가 포함된 오더는 정보망접수 할 수 없습니다..");
            return
        }
        var selectedItem = chkSelectedOrder();

        if(selectedItem.isSelected){

            var sSido = selectedItem.item.sSido;
            var sGungu = selectedItem.item.sGungu;
            var eSido = selectedItem.item.eSido;
            var eGungu = selectedItem.item.eGungu;
            var carTonCode = selectedItem.item.carTonCode;
            var allocId = selectedItem.item.allocId;
            var orderId = selectedItem.item.orderId;
            var allocState = selectedItem.item.allocState;
            var goodsName = selectedItem.item.goodsName;
            var goodsWeight = selectedItem.item.goodsWeight;
            var eDateDay = selectedItem.item.eDateDay;

            popupModal = $("#divSendLink").kendoWindow({
                width: 850,
                height: 729,
                title: "정보망 전송",
                visible: false,
                content: {
                    url: "/contents/order/view/sendLinkPop.do?orderId="+orderId+"&allocId="+allocId+"&allocState="+allocState+"&sSido="+sSido+"&sGungu="+sGungu+"&eSido="+eSido+"&eGungu="+eGungu+"&carTonCode="+carTonCode+"&goodsName="+goodsName+"&goodsWeight="+goodsWeight+"&eDateDay="+eDateDay,
                },
                iframe:true,
                modal:true
            }).data("kendoWindow");

            popupModal.center().open();
        }
    }

    function openTalkPop() {
        var selectedItem = chkSelectedOrder();

        if(selectedItem.isSelected){

        }
    }

    function searchReset(){
        $("#fSearch")[0].reset();
    }

    function startInterval() {

        refresh_timer = 31;
        autoRefresh = setInterval(function(){
            refresh_timer --;
            if(refresh_timer < 2) {
                refresh_timer = 31;
                goList();
            }
        }, 1000);
    }

    function stopInterval() {
        clearInterval(autoRefresh);
    }

    // 22.07.15 이건욱 그리드 개인화 설정
    function onContextMenuSelect(e) {
        var rCookie = $.cookie("autoRefresh");

        if(rCookie != "0") {
            alert("자동새로고침 기능 해제 후 사용하시기 바랍니다.");
            return;
        }

        var grid = $("#grid").data("kendoGrid");
        var data = grid.dataItem(e.target);
        var row = grid.select();
        var multiSelectedData = [];
        var item = e.item.id;

        for(var i = 0; i < row.length; i++) {
            multiSelectedData.push(grid.dataItem(row[i]));
        }

        switch (item) {
            case "cSave" : // 리스트 현재설정 저장 버튼 이벤트
                setPrivateSaveData("B2110", "grid", userId);
                break;
            case "dSave" : // 리스트 세부설정 변경 버튼 이벤트
                setPrivatePanel("B2110", "grid", userId);
                break;
            case "custMod" : // 리스트 세부설정 변경 버튼 이벤트
                var grid = $("#grid").data("kendoGrid");
                var dataItem = grid.dataItem(grid.select());
                changeShipper(dataItem);
                break;
        }
    }

    reqChangeModal = $("#divChangeReq");
    reqChangeModal.kendoDialog({
        width: "500px",
        height: "240px",
        visible: false,
        title: "화주변경",
        closable: true,
        modal: true
    });

    function changeShipper(dataItem){
        if(dataItem ==null){
            alert("화주변경 처리 될 오더를 선택해 주세요.");
            return;
        }
        if(!$("#sDeptId").val()) {
            alert("담당부서를 선택해주세요.");
            return;
        }

        $.ajax({
            url: "/contents/order/data/orderDetail.do",
            type: "POST",
            dataType: "json",
            data: "orderId=" + dataItem.orderId + "&sellAllocId=" + dataItem.sellAllocId + "&allocId=" + dataItem.allocId,
            success: function(data) {
                if(data.result) {

                    if(data.data.salesFinish !="N" && data.data.salesFinish !=null){
                        alert("매출 마감처리가 된 오더입니다.");
                        return;
                    }
                    if(data.data.salesTaxinv !="N" && data.data.salesTaxinv !=null){
                        alert("매출 세금계산서가 발행된 오더입니다.");
                        return;
                    }
                    var orderIdList = [];
                    var allocIdList = [];

                    orderIdList.push(dataItem.orderId);
                    allocIdList.push(dataItem.sellAllocId);

                    reqChangeModal.data("kendoDialog").open();
                    $("#modalAllocList").val(allocIdList);
                    $("#modalOrderList").val(orderIdList);

                    searchModalCustName = $("#sModalCustName").data("kendoMultiColumnComboBox");
                    // 22.09.22 이건욱: order.js의 공통 함수사용하지 않음.
                    searchModalCustName = setComboCustName("sModalCustName", "01", $("#sDeptId").val());
                    searchModalCustName.bind("select", onChangeSearchModalCust);
                }
            }
        });


 /*       if(dataItem.salesFinish !="N" && dataItem.salesFinish !=null){
            alert("매출 마감처리가 된 오더입니다.");
            return;
        }
        if(dataItem.salesTaxinv !="N" && dataItem.salesTaxinv !=null){
            alert("매출 세금계산서가 발행된 오더입니다.");
            return;
        }
*/

    }
    //09-21 사용자 talk 사용여부 정보 추가
    function userTalkYn() {
        $.ajax({
            url: "/contents/basic/data/getUserTalk.do",
            type: "POST",
            dataType: "json",
            success: function (data) {
                if (data.result) {
                    $("#f input[name =chkTalk]:input[value=" + data.userInfo.talkYn + "]").prop("checked", true);
                }
            }
        })
    }

    function choiceSelectBox(obj){
        var nWidth = parseInt( obj.offsetWidth );
        var nHeight = parseInt( obj.offsetHeight  );
        var nLeft =  obj.offsetLeft;
        var nTop = obj.offsetTop+obj.offsetHeight+2;

        if( navigator.appName=="Microsoft Internet Explorer"){
            nLeft += obj.offsetParent.offsetParent.offsetLeft + obj.offsetParent.offsetLeft;
            nTop += obj.offsetParent.offsetParent.offsetTop + obj.offsetParent.offsetTop;
        }

        if( $("#testVal").css("visibility") =="hidden" ){

            $("#testVal").css("left", nLeft) ;
            $("#testVal").css("top", nTop) ;
            $("#testVal").css("padding-left", "0px");
            $("#testVal").css("width", nWidth);
            $("#testVal").css("visibility", "visible");

        }else{
            $("#testVal").css("visibility", "hidden");
        }
    }

    function setComboCustName(elementId, sellBuySctn, deptId) {
        var comboCustName = $("#" + elementId).kendoMultiColumnComboBox({
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
                            sellBuySctn : sellBuySctn,
                            deptId: deptId
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
            popup: {
                position: "top left"
            },
            columns: [
                { field: "custName", title: "거래처명", width: "220" },
                { field: "deptName", title: "부서명", width: "100" },
                { field: "bizName", title: "계약사명", width: "220" },
                { field: "ceo", title: "대표자", width: "100" },
                { field: "bizNum", title: "사업자번호", width: "150" }
            ]
        }).data("kendoMultiColumnComboBox");

        return comboCustName;
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
    $('#fChangeReq').validator().on('submit', function(e) {
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

</script>