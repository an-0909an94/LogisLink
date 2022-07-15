<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header">
    <div class="summary p30">
        <div class="hdr-tit">
            <P class="headerTitle">일괄등록</P>
        </div>
    </div>
    <div class="contents">
        <div id="group-list" class="cont-wrapper-page-grid">
            <form id="f" name="f" method="post" enctype="multipart/form-data">
                <div class="form-group row">
                    <div class="col">
                        <div class="input-group input-group-sm" style="padding: 0px;">
                            <div style="width: 100%;" class="filebox">
                                <div class="option-area">
                                    <input style="width: 90%;" class="upload-name" value="파일을 선택해 주세요." disabled="disabled">
                                    <label for="uploadFile">파일등록</label>
                                    <input type="file" id="uploadFile" name="uploadFile" class="upload-hidden">
                                    <button style="padding: .25rem .5rem; font-size: .875rem; line-height: 1.5; border-radius: .2rem;" class="btn btn-outline-secondary" type="button" onclick="fileUpload();">업로드</button>
                                </div>
                            </div>
                        </div>
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
                                            <a href="javascript:sampleDownload();" class="k-pager-refresh k-button">
                                                <b class="btn-x"><i class="k-icon k-i-file-excel"></i>양식 다운로드</b>
                                            </a>
                                            <c:if test="${menuAuth.writeYn eq 'Y'}">
                                                <a href="javascript:insertData();" class="k-pager-refresh k-button">
                                                    <b class="btn-h"><i class="k-icon k-i-plus"></i>저장</b>
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /toolbar -->
                        <div id="grid" style="width: 100%; height: calc(100vh - 320px);"></div>
                        <!-- /table -->
                    </div>
                </div>
            </div>
            <!--  -->
        </div>
        <!-- group-list -->
    </div>
    <!--  -->
    <!-- content -->
