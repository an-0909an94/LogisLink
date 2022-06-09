<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<div class="text-center" id="loading" style="display:none;">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>
<div class="oms_header">	
	<div class="summary p30">
		<div class="hdr-tit">
			<P class="headerTitle">일괄등록</P>
		</div>
	</div>
	<div id="group-list" class="cont-wrapper-page-grid">
		<div style="display: block;" class="form-group row oms_header_set">
			<form id="f" name="f" method="post" enctype="multipart/form-data">
			<div class="form-group row">
				<div class="col">
					<div class="input-group input-group-sm" style="padding:0px;">
						<div style="width: 100%;" class="filebox"> 
		        			<div class="option-area">
									<input style="width: 70%;" class="upload-name" value="파일을 선택해 주세요." disabled="disabled"> 
									<label for="uploadFile">파일등록</label> 
									<input type="file" id="uploadFile" name="uploadFile" class="upload-hidden"> 
									<button onclick="fileUpload();" type="button">업로드</button>
	                    		<c:if test="${menuAuth.writeYn eq 'Y'}">
									<button onclick="insertData();" type="button" class="btn-primary">등록</button>
								</c:if>
								<button onclick="sampleDownload();" type="button">양식 다운로드</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			</form>
		</div>
		<div class="cont-body">
			<div class="k-wrap content">
				<div class="lookup_table">
					<div id="grid" style="width:100%;"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
var validator = $("#grid").kendoValidator().data("kendoValidator");

var carTypeData = Util.getComCode("CAR_TYPE_CD");
var carTonData = Util.getComCode("CAR_TON_CD");
var wayTypeData = Util.getComCode("WAY_TYPE_CD");
var mixSizeData = Util.getComCode("MIX_SIZE_CD");
var itemCodeData = Util.getComCode("ITEM_CD");
var weightUnitCodeData = Util.getComCode("WGT_UNIT_CD");

