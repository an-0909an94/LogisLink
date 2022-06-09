<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pop-layer">
    <div class="editor_wrap pop-layer" id="layer1">
	    <div class="insertClose">
	    	<a class="insertCloseButton k-icon k-i-close" onclick="init_popup_close();"></a>
	    </div>
        <!-- wrap -->
        <div class="k-tabstrip-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
                    <div class="editor">
                    <form id="f" data-toggle="validator" role="form">
	                    <fieldset>
	                        <legend id="user_legend">사용자 등록</legend>
	                        <div class="form-group row">
	                            <label class="col-form-label big-name">기본정보</label>
	                            <div class="input-group input-group-sm col middle-name form-group">
	                            	<strong class="required">조직</strong>
									<input type="hidden" name="custId" id="custId">
									<input type="text" style="width: 100%;" name="custName" id="custName" required>
                                    <div class="help-block with-errors"></div>
	                            </div>
	                            <div class="input-group input-group-sm col middle-name form-group">
	                            	<strong class="required">소속부서</strong>
									<input type="hidden" name="deptId" id="deptId">
									<input type="text" style="width: 100%;" name="deptName" id="deptName" required>
                                    <div class="help-block with-errors"></div>
	                            </div>
	                        </div>
	                        <div class="form-group row">
	                            <label class="col-form-label"></label>
	                            <div class="input-group input-group-sm col middle-name form-group">
	                            	<strong class="required">아이디</strong>
	                                <input type="text" class="form-control form-control-sm" id="userId" required>
                                    <div class="help-block with-errors"></div>
	                            </div>
	                            <div class="input-group input-group-sm col middle-name">
	                            	<strong>아이디확인</strong>
	                                <button class="form-control form-control-sm a-text-center" id="btn_chkUserId">중복확인</button>
	                            </div>
	                        </div>
	                        
	                        <div class="form-group row chgPasswd">
	                            <label class="col-form-label"></label>
	                            <div class="col middle-name">
	                                <button class="form-control a-text-center" id="btnChgPasswd">비밀번호 변경</button>
	                            </div>
	                       	</div>
	                       	<div class="form-group row writePasswd">
	                            <label class="col-form-label"></label>
	                            <div class="col input-group middle-name form-group">
	                            	<strong class="required">비밀번호</strong>
	                                <input type="password" class="form-control form-control-sm" id="passwd" pattern="^(?=.{4,265}$).*" 
	                                data-pattern-error="4자리 이상 입력해 주세요.">
                                    <div class="help-block with-errors"></div>
	                            </div>
	                            <div class="col input-group middle-name form-group">
	                            	<strong class="required">비밀번호 확인</strong>
	                                <input type="password" class="form-control form-control-sm" id="passwd_comfirm" data-match="#passwd" 
	                                data-match-error="비밀번호가 일치하지 않습니다.">
	                                <div class="help-block with-errors"></div>
	                            </div>
	                       	</div>
	                       	
	                        <div class="form-group row">
	                            <label class="col-form-label"></label>
	                            <div class="col input-group middle-name">
	                            	<strong>이름</strong>
	                                <input type="text" class="form-control form-control-sm" id="userName">
	                            </div>
	                            <div class="input-group input-group-sm col middle-name form-group">
	                            	<strong class="required">권한</strong>
	                                <select class="custom-select" id="authSeq" required></select>
	                                <div class="help-block with-errors"></div>
	                            </div>
	                            <div class="input-group input-group-sm col middle-name">
	                            	<strong>사용여부</strong>
	                                <select class="custom-select" id="useYn">
	                                    <option value='Y'>사용</option>
	                                    <option value='N'>미사용</option>
	                                    <option value='W'>대기</option>
	                                </select>
	                            </div>
	                        </div>
	
                            <div class="form-group row">
                                <label class="col-form-label"></label>
                                <div class="input-group input-group-sm col middle-name">
                                    <strong>직급</strong>
                                    <input type="text" class="form-control form-control-sm" id="grade">
                                </div>
                                <div class="input-group input-group-sm col middle-name">
                                    <strong>전화번호</strong>
                                    <input type="text" class="form-control form-control-sm" id="telNum" maxlength="13">
                                </div>
                            </div>
	
                            <div class="form-group row">
                                <label class="col-form-label"></label>
                                <div class="input-group input-group-sm col middle-name form-group">
                                    <strong class="required">휴대전화</strong>
                                    <input type="text" class="form-control form-control-sm" id="mobile" maxlength="13" required>
		                            <div class="help-block with-errors"></div>
                                </div>
                                <div class="input-group input-group-sm col-2 middle-name">
                                    <strong>마스터사용자</strong>
                                    <input type="checkbox" id="masterYn" name="masterYn" class="input_on-off" value="Y">
									<label for="masterYn" class="label_on-off">
									  <span class="marble"></span>
									  <span class="on">on</span>
									  <span class="off">off</span>
									</label>
                                </div>
                                <div class="input-group input-group-sm col-3 middle-name">
                                    <strong>알림톡 수신여부</strong>
                                    <input type="checkbox" id="talkYn" name="talkYn" class="input_on-off" value="Y">
									<label for="talkYn" class="label_on-off">
									  <span class="marble"></span>
									  <span class="on">on</span>
									  <span class="off">off</span>
									</label>
                                </div>
                            </div>
	
	                        <div class="form-group row">
	                            <label class="col-form-label"></label>
	                            <div class="col middle-name">
	                            	<strong>이메일</strong>
	                                <input type="text" class="form-control form-control-sm" id="email">
	                            </div>
	                            <div class="input-group input-group-sm col middle-name">
	                            	<strong>등록일</strong>
	                                <input type="text" class="form-control form-control-sm" id="regDate"  readonly="readonly">
	                            </div>
	                        </div>
	                        <c:choose>
								<c:when test="${mainCustId eq sessionScope.userInfo.custId }">
			                        <div class="form-group row">
			                            <label class="col-form-label"></label>
			                            <div class="input-group input-group-sm col middle-name">
			                            	<strong>24시콜 아이디</strong>
			                                <input type="text" class="form-control form-control-sm" id="link24Id">
			                            </div>
			                            <div class="input-group input-group-sm col middle-name">
			                            	<strong>DOUZONE 아이디</strong>
			                                <input type="text" class="form-control form-control-sm" id="douzoneId">
			                            </div>
			                        </div>
			                    </c:when>
			                    <c:otherwise>
			                    	<input type="hidden" id="link24Id">
			                    	<input type="hidden" id="douzoneId">
			                    </c:otherwise>
							</c:choose>
	                        <div class="form-group row">
                                <label class="col-form-label"></label>
                                    <div class="col middle-name">
                                    <strong>메모</strong>
                                    <textarea rows="4" class="form-control form-control-sm textarea" id="memo"></textarea>
                                </div>
                            </div>
	                    </fieldset>
		                    <div class="editor_btns" style="text-align:center;">
		                    	<div class="padding">
			                    	<button type="submit" class="k-pager-refresh k-button" id="btnSubmit"><b class="btn-b"><i class="k-icon k-i-check"></i><strong id="btn_save">저장</strong></b></button>
							        <a onclick="init_popup_close();" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
						        </div>
						    </div>
	                    </form>
                    </div>
                    <!-- editor -->
                </div>
            </div><!-- content -->
        </div>
    </div><!-- wrap -->