</div>
<div id="popValidation"></div>
<script type="text/javascript">
	var validator = $("#grid").kendoValidator().data("kendoValidator");

	var carTypeData = Util.getComCode("CAR_TYPE_CD");
	var carTonData = Util.getComCode("CAR_TON_CD");
	var wayTypeData = Util.getComCode("WAY_TYPE_CD");
	var mixSizeData = Util.getComCode("MIX_SIZE_CD");
	// 22.07.06 이건욱 T1 > J5, J6 배차관리 기능개선
	var chargeTypeData = Util.getComCode("CHARGE_TYPE_CD");
	var inOutSctnData = Util.getComCode("IN_OUT_SCTN");
	var truckTypeData = Util.getComCode("TRUCK_TYPE_CD");
	var validationErrorData = new Array();

	// 22.07.07 이건욱 T1 > J6 배차관리 기능개선 (필수입력 항목 강조)
	var columns = [
			// 22.07.09 이건욱 T1 > J6 Row number 추가
			{
				field : "no",
				title : "번호",
				width : 50,
				editable : function(e) {
					return false;
				}
			},
			{
				field : "reqCustName",
				title : "화주거래처명",
				width : 120,
				headerTemplate : '<label class="requireHeader">화주거래처명</label>'
			},
			{
				field : "reqDeptName",
				title : "화주담당부서",
				width : 120,
				headerTemplate : '<label class="requireHeader">화주담당부서</label>'
			},
			{
				field : "sComName",
				title : "상차지명",
				width : 100,
				headerTemplate : '<label class="requireHeader">상차지명</label>'
			},
			{
				field : "sAddr",
				title : "상차지주소",
				width : 200,
				headerTemplate : '<label class="requireHeader">상차지주소</label>'
			},
			{
				field : "sAddrDetail",
				title : "상차지상세주소",
				width : 200
			},
			{
				field : "sDate",
				title : "상차일자",
				width : 100,
				template : function(dataItem) {
					var sDate = dataItem.sDate + "";
					return Util.formatDate(sDate);
				},
				headerTemplate : '<label class="requireHeader">상차일자</label>'
			},
			{
				field : "sTime",
				title : "상차시간",
				width : 100,
				template : function(dataItem) {
					var sTime = dataItem.sTime + "";
					return Util.formatTime(sTime);
				}
			},
			{
				field : "sStaff",
				title : "상차지담당자",
				width : 120
			},
			{
				field : "sTel",
				title : "상차지연락처",
				width : 120
			},
			{
				field : "sMemo",
				title : "상차지메모",
				width : 120
			},
			{
				field : "eComName",
				title : "하차지명",
				width : 100,
				headerTemplate : '<label class="requireHeader">하차지명</label>'
			},
			{
				field : "eAddr",
				title : "하차지주소",
				width : 200,
				headerTemplate : '<label class="requireHeader">하차지주소</label>'
			},
			{
				field : "eAddrDetail",
				title : "하차지상세주소",
				width : 200
			},
			{
				field : "eDate",
				title : "하차일자",
				width : 100,
				template : function(dataItem) {
					var eDate = dataItem.eDate + "";
					return Util.formatDate(eDate);
				},
				headerTemplate : '<label class="requireHeader">하차일자</label>'
			},
			{
				field : "eTime",
				title : "하차시간",
				width : 100,
				template : function(dataItem) {
					var eTime = dataItem.eTime + "";
					return Util.formatTime(eTime);
				}
			},
			{
				field : "eStaff",
				title : "하차지담당자",
				width : 120
			},
			{
				field : "eTel",
				title : "하차지연락처",
				width : 120
			},
			{
				field : "eMemo",
				title : "하차지메모",
				width : 120
			},
			{
				field : "inOutSctn",
				title : "수출입구분",
				width : 100,
				editor : function(container) {
					var input = $("<input id='inOutSctn' name='inOutSctn'>");
					input.appendTo(container);
					input.kendoDropDownList({
						dataTextField : "cname",
						dataValueField : "cname",
						autoBind : true,
						dataSource : inOutSctnData
					}).appendTo(container);
				},
				headerTemplate : '<label class="requireHeader">수출입구분</label>'
			},
			{
				field : "truckTypeName",
				title : "운송유형",
				width : 100,
				editor : function(container) {
					var input = $("<input id='truckTypeName' name='truckTypeName'>");
					input.appendTo(container);
					input.kendoDropDownList({
						dataTextField : "cname",
						dataValueField : "cname",
						autoBind : true,
						dataSource : truckTypeData
					}).appendTo(container);
				},
				headerTemplate : '<label class="requireHeader">운송유형</label>'
			},
			{
				field : "carTypeName",
				title : "요청차종",
				width : 100,
				editor : function(container) {
					var input = $("<input id='carTypeName' name='carTypeName'>");
					input.appendTo(container);
					input.kendoDropDownList({
						dataTextField : "cname",
						dataValueField : "cname",
						autoBind : true,
						dataSource : carTypeData
					}).appendTo(container);
				},
				headerTemplate : '<label class="requireHeader">요청차종</label>'
			},
			{
				field : "carTonName",
				title : "요청톤수",
				width : 100,
				editor : function(container) {
					var input = $("<input id='carTonName' name='carTonName' required>");
					input.appendTo(container);
					input.kendoDropDownList({
						dataTextField : "cname",
						dataValueField : "cname",
						autoBind : true,
						dataSource : carTonData
					}).appendTo(container);
				},
				headerTemplate : '<label class="requireHeader">요청톤수</label>'
			},
			{
				field : "goodsName",
				title : "화물정보",
				width : 100
			},
			{
				field : "goodsWeight",
				title : "중량",
				width : 100,
				headerTemplate : '<label class="requireHeader">중량</label>'
			},
			{
				field : "allocCharge",
				title : "청구운임",
				width : 100,
				template : function(dataItem) {
					var allocCharge = dataItem.allocCharge;
					return Util.formatNumber(allocCharge);
				},
				attributes : {
					style : "text-align: right"
				},
				headerTemplate : '<label class="requireHeader">청구운임</label>'
			},
			{
				field : "buyCharge",
				title : "지불운임",
				width : 100,
				template : function(dataItem) {
					var buyCharge = dataItem.buyCharge;
					return Util.formatNumber(buyCharge);
				},
				attributes : {
					style : "text-align: right"
				}
			},
			{
				field : "carNum",
				title : "차량번호",
				width : 120
			},
			{
				field : "driverName",
				title : "차주명",
				width : 100
			},
			{
				field : "driverTel",
				title : "차주연락처",
				width : 120
			},
			{
				field : "allocDate",
				title : "배차일시",
				width : 100,
				template : function(dataItem) {
					var allocDate = dataItem.allocDate + "";
					return Util.formatDate(allocDate);
				}
			},
			{
				field : "sWayName",
				title : "상차방법",
				width : 100,
				editor : function(container) {
					var input = $("<input id='sWayName' name='sWayName'>");
					input.appendTo(container);
					input.kendoDropDownList({
						dataTextField : "cname",
						dataValueField : "cname",
						autoBind : true,
						dataSource : wayTypeData
					}).appendTo(container);
				},
				headerTemplate : '<label class="requireHeader">상차방법</label>'
			},
			{
				field : "eWayName",
				title : "하차방법",
				width : 100,
				editor : function(container) {
					var input = $("<input id='eWayName' name='eWayName'>");
					input.appendTo(container);
					input.kendoDropDownList({
						dataTextField : "cname",
						dataValueField : "cname",
						autoBind : true,
						dataSource : wayTypeData
					}).appendTo(container);
				},
				headerTemplate : '<label class="requireHeader">하차방법</label>'
			},
			{
				field : "mixYn",
				title : "혼적",
				width : 70,
				template : "<input style='height: auto;width: auto;' type='checkbox' #=(mixYn=='Y') ? checked='checked' : '' # class='chkMixYn' />",
				editable : function(e) {
					return false;
				}
			},
			{
				field : "returnYn",
				title : "왕복",
				width : 70,
				template : "<input style='height: auto;width: auto;' type='checkbox' #=(returnYn=='Y') ? checked='checked' : '' # class='chkReturnYn' />",
				editable : function(e) {
					return false;
				}
			},
			// 22.07.06 이건욱 T1 > J5, J6 배차관리 기능개선 (운임구분 추가)
			{
				field : "chargeType",
				title : "운임구분",
				width : 100,
				editor : function(container) {
					var input = $("<input id='chargeType' name='chargeType'>");
					input.appendTo(container);
					input.kendoDropDownList({
						dataTextField : "cname",
						dataValueField : "cname",
						autoBind : true,
						dataSource : chargeTypeData
					}).appendTo(container);
				},
				headerTemplate : '<label class="requireHeader">운임구분</label>'
			} ];

	$(document).ready(
			function() {
				$("#grid").kendoGrid({
					columns : columns,
					//dataSource : dataSource,
					editable : true,
					noRecords : true,
					messages : {
						noRecords : "엑셀 데이터를 Import 해 주세요."
					}
				});

				var fileTarget = $('.filebox .upload-hidden');
				fileTarget.on('change', function() { // 값이 변경되면
					if (fileTarget.val() != "") {
						if (window.FileReader) { // modern browser 
							var filename = $(this)[0].files[0].name;
						} else { // old IE 
							var filename = $(this).val().split('/').pop()
									.split('\\').pop(); // 파일명만 추출 
						}
					} else {
						filename = "파일을 선택해 주세요."
					}

					// 추출한 파일명 삽입
					$(this).siblings('.upload-name').val(filename);
				});
			});

	function fileUpload() {
		if (!$("input[name=uploadFile]").val()) {
			alert("엑셀 파일을 업로드해주세요.");
			return;
		}

		$("#f")
				.ajaxForm(
						{
							url : "/cmm/excelUpload.do",
							contentType : false,
							dataType : "json",
							success : function(data) {
								getExcelData(data.uploadFile);
							},
							// 22.07.09 이건욱 파일 업로드시 최초 등록된 파일이 외부에서 변경됐을 경우 ERR_UPLOAD_FILE_CHANGED 에러에 대한 처리
							error : function(e) {
								alert("배차 엑셀파일을 업로드 할 수 없습니다.\n등록된 파일이 외부에서 변경 되었을 수 있습니다.\n해당 페이지를 새로고침 (F5)하고 다시 시도해주세요.");
							}
						});

		$("#f").submit();
	}

	// 22.07.08 이건욱 T1 > J5 배차일괄등록 편의성 개선
	function getExcelData() {
		var filename = arguments[0];

		$.ajax({
			url : "/cmm/excelToJson.do",
			type : "POST",
			dataType : "json",
			data : {
				fileName : filename,
				className : "orderBundle"
			},
			beforeSend : function(xmlHttpRequest) {
				xmlHttpRequest.setRequestHeader("AJAX", "true");
				$("#loading").show();
			},
			success : function(data) {
				// 22.07.08 이건욱 Excel to json 변환 실패 시 처리 내용 기술
				if (data.status == 0) {
					setGridData(data.data);
				} else {
					alert(data.message);
				}
			},
			complete : function() {
				$("#loading").hide();
			},
			error : function(request) {
				//alert("배차양식 엑셀 파일을 처리하는데 문제가 발생했습니다.\n올바른 배차양식 엑셀 파일을 업로드 해주세요.");
			}
		});
	}

	function setGridData(data) {
		var tmpData = [];
		// 22.07.13 이건욱 T1 > J5 배차일괄등록 편의성 개선 -> data 자체에 헤더가 빠져있으므로 0부터 순환
		if (data.length > 0) {
			for (var i = 0; i < data.length; i++) {
				tmpData[i] = {
					"reqCustName" : data[i][0],
					"reqDeptName" : data[i][1],
					"sComName" : data[i][2],
					"sAddr" : data[i][3],
					"sAddrDetail" : data[i][4],
					"sDate" : data[i][5],
					"sTime" : data[i][6],
					"sStaff" : data[i][7],
					"sTel" : data[i][8],
					"sMemo" : data[i][9],
					"eComName" : data[i][10],
					"eAddr" : data[i][11],
					"eAddrDetail" : data[i][12],
					"eDate" : data[i][13],
					"eTime" : data[i][14],
					"eStaff" : data[i][15],
					"eTel" : data[i][16],
					"eMemo" : data[i][17],
					"inOutSctn" : data[i][18],
					"truckTypeName" : data[i][19],
					"carTypeName" : data[i][20],
					"carTonName" : data[i][21],
					"goodsName" : data[i][22],
					"goodsWeight" : data[i][23],
					"allocCharge" : data[i][24],
					"buyCharge" : data[i][25],
					"carNum" : data[i][26],
					"driverName" : data[i][27],
					"driverTel" : data[i][28],
					"allocDate" : data[i][29],
					"sWayName" : data[i][30],
					"eWayName" : data[i][31],
					"mixYn" : data[i][32],
					"returnYn" : data[i][33],
					// 22.07.06 이건욱 T1 > J5, J6, J7 배차관리 기능개선
					"chargeType" : data[i][34],
					// 22.07.06 이건욱 T1 > J6 Row number 추가
					"no" : data[i][35]
				}
			}
		}

		var dataSource = new kendo.data.DataSource({
			data : tmpData,
			schema : {
				model : {
					fields : {
						reqCustName : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "거래처명을 입력해 주세요."
							}
						},
						reqDeptName : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "담당부서를 입력해 주세요."
							}
						},
						sComName : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "상차지명을 입력해 주세요."
							}
						},
						sAddr : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "상차지 주소를 입력해 주세요."
							}
						},
						sAddrDetail : {
							type : "string"
						},
						sDate : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "상차일시를 입력해 주세요."
							}
						},
						sTime : {
							type : "string"
						},
						sStaff : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "상차지 담당자를 입력해 주세요."
							}
						},
						sTel : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "상차지 연락처를 입력해 주세요."
							}
						},
						sMemo : {
							type : "string"
						},
						eComName : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "하차지명을 입력해 주세요."
							}
						},
						eAddr : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "하차지 주소를 입력해 주세요."
							}
						},
						eAddrDetail : {
							type : "string"
						},
						eDate : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "하차일시를 입력해 주세요."
							}
						},
						eTime : {
							type : "string"
						},
						eStaff : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "하차지 담당자를 입력해 주세요."
							}
						},
						eTel : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "하차지 연락처를 입력해 주세요."
							}
						},
						eMemo : {
							type : "string"
						},
						inOutSctn : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "수출입 구분을 입력해 주세요."
							}
						},
						truckTypeName : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "운송유형을 입력해 주세요."
							}
						},
						carTypeName : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "차종을 입력해 주세요."
							}
						},
						carTonName : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "톤수를 입력해 주세요."
							}
						},
						goodsName : {
							type : "string"
						},
						goodsWeight : {
							type : "number",
							validation : {
								required : true,
								validationMessage : "중량을 입력해 주세요."
							}
						},
						allocCharge : {
							type : "number",
							validation : {
								required : true,
								validationMessage : "운송료를 입력해 주세요."
							}
						},
						buyCharge : {
							type : "number"
						},
						carNum : {
							type : "string"
						},
						driverName : {
							type : "string"
						},
						driverTel : {
							type : "string"
						},
						sWayName : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "상차방법을 입력해 주세요."
							}
						},
						eWayName : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "하차방법을 입력해 주세요."
							}
						},
						mixYn : {
							type : "string"
						},
						returnYn : {
							type : "string"
						},
						// 22.07.06 이건욱 T1 > J5, J6 배차관리 기능개선
						chargeType : {
							type : "string",
							validation : {
								required : true,
								validationMessage : "운임구분을 입력해 주세요."
							}
						}
					}
				}
			}
		});

		var grid = $("#grid").data("kendoGrid");
		grid.setDataSource(dataSource);

		// grid 에서 checkbox 선택 시, Data setting
		$("#grid .k-grid-content").on("click", "input.chkMixYn", function(e) {
			var grid = $("#grid").data("kendoGrid");
			var checked = $(this).is(":checked");
			var col = $(this).closest("td");

			dataItem = grid.dataItem($(e.target).closest("tr"));
			dataItem.mixYn = checked ? "Y" : "N";
		});

		$("#grid .k-grid-content").on("click", "input.chkReturnYn",
				function(e) {
					var grid = $("#grid").data("kendoGrid");
					var checked = $(this).is(":checked");
					var col = $(this).closest("td");

					dataItem = grid.dataItem($(e.target).closest("tr"));
					dataItem.returnYn = checked ? "Y" : "N";
				});
	}

	// 22.07.09 이건욱 T1 > J5, J6 배차관리 기능개선
	function insertData() {
		// 기본 유효성 체크
		var validator = $("#grid").kendoValidator().data("kendoValidator");
		if (validator.validate()) {
			var grid = $("#grid").data("kendoGrid");
			var gridData = JSON.stringify(grid.dataSource._data);

			if (grid.dataSource._data.length > 0) {
				$.ajax({
					url : "/contents/order/data/orderBundleWrite.do",
					type : "POST",
					dataType : "json",
					data : {
						sender : "orderBundle",
						dataType : "json",
						data : gridData
					},
					beforeSend : function(xmlHttpRequest) {
						xmlHttpRequest.setRequestHeader("AJAX", "true");
						$("#loading").show();
					},
					success : function(data) {
						if (data.linkMessage.status == 0) {
							// 요청 성공시 내용 기술
							alert(data.linkMessage.message);
							location.reload();
						} else if (data.linkMessage.status == 1){
							// Validation 체크 실패 시 팝업 출력
							data.linkMessage.data.data
							alert(data.linkMessage.message);
							validationErrorData = data.linkMessage.data.data;
							popValidation();
						} else {
							// 기타 에러 출력
							alert(data.linkMessage.message);
						}
					},
					complete : function() {
						$("#loading").hide();
					}
				});
			} else {
				alert("올바른 배차 엑셀 파일을 업로드 해주세요.\n데이터가 없는 파일은 저장이 안됩니다.");
			}
		}
	}

	//공통코드 데이터 가져온다.
	function getComCode(gCode) {
		var item = [];
		$.ajax({
			url : "/cmm/codeList.do",
			type : "post",
			dataType : "json",
			data : "gCode=" + gCode,
			success : function(data) {
				item = data.data;
			}
		});

		return item;
	}

	function sampleDownload() {
		// 22.07.14 이건욱 T1 > J6 배차관리 기능개선 -> 양식파일 변경
		location.href = "/cmm/fileDownloadEtc.do?fileName=배차업로드양식파일_v3.0.xlsx";
	}

	/**
	 * 22.07.13 이건욱 T1 > J5, J6 배차관리 기능개선 -> Validation check error 레포트 뷰
	 */
	function popValidation() {
		var popup = $("#popValidation").data("kendoWindow");
		if (popup == null) {
			popup = $("#popValidation").kendoWindow({
				width : 1492,
				height : 623,
				content : {
					url : "/contents/order/popValidation.do"
				},
				iframe : true,
				visible : false
			}).data("kendoWindow");
		} else {
			// 이미 출력되어 있는 경우 새로고침
			popup.refresh({
				url : "/contents/order/popValidation.do"
			});
		}
		popup.center().open();
	}
</script>
<style>
.requireHeader {
	color: blue;
	display: inline;
	font-size: 14px !important;
}
</style>