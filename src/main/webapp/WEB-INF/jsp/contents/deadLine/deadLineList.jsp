<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<style>

    #grid .k-grid-content {max-height:calc(100vh - 260px)}
</style>
<div class="header">
    <div style="justify-content: space-between; display: flex;" class="summary p30">
        <div class="hdr-tit" style ="padding: 5px; font-weight:bold;">
            <P id="headerTitle">마감장표</P>
        </div>
    </div>
    <div class="contents">
        <div id="group-list" class="cont-wrapper-page-grid">
            <form id="fSearch" class="date-bnt">
                <div class="form-group row mt0" style="justify-content: space-between">
                    <div class="row">
                        <div class="input-group input-group-sm wd90 middle-name div-min-col-1">
                            <select class="custom-select wd90" name="searchDate" id="searchDate">
                                <option value="sDate" selected>상차일자</option>
                                <option value="eDate">하차일자</option>
                            </select>
                        </div>
                        <div class="input-group input-group-sm wd90 middle-name">
                            <input style="padding: 0;" type="text" id="fromDate" name="fromDate"
                                   class="wd90">
                        </div>
                        <span>~</span>
                        <div class="input-group input-group-sm wd90 middle-name div-min-col-1">
                            <input style="padding: 0;" type="text" id="toDate" name="toDate"
                                   class="wd90">
                        </div>
                        <div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
                            <input type="radio" name="dateChk" id="today" value="0" checked/>
                            <label for="today" class="label-margin">
                                <span>오늘</span>
                            </label>
                        </div>
                        <div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
                            <input type="radio" name="dateChk" id="yesterday" value="1"/>
                            <label for="yesterday" class="label-margin">
                                <span>어제</span>
                            </label>
                        </div>
                        <div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
                            <input type="radio" name="dateChk" id="weekly" value="7"/>
                            <label for="weekly" class="label-margin">
                                <span>7일</span>
                            </label>
                        </div>
                        <div class="input-group input-group-sm wd90 radio-or-checkBox div-min-col-1">
                            <input type="radio" name="dateChk" id="monthly" value="30"/>
                            <label for="monthly" class="label-margin">
                                <span>30일</span>
                            </label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-group input-group-sm middle-name">
                            <button onclick="goList()" type="button" class="form-control-sm btn_58 btn_b">검색</button>
                        </div>
                        <%--
                        <c:if test="${menuAuth.printYn eq 'Y'}">
                            <div class="middle-name" style="width:65px;margin-right:10px">
                                <a href="#" style="font-size:12px"
                                   class="form-control form-control-sm middle-button"
                                   onclick="goExcel();"><b class="btn-x">엑셀출력</b></a>
                            </div>
                        </c:if>
                        --%>
                        <%--<button onclick="goExcel()"  type="button" class="form-control form-control-sm middle-button">엑셀출력</button> --%>
                        <%--<a href="#" class="k-pager-refresh k-button" onclick="goExcel();"><b class="btn-x"><i class="k-icon k-i-file-excel"></i>엑셀출력</b></a>--%>
                        <!--<div class="input-group input-group-sm wd100 middle-name div-min-col-1" style="max-width:80px;min-width:80px;">
                            <strong>　</strong>-->
                        <!--<button onclick="searchReset()"  type="button" class="form-control form-control-sm middle-button"><i class="k-icon k-i-reset-sm"></i>초기화</button>
                        </div>-->
                    </div>
                </div>

            </form>
            <!--  -->
            <div class="cont-body">
                <!-- f-wrap -->
                <div class="k-wrap content">
                    <div class="lookup_table">
                        <c:if test="${menuAuth.printYn eq 'Y'}">
                        <div class="toolbar row">
                            <div class="tool_form col">
                                <div class="btn-row">
                                    <div class="tool_group">
                                        <div class="padding">
                                            <a href="#" onclick="goExcel();" class="k-pager-refresh k-button wd100"><b class="btn-x">엑셀출력</b></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:if>
                        <%--
                        <c:if test="${menuAuth.printYn eq 'Y'}">
                            <div class="middle-name" style="width:65px;margin-right:10px">

                                <a href="#" style="font-size:12px"
                                   class="form-control form-control-sm middle-button"
                                   onclick="goExcel();"><b class="btn-x">엑셀출력</b></a>
                            </div>
                        </c:if>
                        --%>
                        <%--<button onclick="goExcel()"  type="button" class="form-control form-control-sm middle-button">엑셀출력</button> --%>
                        <%--<a href="#" class="k-pager-refresh k-button" onclick="goExcel();"><b class="btn-x"><i class="k-icon k-i-file-excel"></i>엑셀출력</b></a>--%>
                        <div style="min-width: 500px;">
                            <div style="height:calc(100vh - 260px);" id="grid"></div>
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
<script type="text/javascript">
    var userId = '${sessionScope.userInfo.userId}';
    var deptId = "${sessionScope.userInfo.deptId}";

    $("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
    $("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
    Util.setSearchDateForm();
    var headerTitle = ($("#headerTitle").text());

    $(document).ready(function() {
        // 리스트 출력
        goList();
    });


    // 그리드 리스트
    function goList() {


        // columns = setPrivateData("C3130", "grid", userId, columns);

        var grid = $("#grid").kendoGrid({
            dataSource: {
                transport: {
                    read: {
                        url: "/contents/deadLine/data/deadLineList.do",
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
                        // getSummary(response.total, response.sumPayableAmt, response.sumWithdrawalAmt);
                        return response.total;
                    },
                    model: {
                        //id: "orderId"
                    }
                },
                pageSize: 50,
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
            fileName: headerTitle+"(" + new Date().yyyymmdd() + ").xlsx",
                proxyURL: "/cmm/saveGrid.do",
                filterable: false,
                allPages: true
            },
            excelExport: function(e) {
                $("#loading").hide();
            },
            navigatable: true,
            selectable: "cell",
            persistSelection: true,
            editable: false,
            //save: onEditSave,
            columns: columns,
            noRecords: true,
            scrollable: {
                endless: true
            },
            pageable: false,
            //sort: onSortEnd,
            messages: {
                noRecords: "조회된 데이터가 없습니다."
            }
        }).data("kendoGrid");

        //  setOptionActive("C3130", "grid", userId);

/*        grid.thead.on("click", "#orderAllCheck", orderAllCheckHandler);
        grid.table.on("click", ".orderCheck", orderCheckHandler);*/
    }

    var columns = [
        {
            title: "구분",
            columns: [
                { field: "custName", title: "매출처(계산서발행처)", width: 150,
                    attributes: {
                        style: "text-align: left"
                    }
                },
                { field: "bizName", title: "거래처명(계약명)", width: 150,
                    attributes: {
                        style: "text-align: left"
                    }
                },
            ]
        },
        { field: "deptName", title: "부서명", width: 150 },
        {
            title: "마감 현황",
            columns: [
                { field: "allocCntF", title: "배차 수", width: 80,
                    template: function(dataItem) {

                        if(dataItem.allocCntF == 0){
                            return "0";
                        }else{
                            return Util.formatNumber(dataItem.allocCntF)+"";
                        }

                    }
                    ,attributes: {
                        style: "text-align: right"
                    }
                },
                { field: "sellAmtF", title: "매출", width: 100,
                    template: function(dataItem) {

                        if(dataItem.sellAmtF == 0){
                            return "0";
                        }else{
                            return Util.formatNumber(dataItem.sellAmtF)+"";
                        }

                    },
                    attributes: {
                        style: "text-align: right"
                    }
                },
                { field: "buyAmtF", title: "매입", width: 100,
                    template: function(dataItem) {

                        if(dataItem.buyAmtF == 0){
                            return "0";
                        }else{
                            return Util.formatNumber(dataItem.buyAmtF)+"";
                        }

                    },
                    attributes: {
                        style: "text-align: right"
                    }
                },
                { field: "profitAmtF", title: "한계이익", width: 100,
                    template: function(dataItem) {

                        if(dataItem.profitAmtF == 0){
                            return "0";
                        }else{
                            return Util.formatNumber(dataItem.profitAmtF)+"";
                        }

                    },
                    attributes: {
                        style: "text-align: right"
                    }
                },
                /*                { field: "invCnt", title: "계산서 수", width: 100 },*/
                { field: "depositAmt", title: "입금확인", width: 100,
                    attributes: {
                        style: "text-align: right"
                    }
                }
            ]
        },
        {
            title: "이월 현황(조회시점 기준 마감전 내역)",
            columns: [
                { field: "", title: "배차 수", width: 80 ,
                    template: function(dataItem) {
                        var allocCnt = dataItem.allocCnt;
                        var allocCntF = dataItem.allocCntF;
                        if(allocCnt ==''){
                            allocCnt = 0;
                        }
                        if(allocCntF ==''){
                            allocCntF = 0;
                        }
                        var allocCntA = allocCnt - allocCntF;
                        if(allocCntA == 0){
                            return "0";
                        }else{
                            return Util.formatNumber(allocCntA)+"";
                        }

                    },attributes: {
                        style: "text-align: right"
                    }
                },
                { field: "", title: "매출", width: 100,
                    template: function(dataItem) {
                        var sellAmt = dataItem.sellAmt;
                        var sellAmtF = dataItem.sellAmtF;
                        if(sellAmt ==''){
                            sellAmt = 0;
                        }
                        if(sellAmtF ==''){
                            sellAmtF = 0;
                        }
                        var sellAmtA = dataItem.sellAmt - sellAmtF;
                        if(sellAmtA == 0){
                            return "0";
                        }else{
                            return Util.formatNumber(sellAmtA)+"";
                        }

                    },attributes: {
                        style: "text-align: right"
                    }
                },
                { field: "", title: "매입", width: 100 ,
                    template: function(dataItem) {
                        var buyAmt = dataItem.buyAmt;
                        var buyAmtF = dataItem.buyAmtF;

                        if(buyAmt ==''){
                            buyAmt = 0;
                        }
                        if(buyAmtF ==''){
                            buyAmtF = 0;
                        }
                        var buyAmtA = buyAmt - buyAmtF;
                        if(buyAmtA == 0){
                            return "0";
                        }else{
                            return Util.formatNumber(buyAmtA)+"";
                        }

                    },attributes: {
                        style: "text-align: right"
                    }
                },
                { field: "", title: "한계이익", width: 100 ,
                    template: function(dataItem) {

                        var profitAmt = dataItem.profitAmt;
                        var profitAmtF = dataItem.profitAmtF;

                        if(dataItem.profitAmt ==''){
                            dataItem.profitAmt = 0;
                        }
                        if(dataItem.profitAmtF ==''){
                            dataItem.profitAmtF = 0;
                        }
                        var profitAmtA = profitAmt - profitAmtF;
                        if(profitAmtA == 0){
                            return "0";
                        }else{
                            return Util.formatNumber(profitAmtA)+"";
                        }

                    },attributes: {
                        style: "text-align: right"
                    }
                }
                /*                { field: "", title: "계산서 수", width: 100 },*/
                /*{ field: "", title: "입금확인", width: 100 }*/
            ]
        },
        {
            title: "소계",
            columns: [
                { field: "allocCnt", title: "배차 수", width: 80,
                    template: function(dataItem) {

                        if(dataItem.allocCnt == 0){
                            return "0";
                        }else{
                            return Util.formatNumber(dataItem.allocCnt)+"";
                        }

                    },
                    attributes: {
                        style: "text-align: right"
                    }
                },
                { field: "sellAmt", title: "매출", width: 100 ,
                    template: function(dataItem) {

                        if(dataItem.sellAmt == 0){
                            return "0";
                        }else{
                            return Util.formatNumber(dataItem.sellAmt)+"";
                        }

                    },
                    attributes: {
                        style: "text-align: right"
                    }
                },
                { field: "buyAmt", title: "매입", width: 100 ,
                    template: function(dataItem) {

                        if(dataItem.buyAmt == 0){
                            return "0";
                        }else{
                            return Util.formatNumber(dataItem.buyAmt)+"";
                        }

                    },
                    attributes: {
                        style: "text-align: right"
                    }
                },
                { field: "profitAmt", title: "한계이익", width: 100,
                    template: function(dataItem) {

                        if(dataItem.profitAmt == 0){
                            return "0";
                        }else{
                            return Util.formatNumber(dataItem.profitAmt)+"";
                        }

                    },
                    attributes: {
                        style: "text-align: right"
                    }
                }
            ]
        }
    ];

    function goExcel(){
        $("#loading").show();
        var grid = $("#grid").data("kendoGrid");
        grid.saveAsExcel();
    }
</script>