var columns = [
	{ field: "buyCustName", title: "매입처", width: 150},
	{ field: "buyDeptName", title: "매입담당부서", width: 150},
	{ field: "sComName", title: "상차지명", width: 100},
	{ field: "sAddr", title: "상차지주소", width: 200},
	{ field: "sAddrDetail", title: "상차지상세주소", width: 200},
	{ field: "sDate", title: "상차일시", width: 100,
		template: function(dataItem) {
			var sDate = dataItem.sDate+"";
			return Util.formatDate(sDate);
		}	
	},
	{ field: "sTime", title: "상차시간", width: 100,
		template: function(dataItem) {
			var sTime = dataItem.sTime + "";
			return Util.formatTime(sTime);
		}	
	},
	{ field: "sStaff", title: "상차지담당자", width: 150},
	{ field: "sTel", title: "상차지연락처", width: 150,
		template: function(dataItem) {
			var sTel = dataItem.sTel;
			return Util.formatPhone(sTel);
		}	
	},
	{ field: "sMemo", title: "상차지메모", width: 100},
	{ field: "eComName", title: "하차지명", width: 100},
	{ field: "eAddr", title: "하차지주소", width: 200},
	{ field: "eAddrDetail", title: "하차지상세주소", width: 200},
	{ field: "eDate", title: "하차일시", width: 100,
		template: function(dataItem) {
			var eDate = dataItem.eDate+"";
			return Util.formatDate(eDate);
		}	
	},
	{ field: "eTime", title: "하차시간", width: 100,
		template: function(dataItem) {
			var eTime = dataItem.eTime + "";
			return Util.formatTime(eTime);
		}	
	},
	{ field: "eStaff", title: "하차지담당자", width: 150},
	{ field: "eTel", title: "하차지연락처", width: 150,
		template: function(dataItem) {
			var eTel = dataItem.eTel;
			return Util.formatPhone(eTel);
		}	
	},
	{ field: "eMemo", title: "하차지메모", width: 100},
	{ field: "inOutSctn", title: "수출입구분", width: 100},
	{ field: "truckTypeName", title: "운송유형", width: 100},
	{ field: "carTypeName", title: "차종", width: 100,
		editor: function(container) {
			var input = $("<input id='carTypeName' name='carTypeName'>");
			input.appendTo(container);
			input.kendoDropDownList({
				dataTextField: "cname",
				dataValueField: "cname",
				autoBind: true,
				dataSource: carTypeData
			}).appendTo(container);
		}	
	},
	{ field: "carTonName", title: "톤수", width: 100,
		template: "#=checkCodeName('carTon', carTonName)#",
		editor: function(container) {
			var input = $("<input id='carTonName' name='carTonName' required>");
			input.appendTo(container);
			input.kendoDropDownList({
				dataTextField: "cname",
				dataValueField: "cname",
				autoBind: true,
				dataSource: carTonData
			}).appendTo(container);			
		}	
	},
	{ field: "goodsName", title: "화물정보", width: 100},
	{ field: "itemCode", title: "운송품목", width: 100,
		editor: function(container) {
			var input = $("<input id='itemCode' name='itemCode' required>");
			input.appendTo(container);
			input.kendoDropDownList({
				dataTextField: "cname",
				dataValueField: "cname",
				autoBind: true,
				dataSource: itemCodeData
			}).appendTo(container);			
		}	
	},
	{ field: "goodsWeight", title: "중량", width: 100},
	{ field: "weightUnitCode", title: "중량단위", width: 100,
		editor: function(container) {
			var input = $("<input id='weightUnitCode' name='weightUnitCode' required>");
			input.appendTo(container);
			input.kendoDropDownList({
				dataTextField: "cname",
				dataValueField: "cname",
				autoBind: true,
				dataSource: weightUnitCodeData
			}).appendTo(container);			
		}	
	},
	{ field: "allocCharge", title: "운송료", width: 100,
		template: function(dataItem) {
			var allocCharge = dataItem.allocCharge;
			return Util.formatNumber(allocCharge);
		},
		attributes: { 
			style: "text-align: right" 
		}
	},
	{ field: "sWayName", title: "상차방법", width: 100,
		editor: function(container) {
			var input = $("<input id='sWayName' name='sWayName'>");
			input.appendTo(container);
			input.kendoDropDownList({
				dataTextField: "cname",
				dataValueField: "cname",
				autoBind: true,
				dataSource: wayTypeData
			}).appendTo(container);
		}	
	},
	{ field: "eWayName", title: "하차방법", width: 100,
		editor: function(container) {
			var input = $("<input id='eWayName' name='eWayName'>");
			input.appendTo(container);
			input.kendoDropDownList({
				dataTextField: "cname",
				dataValueField: "cname",
				autoBind: true,
				dataSource: wayTypeData
			}).appendTo(container);
		}	
	},
	{ field: "mixYn", title: "혼적", width: 70, 
		template: "<input type='checkbox' #=(mixYn=='Y') ? checked='checked' : '' # class='chkMixYn' />",
		editable: function(e) {return false;}
	},
	{ field: "mixSize", title: "혼적크기", width: 100,
		editor: function(container) {
			var input = $("<input id='mixSize' name='mixSize'>");
			input.appendTo(container);
			input.kendoDropDownList({
				dataTextField: "cname",
				dataValueField: "cname",
				autoBind: true,
				dataSource: mixSizeData
			}).appendTo(container);
		}	
	},
	{ field: "returnYn", title: "왕복", width: 70, 
		template: "<input type='checkbox' #=(returnYn=='Y') ? checked='checked' : '' # class='chkReturnYn' />",
		editable: function(e) {return false;}
	}
]

$(document).ready(function(){

	$("#grid").kendoGrid({
		columns : columns,
		//dataSource : dataSource,
		height: 706,
		editable: true,
	 	noRecords: true,
	  	messages: {
			noRecords: "엑셀 데이터를 Import 해 주세요."
	  	}
	});
	
	var fileTarget = $('.filebox .upload-hidden'); 
	fileTarget.on('change', function(){ // 값이 변경되면
		if(fileTarget.val() != ""){
			if(window.FileReader){ // modern browser 
				var filename = $(this)[0].files[0].name; 
			} else { // old IE 
				var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
			} 
		}else {
			filename = "파일을 선택해 주세요."
		}
		// 추출한 파일명 삽입
		$(this).siblings('.upload-name').val(filename); 
	});
});

