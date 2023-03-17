<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	.omsCompList .contents {
		max-width: 100%!important;
	}
	.tool_form .row {

	}
	.userButton button {
		width: 76px;
		background: #2a5dc4 !important;
		font-size: 10px;
		margin: 0;
		padding: 5px 0px !important;
	}
	.form-control-sm,.custom-select {
		width: 135px;
		margin: 5px 0!important;
	}
	.modalEditor {
		width: 80%;
		margin: 0 auto;
	}
	.userUpload {
		display: flex;
		height: 51px;
		align-items: center;
	}
	.help-block {
		font-size: 9px;
	}
	.modalHeader {
		display: flex;
		justify-content: space-around;
		flex-wrap: wrap;
	}
	.modal-big-name {
		font-size: 14px !important;
		color: #1d54c4 !important;
		text-align: left !important;
		padding: 0px !important;
		display: flex !important;
		width: 91px !important;
		margin-left: 14px
	}

</style>

<!-- modal -->
<div id="divAddDept" class="editor-warp p-0">
    <form id="modal-form" data-toggle="validator" role="form">
		<div class="modalEditor" id="addDept">
			<div class="modalHeader">
				<div class="form-group row userUpload">
		            <label class="col-form-label modal-big-name">아이디</label>
		            <div class="input-group input-group-sm col middle-name form-group">
		                <input type="text" class="form-control form-control-sm" id="userId" name="userId" required>
                        <div style="position: absolute;"class="help-block with-errors"></div>
		            </div>
		            <label class="col-form-label modal-big-name">아이디확인</label>
		            <div class="input-group input-group-sm col middle-name form-group">
		                <button type="button" class="form-control form-control-sm a-text-center" id="btn_chkUserId" name="btn_chkUserId">중복확인</button>
		            </div>
		        </div>
				<div class="form-group row userUpload" id="passwdDiv">
		            <label class="col-form-label modal-big-name">비밀번호</label>
		            <div class="input-group input-group-sm col middle-name form-group">
		                <input type="password" class="form-control form-control-sm" id="passwd" name="passwd" required>
                        <div style="position: absolute;"class="help-block with-errors"></div>
		            </div>
		            <label class="col-form-label modal-big-name">비밀번호 확인</label>
		            <div class="input-group input-group-sm col middle-name form-group">
		                <input type="password" class="form-control form-control-sm" id="passwd_comfirm" name="passwd_comfirm" data-match="#passwd" data-match-error="비밀번호가 일치하지 않습니다.">
                        <div style="position: absolute;"class="help-block with-errors"></div>
		            </div>
		        </div>
		        <div class="form-group userUpload row" id="passwdChangeDiv">
		            <label class="col-form-label modal-big-name">비밀번호</label>
		            <div class="input-group input-group-sm col middle-name form-group">
	                    <button type="button" class="form-control form-control-sm" id="btnChgPasswd">비밀번호 변경</button>
	                </div>
	           	</div>
		        <div class="form-group row userUpload">
		            <label class="col-form-label modal-big-name">이름</label>
		            <div class="input-group input-group-sm col middle-name form-group">
		                <input type="text" class="form-control form-control-sm" id="userName" name="userName">
		            </div>
		            <label class="col-form-label modal-big-name">연락처</label>
		            <div class="input-group input-group-sm col middle-name form-group">
		                <input type="text" class="form-control form-control-sm" id="telNum" name="telNum">
		            </div>
		        </div>
		        <div class="form-group row userUpload">
		            <label class="col-form-label modal-big-name">직급</label>
		            <div class="input-group input-group-sm col middle-name form-group">
		                <input type="text" class="form-control form-control-sm" id="grade" name="grade">
		            </div>
		            <label class="col-form-label modal-big-name">사용여부</label>
		            <div class="input-group input-group-sm col middle-name form-group">
		                <select class="custom-select" id="useYn" name="useYn" required>
	                        <option value='Y' selected>Y</option>
	                        <option value='N'>N</option>
	                    </select>
                        <div style="position: absolute;"class="help-block with-errors"></div>
		            </div>
		        </div>
		        <div class="form-group row userUpload">
		            <label class="col-form-label modal-big-name">휴대전화</label>
		            <div class="input-group input-group-sm col middle-name form-group">
		                <input type="text" class="form-control form-control-sm" id="mobile" name="mobile" required>
                        <div style="position: absolute;"class="help-block with-errors"></div>
		            </div>
		            <label class="col-form-label modal-big-name">알림톡</label>
		            <div class="input-group input-group-sm col middle-name form-group">
		                <select class="custom-select" id="talkYn" name="talkYn">
	                        <option value='Y' selected>Y</option>
	                        <option value='N'>N</option>
	                    </select>
		            </div>
		        </div>
		        <div class="form-group row userUpload">
		            <label class="col-form-label modal-big-name">이메일</label>
		            <div class="input-group input-group-sm col middle-name form-group">
		                <input type="text" class="form-control form-control-sm" id="email" name="email">
		            </div>
		            <label class="col-form-label modal-big-name">부서</label>
		            <div class="input-group input-group-sm col middle-name form-group">
		                <select class="custom-select" id="insertDeptList" name="insertDeptList"></select>
		            </div>
		        </div>
			</div>
			<div class="editor_btns">
				<div class="padding">
					<c:if test="${menuAuth.editYn eq 'Y'}">
						<button type="submit" class="btn_b k-pager-refresh k-button"><b class="btn-b"><strong id="btn_save">저장</strong></b></button>
					</c:if>
					<a id="closeBtn" onclick="modalClose()" class="k-pager-refresh k-button"><b class="btn-g">닫기</b></a>
				</div>
			</div>
		</div>
	</form>
