<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="editor_wrap pop-layer omsCustAddrList" id="layer1">
    <div class="insertClose">
    	<a class="insertCloseButton k-icon k-i-close" onclick="init_popup_close();"></a>
    </div>
    <!-- wrap -->
    <div class="k-tabstrip-wrapper">
        <div id="editor_tabs" class="tabs_wrap k-widget k-tabstrip k-floatwrap k-tabstrip-top" data-role="tabstrip"
            tabindex="0" role="tablist" aria-activedescendant="editor_tabs_ts_active">
            <!-- content -->
            <div class="tab-content k-content k-state-active" id="editor_tabs-1" role="tabpanel"
                aria-expanded="true" style="display: block;">
                <div class="editor">
                    <form id="f" data-toggle="validator" role="form">
                        <fieldset>
                        	<div class="omsCustAddrList_top">
	                            <legend id="addr_legend">주소지 등록</legend>
	                            <div class="editor_btns" style="text-align:center;">
					        	    <div class="padding">
								        <!-- <a onclick="submit" class="k-pager-refresh k-button" id="btn_save"><b class="btn-b"><i class="k-icon k-i-check"></i>저장</b></a> -->
					        	    	<button type="submit" class="k-pager-refresh k-button btn_b btn_58" id="btnSubmit"><strong id="btn_save">저장</strong></button>
							            <a onclick="init_popup_close();" class="k-pager-refresh k-button"><b class="btn-g">닫기</b></a>
								    </div>
						    	</div>
					    	</div>
                            <div class="form-group row mt77 gray_box mr0">
                                <label class="col-form-label big-name">주소</label>
                                <div class="input-group input-group-sm wd270 middle-name form-group">
                                <strong class="required">주소지명</strong>
                                    <input type="text" class="form-control form-control-sm" id="addrName" required>
                                    <div class="help-block with-errors"></div>
                                </div>
                            
	                            <div class="form-group row mr0">
	                                <label class="col-form-label"></label>
	                                <div class="input-group input-group-sm wd260 middle-name form-group">
	                                <strong class="required">주소(검색)</strong>
	                                    <div class="textBox-in-icon">
	                                     <input onClick="popSearchPost();" type="text" class="form-control form-control-sm" id="addr" readonly="readonly" required>
	                                   	 	<div class="help-block with-errors"></div>
											<i><img onclick="popSearchPost();" src="/images/icon/icon_search.png"></i>
										</div>
	                                </div>
	                                <div class="input-group input-group-sm wd90 mr0 middle-name form-group">
	                                <strong>상세주소</strong>
	                                    <input type="text" class="form-control form-control-sm" id="addrDetail">
	                                </div>
	                            </div>
	                            <div class="form-group row mt5">
	                                <label class="col-form-label"></label>
	                                <div class="input-group input-group-sm wd140 middle-name form-group">
	                                <strong>시도</strong>
	                                    <input type="text" class="form-control form-control-sm" id="sido" readonly>
	                                </div>
	                                <div class="input-group input-group-sm wd140 middle-name form-group">
	                                <strong>군구</strong>
	                                    <input type="text" class="form-control form-control-sm" id="gungu" readonly>
	                                </div>
	                           	</div>
	                            <div class="form-group row mt5">
	                                <label class="col-form-label"></label>
	                                <div class="input-group input-group-sm wd90 middle-name form-group">
	                                <strong>동/거리명</strong>
	                                    <input type="text" class="form-control form-control-sm" id="dong" readonly>
	                                </div>
	                            </div>
	                            <div class="form-group row pb30 mt5">
	                                <label class="col-form-label"></label>
	                                <div class="input-group input-group-sm wd140 middle-name form-group">
	                                <strong>위도</strong>
	                                    <input type="text" class="form-control form-control-sm" id="lat" readonly>
	                                </div>
	                                <div class="input-group input-group-sm wd140 middle-name form-group">
	                                <strong>경도</strong>
	                                    <input type="text" class="form-control form-control-sm" id="lon" readonly>
	                                </div>
	                            </div>
                            </div>
                            <div class="form-group row gray_box mt5 mr0">
                                <label class="col-form-label big-name">담당자</label>
                                <div class="input-group input-group-sm wd90 middle-name form-group">
                                <strong>담당자명</strong>
                                    <input type="text" class="form-control form-control-sm" id="staffName" >
                                </div>
                                <div class="input-group input-group-sm wd140 middle-name form-group">
                                <strong>연락처</strong>
                                    <input type="text" class="form-control form-control-sm" id="staffTel" maxlength="13">
                                </div>
                            </div>
                            <div class="form-group row gray_box mt5 mr0">
                                <label class="col-form-label big-name">메모</label>
                                <div class="input-group input-group-sm col middle-name form-group">
                                <strong>메모</strong>
                                    <input type="text" class="form-control form-control-sm" id="orderMemo">
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

