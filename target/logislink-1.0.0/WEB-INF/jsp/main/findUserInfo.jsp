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
}

.modal-big-name {
	text-align: center;
}
</style>

<div class="pop-layer">
    <div class="editor_wrap pop-layer" id="layer1">
        <!-- wrap -->
        <div class="k-tabstrip-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <!-- content -->
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
                    <div class="editor">
						<form id="fIdFind" name="fIdFind" action="post" data-toggle="validator" style="padding-bottom: 1.563rem;">
						   <input type="hidden" id="idFindMode" name="mode" value="id">
                           <fieldset>
                               <legend style="text-align: center;">아이디 찾기</legend>
                               <div class="modalEditor">
	                               <div class="form-group row" style="padding: 0.625rem 3.125rem 0.625rem 3.125rem;">
							            <label class="col-form-label modal-big-name">이름</label>
							            <div class="input-group input-group-sm col middle-name form-group">
						                	<input type="text" class="form-control form-control-sm" id="idFindUserName" name="userName" required>
							            	<div class="help-block with-errors"></div>
							            </div>
							        </div>
	                               <div class="form-group row" style="padding: 0.625rem 3.125rem 0.625rem 3.125rem;">
							            <label class="col-form-label modal-big-name">휴대폰 번호</label>
							            <div class="input-group input-group-sm col middle-name form-group">
						                	<input type="text" class="form-control form-control-sm" id="idFindUserPhone" name="userPhone"  maxlength="13" required>
							            	<div class="help-block with-errors"></div>
						            	</div>
							        </div>
							        <div class="padding" style="padding: 0.625rem 3.125rem 0.625rem 3.125rem;">
							        	<button type="submit" class="k-pager-refresh k-button disabled" style="width: 100%;">
							        		<strong>
							        			<b id="manualBtnSave" class="btn-b">
							        				<i class="k-icon k-i-user"></i>아이디 찾기
							        			</b>
							        		</strong>
							        	</button>
							        </div>
						   	    </div>
                           </fieldset>
                     	</form>
						<form id="fPassWordFind" name="fPassWordFind" action="post" data-toggle="validator" style="padding-top: 1.563rem;">
						   <input type="hidden" id="pwFindUserMode" name="mode" value="pw">
                           <fieldset>
                               <legend style="text-align: center;">비밀번호 찾기</legend>
                               <div class="modalEditor">
	                               <div class="form-group row" style="padding: 0.625rem 3.125rem 0.625rem 3.125rem;">
							            <label class="col-form-label modal-big-name">아이디</label>
							            <div class="input-group input-group-sm col middle-name form-group">
						                	<input type="text" class="form-control form-control-sm" id="pwFindUserId" name="userId" required>
							            	<div class="help-block with-errors"></div>
							            </div>
							       </div>
	                               <div class="form-group row" style="padding: 0.625rem 3.125rem 0.625rem 3.125rem;">
							            <label class="col-form-label modal-big-name">이름</label>
							            <div class="input-group input-group-sm col middle-name form-group">
						                	<input type="text" class="form-control form-control-sm" id="pwFindUserName" name="userName" required>
							            	<div class="help-block with-errors"></div>
							            </div>
							       </div>
	                               <div class="form-group row" style="padding: 0.625rem 3.125rem 0.625rem 3.125rem;">
							            <label class="col-form-label modal-big-name">휴대폰 번호</label>
							            <div class="input-group input-group-sm col middle-name form-group">
						                	<input type="text" class="form-control form-control-sm" id="pwFindUserPhone" name="userPhone"  maxlength="13" required>
							            	<div class="help-block with-errors"></div>
						            	</div>
							        </div>
							        <div class="padding" style="padding: 0.625rem 3.125rem 0.625rem 3.125rem;">
							        	<button type="submit" class="k-pager-refresh k-button disabled" style="width: 100%;">
							        		<strong>
							        			<b id="manualBtnSave" class="btn-b">
							        				<i class="k-icon k-i-lock"></i>비밀번호 찾기
							        			</b>
							        		</strong>
							        	</button>
							        </div>
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