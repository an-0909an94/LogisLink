<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .cancel {color:#e54524 !important;}
    .accept {color:#0065bd !important;}
    .myOrder {background: #FAFAD2}
    .isMemo {background: #f08080}

    #grid .k-grid-content {max-height:100vh}
    .width6_5{
        width: 6.5%;
        align-self: center;
    }
    .modalEditor {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        flex-wrap: wrap;
    }
/*    .form-control {
        border: 0px solid #bbbbbb;
    }*/
    .custom-select {
        border: 1px solid #ddd !important;
    }


    #back{
        position: absolute;
        z-index: 9998;
        background-color: #000000;
        display:none;
        left:0;
        top:0;
    }

    #loadingBar{
        position:absolute;
        left:50%;
        top: 40%;
        display:none;
        z-index:9999;
    }
</style>

<div class="header">
    <div style="justify-content: space-between; display: flex;" class="summary p30">
        <div class="hdr-tit" style ="padding: 5px; font-weight:bold;">
            <P id="headerTitle">RPA리스트</P>
        </div>
    </div>
    <div class="contents">
        <div id="group-list" class="cont-wrapper-page-grid">
            <form id="fSearch" class="date-bnt">
                <div class="form-group row" style ="margin-bottom: 20px;justify-content: space-between;">
                    <div class="row" style="display: block">
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
<%--                        <strong>등록일자</strong>--%>
                        <select class="custom-select col-12" name="searchDate" id="searchDate">
                            <option value="sDate" selected>상차일자</option>
                            <option value="regdate">등록일자</option>
                        </select>
                    </div>
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <input style="padding: 0;" type="text" id="fromDate" name="fromDate" class="col-12">
                    </div>
                    <span style="margin-top: 31px;">~</span>
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
                        <select class="form-control" class="custom-select col-12" id="sDeptId" name="sDeptId">
                            <option>--부서명--</option>
                        </select>
                    </div>
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <select class="form-control" class="custom-select col-12" id="userId" name="userId"></select>
                    </div>
                    <div class="input-group input-group-sm width6_5 middle-name div-min-col-1">
                        <select class="custom-select col-12" id="searchColumn" name="searchColumn">
                            <option value="sellCustName">거래처명</option>
                            <option value="orderId">오더ID</option>
                        </select>
                    </div>
                    <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
                        <input type="text" id="searchValue" name="searchValue" class="form-control form-control-sm searchValue">
                    </div>
                </div>
                    <div class="row" style="display: block">
                    <div class="btn_58 input-group-sm middle-name mr7" style="">
                        <button onclick="goList()" type="button" style="" class="btn_58 btn_b">검색</button>
                    </div>
                    <div class="btn_58 input-group input-group-sm middle-name mr0" style="">
                        <button onclick="searchReset()"  type="button" class="btn_58 btn_black">초기화</button>
                    </div>
                    </div>
                </div>

            </form>
            <!--  -->
            <div class="cont-body">
                <!-- f-wrap -->
                <div class="k-wrap content">
                    <div class="toolbar row">
                        <div class="tool_form col" style="margin-bottom:15px;">
                            <div class="btn-row" style="float:left;margin-top:12px;">
                                <div class="tool_group" style ="font-size: 13px">
                                    자동새로고침
                                    <input type="checkbox" id="autoRefresh" name="autoRefresh" class="input_on-off">
                                    <label for="autoRefresh" class="label_on-off"  style="vertical-align:middle;">
                                        <span class="marble"></span>
                                        <span class="on">on</span>
                                        <span class="off" >off</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div><!-- /toolbar -->
                    <div class="lookup_table">
                        <!-- table -->
                        <div style="width: 100%">
                            <div style="height:calc(100vh - 235px);" id="grid"></div>
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

<%--<div id="divChangeReq" class="editor-warp p-0">
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
    </form>
</div>--%>
<div id="outreqModal" class="editor-warp p-0">
    <form class="modalEditor" id="fOutreqModal">
        <input type="hidden" name="orderId" id="orderId">
        <input type="hidden" name="orderState" id="orderState">
        <input type="hidden" name="link_id" id="link_id">
        <input type="hidden" name="alloc_charge_YN" id="alloc_charge_YN">

        <div class="modalHeader">
            <div class="form-group row" style="display: block;">
               <%--<label class="col-form-label big-name"></label>--%>
                <div class="input-group input-group-sm" >
                    <table border="1">
                        <tr>
                            <th>이전 운임</th>
                            <th>변경 운임</th>
                        </tr>
                        <tr>
                            <td class ="form-control form-control-sm" style="width:120px;" id ="afterLinkCharge"></td>
                            <td><input type="text" id="linkCharge" name="linkCharge"class ="form-control form-control-sm" style="width:100%;" required></td>
                        </tr>
                    </table>

                </div>
            </div>
        </div>
        <div class="editor_btns">
            <div class="padding">
                <a onclick="outreqModalSubmit()" class="btn_b k-pager-refresh k-button" style="color: #fff">저장</a>
                <a onclick="outreqModalClose()" class="btn_gray k-pager-refresh k-button" style="color: #fff">닫기</a>
            </div>
        </div>
    </form>
</div>
<div id="outreqModalAlert" class="editor-warp p-0">
    <form class="modalEditor" id="fOutreqModalAlert">
        <div class="modalHeader">
            <div class="form-group row">
                <div class="input-group input-group-sm col" id = "alertMsg">

                </div>
            </div>
        </div>
        <div class="editor_btns">
            <div class="padding">
                <a onclick="outreqModalAlertClose()" class="k-pager-refresh k-button"><b class="btn-b">확인</b></a>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
	var id24 = "";
	var idOne = "";
	var idMan = "";
    var viewLocation = null;

    var userId = '${sessionScope.userInfo.userId}';

    var headerTitle = ($("#headerTitle").text());

    var refresh_timer;
    var autoRefresh;
    $(document).ready(function(){

        $("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
        $("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
        Util.setSearchDateForm();

        Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", {deptId:$(this).val()}, "userId", "userName", "${sessionScope.userInfo.userId}", "전체");
        $('#sDeptId').on('change', function() {
            Util.setSelectBox("/contents/basic/data/userNameList.do", "userId", {deptId:$(this).val()}, "userId", "userName", "", "전체");
        });

        Util.setSelectBox("/contents/basic/data/compDeptList.do", "sDeptId", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn :'Y'}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "--부서명--");

        var $options = $("#sDeptId > option").clone();
        $('#deptId').append($options);
        $("#deptId option[value='']").remove();

        $(window).bind("resize", function() {
            $("#grid").css("height", "calc(100vh - 235px)");

            $("#grid").data("kendoGrid").resize();
        });

        goList();


        var rCookie = $.cookie("autoRefreshLink");
        if(rCookie == null) {
            $.cookie("autoRefreshLink", 30000, {expires:10000,path:"/"});
            rCookie = $.cookie("autoRefreshLink");
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
                $.cookie("autoRefreshLink", 30000, {expires:9999,path:"/"});
                startInterval();
            } else {
                $.cookie("autoRefreshLink", 0, {expires:9999,path:"/"});
                stopInterval();
            }
        });

        $('#linkCharge').on("input", function() {
            var linkCharge = /^\d*$/;
            if(!linkCharge.test($("#linkCharge").val().trim().replace(/,/g, ""))){
                alert("숫자만 입력하시기 바랍니다.");
                $("#linkCharge").val("")
                return;
            }
            $("#linkCharge").val(Util.formatNumberInput($("#linkCharge").val().trim()));
        });

    });

    // 22.07.18 이건욱 그리드 개인화 설정 -> 숫자 형태의 컬럼 타입을 Number로 바꿔 정렬 시 올바르게 정렬 되도록 추가
    var columns = [
        { field: "number", title: "No", width: 20 },
        { field: "orderCarTonName", title: "요청톤수", width:30},
        { field: "sAddr", title: "상차지주소", width:150},
        { field: "eAddr", title: "하차지주소", width:150},
        { field: "custName", title: "거래처명", width: 60,
            attributes: {
                style: "text-align: left"
            }
        },
        { field: "sDateDay", title: "상차일자", width: 40 },
        { field: "orderCarName", title: "요청차종", width: 40 },
        {
            title: "24시콜",
            columns: [
                { field: "", width: 40, title: "운임",
                    template: function(dataItem) {
                        var msg = statMsg(dataItem.link_stat_03, dataItem.job_stat_03);
                        if(dataItem.link_charge_03 !=="" && dataItem.link_charge_03 !=null){
                            if(msg ==""){
                                return "<a href=\"#\" onclick='getMsg(\""+dataItem.rpa_msg_03+"\")' style='color: #0033FF; text-decoration-line: underline'><strong>"+Util.formatNumber(dataItem.link_charge_03) + "<br/>" + msg+"</strong></a>";
                            }else{
                                if(dataItem.link_stat_03 =="D"  && dataItem.job_stat_03 =="F"){
                                    return "<a href=\"#\" onclick='getMsg(\""+dataItem.rpa_msg_03+"\")' style='color: #A2A2A2;'><strike>"+Util.formatNumber(dataItem.link_charge_03) + "<br/></strike></a>";
                                }else{
                                    return "<a href=\"#\" onclick='getMsg(\""+dataItem.rpa_msg_03+"\")'>"+Util.formatNumber(dataItem.link_charge_03) + "<br/>" + msg+"</a>";
                                }
                            }
                        }else{
                            if(msg ==""){
                                return "";
                            }else{
                                return "<a href=\"#\" onclick='getMsg(\""+dataItem.rpa_msg_03+"\")'>" + msg+"</a>";
                            }
                        }
                    }
                },
                { field: "", width: 55, title: "기능",
                    template: function(dataItem) {
                    	if(id24 !="") {
                            if ((dataItem.link_charge_03 !== "" && dataItem.link_charge_03 != null) && (dataItem.link_stat_03 != "D" && dataItem.job_stat_03 != "F") && (dataItem.link_stat_03 != "I" && dataItem.job_stat_03 != "E")
                                || (dataItem.link_stat_03 == "D" && dataItem.job_stat_03 == "E") || (dataItem.link_stat_03 == "I" && dataItem.job_stat_03 == "W")
                                || (dataItem.link_stat_03 == "I" && dataItem.job_stat_03 == "F") || dataItem.link_stat_03 == "U") {
                                return " <a class='k-grid-decreaseIndent k-button' style='background-color:#006633; color: #fff' onclick='modLink(\"" + dataItem.order_id + "\",\"" + dataItem.link_charge_03 + "\",\"00\",\"24Cargo\",\"Y\")' ><span>수정</span></a>" +
                                    " <a class='k-grid-decreaseIndent k-button' style='background-color: #FF0033; color: #fff' onclick='cancelLink(\"" + dataItem.order_id + "\",\"" + dataItem.link_charge_03 + "\",\"09\",\"24Cargo\")' ><span>취소</span></a>";
                            } else {

                                return "<a class='k-grid-decreaseIndent k-button' style='background-color: #0A8DFF; color: #fff' onclick='modLink(\"" + dataItem.order_id + "\",\"" + dataItem.link_charge_03 + "\",\"00\",\"24Cargo\",\"N\")' ><span>등록</span></a>";
                            }
                        }else{
                            return "";
                        }
                    }
                },
            ]
        },
        {
            title: "화물맨",
            columns: [
                { field: "", width: 40,  title: "운임",
                    template: function(dataItem) {
                        var msg = statMsg(dataItem.link_stat_21, dataItem.job_stat_21);
                        if(dataItem.link_charge_21 !=="" && dataItem.link_charge_21 !=null){
                            if(msg ==""){
                                return "<a href=\"#\" onclick='getMsg(\""+dataItem.rpa_msg_21+"\")' style='color: #0033FF; text-decoration-line: underline' ><strong>"+Util.formatNumber(dataItem.link_charge_21) + "<br/>" + msg+"</strong></a>";
                            }else{
                                if(dataItem.link_stat_21 =="D"  && dataItem.job_stat_21 =="F"){
                                    return "<a href=\"#\" onclick='getMsg(\""+dataItem.rpa_msg_21+"\")' style='color: #A2A2A2;'><strike>"+Util.formatNumber(dataItem.link_charge_21) + "<br/></strike></a>";
                                }else{
                                    return "<a href=\"#\" onclick='getMsg(\""+dataItem.rpa_msg_21+"\")'>"+Util.formatNumber(dataItem.link_charge_21) + "<br/>" + msg+"</a>";
                                }
                            }
                        }else{
                            if(msg ==""){
                                return "";
                            }else{
                                return "<a href=\"#\" onclick='getMsg(\""+dataItem.rpa_msg_21+"\")'>" + msg+"</a>";
                            }
                        }
                    }
                },
                { field: "", width: 55, title: "기능",
                    template: function(dataItem) {
                    	if(idMan !="") {
                            if ((dataItem.link_charge_21 !== "" && dataItem.link_charge_21 != null) && (dataItem.link_stat_21 != "D" && dataItem.job_stat_21 != "F") && (dataItem.link_stat_21 != "I" && dataItem.job_stat_21 != "E")
                                || (dataItem.link_stat_21 == "D" && dataItem.job_stat_21 == "E") || (dataItem.link_stat_21 == "I" && dataItem.job_stat_21 == "W")
                                || (dataItem.link_stat_21 == "I" && dataItem.job_stat_21 == "F") || dataItem.link_stat_21 == "U") {
                                return " <a class='k-grid-decreaseIndent k-button' style='background-color:#006633; color: #fff' onclick='modLink(\"" + dataItem.order_id + "\",\"" + dataItem.link_charge_21 + "\",\"00\",\"manCargo\",\"Y\")' ><span>수정</span></a>" +
                                    " <a class='k-grid-decreaseIndent k-button' style='background-color: #FF0033; color: #fff' onclick='cancelLink(\"" + dataItem.order_id + "\",\"" + dataItem.link_charge_21 + "\",\"09\",\"manCargo\")' ><span>취소</span></a>";
                            } else {
                                return "<a class='k-grid-decreaseIndent k-button' style='background-color: #0A8DFF; color: #fff' onclick='modLink(\"" + dataItem.order_id + "\",\"" + dataItem.link_charge_21 + "\",\"00\",\"manCargo\",\"N\")' ><span>등록</span></a>";
                            }
                        }else{
                            return "";
                        }
                    }
                },
            ]
        },
        {
            title: "원콜",
            columns: [
                { field: "", width: 40, title: "운임",
                    template: function(dataItem) {
                        var msg = statMsg(dataItem.link_stat_18, dataItem.job_stat_18);
                        if(dataItem.link_charge_18 !=="" && dataItem.link_charge_18 !=null){
                            if(msg ==""){
                                return "<a href=\"#\" onclick='getMsg(\""+dataItem.rpa_msg_18+"\")' style='color: #0033FF; text-decoration-line: underline'><strong>"+Util.formatNumber(dataItem.link_charge_18) + "<br/>" + msg+"</strong></a>";
                            }else{
                                if(dataItem.link_stat_18 =="D"  && dataItem.job_stat_18 =="F"){
                                    return "<a href=\"#\" onclick='getMsg(\""+dataItem.rpa_msg_18+"\")' style='color: #A2A2A2;'><strike>"+Util.formatNumber(dataItem.link_charge_18) + "<br/></strike></a>";
                                }else{
                                    return "<a href=\"#\" onclick='getMsg(\""+dataItem.rpa_msg_18+"\")'>"+Util.formatNumber(dataItem.link_charge_18) + "<br/>" + msg+"</a>";
                                }}
                        }else{
                            if(msg ==""){
                                return "";
                            }else{
                                return "<a href=\"#\" onclick='getMsg(\""+dataItem.rpa_msg_18+"\")'>" + msg+"</a>";
                            }
                        }
                    }
                },
                { field: "", width: 55, title: "기능",
                    template: function(dataItem) {
                    	if(idOne !="") {
                            if ((dataItem.link_charge_18 !== "" && dataItem.link_charge_18 != null) && (dataItem.link_stat_18 != "D" && dataItem.job_stat_18 != "F") && (dataItem.link_stat_18 != "I" && dataItem.job_stat_18 != "E")
                                || (dataItem.link_stat_18 == "D" && dataItem.job_stat_18 == "E") || (dataItem.link_stat_18 == "I" && dataItem.job_stat_18 == "W")
                                || (dataItem.link_stat_18 == "I" && dataItem.job_stat_18 == "F") || dataItem.link_stat_18 == "U") {
                                return " <a class='k-grid-decreaseIndent k-button' style='background-color:#006633; color: #fff' onclick='modLink(\"" + dataItem.order_id + "\",\"" + dataItem.link_charge_18 + "\",\"00\",\"oneCargo\",\"Y\")' ><span>수정</span></a>" +
                                    " <a class='k-grid-decreaseIndent k-button' style='background-color: #FF0033; color: #fff' onclick='cancelLink(\"" + dataItem.order_id + "\",\"" + dataItem.link_charge_18 + "\",\"09\",\"oneCargo\")' ><span>취소</span></a>";
                            } else {
                                return "<a class='k-grid-decreaseIndent k-button' style='background-color: #0A8DFF; color: #fff' onclick='modLink(\"" + dataItem.order_id + "\",\"" + dataItem.link_charge_18 + "\",\"00\",\"oneCargo\",\"N\")' ><span>등록</span></a>";
                            }
                        }else{
                            return "";
                        }
                    }
                },
            ]
        },
        { field: "orderStateName", title: "상태", width: 30 },

        { field: "eDateDay", title: "하차일자", width: 40 },
        { field: "chargeType", title: "운임구분", width: 40 },
        { field: "goodsWeight", title: "중량", width:20},
        { field: "goodsName", title: "화물정보", width:80,
            attributes: {
                style: "text-align: left"
            }
        },
        { field: "order_id", title: "오더ID", width: 75}

    ];

    function goList() {
        // 22.07.15 이건욱 그리드 개인화 설정 -> 메뉴코드, 그리드아이디, 접속사용자아이디, 기존 컬럼정보 전달
    //    columns = setPrivateData("B2110", "grid", userId, columns);

        $("#grid").text("");
        $("#grid").kendoGrid({
            dataSource : {
                transport : {
                    read : {
                        url : "/contents/order/data/rpaList.do",
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
                    	if(response.userLink != null) {
                            id24 = response.userLink.link24Id;
                            idOne = response.userLink.one24Id;
                            idMan = response.userLink.man24Id;
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


    }

    function cancelLink(order_id,link_charge,orderState,link_id){

        var titleNm ="";
        if(link_id =="24Cargo"){
            titleNm ="[24시콜]";
        }else if(link_id =="manCargo"){
            titleNm ="[화물맨]";
        }else if(link_id =="oneCargo"){
            titleNm ="[원콜]";
        }else{
            titleNm ="";
        }



        if(!confirm(titleNm +' 정보망 취소 하시겠습니까?')){
            return false;
        }


        $.ajax({
            url: "/contents/order/cancelLink.do",
            type: "POST",
            dataType: "json",
            data: {
                orderId : order_id
                ,link_charge : link_charge
                ,orderState: orderState
                ,link_id: link_id
            },
            beforeSend: function () {
                FunLoadingBarStart();      	//로딩바 생성
            }
            , complete: function () {
                FunLoadingBarEnd();			//로딩바 제거
            },
            success: function(data) {
                alert("취소요청처리 되었습니다.");
                goList();
            }
        });


    }
    function modLink(order_id,link_charge,orderState,link_id,alloc_type){
        $("#fOutreqModal")[0].reset();
        $("#afterLinkCharge").empty();

        $("#afterLinkCharge").append(Util.formatNumber(link_charge));
        $("#orderId").val(order_id);
        $("#orderState").val(orderState);
        $("#link_id").val(link_id);
        if(alloc_type =="N"){
            $("#alloc_charge_YN").val("N");
        }else{
            $("#alloc_charge_YN").val("Y");
        }



        outreqModal.data("kendoDialog").open();
        $('#linkCharge').focus();
    }

    outreqModal = $("#outreqModal");
    outreqModal.kendoDialog({
        width: "400px",
        height: "220px",
        visible: false,
        title: "금액수정",
        closable: true,
        modal: true,
        close: function() {
            $("#fOutreqModal")[0].reset();
        }
    });

    function outreqModalSubmit() {

        if($("#linkCharge").val() ==""){
            alert("금액을 입력해 주세요.");
            return;
        }

        $("#linkCharge").val($("#linkCharge").val().replace(/,/g, ""));

        $.ajax({
            url: "/contents/order/modLink.do",
            type: "POST",
            dataType: "json",
            data : $("#fOutreqModal").serializeObject(),
            beforeSend: function () {
                FunLoadingBarStart();      	//로딩바 생성
            }
            , complete: function () {
                FunLoadingBarEnd();			//로딩바 제거
            },
            success: function(data) {
                alert("전송요청처리 되었습니다");
                outreqModalClose();
                goList();
            }
        });
      //  goList();
    }

    function outreqModalClose() {
        outreqModal.data("kendoDialog").close();
        $("#fOutreqModal")[0].reset();
    }

    function statMsg(link_stat, job_stat) {
        var msg = "";
        if(job_stat=="W"){
            if(link_stat=="I"){
                msg ="(등록중)";
            }else if(link_stat=="D"){
                msg ="(취소중)";
            }else if(link_stat=="U"){
                msg ="(수정중)";
            }else{
                msg ="";
            }
        }else if(job_stat=="E"){
            if(link_stat=="I"){
                msg ="(등록실패)";
            }else if(link_stat=="D"){
                msg ="(취소실패)";
            }else if(link_stat=="U"){
                msg ="(수정실패)";
            }else{
                msg ="";
            }
        }else if(job_stat=="F"){
            if(link_stat=="D"){
                msg ="(취소완료)";
            }else{
                msg ="";
            }
        }else if(job_stat=="C"){
            if(link_stat=="U"){
                msg ="(수정중)";
            }else{
                msg ="";
            }
        }else if(job_stat=="R"){
                msg ="(화망처리중)";
        }else{
                msg ="";
        }
        return msg;
    }

    function getMsg(linkMsg) {
        //$("#fOutreqModalAlert")[0].reset();

        $("#alertMsg").empty();
        //var msg = a;
        if(linkMsg =="성공"|| linkMsg =="null" ){
            linkMsg = "정보망 전송 성공!";
        }
        $("#alertMsg").append(linkMsg);

        outreqModalAlert.data("kendoDialog").open();

    }
    outreqModalAlert = $("#outreqModalAlert");
    outreqModalAlert.kendoDialog({
        width: "400px",
        height: "210px",
        visible: false,
        title: "알림",
        closable: true,
        modal: true,
        close: function() {
            $("#fOutreqModalAlert")[0].reset();
        }
    });

    function outreqModalAlertClose() {
        outreqModalAlert.data("kendoDialog").close();
        $("#fOutreqModalAlert")[0].reset();
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

    function FunLoadingBarStart() {
        var backHeight = $(document).height();               	//뒷 배경의 상하 폭
        var backWidth = window.document.body.clientWidth;		//뒷 배경의 좌우 폭

        var backGroundCover = "<div id='back'></div>";			//뒷 배경을 감쌀 커버
        var loadingBarImage = '';								//가운데 띄워 줄 이미지

        loadingBarImage += "<div id='loadingBar'>";
        loadingBarImage += "<img src='/images/ajax-loader.gif'/>"; //로딩 바 이미지
        loadingBarImage += "</div>";

        $('body').append(backGroundCover).append(loadingBarImage);

        $('#back').css({ 'width': backWidth, 'height': backHeight, 'opacity': '0.3' });
        $('#back').show();
        $('#loadingBar').show();
    }

    function FunLoadingBarEnd() {
        $('#back, #loadingBar').hide();
        $('#back, #loadingBar').remove();
    }
</script>