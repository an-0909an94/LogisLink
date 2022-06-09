<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="pop-layer">
    <div class="editor_wrap pop-layer" id="layer1">
        <!-- wrap -->
        <div class="k-tabstrip-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel" aria-expanded="true" style="display: block;">
                    <div class="editor">
                        <fieldset>
                            <legend style="text-align: center;">추천차주</legend>
                           	<div class="form-group row">
	                            <div class="input-group input-group-sm col middle-name">
								<strong>상차지 시도</strong>
								    <input type="text" id="sSido" name="sSido" class="form-control form-control-sm" readonly>
								</div>
	                            <div class="input-group input-group-sm col middle-name">
								<strong>상차지 군구</strong>
								    <input type="text" id="sGungu" name="sGungu" class="form-control form-control-sm">
								</div>
	                            <div class="input-group input-group-sm col middle-name">
								<strong>하차지 시도</strong>
								    <input type="text" id="eSido" name="eSido" class="form-control form-control-sm" readonly>
								</div>
	                            <div class="input-group input-group-sm col middle-name">
								<strong>하차지 군구</strong>
								    <input type="text" id="eGungu" name="eGungu" class="form-control form-control-sm">
								</div>
								<div class="input-group input-group-sm col-1 middle-name div-min-col-1" style="max-width:90px;min-width:90px;">
								<strong>　</strong>
								    <button onclick="goList()" type="button" style="border-radius:4px" class="form-control form-control-sm middle-button-dark"><i class="k-icon k-i-search"></i>검색</button>
								</div>
							</div>
                            <div id="driverProposalGrid" style="min-width: 100%; height: 265px;"></div>
	                        <div class="editor_btns" style="text-align:right;">
	                        	<div class="padding">
							        <a onclick="viewLocationClose();" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
						        </div>
						    </div>
                        </fieldset>
                    </div>
                    <!-- editor -->
                </div>
            </div><!-- content -->
        </div>
    </div><!-- wrap -->
</div>
<script type="text/javascript">
var deptId;
var sSido, eSido;
var carTonCode, carTypeCode;
var mixYn;
$(document).ready(function(){
	deptId = $("#deptId", parent.document).val();
	sSido = $("#sSido", parent.document).val();
	eSido = $("#eSido", parent.document).val();
	carTonCode = $("#carTonCode", parent.document).val();
	carTypeCode = $("#carTypeCode", parent.document).val();
	mixYn = $("#mixYn", parent.document).val();
	
	$("#sSido").val(sSido);
	$("#eSido").val(eSido);
 	goList();
})

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "carNum", title: "차량번호", width: 120 },
	{ field: "driverName", title: "차주명", width: 120 },
	{ field: "carMngCode", title: "차주등급", width: 100,
		template: "#if(carMngCode == '02') {# 블랙리스트 #} else {# 정상 #} #"
	},
	{ field: "carMngMemo", title: "차주등급사유", width: 130 },
	{ field: "carTonName", title: "차량톤수", width: 120 },
	{ field: "driverAllocCount", title: "최근배차건수", width: 150,
		template: "#:Util.formatNumber(mCount) # / #: Util.formatNumber(halfCount) # / #: Util.formatNumber(yearCount) # "	
	},
	{ field: "dangerGoodsYn", title: "위험물운송여부", width: 125,
		template: "#if(dangerGoodsYn == 'Y') {# 가능 #} else {# 불가 #} #"
	},
	{ field: "chemicalsYn", title: "화학물운송여부", width: 125,
		template: "#if(chemicalsYn == 'Y') {# 가능 #} else {# 불가 #} #"
	},
	{ field: "foreignLicenseYn", title: "보세면허여부", width: 125,
		template: "#if(foreignLicenseYn == 'Y') {# 있음 #} else {# 없음 #} #"
	},
	{ field: "forkliftYn", title: "지게차면허여부", width: 125,
		template: "#if(forkliftYn == 'Y') {# 있음 #} else {# 없음 #} #"
	},
	{ field: "cargoBox", title: "적재함길이", width: 100 },
];

var oGrid = null;
oGrid = new gridData("driverProposalGrid");
oGrid.initGrid();
oGrid.setEditable(false);
oGrid.setSortable(false);
oGrid.setPageable(true);
oGrid.setSelectable(true);
oGrid.setSendUrl("/contents/order/data/driverOrderHistory.do");

function goList() {
	var grid = $("#driverProposalGrid").data("kendoGrid");
	
	var param = {
			deptId : deptId,
			carTypeCode : carTypeCode,
			carTonCode : carTonCode,
			sSido : sSido,
			sGungu : $("#sGungu").val(), // 검색조건
			eSido : eSido,
			eGungu : $("#eGungu").val(), // 검색조건
			mixYn : mixYn //혼적체크일때만 혼적선호 차량 보여줌
	};
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#driverProposalGrid").data("kendoGrid");
		//grid.bind("change", onChange);
		grid.tbody.delegate('tr', 'dblclick', function(){
			var dataItem = grid.dataItem($(this));
			window.parent.buyCarNum.value(dataItem.carNum);
			$("#buyVehicId", parent.document).val(dataItem.vehicId);
			$("#buyDriverId", parent.document).val(dataItem.driverId);
			$("#carSctnCode", parent.document).val(dataItem.carSctnCode);
			$("#buyDriverName", parent.document).val(dataItem.driverName);
			$("#buyDriverTel", parent.document).val(Util.formatPhone(dataItem.driverTel));
			$("#buyCarTypeCode", parent.document).val(dataItem.carTypeCode);
			$("#buyCarTonCode", parent.document).val(dataItem.carTonCode);
			$("#buyCargoBox", parent.document).val(dataItem.cargoBox);
			$("#carMngCode", parent.document).val(dataItem.carMngCode);
			$("#carMngMemo", parent.document).val(dataItem.carMngMemo);
			viewLocationClose();
			window.parent.driverCodeChk();
		});	
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}

function viewLocationClose(){
	window.parent.$("#driverProposalView").data("kendoWindow").close();
}
</script>