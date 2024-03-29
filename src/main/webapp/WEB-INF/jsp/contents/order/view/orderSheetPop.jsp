<%@ page language="java" contentType="text/html; charset=UTF-16" pageEncoding="UTF-16"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
.requireHeader {
    color: blue;
    display: inline;
    font-size: 14px !important;
}

.k-spreadsheet-action-bar {
    display: none !important;
}
</style>

<div class="pop-layer">
    <div class="editor_wrap pop-layer" id="layer1">
        <!-- wrap -->
        <div class="k-tabstrip-wrapper">
            <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
                tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
                <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                    aria-expanded="true" style="display: block;">
                    <div class="editor">
                        <div class="editor_btns" style="text-align:right;">
                            <div class="padding">
                                <a onclick="onSave()" class="k-pager-refresh k-button"><b class="btn-g"><i class="k-icon k-i-save"></i>저장</b></a>
                            </div>
                        </div>
                        <div id="spreadSheet" style="width: 100%;"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- wrap -->
    </div>
</div>

<script type="text/javascript" src="<c:url value='/js/kendo.spreadsheet.js'/>" ></script>

<script type="text/javascript">
    var loginCustId = "${sessionScope.userInfo.custId}";
	var loginDeptId = "${sessionScope.userInfo.deptId}";
	
	var headerCells = [
		{
			value: "거래처명",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "blue",
// 			validation: {
//                 dataType: "list",
//                 showButton: true,
//                 comparerType: "list",
//                 from: '"당착,익착,익일당착,익일익착"',
//                 type: "warning"
                
//                 from: "AND(LEN(A3)>3, LEN(A3)<200)",
//                 allowNulls: true,
//                 type: "reject",
//                 titleTemplate: "Full Name validation error",
//                 messageTemplate: "The full name should be longer than 3 letters and shorter than 200."
//             }
		},
    	{
			value: "상하차일",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "blue"
		},
    	
    	{
			value: "상차지명",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "black"
		},
    	{
			value: "상차지주소",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "blue"
		},
    	{
			value: "상차일",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "blue"
		},
    	{
			value: "상차시간",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "black"
		},
    	
    	{
			value: "하차지명",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "black"
		},
    	{
			value: "하차지주소",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "blue"
		},
    	{
			value: "하차일",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "blue"
		},
    	{
			value: "하차시간",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "black"
		},

    	{
			value: "청구구분",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "blue"
		},
    	{
			value: "요청차종",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "blue"
		},
    	{
			value: "요청톤수",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "blue"
		},
    	{
			value: "화물정보",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "blue"
		},
		{
			value: "청구금액",
			textAlign: "center",
			background: "rgb(160,160,160)",
			enable: false,
			bold: true,
			color: "blue"
		}
	];
	
	kendo.spreadsheet.registerEditor("autocomplete", function() {
		var context, model;
		return {
			edit: function(options) {
				context = options;
				
			}
		};
		
		function create() {
			model = kendo
		};
	});
	
