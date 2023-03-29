<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="Author" content="">
	<meta name="Keywords" content="">
	<meta name="Description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>logslink-join</title>
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.common.min.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.default-v2.min.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.default.min.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.default.mobile.min.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap.min.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css?v=2'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css?v=6'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/left.css?v=1'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/style_V2.css?v=1'/>">
	<script type="text/javascript" src="<c:url value='/js/jquery.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.form.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/util.js?v=5'/>"></script>
	<script src="/js/validator.min.js"></script>
</head>
<style>
	#group-list {
		display: flex;
		justify-content: center;
	}

	.with-errors{
		position: absolute;
		width: 100%;
	}


	textarea {
		resize: none;
	}
</style>
<script>
	$.ajax({
		url:"/terms/content.do",
		data:"",
		success:function (data) {

			$('#agree tr:gt(0)').remove();
			$('#privacy tr:gt(0)').remove();
			$('#privateInfo tr:gt(0)').remove();
			$('#dataSource tr:gt(0)').remove();
			$('#marketing tr:gt(0)').remove();

			termsVersion =data.tResult[5].version;
			let str1 = data.tResult[5].detail;
			$("#agree").append(str1);

			let str2 = data.tResult[6].detail;
			$("#privacy").append(str2);

			let str3 = data.tResult[7].detail;
			$("#privateInfo").append(str3);

			let str4 = data.tResult[8].detail;
			$("#dataSource").append(str4);

			let str5 = data.tResult[9].detail;
			$("#marketing").append(str5);

		},
		dataType:"json"
	});
</script>

<body>
<div style="background-color:#ffffff;padding:1.85em;text-align: center;">
	<div>
		<div style="word-break: keep-all;">
			<b>로지스링크 이용신청</b>
		</div>
	</div>
