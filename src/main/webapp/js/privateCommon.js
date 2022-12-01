var CHANGED_GRID_INFO = false;
var SHOW_YN = false;

function toCamelCase(str) {
	return str.toLowerCase().replace(/[^a-zA-Z0-9]+(.)/g, (m, chr) => chr.toUpperCase());
}

function getKeyValue(source, inKey) {
	var outValue = "";
	var arr = source.split(";");
	$.each(arr, function(idx, node) {
		var key = node.split(":")[0];
		var value = $.trim(node.split(":")[1]);
		if(key == "font-size") {
			value = value.replace("px", "");
		}
		if(inKey == toCamelCase(key)) {
			outValue = value;
		}
	});
	
	return outValue;
}

// 컬럼 위치 변경 시 이벤트 캐치
function onReorderEnd(e) {
	// 개인화 설정이 적용되지 않는 컬럼은 컬럼 위치 변경 불가
	if (typeof nonPrivateColumnCheck != 'undefined' && nonPrivateColumnCheck != null && e.column == nonPrivateColumnCheck) {
		var grid = e.sender;
	    setTimeout(function (e) {
	        grid.reorderColumn(0, nonPrivateColumnCheck);
	        return;
	    }, 1);
	} else {
		// 개인화 설정이 적용되지 않는 컬럼 외 다른 컬럼이 Index:0 변경 불가
		if (e.newIndex == 0) {
			// 개인화 설정이 적용되지 않는 컬럼이 존재하는 페이지의 경우만 해당
			if (typeof nonPrivateColumnCheck != 'undefined' && nonPrivateColumnCheck != null) {
				var grid = e.sender;
				var oldIndex = e.oldIndex;
				var column = e.column;
			    setTimeout(function (e) {
			        grid.reorderColumn(oldIndex, column);
			        return;
			    }, 1);
			}
		}
	}
	
	var gridId = $(this)[0].wrapper[0].id;
    var orgColInfo = $("#" + gridId).data("kendoGrid").columns;
    CHANGED_GRID_INFO = true;
}

// 컬럼 사이즈 변경 시 이벤트 캐치
function onResizeEnd(e) {
	// 개인화 설정이 적용되지 않는 컬럼은 컬럼 사이즈 변경 불가
	if (typeof nonPrivateColumnCheck != 'undefined' && nonPrivateColumnCheck != null && e.column == nonPrivateColumnCheck) {
		var grid = e.sender;
		var defaultWidth = e.oldWidth
		setTimeout(function (e) {
			grid.resizeColumn(nonPrivateColumnCheck, defaultWidth);
	        return;
	    }, 1);
	}
	
	var gridId = $(this)[0].wrapper[0].id;
	var orgColInfo = $("#" + gridId).data("kendoGrid").columns;
    CHANGED_GRID_INFO = true;
}

/*
 * 개인화 컬럼 정보 데이터 조회 및 세팅
 * 메뉴코드, 그리드아이디, 접속사용자아이디, 기존 컬럼정보 전달
 * 브라우저 세션스토리지를 통해 현재 접속한 메뉴의 리스트 조회 후 로컬 저장 -> 반복되는 조회를 방지
 */
