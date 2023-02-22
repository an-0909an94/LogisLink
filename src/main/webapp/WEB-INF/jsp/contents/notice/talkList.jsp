<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	#talkList .k-grid-content {max-height:calc(100vh)}
</style>
<div id="talkModal" class="editor-warp p-0">
	<div class="modalEditor" id="addTalk">
		<form id="modalForm" name="modalForm">
			<div class="form-group col">
				<div class="form-group row mb20">
					<div style="float: left; width: 49%;padding-left:35px">
						<div class="form-group mb10 gray_box">
							<div class="input-group input-group-sm wd190 middle-name ">
								<strong style="margin-left: 0em;padding-right: 1.5em;">템플릿</strong>
								<select name="templateCode" id="templateCode" style="width:100%">
									<option value="">시스템 알림톡</option>
								</select>
							</div>
						</div>
						<div class="form-group row ">
							<div class="input-group input-group-sm col middle-name">
								<textarea id="contents" name="contents"
										  style="width: 100%;font-size: 16px;font-weight: 300;border: 1px solid #E8E9EB;border-radius: 5px;"
										  rows="18"
										  class="form-control textarea"></textarea>
							</div>
						</div>
						<div class="form-group row" style="color:#0000ff;">
							※ 알림톡 내용을 임의로 변경할 경우, 알림톡 발송이 되지 않을 수 있습니다.
						</div>
					</div>
					<div style="float: right; width: 49%;padding-right:0px; padding-left:20px">
						<div class="input-group input-group-sm col mb10 gray_box">
							<strong style="margin-left: 0em; padding-right: 1.5em;">예약발송</strong>
							<input class="wd340" id="reserve" type="text" name="reserve" style="width:100%; height: 24px;">
							<input style="width: 24px; height: 24px;" type="checkbox" name="chkReserve" id="chkReserve" value="Y">
						</div>
						<div class="row gray_box">
							<div class="input-group input-group-sm wd90 radio-or-checkBox ">
								<strong style="margin-left: 0em; padding-right: 1.5em;">회원구분</strong>
								<input id="driver" type="checkbox" name="custTypeCode" value="09">
								<label for="driver" class="label-margin">
									<span>차주</span>
								</label>
							</div>
							<div class="input-group input-group-sm wd90 radio-or-checkBox ">
								<input id="owner" type="checkbox" name="custTypeCode" value="04">
								<label for="owner" class="label-margin">
									<span>화주</span>
								</label>
							</div>
							<div class="input-group input-group-sm wd90 radio-or-checkBox ">
								<input id="carrier" type="checkbox" name="custTypeCode" value="01">
								<label for="carrier" class="label-margin">
									<span>주선사/운송사</span>
								</label>
							</div>
						</div>

						<div class="input-group input-group-sm col mb10 gray_box">
							<strong style="margin-left: 0em; padding-right: 1.5em;">수신번호</strong>
							<input class="input-group input-group-sm mr10 wd240 middle-name" id="recvNum" type="text" name="recvNum" maxlength="13">
							<a style="width: 100%; height: 24px; margin-right:5px" href="javascript:addPhone();" class="k-pager-refresh k-button wd58">추가</a>
							<a style="width: 100%; height: 24px;" href="javascript:removePhone();" class="k-pager-refresh k-button wd58">삭제</a>
						</div>
						<div class="splitter" style="border: 0; width: 100%; height: 323px;">
							<div id="popGrid" style="border-radius: 5px;"></div>
						</div>
					</div>
				</div>
				<div class="padding" style="text-align: center;">
					<a style="width: 100%" href="#" class="k-pager-refresh k-button wd58" onclick="sendTalk();"><b class="btn-b">보내기</b></a>
					<a onclick="searchMember();" style="width: 100%" href="#" class="k-pager-refresh k-button wd58"><b class="btn-b">회원검색</b></a>
					<%--<a onclick="uploadFile();" style="width: 25%" href="#" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-file"></i>파일불러오기</b></a>--%>
				</div>
			</div>
		</form>
	</div>
</div>