function checkCodeName(item_name, code_name){
	var data;
	switch (item_name) {
	case "carType" :
		data = carTypeData;
		break;
	case "carTon" :
		data = carTonData;
		break;
	case "wayType" :
		data = wayTypeData;
		break;
	case "mixSize" :
		data = mixSizeData;
		break;
	case "itemCode" :
		data = itemCodeData;
		break;
	case "weightUnitCode" :
		data = weightUnitCodeData;
		break;
	}		
	for(var item, i=0; item=data[i]; i++) {
		if(code_name == item.cname) {
			return code_name;
		}
	}
	return "";
}

function fileUpload() {
	if(!$("input[name=uploadFile]").val()){
		alert("엑셀 파일을 업로드해주세요.");
		return;
	}
	
	$("#f").ajaxForm({
		url: "/cmm/excelUpload.do",
		contentType: false,
		dataType: "json",
		success: function(data) {
			getExcelData(data.uploadFile);
		}
	});
	
	$("#f").submit();
}

function getExcelData() {
	var filename = arguments[0];
	
	$.ajax({
		url: "/cmm/excelToJson.do",
		type: "POST",
		dataType: "json",
		data: "fileName=" + filename,
		beforeSend: function(xmlHttpRequest) {
			xmlHttpRequest.setRequestHeader("AJAX", "true");
			$("#loading").show();
		},
		success: function(data) {
			setGridData(data.data);
		},
		complete: function() {
			$("#loading").hide();
		}
	});
}

