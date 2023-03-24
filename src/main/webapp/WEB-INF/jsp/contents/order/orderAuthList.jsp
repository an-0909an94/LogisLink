<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<style>
  .cancel {color:#e54524 !important;}
  /*.accept {color:#0065bd !important;}*/
  .myOrder {background: #fdf3cf}
  .isMemo {background: #f08080}

  #grid .k-grid-content {max-height:100vh;}
  .width6_5 { width: 6.5%; align-self: center;}

  .k-i-filter::before {
    content: "";
    background-image: url(/img/fillterIcon2.png);
    background-size: cover;
    position: relative;
    width: 20px !important;
    height: 20px !important;
    display: block;
    background-position: center;
    top: 2px;
  }
  .k-icon::before {
    vertical-align: baseline;
  }
  .k-grid-header .k-grid-filter:hover, .k-grid-header .k-header-column-menu:hover, .k-grid-header .k-hierarchy-cell .k-icon:hover {
    color: #656565;
    background-color:transparent;
  }
  .k-i-close::before {
    content: '';
    width: 18px;
    height: 18px;
    background-image: url(/img/close.png);
    display: block;
    background-size: cover;
  }
  .k-button {
    background-color: #f5f5f5;
    /*margin: 0;*/
    /*padding: 0;*/
  }
  .k-button.k-state-hover, .k-button:hover {
    color: transparent;
    border-color: #f5f5f5;
    background-color: #f5f5f5;
    /*margin: 0;*/
    /*padding: 0;*/
  }
  .k-button, .k-button:hover {
    border: 0;
  }
  .k-button,
  .k-button:hover,
  .k-button.k-state-hover,
  .k-button.k-state-focused,
  .k-button:focus,
  .k-button:focus:not(.k-state-disabled):not([disabled]),
  .k-button:focus:active:not(.k-state-disabled):not([disabled]) {
    box-shadow: none;
  }
  /* 배차일보 */
  .k-filter-menu-container .k-input { position: relative; height: 27px; width: 96%; border-radius: 40px; padding: 0px 30px 0px 12px; margin: 8px 0;}
  .k-searchbox { position: relative;}
  .k-input-prefix{ display: none;}
  .k-searchbox { position: relative;}
  .k-input-prefix { position: relative;}
  .k-input-suffix{ position: absolute; right: 9px; top:1px;}
  .k-checkbox-label span { font-size:12px; }



</style>

<div class="header orderList">
  <div class="summary">
    <div class="hdr-tit" style ="font-weight:bold;">
      <P id="headerTitle">배차일보</P>
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
          <div class="input-group input-group-sm wd110 middle-name div-min-col-1">

            <select class="custom-select wd110" name="searchDate" id="searchDate">
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

          <div class="input-group input-group-sm col-1 middle-name div-min-col-1">

            <select class="form-control" class="custom-select col-12" id="sMixYn" name="sMixYn">
              <option value="">독차/혼적</option>
              <option value="N">독차</option>
              <option value="Y">혼적</option>
            </select>
          </div>
          <div class="input-group input-group-sm wd120 middle-name div-min-col-1">

            <select class="form-control wd120 custom-select col-12" id="sAllocState" name="sAllocState">
              <option>배차상태</option>
            </select>
          </div>
        </div>
        <div class="form-group row" style="justify-content: space-between;">
          <div class="row" style="width: 90%;">
            <div class="input-group input-group-sm col-1 middle-name div-min-col-1 wd90">

              <select class="custom-select col-12 wd90" id="searchDriver" name="searchDriver">
                <option value="carNum">차량번호</option>
                <option value="driverName">차주명</option>
              </select>
            </div>
            <div class="input-group input-group-sm middle-name div-min-col-1 wd190 media190">
              <input type="text" id="driverValue" name="driverValue" class="form-control form-control-sm searchValue" style="width: 100%">
            </div>

            <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
              <input type="text" placeholder="상차지" class="form-control form-control-sm searchValue" list="listSSido1" id="listSSido" name="listSSido"/>
              <datalist  id="listSSido1" name="listSSido1">
              </datalist>
            </div>

            <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
              <input type="text" placeholder="하차지" class="form-control form-control-sm searchValue" list="listESido1" id="listESido" name="listESido"/>
              <datalist   id="listESido1" name="listESido1">
              </datalist>
            </div>

            <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
              <select class="form-control" class="custom-select col-12" id="sCarTon" name="sCarTon">
                <option>요청톤수</option>
              </select>
            </div>

            <div class="input-group input-group-sm col-1 middle-name div-min-col-1">
              <select class="form-control" class="custom-select col-12" id="sCarType" name="sCarType">
                <option>요청차종</option>
              </select>
            </div>


            <div class="input-group input-group-sm wd100 middle-name div-min-col-1">

              <select class="custom-select wd100" id="orderStopYn" name="orderStopYn">
                <option value="">경유지 여부</option>
                <option value="Y">있음</option>
                <option value="N">없음</option>
              </select>
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
                    <label for="autoRefresh" class="label_on-off"  style="vertical-align:middle;">
                      <span class="marble"></span>
                      <span class="on">ON</span>
                      <span class="off" >OFF</span>
                    </label>
                  </div>
                </div>
                <div class="btn-row">
                  <div class="tool_group">
                    <div class="padding">
                      <%--                                            <c:if test="${mainCustId eq sessionScope.userInfo.custId }">
                                                                      <a href="#" class="k-pager-refresh k-button" onclick="openSendLinkPop();"><b class="btn-b">정보망 전송</b></a>
                                                                  </c:if>--%>
                      <!-- <a href="#" class="k-pager-refresh k-button" onclick="openTalkPop();"><b class="btn-b"><i class="k-icon k-i-email"></i>알림톡 전송</b></a> -->
                      <c:if test="${menuAuth.printYn eq 'Y'}">
                        <a href="#" class="k-pager-refresh k-button" onclick="goExcel();"><b class="btn-x">엑셀출력</b></a>
                      </c:if>
                    </div>
                  </div>
                </div>
              </div>
            </div><!-- /toolbar -->
            <div style="width: 100%">
              <!-- /그리드반응형 -->
              <div style="height:calc(100vh - 275px)" id="grid"></div>
            </div>
          </div>
        </div>
      </div>
      <!--  -->
    </div>
    <!-- group-list -->
  </div>

</div>


<!-- 화주변경 Modal End -->
<script type="text/javascript">
  var viewLocation = null;

  // 22.07.15 이건욱 그리드 개인화 설정 -> 접속 사용자 아이디 세션 get
  var userId = '${sessionScope.userInfo.userId}';

/*
  $("#gridContextMenu").kendoContextMenu({
    target: "#grid",
    filter: "tr[role='row']"
  });
*/

/*  var contextMenu = $("#gridContextMenu").data("kendoContextMenu");
  contextMenu.bind("select", onContextMenuSelect);*/

  var headerTitle = ($("#headerTitle").text());

  var refresh_timer;
  var autoRefresh;
  $(document).ready(function(){

    $(window).bind("resize", function() {
      //그리드반응형 $("#grid").css("height", "calc(100vh - 235px)");
      $("#grid").css("height", "calc(100vh - 275px)");

      $("#grid").data("kendoGrid").resize();
    });

    Util.setCmmCode("datalist", "listSSido1", "SIDO", "", "--상차지--");
    Util.setCmmCode("datalist", "listESido1", "SIDO", "", "--하차지--");
    Util.setCmmCode("select", "sAllocState", "ALLOC_STATE_CD", "", "배차상태");
    Util.setCmmCode("select", "sCarTon", "CAR_TON_CD", "", "요청톤수");
    Util.setCmmCode("select", "sCarType", "CAR_TYPE_CD", "", "요청차종");
    //Util.getComCode("CAR_TYPE_CD");

   // $("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
   // $("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});


/*
     $('#fromDate').kendoDatePicker({
        format: 'yyyy-MM-dd'
      });
*/

      $('#toDate').kendoDatePicker({
        format: 'yyyy-MM-dd',
       // change: onEdDeChange,
      });
      $("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});

      const endDate =  new Date($("#fromDate").val());
      endDate.setDate(endDate.getDate()+3)


      $('#toDate').kendoDatePicker('min', $("#fromDate").val());
      $('#toDate').kendoDatePicker('max', endDate);
      $('#toDate').kendoDatePicker('value',  $("#fromDate").val());

      $("#fromDate").on("change", function(){
        const endDate =  new Date($("#fromDate").val());
        endDate.setDate(endDate.getDate()+3)

        $('#toDate').kendoDatePicker('min', $("#fromDate").val());
        $('#toDate').kendoDatePicker('max', endDate);
        $('#toDate').kendoDatePicker('value',  endDate);
      });

    //Util.setSearchDateForm();

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
    { field: "sellCustName", title: "거래처명", width: 150
      ,filterable: { multi: true, search: true}  // 추가시 멀티 select 필터 추가
    },
    { field: "sComName", title: "상차지명", width: 150
      ,filterable: { multi: true}
    },
    { field: "sSido", title: "상차지주소(시도)", width: 150 },
    { field: "sGungu", title: "상차지주소(군구)", width: 150 },
    { field: "sAddr", title: "상차지주소", width: 150 },
    { field: "sTel", title: "상차지연락처", width: 120,
      template: function(dataItem) {
        return Util.formatPhone(dataItem.sTel);
      }
    },
    { field: "eComName", title: "하차지명", width: 150 },
    { field: "eSido", title: "하차지주소(시도)", width: 150 },
    { field: "eGungu", title: "하차지주소(군구)", width: 150 },
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

    { field: "deptName", title: "담당부서", width: 160 },
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

    $("#grid").text("");
    $("#grid").kendoGrid({
      dataSource : {
        transport : {
          read : {
            url : "/contents/order/data/orderAuthList.do",
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
          }
/*          total : function(response) {
            return response.total;
          }*/
        },
       // pageSize : 50,
        serverPaging : false,
        serverFiltering : false,
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
     // sortable : true,
      sortable : {
        mode: 'multiple'
      },
      pageable : false,
      resizable: true,
      scrollable: true,
      filterable: true,
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

    var grid = $("#grid").data("kendoGrid");

    grid.bind("dataBound", grid_dataBound);
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


  //excel download
  function goExcel(){
    $("#loading").show();
    var grid = $("#grid").data("kendoGrid");
    grid.saveAsExcel();
  }



  function openTalkPop() {
    var selectedItem = chkSelectedOrder();

    if(selectedItem.isSelected){

    }
  }

  function searchReset(){
    $("#fSearch")[0].reset();
    $("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});


    const endDate =  new Date($("#fromDate").val());
    endDate.setDate(endDate.getDate()+3)

    $('#toDate').kendoDatePicker('min', $("#fromDate").val());
    $('#toDate').kendoDatePicker('max', endDate);
    $('#toDate').kendoDatePicker('value',  $("#fromDate").val());
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

</script>