</div>
<div class="oms_header omsCompList">
	<div class="summary p30">
		<div class="hdr-tit">
			<p id="headerTitle">조직관리</p>
		</div>
	</div>
   	<form id="f" data-toggle="validator" role="form">
	<div class="contents">
		<div class="box">
				<div id="group-list" class="cont-wrapper">
					<!--  -->
						<div class="cont-b-head">
							<h4>회사정보</h4>
							<c:if test="${menuAuth.editYn eq 'Y'}">
								<button type="submit" id="btnUpdateComp" class="btn_b btn_58">정보수정</button>
							</c:if>
						</div>
						<div class="gray_box">
							<div class="form-group row">
								<label class="big-name col-form-label">기본정보</label>
								<input type="hidden" id="custId" name="custId">
								<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<span class="required">상호</span>
								    <input type="text" id="bizName" required>
	                                <div class="help-block with-errors"></div>
								</div>
								<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<span>부서명</span>
								    <input type="text" id="deptName" readonly>
								</div>
								<div class="input-group input-group-sm wd90 mr10 middle-name form-group">
								<span class="required">분류</span>
								    <select id="custTypeCode" required>
								    	<option value="04">화주</option>
								    </select> 
	                                <div class="help-block with-errors"></div>
								</div>
								<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<span>업태</span>
								    <input type="text" id="bizCond">
								</div>
								<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<span>업종</span>
								    <input type="text" id="bizKind">
								</div>
							</div>
							<div class="form-group row mt10">
								<label class="col-form-label"></label>
								<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<span class="required">사업자구분</span>
								    <select id="bizTypeCode" required></select> 
	                                <div class="help-block with-errors"></div>
								</div>
								<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<span class="required">사업자번호</span>
								    <input type="text" id="bizNum" maxlength="12" required>
	                                <div class="help-block with-errors"></div>
								</div>
								<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<span>종사업장번호</span>
								    <input type="text" id="bizNumSub">
								</div>
								<div class="input-group input-group-sm wd190 middle-name form-group">
								<span class="required">대표자명</span>
								    <input type="text" id="ceo" required>
	                                <div class="help-block with-errors"></div>
								</div>		
							</div>
							<div class="form-group row bortop mt20 pt20"">
								<label class="big-name col-form-label">상세주소</label>
								<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<span>우편번호(검색)</span>
								    <div class="textBox-in-icon">
	                                	<input style="border-radius: 0px 8px 8px 0px;" onClick="popSearchPost('');" type="text" class="form-control form-control-sm" id="bizPost">
										<i><img onclick="popSearchPost('');" src="/images/icon/icon_search.png"></i>
									</div>
								</div>
								<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<span>주소</span>
								    <input type="text" id="bizAddr">
								</div>
								<div class="input-group input-group-sm wd190 middle-name form-group">
								<span>상세주소</span>
								    <input type="text" id="bizAddrDetail">
								</div>
							</div>
							
							<div class="form-group row bortop mt20 pt20"">
								<label class="big-name col-form-label">계좌정보</label>
								<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
	                            <span>은행명</span>
	                                <select id="bankCode"></select>
	                            </div>
	                            <div class="input-group input-group-sm wd190 mr10 middle-name form-group">
	                            <span>예금주</span>
	                                <input type="text" id="bankCnnm">
	                            </div>
	                            <div class="input-group input-group-sm wd190 middle-name form-group">
	                            <span>계좌번호</span>
	                                <input type="text" id="bankAccount">
	                            </div>
					<div class="form-group row">
						<div class="input-group input-group-sm col-4 middle-name form-group"></div>
						<div style="margin-top: -10px; text-align: center;" class="input-group input-group-sm col-4 middle-name form-group">
								<span class="userButton add_btn">

									<c:if test="${menuAuth.writeYn eq 'Y'}">
										<button type="button" id="btnAddDept">사용자추가</button>
									</c:if>
								</span>

						</div>
					</div>
							</div>
						</div>

					</div>
				</div>
			<!-- group-list -->
			
			<div class="tool_form">
				<div class="cont-b-head bortop mt20 pt20 mb15">
					<h4>부서정보</h4>
					<div class="input-group input-group-sm wd90 middle-name form-group">
		                <select id="deptList" name="deptList"></select>
		            </div>
				</div>
				<div class="row">
					<div style="height: calc(20vw - 1px);" id="grid" class="l-grid"></div>
				</div>
			</div>
		</div>
		<!--  -->
	</form>
	
