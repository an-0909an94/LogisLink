<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#car_list .k-grid-content {max-height:calc(100vh - 471px)}
</style>
<div class="insert_pop">
	<jsp:include page="./view/carInsert.jsp" />
</div>
<div class="header">
	
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">차량관리</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<form id="fSearch" class="date-bnt" onSubmit="return false;">
			<div class="form-group row">
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="form-control" class="custom-select col-12" id="s_dept" name="s_dept">
				    	<option>--부서명--</option>
				    </select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="searchColumn" name="searchColumn">
						<option value="A.CAR_NUM">--차량번호--</option>
						<option value="B.DRIVER_NAME">--이름--</option>
						<option value="B.MOBILE">--연락처--</option>
						<option value="A.BIZ_NUM">--사업자번호--</option>
						<option value="A.BIZ_NAME">--사업자상호--</option>
				    </select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name">
				<strong>　</strong>
				    <input type="text" id="searchValue" name="searchValue" class="form-control form-control-sm searchValue">
				</div>	
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="dangerGoodsUseYn" name="dangerGoodsUseYn">
						<option value="" selected>--위험물 운송 가능 여부--</option>
		                <option value="Y">가능</option>
		                <option value="N">불가</option>
				    </select>
				</div>	
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="chemicalsUseYn" name="chemicalsUseYn">
						<option value="" selected>--유해 화학물질 운송 가능 여부--</option>
		                <option value="Y">가능</option>
		                <option value="N">불가</option>
				    </select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="foreignLicenseUseYn" name="foreignLicenseUseYn">
						<option value="">--보세면허 여부--</option>
		                <option value="Y">있음</option>
		                <option value="N">없음</option>
				    </select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="forkliftUseYn" name="forkliftUseYn">
						<option value="" selected>--지게차 면허 여부--</option>
		                <option value="Y">있음</option>
		                <option value="N">없음</option>
				    </select>
				</div>		
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="form-control" class="custom-select col-12" id="s_carMngCode" name="s_carMngCode"></select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="form-control" class="custom-select col-12" id="s_useYn" name="s_useYn">
						<option value="" selected>--사용여부--</option>
						<option value="Y">정상</option>
						<option value="N">해지</option>
				    </select>
				</div>
			</div>
			<div class="form-group row">
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="s_carSctnCode" name="s_carSctnCode"> </select>
				</div>				
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="s_carTypeCode" name="s_carTypeCode"> </select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="s_carTonCode" name="s_carTonCode"> </select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="s_payType" name="s_payType">
						<option value="">--빠른지급 대상 여부--</option>
		                <option value="Y">Y</option>
		                <option value="N">N</option>
				    </select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="s_taxjoinYn" name="s_taxjoinYn">
						<option value="">--스마트빌 회원가입--</option>
		                <option value="Y">Y</option>
		                <option value="N">N</option>
				    </select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="s_emailYn" name="s_emailYn">
						<option value="">--이메일 유무--</option>
		                <option value="Y">Y</option>
		                <option value="N">N</option>
				    </select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1">
				<strong>&nbsp;</strong>
				    <select class="custom-select col-12" id="s_accountYn" name="s_accountYn">
						<option value="">--계좌정보 유무--</option>
		                <option value="Y">Y</option>
		                <option value="N">N</option>
				    </select>
				</div>
				<div class="input-group input-group-sm col-1 middle-name div-min-col-1" style="max-width:90px;min-width:90px;">
				<strong>　</strong>
				    <button onclick="goList()" type="button" style="border-radius:4px" class="form-control form-control-sm middle-button-dark"><i class="k-icon k-i-search"></i>검색</button>
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
											<a href="#" class="k-pager-refresh k-button" onClick="goExcel();"><b class="btn-x"><i class="k-icon k-i-file-excel"></i>엑셀출력</b></a>
											</c:if>
											<c:if test="${menuAuth.writeYn eq 'Y'}">
											<a href="#" class="k-pager-refresh k-button" onclick="form_popup('N', {})"><b class="btn-h"><i class="k-icon k-i-plus"></i>신규등록</b></a>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->

						<div style="min-width: 500px;">
							<div style="height:calc(100vh - 409px)" id="car_list"></div>

							<ul id="CarListContextMenu">
								<li id="cSave" class="privateRClick">리스트 현재설정 저장</li>
								<li class="k-separator privateRClick"></li>
								<li id="dSave" class="privateRClick">리스트 세부설정 변경</li>
							</ul>
							<!-- /table -->
						</div>
						<!--
						<div style="height:calc(100vh - 409px)" id="car_list"></div>
						-->
						<!-- /table -->
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