<div class="header">
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">알림톡관리</P>
		</div>
	</div>
	<div class="contents">
		<div id="group-list" class="cont-wrapper-page-grid">
			<div style="display: block;" class="form-group row">
				<form id="fSearch" class="date-bnt">
					<div class="form-group row mt0" style="justify-content: space-between">
						<div>
							<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
								<input style="padding: 0;" type="text" id="fromDate" name="fromDate" class="wd90">
							</div>
							<span style="margin-top:25px;margin-right: 10px">~</span>
							<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
								<input style="padding: 0;" type="text" id="toDate" name="toDate" class="wd90">
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

							<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
								<input type="text" class="form-control form-control-sm searchValue" id="s_mobile" placeholder="수신번호">
							</div>

							<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
								<input type="text" class="form-control form-control-sm searchValue" id="s_userName" placeholder="회원이름">
							</div>

							<div class="input-group input-group-sm wd90 middle-name div-min-col-1">
								<select class="form-control" class="com-sel" id="s_isDone">
									<option value="">--전송결과--</option>
									<option value="2">발송성공</option>
									<option value="4">발송실패</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="input-group-sm middle-name">
								<button onclick="goList()" type="button" class="form-control-sm btn_58 btn_b">검색</button>
							</div>
						</div>
					</div>
				</form>
                
				<!-- <div class="input-group input-group-sm col-1 middle-name">
				<strong>　</strong>
				    <button onclick="" class="form-control form-control-sm middle-button"><i class="k-icon k-i-check"></i>초기화</button>
				</div> -->
			</div>
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
											<a href="#" class="k-pager-refresh k-button" onClick="goExcel();"><b class="btn-x">엑셀출력</b></a>
											<a id="btnAddTalk" href="#" class="k-pager-refresh k-button"><b class="btn-b">talk전송</b></a>
										</div>
									</div>
								</div>
							</div>
						</div><!-- /toolbar -->
						<div style="min-width: 500px;">
							<div style="height:calc(100vh - 344px)" id="talkList"></div>
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
</div>

