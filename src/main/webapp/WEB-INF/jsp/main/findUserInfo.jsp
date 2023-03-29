<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/style_V2.css?v=6'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/left.css?v=2'/>">
<script type="text/javascript" src="<c:url value='/js/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/util.js?v=5'/>"></script>
<script src="/js/validator.min.js"></script>

<style>
.help-block.with-errors {
	position: absolute;
	left: 0%;
	right: 0%;
}

.list-unstyled li {
	font-weight: bold;
	font-size: 8px;
}

.modal-big-name {
	text-align: center;
}

/* 아이디/비밀번호 찾기 */
.findUsertitle {
	font-size: 16px;
	font-weight: 700;
	margin-bottom: 14px;
}
.findUserPop {
	display: flex;
	align-items: center;
	margin: 0 auto;
}
.findUserInfobox {
	position: relative;
}
.logis-window-pop {
	position: relative;
	text-align: center;
}
.modalEditor {
	position: relative;
	width: 70%;
	display: flex;
	flex-direction: column;
	justify-content: center;
}
.modal-big-name {
	color: #0a0a0a !important;
}

.findUser {
	position: relative;
	display: flex;
	background: #f5f5f5;
	padding: 33px 0;
}
.findUser legend {
	font-size: 12px;
	position: relative;
	top: 23px;
	color: #2a5dc4 !important;
}

/* 아이디 찾기 */
.findMemberId {
	position: relative;
	display: flex;
	align-content: center;
}
.findMemberId label {
	position: relative;
	display: flex !important;
	align-items: center;
	justify-content: flex-end;
	line-height: 36px;
	margin-right: 13px;
}
.findMemberId div {
	position: relative;
}
.findMemberId div input {
	position: relative;
}
.findMemberId .input-group-sm .form-control-sm {
	position: relative;
}
.IdButton {
	position: relative;
	width: 20%;
}
.IdButton .k-button {
	margin: 4.2px 10px 0 0;
	height: 64.7px;
}

/* 비밀번호 찾기 */
.findMemberPass {
	position: relative;
	display: flex;
	align-content: center;
}
.findMemberPass label {
	position: relative;
	display: flex !important;
	align-items: center;
	justify-content: flex-end;
	line-height: 36px;
	margin-right: 13px;
}
.findMemberPass div {
	position: relative;
}
.findMemberPass div input {
	position: relative;
}
.findMemberPass .input-group-sm .form-control-sm {
	position: relative;
}
.PassButton {
	position: relative;
	width: 20%;
}
.PassButton .k-button {
	margin: 4.2px 10px 0 0;
	height: 64.7px;
}
.k-tabstrip > .k-content {
	padding-top: 20px;
}
.findUser > .IdButton .k-button, .findUser > .PassButton .k-button {
	background: #2a5dc4;
	border: 0;
	color: #fff;
}
.findUser > .IdButton .k-button .btn-b, .findUser > .PassButton .k-button .btn-b {
	color: #fff;
	font-size: 12px;
}
</style>