</div>
<!-- wrap -->

<script type="text/javascript">
var g_mode = "";
var chkUID = false;
$(document).ready(function(){
	Util.setCmmCode("select", "bizTypeCode", "BIZ_TYPE_CD", "", "선택하세요.");
    Util.setCmmCode("select", "bankCode", "BANK_CD", "", "선택하세요.");
    Util.setSelectBox("/contents/basic/data/compDeptList.do", "deptList", {custId:'${custId}'}, "deptId", "deptName", "", "선택하세요.");


    var $options = $("#deptList > option").clone();
	$('#insertDeptList').append($options);
	
	if("${masterYn}" == "N"){
		$("#insertDeptList").find("option").each(function() {
			if(this.value != "${sessionScope.userInfo.deptId}") {
				$(this).remove();
			}
		});
	}
	
	$("#insertDeptList option[value='']").remove();
    
    $("#deptList").change(function(){
    	goList();
    });

 	$.ajax({
		url: "/contents/basic/data/compList.do",
		type: "POST",
		dataType: "json",
		data: "",
		success: function(data){
			if(data.result) {
				Util.setPageData(data.data);
			}
		}
	});
 	
 	goList();
});

$("#btn_chkUserId").click(function(e) {
	var userId = $("#userId").val();
	if(!userId) {
		alert("아이디를 입력해주세요");
		return;
	}
	
	$.ajax({
		url: "/contents/basic/data/checkUserId.do",
		type: "POST",
		dataType: "json",
		data: {
			userId: userId
		},
		success: function(data){
			if(data.result) {
				$("#btn_chkUserId").css('border', '#0bba82 solid 2px');
				$("#btn_chkUserId").html("<i class=\"k-icon k-i-check-outline\" id=\"chkOK\" style=\"color:#0bba82;margin-right:3px;\"></i>중복확인");
				chkUID = true;
				alert(data.msg);
			} else {
				$("#btn_chkUserId").css('border', '#ed4956 solid 2px');
				$("#btn_chkUserId").html("<i class=\"k-icon k-i-close-outline\" id=\"chkFail\" style=\"color:#ed4956;margin-right:3px;\"></i>중복확인");
				alert(data.msg);
				chkUID = false;
			}
		}
	});
});