</div>
<div class="contents join" style="height: auto;">

	<div id="group-list" class="cont-wrapper-page-grid termsOfUse">
		<div class="editor">
			<div class="form-group">
				<div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
					<div class="input-group input-group-sm col radio-or-checkBox ">
						<input id="allCheck" name="btnAllChk" type="checkbox">
						<label for="allCheck" class="label-margin">
							<span><b>이용약관, 이하 사항 모두 동의합니다.</b></span>
						</label>
					</div>
				</div>

				<div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
					<div class="input-group input-group-sm col radio-or-checkBox ">
						<input id="agreeYn" name="btnChk" type="checkbox" value="N">
						<label for="agreeYn" class="label-margin">
							<span><b>이용약관</b>(필수)</span>
						</label>
					</div>
					<span>&nbsp;</span>
					<textarea rows="11" class="form-control form-control-sm noColorReadonly" readonly="readonly" id="agree"></textarea>
				</div>

				<div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
					<div class="input-group input-group-sm col radio-or-checkBox ">
						<input id="privacyYn" name="btnChk" type="checkbox" value="N">
						<label for="privacyYn" class="label-margin">
							<span><b>개인정보수집이용동의</b>(필수)</span>
						</label>
					</div>
					<span>&nbsp;</span>
					<textarea rows="11" class="form-control form-control-sm noColorReadonly" readonly="readonly" id="privacy"></textarea>
				</div>

				<div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
					<div class="input-group input-group-sm col radio-or-checkBox ">
						<input id="privateInfoYn" name="btnChk" type="checkbox" value="N">
						<label for="privateInfoYn" class="label-margin">
							<span><b>개인정보처리방침</b>(필수)</span>
						</label>
					</div>
					<span>&nbsp;</span>
					<textarea rows="11" class="form-control form-control-sm noColorReadonly" readonly="readonly" id="privateInfo"></textarea>
				</div>

				<div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
					<div class="input-group input-group-sm col radio-or-checkBox ">
						<input id="dataSecureYn" name="btnChk" type="checkbox" value="N">
						<label for="dataSecureYn" class="label-margin">
							<span><b>데이터보안서약</b>(필수)</span>
						</label>
					</div>
					<span>&nbsp;</span>
					<textarea rows="11" class="form-control form-control-sm noColorReadonly" readonly="readonly" id="dataSource"></textarea>
				</div>

				<div class="input-group input-group-sm col middle-name form-group" style="margin-bottom: 1.375em;">
					<div class="input-group input-group-sm col radio-or-checkBox ">
						<input id="marketingYn" name="btnChk" type="checkbox" value="N">
						<label for="marketingYn" class="label-margin">
							<span><b>마케팅정보수신동의</b>(선택)</span>
						</label>
					</div>
					<span>&nbsp;</span>
					<textarea rows="11" class="form-control form-control-sm noColorReadonly" readonly="readonly" id="marketing"></textarea>
				</div>

			</div>
			<div class="form-group">
				<div class="input-group input-group-sm middle-name form-group singUpBtn">
					<button type="button" onclick="termsOfUseCancle();" id="termsOfUseCancle" class="btn btn-danger mr10">취소</button>
					<button type="button" onclick="termsOfUseSuccess();" id="termsOfUseSuccess" class="btn btn-success">확인</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Check 이후 Correct 부분 -->

	<div id="group-list" class="cont-wrapper-page-grid signUp" style="display: none;">
		<div class="editor">
			<form id="f" data-toggle="validator" role="form" autocomplete="off">
				<input type="hidden" id="custId" name="custId" class="hiddenValue">
				<input type="hidden" id="deptId" name="deptId" class="hiddenValue">
				<div class="pb25" style="text-align: center;">
					<img class="logislink_logo_b" src="/images/logislink_logo_b.png">
					<p>로지스링크 이용신청을 환영합니다. <br>
						이용신청에 필요한 정보를 입력해 주세요.</p>
				</div>

				<div class="singUpContBox">
					<div>
						<div class="form-group row mr0">
							<label class="col-form-label big-name">회사정보</label>
							<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<strong class="required">상호</strong>
								<input type="text" class="form-control form-control-sm" name="bizName" id="bizName" required>
								<div class="help-block with-errors"></div>
							</div>
							<div class="input-group input-group-sm wd190 mr0 middle-name form-group">
								<strong class="required">사업자번호</strong>
								<button type="button" id="bizNumCheck" class="btn_58 btn_b btn-danger"> 등록확인</button>
								<input type="text" class="form-control form-control-sm" name="bizNum" id="bizNum" maxlength="12" required>
								<!-- <div class="help-block with-errors"></div> -->
							</div>
						</div>

						<div class="form-group row mr0 mt5">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<strong class="required">분류</strong>
								<select class="form-control custom-select col" id="custTypeCode" name="custTypeCode" required></select>
								<div class="help-block with-errors"></div>
							</div>

							<div class="input-group input-group-sm wd190 mr0 middle-name form-group">
								<strong>업태</strong>
								<input type="text" class="form-control form-control-sm" name="bizCond" id="bizCond">
							</div>

						</div>

						<div class="form-group row mr0 mt5">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<strong>업종</strong>
								<input type="text" class="form-control form-control-sm" name="bizKind" id="bizKind">
							</div>
							<div class="input-group input-group-sm wd190 mr0 middle-name form-group">
								<strong class="required">과세유형</strong>
								<select class="form-control custom-select col" id="bizTypeCode" name="bizTypeCode" required></select>
								<div class="help-block with-errors"></div>
							</div>
						</div>

						<div class="form-group row mr0 mt5">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm wd190 mr0 middle-name form-group">
								<strong class="required">대표자명</strong>
								<input type="text" class="form-control form-control-sm" name="ceo" id="ceo" required>
								<div class="help-block with-errors"></div>
							</div>
						</div>
					</div>
				</div>

				<div class="singUpContBox">
					<div>
						<div class="form-group row mr0 mt5">
							<label class="col-form-label big-name">계좌정보</label>
							<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<strong>은행명</strong>
								<select class="form-control custom-select col" id="bankCode" name="bankCode"></select>
							</div>
							<div class="input-group input-group-sm wd190 mr0 middle-name form-group">
								<strong>예금주</strong>
								<input type="text" class="form-control form-control-sm" name="bankCnnm" id="bankCnnm">
							</div>
						</div>

						<div class="form-group row mr0 mt5">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm wd190 mr0 middle-name form-group">
								<strong>계좌번호</strong>
								<input type="text" class="form-control form-control-sm" name="bankAccount" id="bankAccount">
							</div>
						</div>
					</div>
				</div>

				<div class="singUpContBox">
					<div>
						<div class="form-group row mr0 mt5">
							<label class="col-form-label big-name">회원정보</label>
							<div class="input-group input-group-sm wd190 mr10 middle-name form-group" id="divDeptSelect">
								<strong class="required">이름</strong>
								<input type="text" class="form-control form-control-sm" name="deptName" id="deptName" required>
								<div class="help-block with-errors"></div>
							</div>

							<div class="input-group input-group-sm wd190 mr0 middle-name form-group" id="divDeptSelect">
								<strong class="required">부서명</strong>
								<input type="text" class="form-control form-control-sm" name="deptName" id="deptName" required>
								<div class="help-block with-errors"></div>
							</div>
						</div>

						<div class="form-group row mr0 mt5">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm wd190 mr10 middle-name form-group" style="margin-bottom: 0.375em;">
								<strong class="required">아이디</strong>
								<button type="button" id="userIdCheck" class="btn_58 btn_b btn-danger">중복확인</button>
								<input type="text" class="form-control form-control-sm" name="userId" id="userId" onkeyup="this.value=this.value.replace(/[^a-zA-Z-_0-9]/g,'');"  required>
								<div class="help-block with-errors"></div>
							</div>
						</div>
						<div class="form-group row mr0 mt5">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm  wd190 mr10 middle-name form-group">
								<strong class="required">비밀번호</strong>
								<input type="password" class="form-control form-control-sm" id="passwd" name="passwd" pattern="^(?=.{4,265}$).*" data-pattern-error="4자리 이상 입력">
								<div class="help-block with-errors"></div>
							</div>
							<div class="input-group input-group-sm  wd190 mr0 middle-name form-group" style="margin-bottom: 1rem;">
								<strong class="required">비밀번호 확인</strong>
								<input type="password" class="form-control form-control-sm" id="passwd_comfirm" name="passwd_comfirm" data-match="#passwd" data-match-error="일치하지 않음">
								<div class="help-block with-errors"></div>
							</div>
						</div>
						<div class="form-group row mr0 mt5">
							<label class="col-form-label big-name"></label>
							<div class="input-group input-group-sm wd190 mr10 middle-name form-group">
								<strong class="required">휴대폰 번호</strong>
								<input type="text" class="form-control form-control-sm" name="mobile" id="mobile" maxlength="13" required>
								<div class="help-block with-errors"></div>
							</div>

							<div class="input-group input-group-sm wd190 mr0 middle-name form-group">
								<strong>이메일</strong>
								<input type="text" class="form-control form-control-sm" name="email" id="email">
							</div>
						</div>
					</div>
				</div>

				<div class="form-group singUpBtn">
					<div class="input-group input-group-sm wd250 mr10 middle-name form-group">
						<a href="/index.do">
							<button type="button" class="btn_black wd250 btn-primary">취소</button>
						</a>
					</div>
					<div class="input-group input-group-sm wd250 mr0 middle-name form-group">
						<button type="submit" class="btn_b wd250 btn-primary">이용신청</button>
					</div>
				</div>
		</div>

		</form>
	</div>