<div id="divSearchMember"></div>
<div id="divFileUpload"></div>
<script type="text/javascript">
$(document).ready(function(){
	$(".splitter").kendoSplitter({
        orientation: "vertical",
        panes: [{resizable:true}, {resizable:true}]
    }); 
	
	modal = $("#talkModal");
	modalButton = $("#btnAddTalk");

	modalButton.click(function() {
		popInit();
		modal.data("kendoDialog").open();
	});

	modal.kendoDialog({
		width: "1000px",
		height: "700px",
		visible: false,
		closable: true,
		title: "알림톡 전송",
		modal: false,
		close: function(){modalButton.fadeIn();}
	});
	
	$("#fromDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true});
	$("#toDate").kendoDatePicker({format:"yyyy-MM-dd", value : new Date(), dateInput: true}); 
	$("#reserve").kendoDateTimePicker({format: "yyyy-MM-dd HH:mm:ss", timeFormat: "HH:mm:ss", value : new Date(), dateInput: true});
	Util.setSearchDateForm();

	$("#talkModal input:checkbox[name=custTypeCode]").change(function() {
		var grid = $("#popGrid").data("kendoGrid");
		grid.dataSource.data([]);
		
		if($(this).is(":checked")) {
			$("#talkModal input:checkbox[name=custTypeCode]").prop("checked", false);
			$(this).prop("checked", true);
		}
	});
	
	setTemplate();
	goList();
	
	$("#templateCode").change(function(){
		for(var i=0, item; item=templateData[i]; i++) {
			if($(this).val() == item.templateCode) {
				$("#contents").html(item.templateContents);
			}
		}
	});
});

var columns = [
	{ field: "rNum", title: "No", width: 50 },
	{ field: "inTime", title: "등록일", width: 100 },
	{ field: "callPhone", title: "수신번호", width: 100,
		template: function(dataItem) {
			return Util.formatPhone(dataItem.callPhone);
		}
	},
	{ field: "resend", title: "전송결과", width: 100 },
	{ field: "msg", title: "메시지", width: 100 },
	{ field: "sentTime", title: "전송시간", width: 100 },
	{ field: "callName", title: "회원이름", width: 100 },
	{ field: "reqName", title: "등록자", width: 100 }
];
var templateData;
var headerTitle = ($("#headerTitle").text());
var oGrid = null;	
oGrid = new gridData("talkList");
oGrid.initGrid();
oGrid.setSendUrl("/contents/notice/data/talkList.do");
oGrid.setPageable(true);
oGrid.setSelectable(false);
oGrid.setExcelFile(headerTitle+"(" + new Date().yyyymmdd() + ").xlsx");

function goList() {
	var grid = $("#talkList").data("kendoGrid");

	var param = {};
	param["fromDate"] = $("#fromDate").val();
	param["toDate"] = $("#toDate").val();
	param["mobile"] = $("#s_mobile").val();
	param["userName"] = $("#s_userName").val();
	param["isDone"] = $("#s_isDone").val();
	
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#talkList").data("kendoGrid");
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
}

$("#popGrid").kendoGrid({
	sortable: false,
	reorderable: true,
	groupable: false,
	resizable: true,
	filterable: false,
	pageable: false,
	selectable: true,
	columnMenu: true,
	columns: [
		{ field: "id", title: "아이디", width: 100 },
		{ field: "userName", title: "이름", width: 100},
		{ field: "mobile", title: "연락처", width: 100,
			template: function(dataItem) {
				return Util.formatPhone(dataItem.mobile);
			}
		}
	],
	dataSource: {
		data: []
	}
}); 

function sendTalk() {
	var grid = $("#popGrid").data("kendoGrid");
	var searchUserList = JSON.stringify(grid.dataSource._data);
	var searchUserTotalLength = grid.dataSource._data.length;
	
	if(!$("#contents").val()) {
		alert("내용을 입력해주세요.");
		$("#contents").focus();
		return;
	}
	
	if(searchUserTotalLength == 0 && $("input[name=custTypeCode]:checked").length == 0) {
		alert("알림톡을 전송할 회원을 추가해주세요.");
		return;
	}

	var param = $("#modalForm").serialize();
	
	param += "&searchUserList=" + searchUserList;
	param += "&searchUserTotalLength=" + searchUserTotalLength;
	
	$.ajax({
		type: "POST",
		url: "/contents/notice/data/talkSend.do",
		dataType: "json",
		data: param,
		async: false,
		success: function(data) {
			alert(data.msg);
			goList();
			modal.data("kendoDialog").close();
			popInit();
		}
	});
}

function searchMember() {
	var winHeight = ($(window).height()/2) - (250/2);
	var winWidth  = ($(window).width()/2) - (600/2);
	
	popupModal = $("#divSearchMember").kendoWindow({
		            width: "600px",
		            height:"349px",
		            title: "회원검색",
		            position: {
		                top: winHeight+"px", // or "100px"
		                left: winWidth+"px"
		            },
		            visible: false,
		            content: "/contents/cmm/view/searchMember.do",
		            iframe:true,
		            modal:true
		        }).data("kendoWindow");
	
	popupModal.open();
	
}

function setMember(data) {
	var popGrid = $("#popGrid").data("kendoGrid");
	popGrid.number = popGrid.dataSource.view().length+1;
	
	popGrid.dataSource.add(data);	

	$("#talkModal input:checkbox[name=custTypeCode]").prop("checked", false);
}

function uploadFile() {
	var winHeight = ($(window).height()/2) - (250/2);
	var winWidth  = ($(window).width()/2) - (600/2);
	
	popupModal = $("#divFileUpload").kendoWindow({
		            width: "600px",
		            height:"250px",
		            title: "엑셀 업로드",
		            position: {
		                top: winHeight+"px", // or "100px"
		                left: winWidth+"px"
		            },
		            visible: false,
		            content: "/contents/cmm/view/fileUpload.do",
		            iframe:true,
		            modal:true
		        }).data("kendoWindow");
	
	popupModal.open();
}

/**
 * 입력한 수신번호 Grid에 추가
 */
function addPhone(){
	var phone = $("#recvNum").val();
	phone = phone.replace(/[^0-9]/g, "");		//연락처는 숫자만 추출.
	if(!phone) {
		alert("수신번호는 숫자만 입력할 수 있습니다.");
		$("#recvNum").val("");
		$("#recvNum").focus();
		return;
	}
	var rowData = {id:"", mobile:phone};
	var popGrid = $("#popGrid").data("kendoGrid");
		
	popGrid.dataSource.add(rowData);
	$("#recvNum").val("");

	$("#talkModal input:checkbox[name=custTypeCode]").prop("checked", false);
}

/* 알림톡전송 modal 초기화 */
function popInit() {
	var popGrid = $("#popGrid").data("kendoGrid");
	$("#contents").val("");
	$("#modalForm")[0].reset();
	popGrid.removeRow($("#popGrid table tbody tr"));
}

/**
 * 선택된 수신번호 Grid에서 제거
 */
function removePhone(){
	var popGrid = $("#popGrid").data("kendoGrid");
	popGrid.select().each(function() {
		popGrid.dataSource.remove(popGrid.dataItem($(this).closest("tr")));
	});
}

//excel download
function goExcel(){
	var grid = $("#talkList").data("kendoGrid");
	grid.saveAsExcel();
}

$("#recvNum").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});

function setTemplate() {
	$.ajax({
		url: "/contents/notice/data/talkTemplate.do",
		type: "GET",
		dataType: "json",
		success: function(data) {
			if(data.result) {
				templateData = data.data;
				var s = "";
				for(var i=0, item; item=templateData[i]; i++) {
					s += "<option value=\"" + item.templateCode + "\">" + item.templateName + "</option>";
				}
				$("#contents").html(templateData[0].templateContents);
				$("#templateCode").html(s);
			}
			
		}
	});
}
</script>