$("#userId").keypress(function(){
	$("#btn_chkUserId").css('border', '#ced4da solid 1px');
	$('#btn_chkUserId .k-icon').remove();
	chkUID = false;
});

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "userId", title: "아이디", width: 100 },
	{ field: "userName", title: "이름", width: 100 },  
	{ field: "telNum", title: "연락처", width: 100,
		template: function(dataItem) {
			return Util.formatPhone(dataItem.telNum);
		}
	},
	{ field: "mobile", title: "휴대전화", width: 100,
		template: function(dataItem) {
			return Util.formatPhone(dataItem.mobile);
		}
	},  
	{ field: "email", title: "이메일", width: 100 },   
	{ field: "talkYn", title: "알림톡", width: 100 },   
	{ field: "grade", title: "직급", width: 100 },   
	{ field: "useYn", title: "사용여부", width: 100 }, 
	{ field: "deptId", hidden: true }, 
];

var oGrid = null;	
oGrid = new gridData("grid");
oGrid.initGrid();
oGrid.setSendUrl("/oms/comp/data/omsUserList.do");
oGrid.setSelectable(true);
oGrid.setPageable(true);
oGrid.setPageSize(5);

function goList() {
	var grid = $("#grid").data("kendoGrid");
	
	var param = {};
	param["deptList"] = $("#deptList").val();
	
	oGrid.setSearchData(param);
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#grid").data("kendoGrid");
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
	
	if("${masterYn}" == "Y"){
		grid.tbody.delegate('tr', 'dblclick', function(){
			init();
			modal.data("kendoDialog").open();
			var dataItem = grid.dataItem($(this));
			
			g_mode = "E";
			
			$("#userId").val(dataItem.userId);
			$("#userName").val(dataItem.userName);
			$("#telNum").val(Util.formatPhone(dataItem.telNum));
			$("#grade").val(dataItem.grade);
			$("#useYn").val(dataItem.useYn);
			$("#mobile").val(Util.formatPhone(dataItem.mobile));
			$("#email").val(dataItem.email);
			$("#talkYn").val(dataItem.talkYn);
			$("#insertDeptList").val(dataItem.deptId);
			$("#btn_save").html($("#btn_save").html().replace('저장', '수정'));
			$("#divAddDept").parents("div").find(".k-window-title").html("사용자수정");
			$("#passwdDiv").hide();
			$("#passwdChangeDiv").show();
			$("#btn_chkUserId").attr("disabled", true);
			$("#passwd").attr("required" ,false);
			$("#passwd_comfirm").attr("required" ,false);
			$("#userId").attr("readonly" ,true);
		});
	}
}

$('#bizNum').on('input', function() {
	var bizNum = $(this).val().replace(/[^\d]/g, '');
	var temp = bizNum.replace(/(\d{3})(\d{1,2})(\d{1,5})/, '$1-$2-$3');
	$(this).val(temp);
});

