<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" type="text/css" href="/css/style_V2.css">


<div id="priceView" class="editor-warp p-0">
	<div class="modalEditor" id="addCust">
		<div style="padding-left: 30px; padding-right: 30px; text-align: left; overflow: hidden;">
			<div>최저가 : <span id="minFare"></span>원</div>
			<div>최고가 : <span id="maxFare"></span>원</div>
			<div>평균가 : <span id="avgFare"></span>원</div>
		</div>
	</div>
</div>

<div class="pop-window">
    <div class="editor_wrap pop-window" id="layer">
        <!-- wrap -->
        <div class="k-pop-window">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
                    <div class="editor" style="display: flex;flex-direction: column;align-items: center;">
                        <form id="fLink" name="fLink" method="post">
                        	<input type="hidden" id="orderId" name="orderId" value="${param.orderId}">
                        	<input type="hidden" id="allocId" name="allocId" value="${fn:replace(param.allocId, 'null', '')}">
                        	<input type="hidden" id="allocState" name="allocState" value="${param.allocState}">
                        	<input type="hidden" id="sSido" name="sSido" value="${param.sSido}">
                        	<input type="hidden" id="sGungu" name="sGungu" value="${param.sGungu}">
                        	<input type="hidden" id="eSido" name="eSido" value="${param.eSido}">
                        	<input type="hidden" id="eGungu" name="eGungu" value="${param.eGungu}">
                        	<input type="hidden" id="carTonCode" name="carTonCode" value="${param.carTonCode}">
                        	<input type="hidden" id="linkTypes" name="linkTypes">
                            <fieldset>
                                <div class="form-group row">
                                    <div class="input-group input-group-sm col middle-name">
                                    	<strong>정보망 선택</strong>
                                        <select class="" multiple="multiple" id="linkType" name="linkType">
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row" style="display:flex; align-items:center;">
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong style="float: left;padding-right: 5px;">운임</strong>
                                    	<a id="priceDetail" class="k-pager-refresh k-button" style="margin-top: -5px;height: 19px;width: 19px;background: #0a8dff;font-weight: bold;color: #fff;border: 1px solid #0a8dff;border-radius: 100%;">　?　</a>
                                        <input type="text" id="fare" name="fare" class="form-control form-control-sm" value="${allocCharge}">
                                    </div>
                                    <%--<div class="input-group input-group-sm col middle-name">
                                    <strong>수수료</strong>
                                        <input type="text" id="fee" name="fee" class="form-control form-control-sm">
                                    </div> --%>
                                    <div class="input-group input-group-sm col middle-name" >
                                    <strong>결제방법</strong>
                                        <select class="form-control form-control-sm" id="chargeTypeCode" name="chargeTypeCode">
                                        </select>
                                    </div>
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong>결제일</strong>
                                        <input style="padding: 0;" type="text" id="payPlanMd" name="payPlanMd">
                                    </div>
                                    <div class="input-group input-group-sm col middle-name">
                                    	<div>&nbsp;</div>
								        <a onclick="sendLink()" class="btn_b k-button btn-s form-control-sm"><b style="display: flex;flex-direction: row;letter-spacing: -0.45px;color: #fff;padding: 0px;">
                                            <strong id="btn_add">정보망 오더 전송</strong></b></a>
                                    </div>
                                    <div class="input-group input-group-sm col middle-name">
                                    	<div>&nbsp;</div>
								        <a onclick="settleLink()" class="btn_b k-button btn-s"><b style="display: flex;flex-direction: row;letter-spacing: -0.45px;color: #fff;padding: 0px;">
                                            <strong id="btn_add">정보망 오더 확정</strong></b></a>
                                    </div>
                                </div>
                                <div class="form-group row pb30" >
                                    <div class="input-group input-group-sm col middle-name">
                                    <strong>화물정보</strong>
                                    	<input type="text" id="cargoDsc" name="cargoDsc" class="form-control form-control-sm" value="${param.goodsName}"> 
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                       	<div id="gridPop" style="min-width:758px;" ></div>
                    </div>
                    <!-- editor -->
                </div>
            </div><!-- content -->
        </div>
    </div><!-- wrap -->
</div>
<script type="text/javascript">
priceModal = $("#priceView");
priceDetail = $("#priceDetail");

priceModal.kendoDialog({
	width: "200px",
	height: "150px",
	visible: false,
	closable: true,
	title: "운임비용",
	modal: false,
	close: function(){priceModal.fadeIn();}
});

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

var delList = [];
var columns = [
 	{field: "number", title: "No"},
 	{ field: "linkTypeName", title: "정보망"},
	{ field: "fare", title: "운임",
		template: function(dataItem) {
			return Util.formatNumber(dataItem.fare);
		}
	},
/* 	{ field: "fee", title: "수수료",
		template: function(dataItem) {
			return Util.formatNumber(dataItem.fee);
		}
	}, */
	{ field: "payPlanMd", title: "결제일"},
	{ field: "cargoDsc", title: "화물정보", hidden: true},
	{ field: "chargeTypeCode", title: "결제방법", hidden: true},
	{ field: "ordStatusName", title: "오더상태"},
	{ field: "linkStatusName", title: "전송상태"},
	{ field: "regDate", title: "전송일"},
	{ field: "regId", title: "등록 ID"},
	{ template: "#if(ordStatusName == '취소') {# <a class=\"k-button\" href=\"javascript:cancelOrderAlloc('#:linkType#', '#:orderId#', '#:allocId#', '#:seq#', 'REOPENORDER')\">재접수</a> #} else {# <a class=\"k-button\" href=\"javascript:cancelOrderAlloc('#:linkType#', '#:orderId#', '#:allocId#', '#:seq#', 'CANCELORDER')\"> 오더취소 </a>#} #", title:"오더취소"},
	{ template: "#if(ordStatusName == '배차') {# <a class=\"k-button\" href=\"javascript:cancelOrderAlloc('#:linkType#', '#:orderId#', '#:allocId#', '#:seq#', 'CANCELALLOC')\">배차취소</a> #} else {#  #} #", title:"배차취소"}
];

 var pEComName;
  