// 	kendo.spreadsheet.Clipboard.prototype.parse = function() {
// 		console.log("clipseboard parse event");
// 	}

	$(document).ready(function() {
		
// 		kendo.culture("ko-KR");
// 		var culture = kendo.culture();
// 		console.log(culture.name);
		
		createSheet();
		
		$(window).bind("resize", function() {
			$("#spreadSheet").css("width", $(window).width() - 30);
			$("#spreadSheet").css("height", $(window).height() - 90);
			
	        $("#spreadSheet").data("kendoSpreadsheet").resize();
		});
	});
	
	function createSheet() {
		var spreadSheet = $("#spreadSheet").kendoSpreadsheet({
			columns: 14,
			rows: 100,
			toolbar: false,
			sheetsbar: false,
			
			// 이벤트
// 			changing: function(e) {
// 				console.log(e.changeType);
// 			},
// 			change: function(e) {
// 				console.log(e.range.value());
// 			},
// 			render: function(e) {
// 				console.log(e);
				
				
				
// 				if (e.sender._view.editor._active) {
// 					console.log(e.sender._view.editor._active);
// // 					console.log(e.sender._view.editor);
// // 					console.log(e.sender._view.editor._value = "이건욱");
// 					e.sender._view.editor._value = "이건욱";
// 					console.log(e.sender.element[0].innetText);
// 				}
// 					e.sender._view.editor._active = true;
				
// 				console.log(e.sender._view.editor._value);

// 				var activeSheet = e.sender.activeSheet();
// 				var selectCell = activeSheet.selection();
// 				console.log(selectCell.input());

				
// 			},
// 			select: function(e) {
// 				e.sender._view.editor.one("activate", function() {
// 			   		console.log("select edit mode");
// 				});
// 			},
// 			edit: function(e) {
// 				console.log("edting....");
// 			},
			sheets: [
				{
					dataSource: {
						
					},
					rows: [
						// 헤더 타이틀
						{
							height: 25,
							background: "rgb(160, 160, 160)",
							cells: headerCells
						}
					],
					columns: [
						{ width: 100 },
				        { width: 100 },
				        { width: 100 },
				        { width: 100 },
				        { width: 100 },
				        { width: 100 },
				        { width: 100 },
				        { width: 100 },
				        { width: 100 },
				        { width: 100 },
				        { width: 100 },
				        { width: 100 },
				        { width: 100 },
				        { width: 100 },
				        { width: 100 }
					]
				}
			]
		}).data("kendoSpreadsheet");
		
		var activeSheet = spreadSheet.activeSheet();
		
		// cell 포맷지정
// 		activeSheet.range("E2:E100").format(kendo.spreadsheet.formats.date);
		activeSheet.range("E2:E100").format("yyyy-mm-dd");
		activeSheet.range("F2:F100").format("hh:mm");
		activeSheet.range("I2:I100").format(kendo.spreadsheet.formats.date);
		activeSheet.range("J2:J100").format(kendo.spreadsheet.formats.time);
		activeSheet.range("O2:O100").format("#,#");
		
// 		activeSheet.range("A2:A100").editor("autocomplete");
		
		// cell 유효성체크 지정
// 		activeSheet.range("A2:A100").validation({
// 			dataType: "list",
//             showButton: true,
//             comparerType: "list",
//             from: '"당착,익착,익일당착,익일익착"',
//             type: "reject"
// 		});

		// 전체 폰트 사이즈 조정
		spreadSheet.options.defaultCellStyle.fontSize = 9;
		spreadSheet.options.defaultCellStyle.fontFamily = "";
		
		// 헤더 Row 고정
		activeSheet.frozenRows(1);
		
// 		activeSheet.bind("change", function(e) {
// 			console.log(e);

// 			var spreadSheet = $("#spreadSheet").data("kendoSpreadsheet");
// 			var cellElement = spreadSheet._view.editor.cellElement();
// 			console.log(cellElement);
// 			var barElement = spreadSheet._view.editor.barElement();
// 			console.log(barElement);

// 		});
		
// 		$("#spreadSheet .k-spreadsheet-formula-input").on("input", function (e) {
// 			console.log("k-spreadsheet-formula-input");
// 			console.log(this.innerText);
// 			if (this.innerText == null || this.innerText == "") {
// 				var spreadSheet = $("#spreadSheet").data("kendoSpreadsheet");
// 				spreadSheet._controller.activateEditor(true);
// 			}
// 		});
		
		
// 		$("#spreadSheet").on('keyup', function (e) {
// 			console.log("keydown");
			
// 			var spreadSheet = $("#spreadSheet").data("kendoSpreadsheet");
// 			spreadSheet._controller.activateEditor(true);
			
// 			console.log(spreadSheet._view.editor.isActive());
// 			if (e.keyCode == 229) {
// 				var spreadSheet = $("#spreadSheet").data("kendoSpreadsheet");
// 				spreadSheet._controller.activateEditor(true);
// 			}
// 		});

// 		$('#spreadSheet .k-spreadsheet-clipboard').on('keypress', function (e) {
// 			console.log("k-spreadsheet-clipboard(keypress)");
// 		});

    	$('#spreadSheet .k-spreadsheet-clipboard').on('keydown', function (e) {
//     		console.log("k-spreadsheet-clipboard(keydown)");
//     		console.log(spreadSheet._controller.clipBoardValue());
    		if (e.which == 229) {
    			console.log("에디트모드 진입!");
    			var spreadSheet = $("#spreadSheet").data("kendoSpreadsheet");
    			var activeSheet = spreadSheet.activeSheet();
    			
    			
//     			spreadSheet._controller.onEditorActivate();
//     			spreadSheet._controller.onEditorBarFocus();
//     			spreadSheet._controller.onEditorCellFocus();

// 				var test = spreadSheet._view.formulaInput;
// 				test._focus();

				var cellElement = spreadSheet._view.editor.cellElement();
				cellElement.css("display", "inline");
// 				console.log(cellElement.val());
// 				cellElement.focus();
				
				
// 				spreadSheet._view.editor.focus();
				
				
// 				var barElement = spreadSheet._view.editor.barElement();
// 				console.log(barElement);


// 				spreadSheet._view.selectClipboardContents();
    			
    			
    			
//     			spreadSheet._controller.activateEditor(true);
//     			spreadSheet._controller.onEditorUpdate();

// 				e.preventDefault();
    		}
    	});
    	
//     	$('#spreadSheet .k-spreadsheet-clipboard').on('input', function (e) {
//     		console.log("k-spreadsheet-clipboard(input)");
//     	});

//     	$('#spreadSheet .k-spreadsheet-clipboard').on('keyup', function (e) {
//     		console.log("k-spreadsheet-clipboard(keyup)");
//     	});
    	
//     	$('#spreadSheet .k-spreadsheet-cell-editor').on('keydown', function (e) {
//     		console.log("k-spreadsheet-cell-editor(keydown)");
    		
//     		var spreadSheet = $("#spreadSheet").data("kendoSpreadsheet");
//     		var cellElement = spreadSheet._view.editor.cellElement();
// 			console.log(cellElement);
//     	});
	}
	
	// 저장 Action
    function onSave() {
    	var activeSheet = $("#spreadSheet").data("kendoSpreadsheet").activeSheet();
    	
    	// 시트 값 입력
//     	activeSheet.range("F2").input("123123131321");
    	
    	// 셀렉트 셀
//     	var selectCell = activeSheet.selection();
    	
    	var activeSheet = $("#spreadSheet").data("kendoSpreadsheet").activeSheet();
		var selectCell = activeSheet.selection();
    	
    	// 전체 데이터 가져오기
    	var values = activeSheet.toJSON();
	}
	
	
</script>