</div>
<script type="text/javascript">
var g_mode = "";
var chkUID = false;
var custName, deptName;
var custId = $("#custId").val();
$(document).ready(function(){
	custName = Util.setBizName("custName", custId);
	deptName = Util.setDeptName("deptName", custId);
});

function init_pop(mode, data) {
	g_mode = mode;
	chkUID = false;
	init();
	//Util.setSelectBox("/contents/basic/data/masterCompList.do", "custId", {}, "custId", "bizName", '${custId}', "선택하세요");
	var custId = typeof data.custId == 'undefined' ? "${custId}" : data.custId;
	var custAuthSeq = '${custAuthSeq}' == '0' ? "" : '${custAuthSeq}';
	
	Util.setSelectBox("/contents/basic/data/userAuthList.do", "authSeq", {custId:custId, authSeq:data.authSeq}, "authSeq", "authName", custAuthSeq, "선택하세요");

	$("#btnSubmit").show();
	if(mode == "N") {
		$("#user_legend").text("사용자 등록");
		$(".chgPasswd").css("display","none");
		$(".writePasswd").css("display","");
		$("#regDate").val(moment().format('YYYY-MM-DD HH:mm:ss'));
		$("[id=passwd]").attr("required" , true);
		
		$("#btn_save").html($("#btn_save").html().replace('수정', '저장'));
		$("#userId").attr("readonly",false);
		$("#btn_chkUserId").attr("disabled", false);
		if('${authChk}' == 'false') {
			//Util.setDisabledList(["custId"]);
			
			Util.setSelectBox("/contents/basic/data/compDeptList.do", "deptId", {custId:'${custId}', useYn: 'Y'}, "deptId", "deptName", "", "선택하세요");
		}

		Util.setSelectBox("/contents/basic/data/userAuthList.do", "authSeq", {custId:custId}, "authSeq", "authName", custAuthSeq, "선택하세요");

		$("#masterYn").prop("checked", false);
		if("${menuAuth.writeYn}" != "Y")	$("#btnSubmit").hide();
	} else if(mode == "E") {
		$("#user_legend").text("사용자 수정");
		$(".writePasswd").css("display","none");
		$(".chgPasswd").css("display","");
		$("[id=passwd]").attr("required" , false);
		 
		$("#passwd_comfirm").parent().css("display","none");
		$("#regDate").val(moment(data.regDate).format('YYYY-MM-DD HH:mm:ss'));
		
		Util.setSelectBox("/contents/basic/data/compDeptList.do", "deptId", {custId:data.custId}, "deptId", "deptName", "", "선택하세요");
		Util.setPageData(data);
		
		var name = data.bizName;
		custName.select(function(dataItem) {
		    return dataItem.bizName === name;
		});
		custName.value(data.bizName);
		custName.trigger("change");
		custName.readonly(true);
		deptName.value(data.deptName);
		
		$("#btn_save").html($("#btn_save").html().replace('저장', '수정'));
		$("#userId").attr("readonly",true);
		$("#btn_chkUserId").attr("disabled", true);
		if('${authChk}' == 'false') {
			Util.setDisabledList(["custId"]);
		}
		
		if(data.masterYn == "Y") {
			$("#masterYn").prop("checked", true);
		} else {
			$("#masterYn").prop("checked", false);
		}

		if(data.talkYn == "Y") {
			$("#talkYn").prop("checked", true);
		} else {
			$("#talkYn").prop("checked", false);
		}
		
		if("${menuAuth.editYn}" != "Y")	$("#btnSubmit").hide();
	}
}

