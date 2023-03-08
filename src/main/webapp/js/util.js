/**
 * javascript 공통 함수 정의 
 */
var AutoComplete = {
	setAddr: function(gbn) {
		$("#" + gbn + "Addr").on("propertychange change keyup paste input", function(){
			if($("#" + gbn + "Addr").val() == ""){
				$("#" + gbn + "Sido").val("");
			}
		})
		$("#" + gbn + "Addr").kendoAutoComplete({
			filter: "contains",
			dataTextField: "address",
			template: '<div  style="overflow:hidden;display:table-row;width:100%;">' +
			  '	<span style="display:block;text-align:left;border-bottom:1px solid grey;width:100%;">#:data.si# ' +
			  '#if(data.gu == null) {# #} else {# #:data.gu# #}#' + 
			  '#if(data.dong == null) {# #} else {# #:data.dong# #}#' +
			  '#if(data.liname == null) {# #} else {# #:data.liname# #}#' +
			  '</div>', 
			minLength: 2,
			dataSource: {
				transport: {
					read: {
						url: "/contents/basic/data/postDongList.do",
						type: "post",
						dataType: "json",
						data: {}
					}
				},
				schema: {
					data: function(response) {
						return response.data;
					}
				},
				pageSize: 50,
				serverPaging: true,
				serverFiltering: true
			},
			select: function(e){
				var dataItem = this.dataItem(e.item.index());
				$("#" + gbn + "Addr").val(dataItem.si + ' ' + Util.nvl(dataItem.gu, '') + ' ' + Util.nvl(dataItem.dong, '') + ' ' + Util.nvl(dataItem.liname, ''));
				$("#" + gbn + "Sido").val(dataItem.si);
				
				var addr = $("#" + gbn + "Addr").val();
				addrChk(addr,dataItem);
				
				//위, 경도 값 세팅
				if(dataItem.lat != 0 && dataItem.lon != 0) {
					$("#" + gbn + "Lat").val(dataItem.lat);
					$("#" + gbn + "Lon").val(dataItem.lon);	
				} else {
					Util.searchGeo($("#" + gbn + "Addr").val(), gbn, 'D', dataItem.dongSeq);
				}
				
				//거리, 시간 값 세팅
				if($("#sAddr").val() && $("#eAddr").val()){
					Util.searchRoute($("#sLat").val(), $("#sLon").val(), $("#eLat").val(), $("#eLon").val());
				}
			} 
		});
		function addrChk(addr,dataItem){
			$("#" + gbn + "Addr").on("propertychange change keyup paste input", function(){
				var newAddr = $("#" + gbn + "Addr").val();
				post(addr,newAddr,gbn,dataItem);
			})
		}
	}
}
function post(addr,newAddr,gbn,dataItem){
	if(newAddr == ""){
		$("#" + gbn + "Sido").val("");
	}else if(newAddr == addr){
		$("#" + gbn + "Sido").val(dataItem.si);
	}
}

//숫자, '-'만 입력 가능
function numberCheck(obj){
	$("#"+obj.id).on("input", function(){
		obj.value = obj.value.replace(/[^0-9-]/g, '').replace(/(\..*)\./g, '$1');
	})
}
//영문, 숫자, '-', '@', '.' 만 입력가능
function emailCheck(obj){
	$("#"+obj.id).on("input", function(){
		obj.value = obj.value.replace(/[^a-z0-9@_.-]/gi,'');
	})
}