function setGridData(data) {
	var tmpData = [];
	if(data.length > 1) {
		for(var i=1; i<data.length; i++){
			tmpData[i-1] = {
			    "buyCustName"		: data[i][0]
			  , "buyDeptName"		: data[i][1]
			  , "sComName"			: data[i][2]
			  , "sAddr"				: data[i][3]
			  , "sAddrDetail"		: data[i][4]
			  , "sDate"				: data[i][5]
			  , "sTime"				: data[i][6]
			  , "sStaff"			: data[i][7]
			  , "sTel"				: data[i][8]
			  , "sMemo"				: data[i][9]
			  , "eComName"			: data[i][10]
			  , "eAddr"				: data[i][11]
			  , "eAddrDetail"		: data[i][12]
			  , "eDate"				: data[i][13]
			  , "eTime"				: data[i][14]
			  , "eStaff"			: data[i][15]
			  , "eTel"				: data[i][16]
			  , "eMemo"				: data[i][17]
			  , "inOutSctn"			: data[i][18]
			  , "truckTypeName"		: data[i][19]
			  , "carTypeName"		: data[i][20]
			  , "carTonName"		: data[i][21]
			  , "goodsName"			: data[i][22]
			  , "itemCode"			: data[i][23]
			  , "goodsWeight"		: data[i][24]
			  , "weightUnitCode"	: data[i][25]
			  , "allocCharge"		: data[i][26]
			  , "sWayName"			: data[i][27]
			  , "eWayName"			: data[i][28]
			  , "mixYn"				: data[i][29]
			  , "mixSize"			: data[i][30]
			  , "returnYn"			: data[i][31]
			}
		}
	} 

	var dataSource = new kendo.data.DataSource({
		data: tmpData,
		schema: {
			model: {
				fields: {
					buyCustName: {type:"string", validation: {required: true, validationMessage: "매입처를 입력해 주세요."}},
					buyDeptName: {type:"string", validation: {required: true, validationMessage: "매입담당부서를 입력해 주세요."}},
					sComName: {type:"string", validation: {required: true, validationMessage: "상차지명을 입력해 주세요."}},
					sAddr: {type:"string", validation: {required: true, validationMessage: "상차지주소를 입력해 주세요."}},
					sAddrDetail: {type:"string", validation: {required: true, validationMessage: "상차지상세주소를 입력해 주세요."}},
					sDate: {type:"string", validation: {required: true, validationMessage: "상차일시를 입력해 주세요."}},
					sTime: {type:"string", validation: {required: true, validationMessage: "상차시간를 입력해 주세요."}},
					sStaff: {type:"string", validation: {required: true, validationMessage: "상차지담당자를 입력해 주세요."}},
					sTel: {type:"string", validation: {required: true, validationMessage: "상차지연락처를 입력해 주세요."}},
					sMemo: {type:"string"},
					eComName: {type:"string", validation: {required: true, validationMessage: "하차지를 입력해 주세요."}},
					eAddr: {type:"string", validation: {required: true, validationMessage: "하차지주소를 입력해 주세요."}},
					eAddrDetail: {type:"string", validation: {required: true, validationMessage: "하차지상세주소를 입력해 주세요."}},
					eDate: {type:"string", validation: {required: true, validationMessage: "하차일시를 입력해 주세요."}},
					eTime: {type:"string", validation: {required: true, validationMessage: "하차시간를 입력해 주세요."}},
					eStaff: {type:"string", validation: {required: true, validationMessage: "하차지담당자를 입력해 주세요."}},
					eTel: {type:"string", validation: {required: true, validationMessage: "하차지연락처를 입력해 주세요."}},
					eMemo: {type:"string"},
					inOutSctn: {type:"string", validation: {required: true, validationMessage: "수출입구분을 입력해 주세요."}},
					truckTypeName: {type:"string", validation: {required: true, validationMessage: "운송유형을 입력해 주세요."}},
					carTypeName: {type:"string", validation: {required: true, validationMessage: "차종을 입력해 주세요."}},
					carTonName: {type:"string", validation: {required: true, validationMessage: "톤수를 입력해 주세요."}},
					goodsName: {type:"string"},
					itemCode: {type:"string", validation: {required: true, validationMessage: "운송품목을 입력해 주세요."}},
					goodsWeight: {type:"number", validation: {required: true, validationMessage: "중량을 입력해 주세요."}},
					weightUnitCode: {type:"string", validation: {required: true, validationMessage: "중량단위를 입력해 주세요."}},
					allocCharge: {type:"number", validation: {required: true, validationMessage: "운송료를 입력해 주세요."}},
					sWayName: {type:"string"},
					eWayName: {type:"string"},
					mixYn: {type:"string"},
					mixSize: {type:"string"},
					returnYn: {type:"string"}
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
		dataItem.mixYn= checked ? "Y" : "N";
	});

	$("#grid .k-grid-content").on("click", "input.chkReturnYn", function(e) {
		var grid = $("#grid").data("kendoGrid");
		var checked = $(this).is(":checked");
		var col = $(this).closest("td");
		
		dataItem = grid.dataItem($(e.target).closest("tr"));
		dataItem.returnYn = checked ? "Y" : "N";		
	});

}

function insertData(){
	if($(".k-grid-norecords-template").html() == "엑셀 데이터를 Import 해 주세요."){
		alert("엑셀 파일을 업로드 해 주세요.");
		return
	}else{
		var validator = $("#grid").kendoValidator().data("kendoValidator");
		if(validator.validate()) {
			var grid = $("#grid").data("kendoGrid");
			var gridData = JSON.stringify(grid.dataSource._data);
			
 			grid.columns.forEach(function (el, index){
				console.log(el);	
			});
			
			$.ajax({
				url: "/oms/order/data/orderBundleWrite.do",
				type: "POST",
				dataType: "json",
				data: "gridData=" + gridData,
				success: function(data) {
					if(data.result) {
						alert(data.msg);
						location.reload();	
					} else {
						alert(data.msg);
					}
				}
			});
		}
	}
		
}

//공통코드 데이터 가져온다.
function getComCode(gCode){
	var item = [];
	$.ajax({
		url: "/cmm/codeList.do",
		type: "post",
		dataType: "json",
		data: "gCode=" + gCode,
		success: function(data) {
			item = data.data;
		}
	});
	
	return item;
}


function sampleDownload(){
	location.href = "/cmm/fileDownloadEtc.do?fileName=화주용배차업로드양식파일.xlsx";
}
</script>