var userId='${sessionScope.userInfo.userId}';


$("#CarListContextMenu").kendoContextMenu({
	target: "#car_list",
	filter: "tr[role='row']"
});

var contextMenu = $("#CarListContextMenu").data("kendoContextMenu");
contextMenu.bind("select", onContextMenuSelect);

$(document).ready(function(){ 	
	$("#mobile, #telNum, #cid").val(Util.formatPhone($("#mobile, #telNum, #cid").val()));

	Util.setCmmCode("select", "s_carMngCode", "CAR_MNG_CD", "", "--차량등급--");
	Util.setCmmCode("select", "s_carSctnCode", "CARGO_TRAN_CAR_SCTN_CD", "", "--차량구분--");
	Util.setCmmCode("select", "s_carTypeCode", "CAR_TYPE_CD", "", "--차종--");
	Util.setCmmCode("select", "s_carTonCode", "CAR_TON_CD", "", "--톤수--");
	Util.setSelectBox("/contents/basic/data/compDeptList.do", "s_dept", {custId:'${custId}', deptId:'${sessionScope.userInfo.deptId}', useYn: 'Y'}, "deptId", "deptName", "${sessionScope.userInfo.deptId}", "--부서명--");

 	goList();
});

var columns = [
	{ field: "rNum", title: "No", width: 50 },
	{ field: "deptName", title: "담당부서", width:100},
	{ field: "carNum", title: "차량번호", width: 120 },
	{ field: "driverName", title: "차주명", width: 120 },
	{ field: "mobile", title: "휴대전화", width: 120,
		template: function(dataItem) {
			return Util.formatPhone(dataItem.mobile);
		}
	},
	{ field: "telNum", title: "전화번호", width: 120,
		template: function(dataItem) {
			return Util.formatPhone(dataItem.telNum);
		}
	},
	{ field: "cid", title: "CID", width: 120,
		template: function(dataItem) {
			return Util.formatPhone(dataItem.cid);
		}
	},
	{ field: "carTypeName", title: "차종", width: 100 },
	{ field: "carTonName", title: "톤수", width: 100 },
	{ field: "cargoBox", title: "적재함길이", width: 100 },
	{ field: "driverEmail", title: "이메일", width: 120 },
	{ field: "taxjoinDate", title: "스마트빌가입", width: 120 },
	{ field: "payType", title: "빠른지급대상여부", width: 120 },
	{ field: "carSctnName", title: "차량구분", width: 100 },
	{ field: "bizName", title: "사업자상호", width: 100 },
	{ field: "bizNum", title: "사업자번호", width: 110,
		template: function(dataItem) {
			return Util.formatBizNum(dataItem.bizNum);
		}
	},
	{ field: "subBizNum", title: "종사업장번호", width: 110 },
	{ field: "ceo", title: "대표자", width: 100 },
	{ field: "bizCond", title: "업태", width: 100 },
	{ field: "bizKind", title: "업종", width: 100 },
	{ field: "bizPost", title: "우편번호", width: 100 },
	{ field: "bizAddr", title: "주소", width: 300 },
	{ field: "bizAddrDetail", title: "상세주소", width: 200 },
	{ field: "useYn", title: "사용여부", width: 200 },
 	{ field: "pushYn", title: "push수신", width: 100 },
	{ field: "talkYn", title: "알림톡수신", width: 100 },
	{ field: "dangerGoodsYn", title: "위험물 운송 여부", width: 150,
		template: "#if(dangerGoodsYn == 'Y') {# 가능 #} else {# 불가 #} #"
	},
	{ field: "chemicalsYn", title: "유해 화학물질 운송 여부", width: 170,
		template: "#if(chemicalsYn == 'Y') {# 가능 #} else {# 불가 #} #"
	},
	{ field: "foreignLicenseYn", title: "보세면허 여부", width: 130,
		template: "#if(foreignLicenseYn == 'Y') {# 있음 #} else {# 없음 #} #"
	},
	{ field: "forkliftYn", title: "지게차면허 여부", width: 140,
		template: "#if(forkliftYn == 'Y') {# 있음 #} else {# 없음 #} #"
	},
	{ field: "carMngName", title: "차량등급", width: 140},
	{ field: "bankName", title: "은행명", width: 130 },
	{ field: "bankCnnm", title: "예금주", width: 100 },
	{ field: "bankAccount", title: "계좌번호", width: 150 },
	{ field: "bankChkDate", title: "계좌확인일시", width: 160 },
	{ field: "regdate", title: "등록일자", width: 170 },
	{ field: "userId", title: "담당직원", width: 130 },
	{ field: "memo", title: "메모", width: 157 },
	{ field: "custId", hidden:true },
	{ field: "deptId", hidden:true },
	{ field: "custVehicSeq", hidden:true},
	{ field: "carMngCode", hidden:true},
];

