<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!-- modal -->
<div id="divAddDept" class="editor-warp p-0">
	<div class="modalEditor" id="addDept">
		<div id="popGrid"></div>
		<div class="modalHeader">
			<div class="form-group row">
                <label class="col-form-label modal-big-name">부서명</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" id="deptName" name="deptName">
                </div>
            </div>
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <a onclick="modalSubmit()" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i>저장</b></a>
		        <a id="closeBtn" onclick="modalClose()" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
	        </div>
	    </div>
	</div>	
</div>
<div id="divDetailDept" class="editor-warp p-0">
	<div class="modalEditor" id="addDept">
		<div id="popGrid"></div>
		<div class="modalHeader">
			<input type="hidden" id="modalCustId" name="modalCustId">
			<input type="hidden" id="modalDeptId" name="modalDeptId">
			<div class="form-group row">
                <label class="col-form-label modal-big-name">부서명</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <input type="text" class="form-control form-control-sm" id="modalDeptName" name="modalDeptName" readonly>
                </div>
            </div>
			<div class="form-group row">
                <label class="col-form-label modal-big-name">사용여부</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <select class="form-control form-control-sm" id="modalUseYn" name="modalUseYn">
						<option value="Y">Y</option>
						<option value="N">N</option>
                    </select>
                </div>
            </div>
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <a onclick="detailModalSubmit()" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-check"></i>저장</b></a>
		        <a id="closeBtn" onclick="modalClose()" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
	        </div>
	    </div>
	</div>
</div>
<div id="divApiModal" class="editor-warp p-0">
	<div class="modalEditor" id="apiModal">		
		<div class="modalHeader">
			<div class="form-group row">
                <label class="col-form-label modal-big-name">API Key</label>
                <div class="input-group input-group-sm col middle-name form-group">
                    <textarea id="oapiToken" name="oapiToken" class="form-control form-control-sm" rows="3" readonly>
                    </textarea>
                </div>
            </div>
		</div>
		<div class="editor_btns">
			<div class="padding">
		        <a onclick="copyApiKey();" class="k-pager-refresh k-button"><b class="btn-b"><i class="k-icon k-i-copy"></i>복사</b></a>
		        <a id="closeBtn" onclick="apiModalClose()" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-cancel"></i>닫기</b></a>
	        </div>
	    </div>
	</div>
</div>
<div class="header">
	<div class="summary p30">
		<div class="hdr-tit">
			<P id="headerTitle">조직정보</P>
		</div>
	</div>
	<div class="contents">
		<div class="box">
        	<form id="f" data-toggle="validator" role="form">
                <input type="hidden" id="dlineDayCode" name="dlineDayCode">
                <input type="hidden" id="dlinePointCode" name="dlinePointCode">
				<div id="group-list" class="cont-wrapper">
					<!--  -->
						<div class="cont-b-head">
							<h4>회사정보</h4>
						</div>
						<div class="form-group row">
							<div class="input-group input-group-sm col-3 middle-name form-group">
							<strong class="required">상호</strong>
							    <input type="text" id="bizName" required>
                                <div class="help-block with-errors"></div>
							</div>
							<div class="input-group input-group-sm col-3 middle-name form-group">
							<strong>업태</strong>
							    <input type="text" id="bizCond">
							</div>
						</div>
						
						<div class="form-group row">
							<div class="input-group input-group-sm col-3 middle-name form-group">
							<strong class="required">분류</strong>
							    <select id="custTypeCode" style="font-size: initial;" required></select> 
                                <div class="help-block with-errors"></div>
							</div>
							<div class="input-group input-group-sm col-3 middle-name form-group">
							<strong>업종</strong>
							    <input type="text" id="bizKind">
							</div>
							<div class="input-group input-group-sm col-3 middle-name form-group">
							<strong class="required">과세유형</strong>
							    <select id="bizTypeCode" style="font-size: initial;" required></select> 
                                <div class="help-block with-errors"></div>
							</div>
						</div>
						
						<div class="form-group row">
							<div class="input-group input-group-sm col-3 middle-name form-group">
							<strong class="required">사업자번호</strong>
							    <input type="text" id="bizNum" maxlength="12" required>
                                <div class="help-block with-errors"></div>
							</div>
							<div class="input-group input-group-sm col-3 middle-name form-group">
							<strong>종사업장번호</strong>
							    <input type="text" id="bizNumSub">
							</div>
							<div class="input-group input-group-sm col-3 middle-name form-group">
							<strong class="required">대표자명</strong>
							    <input type="text" id="ceo" required>
                                <div class="help-block with-errors"></div>
							</div>
						</div>
						
						<div class="form-group row">
							<div class="input-group input-group-sm col-3 middle-name form-group">
							<strong>우편번호(검색)</strong>
							    <div class="textBox-in-icon">
                                	<input style="border-radius: 0px 8px 8px 0px;" onClick="popSearchPost('');" type="text" class="form-control form-control-sm" id="bizPost">
									<i><img style="width: 40px;margin-left: -49px;" onclick="popSearchPost('');" src="/images/icon/search.png"></i>
								</div>
							</div>
							<div class="input-group input-group-sm col-3 middle-name form-group">
							<strong>주소</strong>
							    <input type="text" id="bizAddr">
							</div>
							<div class="input-group input-group-sm col-3 middle-name form-group">
							<strong>상세주소</strong>
							    <input type="text" id="bizAddrDetail">
							</div>
						</div>
						
						<div class="form-group row">
							<div class="input-group input-group-sm col-3 middle-name form-group">
                            <strong>은행명</strong>
                                <select id="bankCode"></select>
                            </div>
                            <div class="input-group input-group-sm col-3 middle-name form-group">
                            <strong>예금주</strong>
                                <input type="text" id="bankCnnm">
                            </div>
                            <div class="input-group input-group-sm col-3 middle-name form-group">
                            <strong>계좌번호</strong>
                                <input type="text" id="bankAccount">
                            </div>
						</div>
						
						<div class="form-group row">
							<div class="input-group input-group-sm col-3 middle-name form-group">
							</div>
							<div style="margin-top: -10px" class="input-group input-group-sm col-4 middle-name form-group">
								<span class="button add_btn">
								<c:if test="${custId eq 'newComp' && menuAuth.writeYn eq 'Y'}">
									<button type="submit" id="btnUpdateComp">저장</button>
								</c:if>		
								<c:if test="${custId ne 'newComp' && menuAuth.editYn eq 'Y'}">
									<button type="submit" id="btnUpdateComp">정보수정</button>
									<button type="button" id="btnAddDept">부서추가</button>
									<c:if test="${sessionScope.userInfo.authSeq eq '100' }">
										<button type="button" id="btnCreateApiKey" onClick="createToken();">API키발급</button>
										<button type="button" id="btnViewApiKey" onClick="oepnApiKey();" style="display:none;">API키확인</button>
									</c:if>	
								</c:if>	
								</span>
							</div>
						</div>
						
						<div class="k-wrap content">
							<div class="lookup_table">
								<div class="tool_btn col-auto">
									<!-- toolbar -->
									<div class="toolbar row">
										<div class="tool_form col">
											<div class="row">
												<div style="height:calc(100vh - 709px)" id="comp_list"></div>
											</div>
										</div>
									</div><!-- /toolbar -->
									<div id="compList"></div>
								</div>
							</div>
						</div>
					<!-- group-list -->
				</div>
				<!--  -->
			</form>
		</div>
		<!-- content -->
	</div>