<div class="pop-layer logis-window-pop">
    <div class="editor_wrap pop-layer" id="layer1">
        <!-- wrap -->
        <div class="k-tabstrip-wrapper findUserPop">
            <div id="editor_tabs" class="findUserInfobox tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
				<%--<h2 class="findUsertitle">아이디/비밀번호 찾기</h2>--%>
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
                    <div class="editor">
						<form id="fIdFind" name="fIdFind" action="post" data-toggle="validator" style="padding-bottom: 0.6rem;">
						   <input type="hidden" id="idFindMode" name="mode" value="id">
                           <fieldset class="findUser">
                               <legend style="text-align: center;">아이디 찾기</legend>
                               <div class="modalEditor">
	                               <div class="form-group row findMemberId">
							            <label class="col-form-label modal-big-name">이름</label>
							            <div class="input-group input-group-sm col middle-name form-group">
						                	<input type="text" class="form-control form-control-sm" id="idFindUserName" name="userName" placeholder="이름을 입력하세요." required>
							            	<%--<div class="help-block with-errors"></div>--%>
							            </div>
							        </div>
	                               <div class="form-group row findMemberId">
							            <label class="col-form-label modal-big-name">휴대폰 번호</label>
							            <div class="input-group input-group-sm col middle-name form-group">
						                	<input type="text" class="form-control form-control-sm" id="idFindUserPhone" name="userPhone" placeholder="휴대폰번호를 입력하세요." maxlength="13" required>
							            	<%--<div class="help-block with-errors"></div>--%>
						            	</div>
							        </div>
						   	    </div>
							   <div class="IdButton">
								   <button type="submit" class="k-pager-refresh k-button disabled" style="width: 100%;">
									   <strong>
										   <b id="manualBtnSave" class="btn-b">
											   아이디 찾기
										   </b>
									   </strong>
								   </button>
							   </div>
                           </fieldset>
                     	</form>
						<form id="fPassWordFind" name="fPassWordFind" action="post" data-toggle="validator">
						   <input type="hidden" id="pwFindUserMode" name="mode" value="pw">
                           <fieldset class="findUser">
                               <legend style="text-align: center;">비밀번호 찾기</legend>
                               <div class="modalEditor">
	                               <div class="form-group row findMemberPass">
							            <label class="col-form-label modal-big-name">아이디</label>
							            <div class="input-group input-group-sm col middle-name form-group">
						                	<input type="text" class="form-control form-control-sm" id="pwFindUserId" name="userId" placeholder="아이디를 입력하세요." required>
							            	<%--<div class="help-block with-errors"></div>--%>
							            </div>
							       </div>
	                               <div class="form-group row findMemberPass">
							            <label class="col-form-label modal-big-name">이름</label>
							            <div class="input-group input-group-sm col middle-name form-group">
						                	<input type="text" class="form-control form-control-sm" id="pwFindUserName" name="userName" placeholder="이름을 입력하세요." required>
							            	<%--<div class="help-block with-errors"></div>--%>
							            </div>
							       </div>
	                               <div class="form-group row findMemberPass">
							            <label class="col-form-label modal-big-name">휴대폰 번호</label>
							            <div class="input-group input-group-sm col middle-name form-group">
						                	<input type="text" class="form-control form-control-sm" id="pwFindUserPhone" name="userPhone" placeholder="휴대폰번호를 입력하세요." maxlength="13" required>
							            	<%--<div class="help-block with-errors"></div>--%>
						            	</div>
							        </div>
						   	    </div>
							   <div class="PassButton">
								   <button type="submit" class="k-pager-refresh k-button disabled" style="width: 100%;">
									   <strong>
										   <b id="manualBtnSave" class="btn-b">
											   비밀번호 찾기
										   </b>
									   </strong>
								   </button>
							   </div>
                           </fieldset>
                        </form>
                    </div>
                    <!-- editor -->
                </div>
            </div><!-- content -->
        </div>
    </div><!-- wrap -->
</div>

<script type="text/javascript">
$('#fIdFind').validator().on('submit', function (e) {
	if (e.isDefaultPrevented()) {
	    alert("항목을 입력해 주세요.");
    } else {
	  	$("#idFindUserPhone").val($("#idFindUserPhone").val().replace(/\-/g, ""));
  		e.preventDefault();
  		$.ajax({
			url: "/findUserData.do",
			type: "POST",
			dataType: "json",
			data: $("#fIdFind").serialize(),
			success: function(data){
				if(data.result) {
					alert(data.msg);
					window.parent.$("#divFindUserInfo").data("kendoWindow").close();
				}else{
					alert(data.msg);
				}
			}
		});
    }
})

$('#fPassWordFind').validator().on('submit', function (e) {
	if (e.isDefaultPrevented()) {
	    alert("항목을 입력해 주세요.");
    } else {
	  	$("#pwFindUserPhone").val($("#pwFindUserPhone").val().replace(/\-/g, ""));
  		e.preventDefault();
  		$.ajax({
			url: "/findUserData.do",
			type: "POST",
			dataType: "json",
			data: $("#fPassWordFind").serialize(),
			success: function(data){
				if(data.result) {
					alert(data.msg);
					window.parent.$("#divFindUserInfo").data("kendoWindow").close();
				}else{
					alert(data.msg);
				}
			}
		});
    }
})

$("#idFindUserPhone, #pwFindUserPhone").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});
</script>