function setPrivateData(inPageId, inGridId, inUserId, inOrgColInfo) {
	
	var param = {
			pageId: inPageId, // 페이지 번호 (키)
			gridId: inGridId,  // 그리드 아이디 (키)
			userId: inUserId
	};
	
	// 접속 화면 그리드의 옵션 사용여부를 조회 
	var tblInfo = null;
	$.ajax({
		url: "/cmm/getPrivateTblList.do",
		type: "POST",
		dataType: "json",
		data: param,
		async: false,
		success: function(data){
			if(data.result == true) {
				tblInfo = data.tblInfo;
			}
		}
	});
	
	// 기존 컬럼 정보를 리턴하는 경우
	if(tblInfo.length == 0) { // 개인화 마스터설정 정보가 없는 경우 
		$(".privateRClick").hide();
		return inOrgColInfo;
	} else {
		if(tblInfo[0].USE_YN != "Y") { // 개인화 마스터설정 정보는 있으나 사용여부가 N일 경우 
			$(".privateRClick").hide();
			return inOrgColInfo;
		}
	}
	
//	sessionStorage.clear();
	var stoId = inUserId + "_" + inPageId;
	var stoLength = sessionStorage.length;
	for(var i = 0; i < stoLength; i++) {
		if(sessionStorage.key(i) != stoId) {
			sessionStorage.removeItem(sessionStorage.key(i));
		}
	}
	var colList = JSON.parse(sessionStorage.getItem(stoId));
	
	if(colList == null) {
		
		$.ajax({
			url: "/cmm/getPrivateColList.do",
			type: "POST",
			dataType: "json",
			data: param,
			async: false,
			success: function(data){
				if(data.result == true) {
					// 20220720 개인화 컬럼 정보 테이블에 현재 접속한 유저의 정보가 있는지 체크 
					if(data.colInfo.length == 0) {
						// 없는 경우 마스터 정보의 컬럼 정보를 가져와서 디폴트 초기화  
						$.ajax({
							url: "/cmm/savePrivateColReset.do",
							type: "POST",
							dataType: "json",
							data: param,
							async: false,
							success: function(data){
								if(data.result) {
									CHANGED_GRID_INFO = false;
									sessionStorage.clear();
									sessionStorage.setItem(stoId, JSON.stringify(data.colInfo));
									colList = data.colInfo;
								} else {
									alert("오류가 발생했습니다. 관리자에게 문의하세요.");
									return;
								}
							}
						});
					} else {
						sessionStorage.setItem(stoId, JSON.stringify(data.colInfo));
						colList = data.colInfo;
					}
				}
			}
		});
	}
	
	$.each(colList, function(idx, node) {
		if(node.FIELD_USE_YN == "Y") {
			node["field"] = node.COL_ID;
		}
		node["title"] = node.COL_NAME;
		node["orgField"] = node.COL_ID;
		node["width"] = node.COL_WIDTH;
		node["idx"] = node.COL_IDX;
		node["hidden"] = (node.SHOW_YN == "N" ? true : false);
		node["sticky"] = (node.FIX_YN == "Y" ? true : false); // locked (틀고정) 옵션 대신 사용 
		node["stickable"] = true;
		var styleText = "";
		styleText += "text-align: " + (node.TEXT_ALIGN == "1" ? "center" : (node.TEXT_ALIGN == "2" ? "left" : "right")) + ";";
		styleText += "font-size: " + node.FONT_SIZE + "px;";
		styleText += "color: " + node.COLOR + ";";
		styleText += "font-weight: " + node.FONT_WEIGHT + ";";
		styleText += "font-style: " + node.FONT_STYLE + ";";
		node["attributes"] = {
			"style": styleText
		};
		
		$.each(inOrgColInfo, function(subIdx, subNode) {
			if(node.COL_ID == subNode.field || node.COL_NAME == subNode.title) {
				if(node.FIELD_USE_YN == "Y") {
					node["field"] = node.COL_ID;
				}
				node["template"] = subNode.template;
				// 추가
				node["headerTemplate"] = subNode.headerTemplate;
				if (subNode.editable != null)
					node["editable"] = subNode.editable;
			}
		});
	});
	
	colList.sort(function(a, b) {
		if(a.idx > b.idx) {
			return 1;
		} 
		if(a.idx < b.idx) {
			return -1;
		} 
	});
	
	return colList.length == 0 ? inOrgColInfo : colList;
}

/*
 * 개인화 컬럼 정보 데이터 리스트 일괄 저장
 * 메뉴코드, 그리드아이디, 접속사용자아이디 전달
 */