</div>
<!-- wrap -->

<script type="text/javascript">
$(document).ready(function(){
	Util.setCmmCode("select", "custTypeCode", "CUST_TYPE_CD", "01", "선택");
	Util.setCmmCode("select", "bizTypeCode", "BIZ_TYPE_CD", "", "선택하세요");
    Util.setCmmCode("select", "bankCode", "BANK_CD", "", "선택하세요");

 	$.ajax({
		url: "/contents/basic/data/compList.do?custId="+'${custId}',
		type: "POST",
		dataType: "json",
		data: "",
		success: function(data){
			if(data.result) {
				Util.setPageData(data.data);
				if('${custId}' == 'newComp') {
					$("#btnUpdateComp").text('조직 추가');
					Util.setReadOnlyDisable(["bizNum"]);
				} else {
					Util.setReadOnlyEnable(["bizNum"]);
					
					if("${sessionScope.userInfo.authSeq}" == "100") {
						if(data.data.oapiYn == "Y") {
							$("#btnViewApiKey").show();
							$("#btnCreateApiKey").hide();
						} else {
							$("#btnCreateApiKey").show();
							$("#btnViewApiKey").hide();
						}
					}
				}
			}
		}
	});
 	goList();
});

var columns = [
	{ field: "number", title: "No", width: 50 },
	{ field: "deptName", title: "부서명", width: 100 },
	{ field: "useYn", title: "사용여부", width: 100 },  
];

var oGrid = null;	
oGrid = new gridData("comp_list");
oGrid.initGrid();
oGrid.setSendUrl("/contents/basic/data/compDeptList.do?custId="+'${custId}');
oGrid.setExcelFile("부서관리.xlsx");
oGrid.setPageable(false);
oGrid.setSelectable(true);

function goList() {
	var grid = $("#comp_list").data("kendoGrid");
	
	oGrid.setSearchData($("#f").serializeObject());
	if(grid == null) {
		oGrid.setGrid(columns);
		grid = $("#comp_list").data("kendoGrid");
	} else {
		grid.setDataSource(oGrid.gridOption.dataSource);
	}
	
	grid.tbody.delegate('tr', 'dblclick', function(){
		var dataItem = grid.dataItem($(this));
		$("#modalDeptName").val(dataItem.deptName);
		$("#modalUseYn").val(dataItem.useYn);
		$("#modalCustId").val(dataItem.custId);
		$("#modalDeptId").val(dataItem.deptId);
		modal.data("kendoDialog").close();
		detailModal.data("kendoDialog").open();
	});
}