<script type="text/javascript">
$(document).ready(function(){ 	
	
});

var g_mode = "";
var g_seq = "";

function init_pop(mode, data) {
	g_mode = mode;
	g_seq = "";
	init();

	$("#btnSubmit").show();
	if(mode == "N") {
		$("#addr_legend").text("주소지 등록");
		$("#btn_save").html($("#btn_save").html().replace('수정', '저장'));

		if("${menuAuth.writeYn}" != "Y")	$("#btnSubmit").hide();
	} else if(mode == "E") {
		$("#addr_legend").text("주소지 수정");
		$("#btn_save").html($("#btn_save").html().replace('저장', '수정'));
		
		g_seq = data.addrSeq;
		Util.setPageData(data);

		if("${menuAuth.editYn}" != "Y")	$("#btnSubmit").hide();
	}
}

$('#f').validator().on('submit', function (e) {
	  if (e.isDefaultPrevented()) {
	    alert("항목을 입력해 주세요.")
	  } else {
		  	e.preventDefault();
			$.ajax({
				url: "/oms/cust/data/insertCustAddr.do",
				type: "POST",
				dataType: "json",
				data: {
					addrSeq: Util.nvl(g_seq, ''),
					addrName: $("#addrName").val(),
					addr: $("#addr").val(),
					addrDetail: $("#addrDetail").val(),
					sido: $("#sido").val(),
					gungu: $("#gungu").val(),
					dong: $("#dong").val(),
					lon: $("#lon").val(),
					lat: $("#lat").val(),
					staffName: $("#staffName").val(),
					staffTel: $("#staffTel").val().replace(/\-/g, ""),
					orderMemo: $("#orderMemo").val(),
					mode: g_mode
				},
				success: function(data){
					if(data.result) {
						alert(data.msg);
						init_popup_close();
						goList();
					} else {
						alert(data.msg);
					}
				}
			});
	  }
})

function init() {
	Util.formReset("", [".editor input"], {});
	$(".list-unstyled").remove();
}

function init_popup_close() {
	form_popup_close();
	init();
}

function popSearchPost(){
	//addrFlag = arguments[0];
	Util.dummyPopSearchPost();
}

function dummyAddressInfo(data) {
	$.ajax({
		url: "/contents/basic/data/getLatLon.do",
		type: "POST",
		dataType: "json",
		data: {
			searchAddress: data.sido+" "+data.gungu,
			size: 10
		},
		success: function(apiData){
			if(apiData.result){
				var localData = JSON.parse(apiData.data);
				var lat = '';
    			var lon = '';
    			lon = localData.documents[0].x;
				lat = localData.documents[0].y;
				var addressData = localData.documents[0].address;
				$("#addr").val(data.sido+" "+data.gungu);
                $("#sido").val(addressData.region_1depth_name);
                $("#gungu").val(addressData.region_2depth_name);
                $("#lon").val(lon);
                $("#lat").val(lat);
                $("#addrDetail").focus();
			} else {
				$("#addr").val(data.sido+" "+data.gungu);
				$("#sido").val(data.sido);
                $("#gungu").val(data.gungu);
                $("#dong").val("");
                $("#lat").val("37.5302996530226");
                $("#lon").val("126.919577176287");
			}
		}
	});
}

function setSearchAddressInfo(data) {
	//var addr = data.roadAddr; // 주소 변수	
	var addr = data.jibunAddr; // 주소 변수
	var sido = data.siNm;
	var gungu = data.sggNm;
    var dong = data.emdNm;

    /*if (data.userSelectedType === 'R') { 
        addr = data.roadAddress;
    } else { 
        addr = data.jibunAddress;
    }*/
    
	$.ajax({
		url: "/contents/basic/data/getLatLon.do",
		type: "POST",
		dataType: "json",
		data: {
			searchAddress: addr,
			size: 10
		},
		success: function(apiData){
			//console.log(apiData);
			if(apiData.result){
				var localData = JSON.parse(apiData.data);
				var lat = '';
    			var lon = '';
    			lon = localData.documents[0].x;
				lat = localData.documents[0].y;
				var addressData = localData.documents[0].address;
				
                $("#addr").val(addressData.address_name);
                $("#sido").val(addressData.region_1depth_name);
                $("#gungu").val(addressData.region_2depth_name);
                $("#dong").val(addressData.region_3depth_name);
                $("#lon").val(lon);
                $("#lat").val(lat);
                $("#addrDetail").focus();
			} else {
				$("#addr").val(addr);
                $("#sido").val(sido);
                $("#gungu").val(gungu);
                $("#dong").val(dong);
			}
		}
	});
}

$("#staffTel").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});
</script>