function setPrivateSaveData(inPageId, inGridId, inUserId) {
	var stoId = inUserId + "_" + inPageId;
	if(!CHANGED_GRID_INFO) {
		alert("변경된 정보가 없습니다."); 
		return;
	}
	
	var orgColInfo = $("#" + inGridId).data("kendoGrid").columns;
    
    var saveList = [];
    var pos = 0;
    $.each(orgColInfo, function(idx, node) {
    	saveList.push({});
    	saveList[idx]["userId"] = inUserId;
    	saveList[idx]["menuCode"] = inPageId;
    	saveList[idx]["gridId"] = inGridId;
		saveList[idx]["colId"] = node["orgField"];
    	saveList[idx]["colName"] = node["title"];
    	saveList[idx]["colIdx"] = (idx + 1);
    	saveList[idx]["fixYn"] = node["sticky"] ? "Y" : "N";
    	saveList[idx]["showYn"] = node["hidden"] ? "N" : "Y";
    	saveList[idx]["colWidth"] = node["width"];
    	var str = node["attributes"]["style"];
    	var align = getKeyValue(str, "textAlign");
    	saveList[idx]["textAlign"] = align == "center" ? 1 : align == "left" ? 2 : 3;
    	saveList[idx]["fontSize"] = getKeyValue(str, "fontSize");
    	saveList[idx]["color"] = getKeyValue(str, "color");
    	saveList[idx]["fontWeight"] = getKeyValue(str, "fontWeight");
    	saveList[idx]["fontStyle"] = getKeyValue(str, "fontStyle");
    });
    
    // 리스트 저장 (업데이트)
    $("#privateSaveDataHidden").val(JSON.stringify(saveList));
    $.ajax({
		url: "/cmm/savePrivateColList.do",
		type: "POST",
		dataType: "json",
		data: $("#privateForm").serialize(),
		async: false,
		success: function(data){
			if(data.result) {
				alert("변경 정보가 저장되었습니다.");
				CHANGED_GRID_INFO = false;
				sessionStorage.clear();
				sessionStorage.setItem(stoId, JSON.stringify(data.colInfo));
			} else {
				alert("오류가 발생했습니다. 관리자에게 문의하세요.");
				return;
			}
		}
	});
}

/*
 * 개인화 옵션 활성화 여부 처리 
 */
function setOptionActive(inPageId, inGridId, inUserId) {
	var param = {
			pageId: inPageId, // 페이지 번호 (키)
			gridId: inGridId,  // 그리드 아이디 (키)
			userId: inUserId
	};
	
	// 접속 화면 그리드의 옵션 사용여부를 조회 
	var tblInfo = null;
	$.ajax({
		url: "/cmm/getPrivateTblList.do",
		type: "POST",
		dataType: "json",
		data: param,
		async: false,
		success: function(data){
			if(data.result && data["tblInfo"].length > 0) {
				tblInfo = data.tblInfo[0];
			}
		}
	});
	
	if(tblInfo != null) {
		var grid = $("#" + inGridId).data("kendoGrid");
		
		var options = grid.getOptions();
		options["reorderable"] = tblInfo["MOVE_USE_YN"] == "Y" ? true : false;
		if(tblInfo["MOVE_USE_YN"] == "Y") {
			options["columnReorder"] = onReorderEnd; // 컬럼 위치 변경 이벤트
		}
		options["resizable"] = tblInfo["WIDTH_USE_YN"] == "Y" ? true : false;
		if(tblInfo["WIDTH_USE_YN"] == "Y") {
			options["columnResize"] = onResizeEnd; // 컬럼 사이즈 변경 이벤트
		}
		if(tblInfo["MULTI_SORT_USE_YN"] == "Y") {
			options["sortable"] = {
			    mode: "multiple",
			    allowUnsort: true,
			    showIndexes: true
			};
		}
		
		var pagingCnt = 50;
		// 사용자 페이징 설정 카운트 조회 후 세팅
		if(tblInfo["PAGING_USE_YN"] == "Y") {
			options["pageable"] = {
					pageSize: pagingCnt,
					pageSizes: true
			};
			$.ajax({
				url: "/cmm/getPrivateTblCnt.do",
				type: "POST",
				dataType: "json",
				data: param,
				async: false,
				success: function(data){
					if(data.result && data["tblInfo"].length > 0) {
						options["pageable"]["pageSize"] = data.tblInfo[0]["PAGING_CNT"];
						pagingCnt = data.tblInfo[0]["PAGING_CNT"];
						options["pageable"]["pageSizes"] = [10, 20, 30, 40, 50];
						var dataSource = grid.dataSource;
						dataSource.options.pageSize = pagingCnt;
						dataSource._take = pagingCnt;
						grid.setDataSource(dataSource);
						
						grid.one("dataBound", function(e){
					        var grid = e.sender;
					        var pageSizesDdl = $(grid.pager.element).find("[data-role='dropdownlist']").data("kendoDropDownList");
					        pageSizesDdl.bind("change", function(ev){
					        	var value = ev.sender.value();
					        	param.pagingCnt = value;
					        	$.ajax({
									url: "/cmm/savePrivateTblCnt.do",
									type: "POST",
									dataType: "json",
									data: param,
									async: false,
									success: function(data){
										if(data.result) {
											// alert("페이징 설정 카운트가 저장되었습니다.");
										} else {
											alert("오류가 발생했습니다. 관리자에게 문의하세요.");
											return;
										}
									}
								});
					        });
					    });
					}
				}
			});
		}
		
	    grid.setOptions(options);
	}
}