var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("car_list");
oGrid.initGrid();
oGrid.setSendUrl("/contents/basic/data/carList.do");
oGrid.setPageable(true);
oGrid.setSelectable(true);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

function goList() {
	var grid = $("#car_list").data("kendoGrid");

	var param = {};
	param["select"] = $("#searchColumn").val();
	param["value"] = $("#searchValue").val();
	param["authSeq"] = $("#s_authSeq").val();
	param["useYn"] = $("#s_useYn").val();
	param["deptId"] = $("#s_dept").val();
	param["dangerGoodsUseYn"] = $("#dangerGoodsUseYn").val();
	param["chemicalsUseYn"] = $("#chemicalsUseYn").val();
	param["foreignLicenseUseYn"] = $("#foreignLicenseUseYn").val();
	param["forkliftUseYn"] = $("#forkliftUseYn").val();
	param["carMngCode"] = $("#s_carMngCode").val();
	param["carSctnCode"] = $("#s_carSctnCode").val();
	param["carTypeCode"] = $("#s_carTypeCode").val();
	param["carTonCode"] = $("#s_carTonCode").val();
	param["payType"] = $("#s_payType").val();
	param["taxjoinYn"] = $("#s_taxjoinYn").val();
	param["emailYn"] = $("#s_emailYn").val();
	param["accountYn"] = $("#s_accountYn").val();

	//columns = setPrivateData("A1410", "car_list", userId, columns);

	oGrid.setSearchData(param);
	if (grid == null) {
		oGrid.setGrid(columns);
		grid = $("#car_list").data("kendoGrid");
		//grid.bind("change", onChange);
		//setOptionActive("A1410", "car_list", userId);

		grid.tbody.delegate('tr', 'dblclick', function () {
			var dataItem = grid.dataItem($(this));
			form_popup("E", dataItem);
		});
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}
	/*
    function onChange(e){
        var row = this.select();
        var data = this.dataItem(row);

        form_popup("E", data);
    }
	*/

	function form_popup(mode, data) {
		Util.insertCloseButton();
		$('#group-list').addClass("block");
		$('.insert_pop').addClass("block");
		$('.insertClose').addClass("block");
		init_pop(mode, data);
	}
	function form_popup_close() {
		$('#group-list').removeClass("block");
		$('.insert_pop').removeClass("block");
		$('.insertClose').removeClass("block");
	}
	//excel download
	function goExcel(){
		$("#loading").show();
		var grid = $("#car_list").data("kendoGrid");
		grid.saveAsExcel();
	}
	function onContextMenuSelect(e) {
		var grid = $("#car_list").data("kendoGrid");
		var data = grid.dataItem(e.target);
		var row = grid.select();
		var multiSelectedData = [];
		var item = e.item.id;
		for(var i = 0; i < row.length; i++) {
			multiSelectedData.push(grid.dataItem(row[i]));
		}
		switch (item) {
			case "cSave" : // 리스트 현재설정 저장 버튼 이벤트
				setPrivateSaveData("A1410", "car_list", userId);
				break;
			case "dSave" : // 리스트 세부설정 변경 버튼 이벤트
				setPrivatePanel("A1410", "car_list", userId);
				break;
		}
	}
</script>