</div>
</div>
</body>

<script type="text/javascript">
	var chkBiz = false;
	var chkUid = false;
	$(document).ready(function(){
		setCmmCode("select", "custTypeCode", "CUST_TYPE_CD", "", "분류");
		setCmmCode("select", "bizTypeCode", "BIZ_TYPE_CD", "", "과세유형");
		setCmmCode("select", "bankCode", "BANK_CD", "", "은행명");
	});

	function setCmmCode(type, id, groupCode, dftVal, dftTxt){
		$.ajax({
			url: "/codeList.do",
			type: "POST",
			dataType: "json",
			data: "gCode=" + groupCode,
			async: false,
			success: function(data){
				$("#" + id).empty();
				var s = "";
				if(type == "select"){
					if(dftTxt != "") {
						s += "<option value=\"\" >" + dftTxt + "</option>";
					}
					for(var i=0, item; item=data.data[i]; i++){
						s += "<option value=\"" + item.code + "\""
						if(dftVal == item.code)	s += " selected";
						s += ">" + item.cname + "</option>";
					}
					$("#" + id).append(s);
				} else{
					for(var i=0, item; item=data.data[i]; i++){
						s += "<div class=\"form-check form-check-inline\">";
						s += "<input id=\"" + id + "-" + item.code + "\" class=\"form-check-input\" type=\"" + type + "\" name=\"" + id + "\" value=\"" + item.code + "\" data-name=\"" + item.cname + "\" ";
						if(dftVal == item.code)	s += " checked";
						if(dftVal == "" && i == 0) s+= " checked";
						s += ">";
						s += "<label for=\"" + id + "-"  + item.code + "\" class=\"form-check-label\">"+ item.cname + "</label>";
						s += "</div>"
					}
					$("#" + id + "Div").html(s);
				}
			},
			error: function(data) {
			}
		});
	}

	function setDeptList(url, id, param, val, txt, dftVal, dftTxt){
		$.ajax({
			url: url,
			type: "POST",
			dataType: "json",
			data: param,
			async: false,
			success: function(data){
				$("#" + id).empty();
				var s = "";
				if (dftTxt != "") s += "<option value=\"\" >" + dftTxt + "</option>";
				for(var i=0, item; item=data.data[i]; i++){
					s += "<option value=\"" + item[val] + "\""
					if(dftVal == item[val])	s += " selected";
					s += ">" + item[txt] + "</option>";
				}
				$("#" + id).append(s);
			},
			error: function(data) {
			}
		});
	}

	$("#bizNumCheck").click(function(){
		var bizNum = $("#bizNum").val().replace(/\-/g, '');
		if(bizNum.length < 10) {
			alert("사업자번호는 하이픈(-)을 제외한 10자리 숫자로 입력해주세요.");
			return;
		}
		$.ajax({
			url: "/checkBizNum.do",
			type: "POST",
			dataType: "json",
			data: {
				bizNum: bizNum
			},
			success: function(data){
				if(data.result) {
					if(!confirm('계속 진행하시려면 "확인" 버튼을 클릭해주세요.')){
						chkBiz = false;
						return false;
					}else{
						chkBiz = true;
						$("#bizNumCheck").removeClass('btn-danger');
						$("#bizNumCheck").addClass('btn-success');
						$("#bizNumCheckIcon").removeClass('bi-clipboard-x');
						$("#bizNumCheckIcon").addClass('bi-clipboard-check');
						Util.setPageData(data.data);
						if(data.data.custId != null){
							setDeptSelectBox();
						}else{
							setDeptTextBox();
						}
					}
				}else{
					chkBiz = true;
					$("#bizNumCheck").removeClass('btn-danger');
					$("#bizNumCheck").addClass('btn-success');
					$("#bizNumCheckIcon").removeClass('bi-clipboard-x');
					$("#bizNumCheckIcon").addClass('bi-clipboard-check');
					alert(data.msg + '\n신규 거래처를 등록해주세요.');
					setDeptTextBox();
				}
			}
		});
	});

	function setDeptSelectBox(){
		var str = "";
		str += 	"<strong class=\"required\">부서명</strong>" +
				"<select id=\"deptName\" name=\"deptName\" class=\"custom-select col-12\" required></select>" +
				"<div class=\"help-block with-errors\"></div>";

		$("#divDeptSelect").html(str);
		$("#f").validator('update');

		setDeptList("/deptList.do", "deptName", {custId:$("#custId").val(), useYn:'Y'}, "deptId", "deptName", "", "부서명");

		$("#deptName").append('<option value="new">신규입력</option>');
	}

	function setDeptTextBox(){
		var str = "";
		str += 	"<strong class=\"required\">부서명</strong>" +
				"<input type=\"text\" id=\"deptName\" name=\"deptName\" class=\"form-control form-control-sm\" required>" +
				"<div class=\"help-block with-errors\"></div>";

		$("#divDeptSelect").html(str);
		$("#f").validator('update');
	}

	$("#divDeptSelect").change(function() {
		value = $("#divDeptSelect option:selected").val();
		if(value == "new"){
			setDeptTextBox();
		}else{
			$("#deptId").val(value);
		}
	});

	$("#userIdCheck").click(function(e) {
		e.preventDefault();
		var userId = $("#userId").val();
		if(!userId) {
			alert("아이디를 입력해주세요");
			return;
		}

		$.ajax({
			url: "/checkUserId.do",
			type: "POST",
			dataType: "json",
			data: {
				userId: userId
			},
			success: function(data){
				if(data.result) {
					chkUid = true;
					$("#userIdCheck").removeClass('btn-danger');
					$("#userIdCheck").addClass('btn-success');
					$("#userIdCheckIcon").removeClass('bi-person-x');
					$("#userIdCheckIcon").addClass('bi-person-check');
					alert(data.msg);
				} else {
					chkUid = false;
					$("#userIdCheck").removeClass('btn-success');
					$("#userIdCheck").addClass('btn-danger');
					$("#userIdCheckIcon").removeClass('bi-person-check');
					$("#userIdCheckIcon").addClass('bi-person-x');
					alert(data.msg);
				}
			}
		});
	});

	$('#f').validator().on('submit', function (e) {
		if(!chkBiz) {
			e.preventDefault();
			alert("사업자번호 확인을 해주세요.");
			return;
		}
		if(!chkUid) {
			e.preventDefault();
			alert("이미 존재하는 아이디이거나 중복 확인을 하지 않은 아이디입니다.");
			return;
		}
		if (e.isDefaultPrevented()) {
			alert("항목을 입력해 주세요.");
		} else {
			$("#bizNum").val($("#bizNum").val().replace(/\-/g, ""));
			$("#mobile").val($("#mobile").val().replace(/\-/g, ""));
			e.preventDefault();

			// TermsAgree 부분 사용자 추가 - junghwan.hwang
			InsertTermsAgree($("#userId").val(),$("#mobile").val());

			$.ajax({
				url: "/signUp.do",
				type: "POST",
				dataType: "json",
				data: $("#f").serialize(),
				success: function(data){
					if(data.result) {
						alert(data.msg);
						location.href = "/";
					}
				}
			});
		}
	})

	$('#bizNum').on('input', function(e) {
		e.preventDefault();
		var bizNum = $(this).val().replace(/[^\d]/g, '');
		var temp = bizNum.replace(/(\d{3})(\d{1,2})(\d{1,5})/, '$1-$2-$3');
		$(this).val(temp);
		chkBiz = false;
		$("#bizNumCheck").removeClass('btn-success');
		$("#bizNumCheck").addClass('btn-danger');
		$("#bizNumCheckIcon").removeClass('bi-clipboard-check');
		$("#bizNumCheckIcon").addClass('bi-clipboard-x');
	});


	$('#userId').on('input', function() {
		$("#userIdCheck").removeClass('btn-success');
		$("#userIdCheck").addClass('btn-danger');
		$("#userIdCheckIcon").removeClass('bi-person-check');
		$("#userIdCheckIcon").addClass('bi-person-x');
	});


	$("#mobile").on("input", function(){
		$(this).val(Util.formatPhone($(this).val()));
	});

	function termsOfUseCancle(){
		location.href = "/";
	}

	function InsertTermsAgree(userName,userTel){
		$.  ajax({
			url:"/terms/insertTermsAgree.do",
			type: "POST",
			data : {
				userId:userName,
				tel:userTel,
				necessary:necessary,
				selective:selective,
				version:termsVersion
			},
			dataType: "json",
			success:function(data){
				//alert("return:"+data);
			}
		});
	}

	let necessary;
	let selective;
	let termsVersion;

	function termsOfUseSuccess(){

// 선택항목 약관 동의 외 필수 항목 약관 동의에 관한 내용 Filter 수정

		if($("#agreeYn").val() == "Y" && $("#privacyYn").val() == "Y" && $("#privateInfoYn").val()=="Y" && $("#dataSecureYn").val()=="Y"){
			$(".termsOfUse").hide();
			$(".signUp").show();

			necessary = "Y";
			//termsVersion = "1.0";

		}else{

			let str ='';
			if($("#agreeYn").val()=="N"){
				str +='"이용약관" ';
			}

			if($("#privacyYn").val()=="N") {
				str +='"개인정보수집이용동의" ';
			}

			if($("#privateInfoYn").val()=="N") {
				str +='"개인정보처리방침" ';
			}

			if($("#dataSecureYn").val()=="N") {
				str +='"데이터보안서약" ';
			}

			alert(str+"에 대한 필수항목에 동의해주세요");
		}

		if($("#marketingYn").val()=="N") {
			selective = "N";
		}
		else{
			selective = "Y";
		}
	}

	$("#allCheck").click(function() {
		if($("#allCheck").is(":checked")){
			$("input[name=btnChk]").prop("checked", true);
			$("input[name=btnChk]").val("Y");
		}else{
			$("input[name=btnChk]").prop("checked", false);
			$("input[name=btnChk]").val("N");
		}
	});

	$("input[name=btnChk]").click(function() {
		var total = $("input[name=btnChk]").length;
		var totalChecked = $("input[name=btnChk]:checked").length;
		var id = $(this).context.id;
		var checked = $(this).context.checked;

		if(checked == true){
			$("#"+id).val("Y")
		}else{
			$("#"+id).val("N")
		}

		if(total != totalChecked){
			$("#allCheck").prop("checked", false);
		}else{
			$("#allCheck").prop("checked", true);
		}
	});
</script>
</html>