$(document).ready(function(){
	//$("#divChargeTypeCode").hide();
	Util.setCmmCode("select", "linkType", "LINK_CD", "", "선택하세요");
	Util.setCmmCode("select", "chargeTypeCode", "CHARGE_TYPE_CD", "", "선택하세요");
	$("#chargeTypeCode option[value!='01']").remove();
	
	var optional = $("#linkType").kendoMultiSelect({
        autoClose: false
    }).data("kendoMultiSelect");
	
	optional.bind("change", onChange);
	
	$("#payPlanMd").kendoDatePicker({format:"yyyy-MM-dd", value : "${param.eDateDay}", dateInput: true, min : "${param.eDateDay}"});
	
	goList();
});

var oGrid = null;
oGrid = new gridData("gridPop");
oGrid.initGrid();
oGrid.setSendUrl("/contents/order/data/linkList.do");
oGrid.setPageable(true);
oGrid.setSelectable(true);
oGrid.setSortable(true);

function goList() {
	var grid = $("#gridPop").data("kendoGrid");
	$("#fare").val(Util.formatNumberInput($("#fare").val()))
	//$("#fee").val(Util.formatNumberInput($("#fee").val()))
	
	oGrid.setSearchData({orderId : $("#orderId").val()});
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#gridPop").data("kendoGrid");
		//grid.bind("change", onChange);
		grid.tbody.delegate('tr', 'dblclick', function(){
			var dataItem = grid.dataItem($(this));
			gridDataSet(dataItem);
		});	
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}

function onChange(e) {
	var linkTypes = $("#linkType").data("kendoMultiSelect").value();
	var isMan = false;
	
	for(var i = 0; i < linkTypes.length; i++) {
		if(linkTypes[i] == '21') isMan = true;
	}
	
/* 	if(isMan) $("#divChargeTypeCode").show();
	else {
		$("#divChargeTypeCode").hide();
		$("#chargeTypeCode").val("");
	} */
}	

function sendLink(){
	var exptext = /[0-9].*(?=T)/g;
	var tonCode = $("#carTonCode").val();
	var weight;
	if(exptext.test(tonCode) == false) {
		weight = Util.checkOverload(tonCode, 0);
	}else{
		weight = Util.checkOverload(tonCode.replace(/[T]/g, "."), 0);
	}
	if(isNaN(weight)==false){
		if(weight < "${param.goodsWeight}"){//오더 중량 보다 크면 과적체크해야함
			alert("과적입니다. 화물 중량을 확인해주세요.");
			return 
		}
	}
	var command = "ADDORDER";
	var linkTypes = $("#linkType").data("kendoMultiSelect").value();
	$("#fare").val($("#fare").val().replace(/,/g, ""));
	$("#linkTypes").val(linkTypes);
	/* $("#fee").val($("#fee").val().replace(/,/g, ""));
	if($("#fee").val() == ""){
		$("#fee").val("0");
	} */ 
	
	if($("#cargoDsc").val() == "") {
		alert("화물정보를 입력해주세요.");
		return;
	}
	
	if($("#chargeTypeCode").val() == "") {
		alert("결제방법을 선택해주세요.");
		return;
	}
	
	$.ajax({
		url: "/contents/order/data/linkWrite.do",
		type: "POST",
		dataType: "json",
		data: $("#fLink").serialize() + "&command=" + command,		
		success: function(data){
			if(data.result) {
				alert(data.msg);
				//init_popup_close();
				goList();
				parent.goList();
				if($("#allocId").val() == ''){
					$("#allocId").val(data.oAllocId);
				}
			}else{
				alert(data.msg);
			}
		}
	})
}

function settleLink(){
	if(!confirm('정보망 오더 확정을 하시겠습니까?')){ 
		return false;
	}
	$.ajax({
		url: "/contents/order/data/linkSettle.do",
		type: "POST",
		dataType: "json",
		data: {
			orderId: $("#orderId").val(),
			allocId: $("#allocId").val()
		},		
		success: function(data){
			if(data.result) {
				alert(data.msg);
				parent.goList();
			} else {
				alert(data.msg);
			}
		}
	});
}

function cancelOrderAlloc(linkType, orderId, allocId, seq, command) {
	if(linkType == '21' && command == 'REOPENORDER'){
		if(!confirm('화물정보가 수정되었을 경우 정보망 재전송 후 \n\"정보망 오더 전송\"을 눌러주세요.')){
			return
		}
	}
	$.ajax({
		url: "/contents/order/data/linkWrite.do",
		type: "POST",
		dataType: "json",
		data: {
			linkTypes: linkType,
			seq: seq,
			orderId: orderId,
			allocId: allocId,
			command: command
		},		
		success: function(data){
			if(data.result) {
				alert(data.msg);
				//init_popup_close();
				goList();
				parent.goList();
			} else {
				alert(data.msg);
			}
		}
	})
}

function gridDataSet(data){
	Util.setPageData(data);
	$("#fare").val(Util.formatNumberInput($("#fare").val()))
	//$("#fee").val(Util.formatNumberInput($("#fee").val()))
	$("#linkType").val(data.linkType);
	var multiselect = $("#linkType").data("kendoMultiSelect");
	multiselect.value(data.linkType);
}

$("#fare").on("input", function(){
	$(this).val(Util.formatNumberInput($(this).val()));
});
</script>