var popupModal = null;
var modal = null;
var modalButton = null;
var Util = {
		/*
		 * ajax로 받아온 json 값을 화면의 id를 찾아 넣어준다.
		 */
		setPageData: function(json){
			$.each(json, function(key, value){
				value = Util.nvl(value, '');
				
				if($("#" + key).length > 0){
					if (key.toLowerCase().indexOf('tel') != -1 || key.toLowerCase().indexOf('mobile') != -1 || key.toLowerCase().indexOf('fax') != -1) {
						$("#" + key).val(Util.formatPhone(value));
					} else if (key.toLowerCase().indexOf('biznum') != -1) {
						$("#" + key).val(Util.formatBizNum(value));
					} else if (key.toLowerCase().indexOf('charge') != -1 && key != "chargeTypeCode") {
						$("#" + key).val(Util.formatNumber(value));
					} else {
						$("#" + key).val(value);	
					} 
				}
			});
		},
		/**
		 * 일자 검색 시 - 오늘, 어제, 7일, 30일 클릭 값에 따라 날짜값 세팅
		 */
		setSearchDateForm: function(){
			if($("#fSearch input[name=dateChk]").length > 0) {
				$("#fSearch input[name=dateChk]").on("click", function(){
					var sDate = new Date();
					var eDate = new Date();

					sDate.setDate(sDate.getDate() - $(this).val());
					if($(this).val() == "1"){
						eDate.setDate(eDate.getDate() - 1);
					}
					
					$("#fromDate").val(sDate.yyyymmdd());
					$("#toDate").val(eDate.yyyymmdd());
				});
				
				$("#fromDate, #toDate").on("change", function(){
					$("#fSearch input[name=dateChk]:checked").prop("checked", false);
				});
			}
		},
		/**
		 * 공통코드를 json 형식으로 받아온다.
		 */
		getComCode: function(gCode){
			var item = [];
			$.ajax({
				url: "/cmm/codeList.do",
				type: "post",
				dataType: "json",
				data: "gCode=" + gCode,
				async: false,
				success: function(data) {
					item = data.data;
				}
			});
			
			return item;
		},
		/**
		 * 공통코드 조회하여 type 별 세팅
		 * type : select, radio, checkbox
		 * id : html 요소 id, name
		 * dftVal : default 값
		 */ 
		setCmmCode: function(type, id, groupCode, dftVal, dftTxt){
			$.ajax({
				url: "/cmm/codeList.do",
				type: "POST",
				dataType: "json",
				data: "gCode=" + groupCode,
				async: false,
				success: function(data){
					$("#" + id).empty();
					var s = "";
					if(type == "select" || type == "datalist" ){
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
		},
		/**
		 * 회사, 부서, 권한 리스트 조회하여 select 세팅
		 * type : select
		 * id : html 요소 id, name
		 * dftVal : default 값
		 */ 
		setSelectBox: function(url, id, param, val, txt, dftVal, dftTxt){
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
		},
		nvl:function(str, str2){
			if(str==null || str==""){
				return str2;
			}
			return str;
		},
		/**
		 * 사용자 정의 페이징 함수
		 */
		setPaging: function(pagingData) {
			var s = "";

			if(pagingData.curBlock > 1){
				s += "<a href=\"javascript:viewData('" + pagingData.prevPage + "')\"><img src=\"/images/btn/btn_prev.gif\" style=\"vertical-align:middle;width:15px;height:15px;\"></a>&nbsp;";
			}else{
				s += "<img src=\"/images/btn/btn_prev.gif\" style=\"vertical-align:middle;width:15px;height:15px;\">&nbsp;";
			}
			for(var i=pagingData.blockBegin; i<=pagingData.blockEnd; i++){
				if(i.toString() == pagingData.curPage){
					s += "&nbsp;<span style=\"font-weight:bold;font-size:9pt;\">" + i.toString() + "</span>&nbsp;";
				}else{
					s += "&nbsp;<a href=\"javascript:viewData(" + i.toString() + ")\">" + i.toString() + "</a>&nbsp;";
				}
				if(i.toString() != pagingData.blockEnd) s += "|";
			}
			if(pagingData.curBlock <= pagingData.totBlock){
				s += "&nbsp;&nbsp;<a href=\"javascript:viewData('" + pagingData.nextPage + "')\"><img src=\"/images/btn/btn_next.gif\" style=\"vertical-align:middle;width:15px;height:15px;\"></a>";
			}else{
				s += "&nbsp;&nbsp;<img src=\"/images/btn/btn_next.gif\" style=\"vertical-align:middle;width:15px;height:15px;\">&nbsp;";
			}
			
			$("#pagingFooter").html(s);
		},
		/**
		 * 우편번호 검색 popup
		 * 해당 함수 호출 시, 호출하는 페이지에 function setAddr(zcode, addr, lat, lon, bldgMngno) 함수 정의 필수
		 */
		popSearchPost: function(mode){
			window.open("/contents/basic/view/searchPost.do?mode="+mode, "PopupPost", "width=712, height=707");
		},

		dummyPopSearchPost(mode){
			window.open("/contents/basic/view/dummySearchPost.do?mode="+mode, "PopupPost", "width=712, height=790");
		},
		
		popSearchBizinfo: function(mode){
			window.open("/contents/basic/view/searchBizinfo.do", "PopupPost", "width=1000, height=663");
		},
		
		closePopup: function(){
			popupModal.close();
		},
		
		closeModal: function(){
			modal.data("kendoDialog").close();
		},

		/*
		 * 숫자 천 단위마다  콤마 찍는다. 
		 */
		formatNumber:function(str){
			str = Util.nvl(str,'');
			var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
			str += '';                          // 숫자를 문자열로 변환
			while (reg.test(str))
				str = str.replace(reg, '$1' + ',' + '$2');
			
			return str;
		},
		
		formatNumberInput:function(str){
			var formatStr = '';
			str = Util.nvl(str,'');
			str = str.replace(/,/g,'');
			formatStr = str.replace(/\B(?=(\d{3})+(?!\d))/g, ",");   // 정규식
			return formatStr;
		},
		/*
		 * 전화번호 형식으로 변경해준다. 
		 */
		formatPhone:function(str){
			var formatStr = '';
			
			str = Util.nvl(str,'');
			str = str.replace(/[-]/gi , '');
			
			if(str.length == 11) {
				formatStr = str.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
			} else if (str.length == 8) {
				formatStr = str.replace(/(\d{4})(\d{4})/, '$1-$2');
			} else {
				if(str.indexOf('02') == 0) {
					formatStr = str.replace(/(\d{2})(\d*)(\d{4})/, '$1-$2-$3'); 
				} else {
					formatStr = str.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
				}
			} 
			
			return formatStr;
		},
		
		/*
		 * 사업자 번호 형식으로 변경해준다.
		 */
		formatBizNum:function(str){
			str = Util.nvl(str,'');			
			return str.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3');
		},
		/*
		 * 입력필드의 데이터를 날짜 포맷으로 변경해 준다.
		 */
		formatDate:function(str){
			
			if(str!=null && str!="" ){
				str = str.replace(/[-]/gi , '');
				if(str.length==8){
					return str.replace(/([0-9]{4})([0-9]{2})([0-9]{2})/,"$1-$2-$3") ;
				}else{					
					return "";
				}
			}else{
				return "";
			}
		},
		/*
		 * 시간 포맷 HH:mm 통일
		 */
		formatTime:function(str){
			if(str!=null && str!="" ){
				str = str.replace(/[^\d]+/g, '');
				return str.replace(/([0-9]{2})([0-9]{2})/, "$1:$2");
			} else {
				return "00:00"
			}
				
		},
		/**
		 * 위, 경도 값을 가져온다. (KAKAO API 연동)
		 * adress : 검색 주소
		 * gbn : 값을 세팅할 태그 id
		 * type: 테이블 구분 (위/경도 값 DB 업데이트 시 사용)
		 * seq : 테이블 시퀀스(위/경도 값 DB 업데이트 시 사용)
		 */
		searchGeo: function(address, gbn, type, seq){
			var lat, lon;
			$.ajax({
				url: "/cmm/searchGeo.do",
				type: "POST",
				dataType: "json",  
				data: "address=" + address + "&type=" + type + "&seq=" + seq,
				async: false,
				success: function(data){
					if(data.result) {
						lat = data.data.lat;
						lon = data.data.lon;
					} else {
						lat = 0;
						lon = 0;
					} 
				},
				error: function(data) {
					lat = 0;
					lon = 0;
				}				
			});
			$("#" + gbn + "Lat").val(lat);
			$("#" + gbn + "Lon").val(lon);
		},

		/**
		 * 거리, 시간 값을 가져온다. (GSEN API 연동)
		 */
		searchRoute: function(sLat, sLon, eLat, eLon){
			var time = 0;
			var distance = 0;
			$.ajax({
				url: "/cmm/searchRoute.do",
				type: "POST",
				dataType: "json",
				async: false,
				data: "sLat=" + sLat + "&sLon=" + sLon + "&eLat=" + eLat + "&eLon=" + eLon,
				success: function(data){
					if(data.result) {
						time = data.data.Time;
						distance = data.data.Distance;
					} 
				},
				error: function(data){}
			});
				
			$("#driverStreet").val(distance);
			$("#driverTime").val(time);
		},
		
		/**
		 * 문자의 byte 크기를 구한다.
		 */
		strByteSize: function(str){
			var l=0;
			for (var i=0; i<str.length; i++) {
				var c = escape(str.charAt(i));
				if (c.length == 1)
					l++;
				else if (c.indexOf("%u") != -1)
					l+=2;
				else if (c.indexOf("%") != -1)
					l += c.length/3;				
			}
			
			return l;
		},
		
		/**
		 * Byte 크기만큼 자른다.
		 */
		subStringByte: function(str, maxByte) {
			for(b=i=0; c= str.charCodeAt(i);) {
				b += c >> 7 ? 2 : 1;
				if (b > maxByte) 
					break;
				i++;
			}
			
			return str.substring(0, i);
		},
		/*
		 * Form 리셋 함수
		 * 파라미터 : Form ID, 리셋 할 항목 tag, 예외 항목 정의
		 */
		formReset: function(frm, tags, excepts) {
			var excepts_keys = Object.keys(excepts);
			if(frm == "") {
				for(var i = 0; i < tags.length; i++) {
					var tag = tags[i];
					for(var j = 0; j < $(tag).length; j++) {
						var id = $(tag)[j];
						var c = false;
						for(var k = 0; k < excepts_keys.length; k++) {
							var t = excepts_keys[k];
							if(t.indexOf(id.id) > -1) {
								c = true;
								break;
							}
						}
						if(c) continue;
						if(tag.indexOf("select") > -1) {
							$(tag + "[id='" + id.id + "']").empty();
							var s = "";
							s += "<option value='' >선택하세요.</option>";
							$(tag + "[id='" + id.id + "']").append(s);
						} else if($(tag + ":checkbox[id='" + id.id + "']").length == 1) {
							$(tag + ":checkbox[id='" + id.id + "']").prop('checked', false);
							continue;
						}
						$(tag + "[id='" + id.id + "']").val("")
					}
				}
			} else {
				$("#" + frm)[0].reset();
			}
			
			if(excepts_keys.length > 0) {
				for(var i = 0; i < excepts_keys.length; i++) {
					var k = excepts_keys[i];
					$(k).val(excepts[k]);
				}
			}
		}, 
		setReadOnlyEnable: function(ids) {
			for(var i = 0; i < ids.length; i++) {
				$("#"+ids[i]).attr("readonly",true);
			}
		},
		setReadOnlyDisable: function(ids) {
			for(var i = 0; i < ids.length; i++) {
				$("#"+ids[i]).attr("readonly",false);
			}
		},
		setDisabledList: function(ids) {
			for(var i = 0; i < ids.length; i++) {
				$("#"+ids[i]).prop('disabled', true);
			}
		},
		setEnabledList: function(ids) {
			for(var i = 0; i < ids.length; i++) {
				$("#"+ids[i]).prop('disabled', false);
			}
		},
		insertCloseButton: function(){
			$("#layer1").scroll(function(){
			    var scrollTop = $(this).scrollTop();
			    var innerHeight = $(this).innerHeight();
			    var scrollHeight = $(this).prop('scrollHeight');

			    if (scrollTop + innerHeight >= scrollHeight) {
			        $( '.insertClose' ).removeClass('block');
			    } else {
			        $( '.insertClose' ).addClass('block');
			    }
			});
		},
		// masterCompList
		setBizName: function(gbn, custId) {
			var custName =  $("#" + gbn).kendoMultiColumnComboBox({
				dataTextField: "bizName",
				dataValueField: "custId",
				filter: "contains",
				minLength: 2,
				autoBind: true,
				dataSource: {
					serverFiltering: true,
					type: "json",
					transport: {
						read : {
							url: "/contents/basic/data/masterCompList.do",
							dataType: "json",
							type: "post",
							data: {
								custId: custId,
								koreanAsc: 'Y',
								useYn : 'Y'
							},
							beforeSend: function(req) {
								req.setRequestHeader("AJAX", true);
							}
						}
					},
					schema : {
						data : function(response) {
							return response.data;
						},
						total : function(response) {
							return response.total;
						}
					}
				},
				select: function(e) {
					var dataItem = e.dataItem;
					if(dataItem != null) {
						$("#custId").val(dataItem.custId);
						$("#custName").val(dataItem.bizName);
					}else{
						if(e.sender.selectedIndex != -1){
							custName.select(e.sender.selectedIndex);
							var data = e.sender.listView._view[e.sender.selectedIndex];
							$("#custId").val(data.item.custId);
							$("#custName").val(data.item.bizName);
						}
					}
				},
				change: function(e) {
					if(this.value() != ""){
						custName.trigger("select");
					}else{
						$("#custId").val("");
						$("#custName").val("");
					}
				},
				columns: [
					{field: "bizName", title: "조직명", width:200},
				]
			}).data("kendoMultiColumnComboBox");
			
			return custName;
		},
		setDeptName: function(gbn, custId) {
			var deptName =  $("#" + gbn).kendoMultiColumnComboBox({
				dataTextField: "deptName",
				dataValueField: "deptId",
				cascadeFrom: "custName",
				filter: "contains",
				autoBind: true,
				dataSource: {
					serverFiltering: true,
					type: "json",
					transport: {
						read : {
							url: "/contents/basic/data/compDeptList.do?custId="+custId,
							dataType: "json",
							type: "post",
							data: {useYn: 'Y'},
							beforeSend: function(req) {
								req.setRequestHeader("AJAX", true);
							}
						}
					},
					schema : {
						data : function(response) {
							return response.data;
						},
						total : function(response) {
							return response.total;
						}
					}
				},
				select: function(e) {
					var dataItem = e.dataItem;
					if(dataItem != null) {
						$("#deptId").val(dataItem.deptId);
						$("#deptName").val(dataItem.deptName);
					}else{
						if(e.sender.selectedIndex != -1){
							deptName.select(e.sender.selectedIndex);
							var data = e.sender.listView._view[e.sender.selectedIndex];
							$("#deptId").val(data.item.deptId);
							$("#deptName").val(data.item.deptName);
						}
					}
				},
				change: function(e) {
					if(this.value() != ""){
						deptName.trigger("select");
					}else{
						$("#deptId").val("");
						$("#deptName").val("");
					}
				},
				columns: [
					{field: "deptName", title: "부서명", width:200},
				]
			}).data("kendoMultiColumnComboBox");
			
			return deptName;
		},
		/*
		 * 과적 체크 함수 - 소숫점 2자리 반올림
		 */
		checkOverload: function(weight, str){
			weight = parseFloat(weight.replace(/[a-z].*/gi, "")) * 1.1;
			weight = weight.toString().substr(0, (weight.toString().indexOf(".")) == -1 ? weight.toString().length : weight.toString().indexOf(".")+3);
			weight = Math.round(weight*10)/10.0;
			if(parseFloat(weight) < parseFloat(str) || str.toString() == "0"){
				return weight;
			}else{
				return str;
			}	
		}
}