/*
 * 개인화 컬럼 정보 설정 레이어 팝업 호출
 * 메뉴코드, 그리드아이디, 접속사용자아이디 전달
 */
function setPrivatePanel(inPageId, inGridId, inUserId) {
	
	var param = {
			pageId: inPageId, // 페이지 번호 (키)
			gridId: inGridId,  // 그리드 아이디 (키)
			userId: inUserId
	};
	
	// 접속 화면 그리드의 옵션 사용여부를 조회 
	var tblInfo = null;
	$.ajax({
		url: "/cmm/getPrivateTblList.do",
		type: "POST",
		dataType: "json",
		data: param,
		async: false,
		success: function(data){
			if(data.result == true) {
				tblInfo = data.tblInfo[0];
			}
		}
	});
	
	var stoId = inUserId + "_" + inPageId;
	var grid = $("#" + inGridId).data("kendoGrid");
	var colInfo = $("#" + inGridId).data("kendoGrid").columns;
	
	var headerHtml = "";
	headerHtml += "<tr>";
	if(tblInfo.MOVE_USE_YN == "Y") {
		headerHtml += "<th style='width: 5%'>&nbsp;</th>";
	}
	if(tblInfo.SHOW_USE_YN == "Y") {
		headerHtml += "<th style='width: 5%'>노출</th>";
	}
	headerHtml += "<th style='width: 15%'>항목명</th>";
	if(tblInfo.FIX_USE_YN == "Y") {
		headerHtml += "<th style='width: 5%'>고정</th>";
	}
	if(tblInfo.WIDTH_USE_YN == "Y") {
		headerHtml += "<th style='width: 10%'>넓이</th>";
	}
	if(tblInfo.SORT_USE_YN == "Y") {
		headerHtml += "<th style='width: 10%'>정렬</th>";
	}
	if(tblInfo.FONT_SIZE_USE_YN == "Y") {
		headerHtml += "<th style='width: 10%'>폰트사이즈</th>";
	}
	if(tblInfo.COLOR_USE_YN == "Y") {
		headerHtml += "<th style='width: 10%'>폰트컬러</th>";
	}
	if(tblInfo.FONT_BOLD_USE_YN == "Y") {
		headerHtml += "<th style='width: 10%'>폰트Bold</th>";
	}
	if(tblInfo.FONT_STYLE_USE_YN == "Y") {
		headerHtml += "<th style='width: 10%'>폰트스타일</th>";
	}
	headerHtml += "</tr>";
	
	$("#privateTHead").html(headerHtml);
	
	var html = "";
	$.each(colInfo, function(idx, node) {
		// 컬럼명이 "chaeck"된 항목은 개인화 패널에 노출시키지 않음. 
		if (node.orgField == "check")
			return true;
		
		var str = "";
    	var textAlign = "center";
    	var fontSize = "13";
    	var fontWeight = "normal";
    	var fontStyle = "normal";
    	
		if(node["attributes"] != null) {
			str = node["attributes"]["style"];
			textAlign = getKeyValue(str, "textAlign");
	    	fontSize = getKeyValue(str, "fontSize");
	    	fontWeight = getKeyValue(str, "fontWeight");
	    	fontStyle = getKeyValue(str, "fontStyle");
		}
		
		html += "<tr id='" + idx + "' class='sortable'>";
		html += "<td style='width: 5%' class='" + (tblInfo.MOVE_USE_YN != "Y" ? "pNone" : "") + "'><img src='/images/handle.png'></td>";
		html += "<td style='width: 5%' class='" + (tblInfo.SHOW_USE_YN != "Y" ? "pNone" : "") + "'><input id='" + node.orgField + "' type='checkbox' " + (node.hidden ? "" : "checked") + " class='chkShowYn'></td>";
		html += "<td style='width: 15%'>" + (node.title || node.orgField) + "</td>";
		html += "<td style='width: 5%' class='" + (tblInfo.FIX_USE_YN != "Y" ? "pNone" : "") + "'><input id='" + node.orgField + "' type='checkbox' " + (node.sticky ? "checked" : "") + " class='chkFixYn'></td>";
		html += "<td style='width: 10%' class='" + (tblInfo.WIDTH_USE_YN != "Y" ? "pNone" : "") + "'><input type='number' min='20' class='form-control form-control-sm changeWidth' value='" + node.width + "'></td>";
		html += "<td style='width: 10%' class='" + (tblInfo.SORT_USE_YN != "Y" ? "pNone" : "") + "'>";
		html += "	<select id='" + node.orgField + "' class='custom-select cmb1'>";
		html += "		<option id='1' " + (textAlign == "center" ? "selected" : "") + ">center</option>";
		html += "		<option id='2' " + (textAlign == "left" ? "selected" : "") + ">left</option>";
		html += "		<option id='3' " + (textAlign == "right" ? "selected" : "") + ">right</option>";
		html += "	</select>";
		html += "</td>";
		html += "<td style='width: 10%' class='" + (tblInfo.FONT_SIZE_USE_YN != "Y" ? "pNone" : "") + "'><input id='" + node.orgField + "' type='number' min='10' class='form-control form-control-sm changeFontSize' value='" + fontSize + "'></td>";
		html += "<td style='width: 10%' class='" + (tblInfo.COLOR_USE_YN != "Y" ? "pNone" : "") + "'><div id='bcPicker_" + node.orgField + "' class='bcPicker'></div>";
		html += "</td>";
		html += "<td style='width: 10%' class='" + (tblInfo.FONT_BOLD_USE_YN != "Y" ? "pNone" : "") + "'>";
		html += "	<select id='" + node.orgField + "' class='custom-select cmb2'>";
		html += "		<option id='normal' " + (fontWeight == "normal" ? "selected" : "") + ">normal</option>";
		html += "		<option id='bold' " + (fontWeight == "bold" ? "selected" : "") + ">bold</option>";
		html += "	</select>";
		html += "</td>";
		html += "<td style='width: 10%' class='" + (tblInfo.FONT_STYLE_USE_YN != "Y" ? "pNone" : "") + "'>";
		html += "	<select id='" + node.orgField + "' class='custom-select cmb3'>";
		html += "		<option id='normal' " + (fontStyle == "normal" ? "selected" : "") + ">normal</option>";
		html += "		<option id='italic' " + (fontStyle == "italic" ? "selected" : "") + ">italic</option>";
		html += "	</select>";
		html += "</td>";
		html += "</tr>";
	});
	
	$("#privateTbody").html(html);
	
	// EVENT 
	// color picker
	$.each(colInfo, function(idx, node) {
		var color = node.COLOR;
		var code = $.fn.bcPicker.toHex(color);
		$('#bcPicker_' + node.orgField).bcPicker({
			defaultColor: !code ? "000000" : (code.replace("#", ""))
		});
	});
	
	// selected color 
	$('.bcPicker-palette').on('click', '.bcPicker-color', function(){
	 	var color = $(this).css('background-color');
	 	var code = $.fn.bcPicker.toHex(color);
	 	var id = $(this).parent().parent()[0].id;
		$("#" + id + " > .bcPicker-picker").css("background-color", code);
	 	$(".bcPicker-palette").hide();
        
        var rowId = $(this).parent().parent().parent().parent()[0].id;
        var colIndex = parseInt(rowId);
        
        $.each($("#" + inGridId).data("kendoGrid").dataSource.view(), function(idx, node) {
        	var jqTr = $("#" + inGridId).find("tbody>tr[data-uid='" + node.uid + "']>td:nth-child(" + (colIndex+1) + ")");
        	jqTr.css("color", color);
        	CHANGED_GRID_INFO = true;
        });
        
        var cellId = id.replace("bcPicker_", "");
        $.each($("#" + inGridId).data("kendoGrid").columns, function(idx, node) {
        	if(node.orgField == cellId) {
        		var style = node["attributes"]["style"];
        		var arr = style.split(";");
        		var newArr = [];
        		$.each(arr, function(subIdx, subNode) {
        			if(subNode.indexOf("color:") > -1) {
        				arr[subIdx] = "color: " + color;
        			}
        			
        			if(subNode.length != 0) {
        				newArr.push(arr[subIdx]);
        			}
        		});
        		
        		var str = newArr.join(";") + ";";
        		node["attributes"]["style"] = str;
        		
        		node["COLOR"] = color;
        	}
        });
	});
	
	if(tblInfo.MOVE_USE_YN == "Y") {
		// sortable
		$(".privateTbl").sortable({ 
			items: "tr.sortable",
			start: function(event, ui) {
	            var startPos = ui.item.index();
	            ui.item.data('startPos', startPos);
	        },
			update: function(event, ui) {

				var startPos = ui.item.data('startPos');
	            var updatePos = ui.item.index();

				if (typeof nonPrivateColumnCheck != 'undefined' && nonPrivateColumnCheck != null) {
					startPos += 1;
					updatePos += 1;
				}
	            // 체크박스 컬럼으로 인해 위치 인덱스를 1씩 늘림.
	            grid.reorderColumn(updatePos, grid.columns[startPos]);
	            CHANGED_GRID_INFO = true;
	            
	            $.each($("#privateTbody tr"), function(idx, node) {

	            	$(node).attr("id", idx);
	            });
	        }
		});
	}
	
	// show yn 
	$(".chkShowYn").on("click", function() {
		var id = $(this)[0].id;

        if (this.checked) {
            grid.showColumn(id);
        } else {
            grid.hideColumn(id);
        }
        CHANGED_GRID_INFO = true;
	});
	
	// fix yn 
	$(".chkFixYn").on("click", function() {
		var id = $(this)[0].id;
		
        if (this.checked) {
            grid.stickColumn(id);
        } else {
            grid.unstickColumn(id);
        }
        CHANGED_GRID_INFO = true;
	});
	
	// width
	$(".changeWidth").on("keyup focusout", function(key) {
		var id = $(this).parent().parent()[0].id;
        var colIndex = parseInt(id);
        var value = $(this).val();
        var defaultValue = $(this)[0].defaultValue;
        var minValue = $(this)[0].min;
        
		var isActive = false;
		if(key.type == "keyup" && key.keyCode == 13) {
			isActive = true;
		} else if(key.type == "focusout") {
			isActive = true;
		}
        if(isActive) {
            var column = grid.columns[colIndex];
            if (parseInt(colIndex) >= 0 && parseInt(value) >= parseInt(minValue)) {
                grid.resizeColumn(column, value);
            } else {
            	$(this).val(defaultValue);
            	grid.resizeColumn(column, defaultValue);
            }
            
            CHANGED_GRID_INFO = true;
        }
	});
	
	// font size 
	$(".changeFontSize").on("keyup focusout", function(key) {
		var id = $(this).parent().parent()[0].id;
        var colIndex = parseInt(id);
        var value = $(this).val();
        var defaultValue = $(this)[0].defaultValue;
        var minValue = $(this)[0].min;
        var setValue = value;
        
		var isActive = false;
		if(key.type == "keyup" && key.keyCode == 13) {
		} else if(key.type == "focusout") {
			isActive = true;
		}
        if(isActive) {
        	if (parseInt(colIndex) >= 0 && parseInt(value) >= parseInt(minValue)) {
        		setValue = value;
        	} else {
        		$(this).val(defaultValue);
        		setValue = defaultValue;
        	}
            $.each($("#" + inGridId).data("kendoGrid").dataSource.view(), function(idx, node) {
            	var jqTr = $("#" + inGridId).find("tbody>tr[data-uid='" + node.uid + "']>td:nth-child(" + (colIndex+1) + ")");
            	jqTr.css("font-size", setValue + "px");
            	CHANGED_GRID_INFO = true;
            });
            
            var rowId = $(this)[0].id;
            $.each($("#" + inGridId).data("kendoGrid").columns, function(idx, node) {
            	if(node.orgField == rowId) {
            		var style = node["attributes"]["style"];
            		var arr = style.split(";");
            		var newArr = [];
            		$.each(arr, function(subIdx, subNode) {
            			if(subNode.indexOf("font-size") > -1) {
            				arr[subIdx] = "font-size: " + value + "px";
            			}
            			
            			if(subNode.length != 0) {
            				newArr.push(arr[subIdx]);
            			}
            		});
            		
            		var str = newArr.join(";") + ";";
            		node["attributes"]["style"] = str;
            	}
            });
        }
	}); 
	
	// select box 
	$(".custom-select").on("change", function() {
		var id = $(this).parent().parent()[0].id;
        var colIndex = parseInt(id);
        var value = $(this).val();
        
        var styleTitle = "";
        if($(this).hasClass("cmb1")) {
        	styleTitle = "text-align";
        } else if($(this).hasClass("cmb2")) {
        	styleTitle = "font-weight";
        } else {
        	styleTitle = "font-style";
        }
        
        $.each($("#" + inGridId).data("kendoGrid").dataSource.view(), function(idx, node) {
        	var jqTr = $("#" + inGridId).find("tbody>tr[data-uid='" + node.uid + "']>td:nth-child(" + (colIndex+1) + ")");
        	jqTr.css(styleTitle, value);
        	CHANGED_GRID_INFO = true;
        });
        
        var rowId = $(this)[0].id;
        $.each($("#" + inGridId).data("kendoGrid").columns, function(idx, node) {
        	if(node.orgField == rowId) {
        		var style = node["attributes"]["style"];
        		var arr = style.split(";");
        		var newArr = [];
        		$.each(arr, function(subIdx, subNode) {
        			if(subNode.indexOf(styleTitle) > -1) {
        				arr[subIdx] = styleTitle + ": " + value;
        			}
        			
        			if(subNode.length != 0) {
        				newArr.push(arr[subIdx]);
        			}
        		});
        		
        		var str = newArr.join(";") + ";";
        		node["attributes"]["style"] = str;
        	}
        });
	});
	
	// 레이어 오픈
	$(".privateRightPanel").show(500, function() {
		SHOW_YN = true;
	});
	
	// 외부영역 클릭 시 팝업 닫기
	$(document).click(function (e){
		if(SHOW_YN) {
			var target = $(".privateRightPanel");
	        if(target.has(e.target).length==0) {
				$("#privateTbody").html("");
	        	$(".privateRightPanel").hide();
				SHOW_YN = false;
	        } 
		}
    });
	
	// 레이어 닫기 버튼 클릭 이벤트
	$(".privateClose").off("click");
	$(".privateClose").on("click", function() {
		$("#privateTbody").html("");
		$(".privateRightPanel").hide();
		SHOW_YN = false;
	});
	
	// 레이어 초기화 버튼 클릭 이벤트 
	$(".privateReset").off("click");
	$(".privateReset").on("click", function() {
		if(confirm("초기화 시 최초 디폴트 컬럼 정보로 초기화됩니다. 초기화하시겠습니까?")) {
			$.ajax({
				url: "/cmm/savePrivateColReset.do",
				type: "POST",
				dataType: "json",
				data: param,
				async: false,
				success: function(data){
					if(data.result) {
						alert("컬럼 정보가 초기화 되었습니다.");
						CHANGED_GRID_INFO = false;
						sessionStorage.clear();
						sessionStorage.setItem(stoId, JSON.stringify(data.colInfo));
						$(".privateRightPanel").hide();
						$("#privateTbody").html("");
						SHOW_YN = false;
						goList();
					} else {
						alert("오류가 발생했습니다. 관리자에게 문의하세요.");
						return;
					}
				}
			});
		}
	});
	
	// 레이어 저장 버튼 클릭 이벤트 
	$(".privateSave").off("click");
	$(".privateSave").on("click", function() {
		setPrivateSaveData(inPageId, inGridId, inUserId);
	});
	
}