$("#custName").change(function(){
	if($(this).val() == "") return;
	$("#deptId").empty();
	//Util.setSelectBox("/contents/basic/data/compDeptList.do", "deptId", {custId:$(this).val()}, "deptId", "deptName", "", "선택하세요");
	Util.setSelectBox("/contents/basic/data/userAuthList.do", "authSeq", {custId:$("#custId").val()}, "authSeq", "authName", "", "선택하세요");
});

$("#btn_chkUserId").click(function(e) {
	e.preventDefault();
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


$('#f').validator().on('submit', function (e) {
	if(typeof $("#btn_chkUserId").attr("disabled") == "undefined") {
		if(!chkUID) {
			e.preventDefault();
			alert("이미 존재하는 아이디이거나 중복 확인을 하지 않은 아이디입니다.");
			return;
		}
	}
	
	if (e.isDefaultPrevented()) {
	    alert("항목을 입력해 주세요.")
  	} else {
  		e.preventDefault();
  		$.ajax({
			url: "/contents/basic/data/insertUser.do",
			type: "POST",
			dataType: "json",
			data: {
				custId: $("#custId").val(),
				deptId: $("#deptId").val(),
				userId: $("#userId").val(),
				passwd: $("#passwd").val(),
				userName: $("#userName").val(),
				authSeq: $("#authSeq").val(),
				grade: $("#grade").val(),
				telNum: $("#telNum").val().replace(/\-/g, ""),
				mobile: $("#mobile").val().replace(/\-/g, ""),
				talkYn: $("#talkYn").is(":checked") ? "Y" : "N",
				masterYn: $("#masterYn").is(":checked") ? "Y" : "N",
				email: $("#email").val(),
				useYn: $("#useYn").val(),
				regDate: $("#regDate").val(),
				memo: $("#memo").val(),
				mode: g_mode,
				link24Id: $("#link24Id").val(),
				douzoneId: $("#douzoneId").val()
			},
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
})

function init() {
	Util.formReset("", [".editor input",".editor select", ".editor textarea"], {".editor #useYn": 'Y'});
	$("#btn_chkUserId").css('border', '#ced4da solid 1px');
	$('#btn_chkUserId .k-icon').remove();
	$(".list-unstyled").remove();
	$("#passwd_comfirm").parent().css("display","block");
	if('${authChk}' == 'true') {
		Util.setEnabledList(["custId"]);	
	}
	custName.value("");
	deptName.value("");
	custName.readonly(false);
	
	if(custName.dataSource.data().length == 1) {
		var name = custName.dataSource.data().bizName;
		custName.select(function(dataItem) {
		    return dataItem.bizName === name;
		});
		custName.value(custName.dataSource.data().custId);
		custName.trigger("change");
	}

/* 	if(deptName.dataSource.data().length == 1) {
		deptName.select(0);
	}
 */	
	/*if(typeof $("#passwd_comfirm")[0] == "undefined") {
		var str = "<div class=\"col input-group middle-name form-group\">" + 
			    	"<strong class=\"required\">비밀번호 확인</strong>" + 
			        "<input type=\"password\" class=\"form-control form-control-sm\" id=\"passwd_comfirm\"" + 
			        "data-match-error=\"비밀번호가 일치하지 않습니다.\">" +
			        "<div class=\"help-block with-errors\"></div>" + 
			    "</div>";
		$(".writePasswd").append(str);
		$("#passwd_comfirm").attr("data-match", "#passwd");
	}*/
}

function init_popup_close() {
	form_popup_close();
	init();
}

$("#btnChgPasswd").click(function(e) {
	e.preventDefault();
	$(".chgPasswd").css("display","none");
	$(".writePasswd").css("display","");
})

$("#mobile, #telNum").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});
</script>