$('#f').validator().on('submit', function (e) {
	var param = {
			custId : $("#custId").val(),
			deptId : $("#deptId").val(),
 			bizName: $("#bizName").val(),
			bizCond: $("#bizCond").val(),
			custTypeCode: $("#custTypeCode").val(),
			bizKind: $("#bizKind").val(),
			bizTypeCode: $("#bizTypeCode").val(),
			bizNum: $("#bizNum").val().replace(/\-/g, ''),
			bizNumSub: $("#bizNumSub").val(),
			ceo: $("#ceo").val(),
			bizAddr: $("#bizAddr").val(),
			bizPost: $("#bizPost").val(),
			bizAddrDetail: $("#bizAddrDetail").val(),
			bankCode : $("#bankCode").val(),
			bankCnnm : $("#bankCnnm").val(),
			bankAccount : $("#bankAccount").val()
		};
	
	if (e.isDefaultPrevented()) {
	    alert("항목을 입력해 주세요.")
	} else {
		// 이벤트 초기화 (submit 동작 중단)
		e.preventDefault();
		
		if(param.bizNumSub == '') {
			param.bizNumSub = '0000';
			$("#bizNumSub").val('0000');
		}
		
		$.ajax({
			url: "/oms/comp/data/compUpdate.do",
			type: "POST",
			dataType: "json",
			data: param,
			success: function(data){
				if (data.result) {
					alert(data.msg);
					if(data.data) {
						location.href = "/oms/comp/omsCompList.do?custId="+data.data.custId;
					}
				} else {
					alert(data.msg);
				}
			}
		});
	}
});

$('#modal-form').validator().on('submit', function (e) {
	if(typeof $("#btn_chkUserId").attr("disabled") == "undefined") {
		if(!chkUID) {
			e.preventDefault();
			alert("이미 존재하는 아이디이거나 중복 확인을 하지 않은 아이디입니다.");
			return;
		}
	}
	if (e.isDefaultPrevented()) {
	    alert("항목을 입력해 주세요.")
	}else{
  		e.preventDefault();
  		$.ajax({
			url: "/oms/comp/data/insertUser.do",
			type: "POST",
			dataType: "json",
			data: {
				custId: $("#custId").val(),
				deptId: $("#insertDeptList").val(),
				userId: $("#userId").val(),
				passwd: $("#passwd").val(),
				userName: $("#userName").val(),
				grade: $("#grade").val(),
				telNum: $("#telNum").val().replace(/\-/g, ""),
				mobile: $("#mobile").val().replace(/\-/g, ""),
				talkYn: $("#talkYn").val(),
				email: $("#email").val(),
				useYn: $("#useYn").val(),
				authSeq: "210",
				mode: g_mode
			},
			success: function(data){
				if(data.result) {
					alert(data.msg);
					modal.data("kendoDialog").close();
					goList();
				} else {
					alert(data.msg);
				}
			}
		});
	}
});

//부서추가 modal
modal = $("#divAddDept");
modalButton = $("#btnAddDept");

modalButton.click(function() {
	init();
	modal.data("kendoDialog").open();
	g_mode = "N";
	$("#btn_save").html($("#btn_save").html().replace('수정', '저장'));
	$("#divAddDept").parents("div").find(".k-window-title").html("사용자 등록");
	$("#passwdDiv").show();
	$("#passwdChangeDiv").hide();
	$("#btn_chkUserId").attr("disabled", false);
	$("#passwd").attr("required" ,true);
	$("#passwd_comfirm").attr("required" ,true);
	$("#userId").attr("readonly" ,false);
});

modal.kendoDialog({
	width: "700px",
	height: "470px",
	visible: false,
	title: "사용자추가",
	closable: true,
	modal: false,
	close: function(){modalButton.fadeIn();}
});

function popSearchPost(){
	Util.popSearchPost();
}

function modalClose(){
	modal.data("kendoDialog").close();
}

$("#btnChgPasswd").click(function(e) {
	$("#passwdChangeDiv").hide();
	$("#passwdDiv").show();
	$("#passwd").val("");
	$("#passwd").attr("required" ,true);
	$("#passwd_comfirm").attr("required" ,true);
})

function init(){
	$("#modal-form")[0].reset();
	$('#btn_chkUserId .k-icon').remove();
	$("#btn_chkUserId").css('border', '#ced4da solid 1px');
	$(".list-unstyled").remove();
}

function setSearchAddressInfo(data) {
	var zipNo = data.zipNo;
	var addr = data.roadAddr; // 주소 변수
    
    $("#bizPost").val(zipNo);
    $("#bizAddr").val(addr);
}

$("#mobile, #telNum").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});
</script>