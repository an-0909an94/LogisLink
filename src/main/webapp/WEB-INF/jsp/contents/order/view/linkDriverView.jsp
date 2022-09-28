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
						<form class="modalEditor" id="linkDriverForm" name="linkDriverForm" data-toggle="validator" role="form" autocomplete="off">
							<input type="hidden" name="allocId" id="allocId">
							<input type="hidden" name="orderId" id="orderId">
							<div class="form-group row">
								<label class="col-form-label modal-big-name">차량번호</label>
								<div class="input-group input-group-sm col middle-name form-group">	
									<input type="text" style="width: 100%;" id="carNum" name="carNum" pattern="^[가-힣ㄱ-ㅎㅏ-ㅣ\x20]{2}\d{2}[가-힣ㄱ-ㅎㅏ-ㅣ\x20]\d{4}$"
									data-pattern-error="차량번호를 확인해 주세요." maxlength="10" required>
									<div class="help-block with-errors" style="position: absolute;"></div>
								</div>
							</div>
							
							<div class="form-group row">
							<label class="col-form-label modal-big-name">차주성명</label>
								<div class="input-group input-group-sm col middle-name form-group">	
									<input type="text" name="driverName" id="driverName" name="driverName" class="form-control form-control-sm" required>
									<div class="help-block with-errors" style="position: absolute;"></div>
								</div>
							</div>
							
							<div class="form-group row">
							<label class="col-form-label modal-big-name">휴대전화</label>
								<div class="input-group input-group-sm col middle-name form-group">			
									<input type="text" name="driverTel" id="driverTel" name="driverTel" class="form-control form-control-sm" maxlength="13" required>
									<div class="help-block with-errors" style="position: absolute;"></div>
								</div>
							</div>
							
							<div class="editor_btns">
								<div class="padding">
							        <button type="submit" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i><strong>차량수정</strong></b></button>
							        <a onclick="viewLocationClose();" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
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
<script src="/js/validator.min.js"></script>
<script type="text/javascript">
var carNum;
var linkCarNum = parent.buyCarNum;
var linkLastDeptSeleted = parent.lastDeptSeleted;
$(document).ready(function(){
	carNum = MultiColumnComboBox.setCarNum("carNum", linkLastDeptSeleted, "");
	carNum.bind("select", carInfo);
	carNum.value(parent.document.getElementById('buyCarNum').value);
	$("#carNum").val(parent.document.getElementById('buyCarNum').value);
	$("#driverName").val(parent.document.getElementById('buyDriverName').value);
	$("#driverTel").val(parent.document.getElementById('buyDriverTel').value);
	$("#allocId").val(parent.document.getElementById('allocId').value);
	$("#orderId").val(parent.document.getElementById('orderId').value);
})

$('#linkDriverForm').validator().on('submit', function (e) {
	if (e.isDefaultPrevented()) {
		alert("항목을 입력해 주세요.")
	} else {
		e.preventDefault();
		if(!confirm('차주정보를 수정하시겠습니까?')){
			return false;
		}else{
			$("#driverTel").val($("#driverTel").val().replace(/\-/g, ""));
			$.ajax({
				url: "/contents/order/data/updateLinkDriver.do",
				type: "POST",
				dataType: "json",
				data: $("#linkDriverForm").serialize(),				
				success: function(data){
					if(data.result) {
						$("#buyDriverTel", parent.document).val(Util.formatPhone($("#driverTel").val()));
						$("#buyDriverName", parent.document).val($("#driverName").val());
						linkCarNum.value($("#carNum").val());
						alert(data.msg);
						viewLocationClose();
					} else {
						alert(data.msg);
					}
				}
			});
		}
	}
})

function carInfo(e){
	var dataItem = e.dataItem;
	if(dataItem != null) {
		$("#driverName").val(dataItem.driverName);
		$("#driverTel").val(Util.formatPhone(dataItem.mobile));
	}	
}

function viewLocationClose(){
	window.parent.$("#linkDriverView").data("kendoWindow").close();
}

$("#driverTel").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});
</script>