$('#bizNum').on('input', function() {
	var bizNum = $(this).val().replace(/[^\d]/g, '');
	var temp = bizNum.replace(/(\d{3})(\d{1,2})(\d{1,5})/, '$1-$2-$3');
	$(this).val(temp);
});

$('#f').validator().on('submit', function (e) {
	var param = {
			custId : '${custId}',
			bizName: $("#bizName").val(),
			custTypeCode: $("#custTypeCode").val(),
			bizNum: $("#bizNum").val().replace(/\-/g, ''),
			bizNumSub: $("#bizNumSub").val(),
			ceo: $("#ceo").val(),
			bizCond: $("#bizCond").val(),
			bizKind: $("#bizKind").val(),
			bizAddr: $("#bizAddr").val(),
			bizPost: $("#bizPost").val(),
			bizAddrDetail: $("#bizAddrDetail").val(),
			bizTypeCode: $("#bizTypeCode").val(),
			bankCode : $("#bankCode").val(),
			bankCnnm : $("#bankCnnm").val(),
			bankAccount : $("#bankAccount").val()
		};
	
	//console.log(param)
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
			url: "/contents/basic/data/compUpdate.do",
			type: "POST",
			dataType: "json",
			data: param,
			success: function(data){
				if (data.result) {
					alert(data.msg);
					if(data.data) {
						if('${custId}' == 'newComp') {
							location.href = "/contents/basic/compList.do?custId="+data.data.custId;	
						} else {
							location.reload();	
						}
					}
				} else {
					alert(data.msg);
				}
			}
		});
	}
});

function modalClose(){
	$("#deptName").val("");
	modal.data("kendoDialog").close();
	detailModal.data("kendoDialog").close();
}


function apiModalClose(){
	apiModal.data("kendoDialog").close();
}

function modalSubmit(){
	if($("#deptName").val() == '') {
		alert('부서명을 입력해주세요.');
		return;
	}
	var param = {
			custId : '${custId}',
			deptName: $("#deptName").val()
		};
	
	$.ajax({
		url: "/contents/basic/data/compDeptInsert.do",
		type: "POST",
		dataType: "json",
		data: param,
		success: function(data){
			if (data.result) {
				alert(data.msg);
				goList();
				if('${custId}' == 'newComp') {
					location.href = "/contents/basic/compList.do?custId="+data.data.custId;	
				} else {
					location.reload();	
				}
			} else {
				alert(data.msg);
			}
			$("#deptName").val("");
			modal.data("kendoDialog").close();
		}
	});
}

function detailModalSubmit(){
	var param = {
			custId : $("#modalCustId").val(),
			deptId : $("#modalDeptId").val(),
			useYn : $("#modalUseYn").val()
	};
	
	$.ajax({
		url: "/contents/basic/data/deptUpdate.do",
		type: "POST",
		dataType: "json",
		data: param,
		success: function(data){
			if (data.result) {
				alert(data.msg);
				goList();
				detailModal.data("kendoDialog").close();
			} else {
				alert(data.msg);
			}
		}
	});
}

//부서추가 modal
modal = $("#divAddDept");
modalButton = $("#btnAddDept");

modalButton.click(function() {
	var custId = '${custId}';
	
	if(custId == 'newComp') {
		alert('조직을 먼저 추가해 주세요.');
		return;
	}
	detailModal.data("kendoDialog").close();
	modal.data("kendoDialog").open();
});

detailModal = $("#divDetailDept");

detailModal.kendoDialog({
	width: "446px",
	height: "280px",
	visible: false,
	title: "부서수정",
	closable: true,
	modal: false,
	close: function(){modalButton.fadeIn();}
})

modal.kendoDialog({
	width: "446px",
	height: "225px",
	visible: false,
	title: "부서추가",
	closable: true,
	modal: false,
	close: function(){modalButton.fadeIn();}
});

apiModal = $("#divApiModal");

apiModal.kendoDialog({
	width: "446px",
	height: "235px",
	visible: false,
	title: "API KEY 확인",
	closable: true,
	modal: false,
	close: function(){}
});

function oepnApiKey(){

	apiModal.data("kendoDialog").open();
}

function popSearchPost(){
	Util.popSearchPost();
}

function setSearchAddressInfo(data) {
	$("#bizPost").val(data.zipNo);
    $("#bizAddr").val(data.roadAddr);
    $("#bizAddrDetail").focus();
}

function createToken() {
	if(!confirm("API 키발급을 하시겠습니까?")) {
		return;
	}	
	
	var param = {
		custId: "${custId}",
		custTypeCode: $("#custTypeCode").val()
	};
	alert($("#custTypeCode").val());
	$.ajax({
		url: "/contents/basic/data/createToken.do",
		type: "POST",
		dataType: "json",
		data: param,
		success: function(data){
			if (data.result) {
				alert(data.msg);				
			} else {
				alert(data.msg);
			}
		}
	});
}

function copyApiKey() {
	document.getElementById("oapiToken").select();
	document.execCommand('copy');
	
}
</script>