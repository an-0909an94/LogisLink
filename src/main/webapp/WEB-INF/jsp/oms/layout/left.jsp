<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
    .side-nav {
        width: 90px;
        display: inline-block;
        height: 100%;
        background: linear-gradient(0deg, rgb(12, 179, 234) -10%, rgb(28, 84, 196));
        position: fixed;
        border-radius: 0px 30px 0px 0px;
        top: 0;
        bottom: 0;
        left: 0;
        z-index: 2000;

        -ms-overflow-style: none;
        /* IE and Edge */
        scrollbar-width: none;
        /* Firefox */
    }

    nav::-webkit-scrollbar {
        display: none;
        /* Chrome, Safari, Opera*/
    }
    
    nav .side-nav-ul a {
        font-size: 14px;
        color: #fff;
        cursor: pointer;
    }

    nav .side-nav-ul .nav-li span {
        text-align: center;
    }
    
    .side-nav-ul.board{
    	padding: 10px 0px;
    }
    
    nav .side-nav-ul span a {
        text-align: center;
        color: #fff;
        padding: 0px;
    }
    
    nav .side-nav-ul span a:hover {
    	color: white;
    	text-decoration: none;
    }

    nav .side-nav-ul span:active a {
        color: #fff;
    }

    nav .side-nav-ul .logo span a {
        text-align: center;
        color: #fff;
    }

    .sub-li-wrap {}
    
    .sub-li {} 
    
    .sub-li a {
        display: block;
        padding: 10px 0;
        text-align: center;
    }

    .sub-li-wrap {
        display: none;
    }
    
	
	.nav-li:hover > span > a > h7 {
		color: #fff;
	}
	
	.side-nav .nav-li{
		text-align: center;
	}
	
	.side-nav .nav-li.logo img{
		margin: 20px auto 0 auto;
	}
	
	.side-nav-img{
		width: 21px;
		height: 21px;
		background-image: url(/images/icon/icon_left_dev.png);
		background-position: 0px 0px;
		margin: auto;
		display: block;	
	}
	
	.mem-info-wrapper{
		width: 80%;
	}
	
	.mem-info > .manager-name,
	.mem-info > .manager-role,
	.mem-info > .carrier-name,
	.mem-setting{
		display: none;	
	}
	
	.side-logout{
		width: 23px;
		left: 50%;
		transform: translateX(-45%);
	}
		
	.side-logout-link{
		font-size: 0px;
		margin: 0px;
	}
	
	.side-logout-link::before{
		width: 23px;
		height: 21px;
		background-size: 26px;
		background-position: -1px -144px;
		margin: 0px;
	}
	
	.mem-info > .mem-setting{
		widht: 21px;
		left: 50%;
		transform: translateX(-50%);
	}
	
	.mem-info > .mem-setting i::before{
		width: 21px;
		height: 21px;
		background-size: 26px;
		background-position: -3px -168px;
		left: 50%;
		transform: translateX(-50%);
		margin: 0px;
	}
	
	.mem-info .manager-profile{
		width: 37px;
		left: 50%;
		transform: translateX(-50%);
	}
	
	.mem-setting img{
		widht:21px;
		height: 21px;
	}
}
</style>
<div id="divUserOption" class="editor-warp p-0" style="display: none;">
	<form class="modalEditor" id="fUserOption" data-toggle="validator" role="form" autocomplete="off">
		<input type="hidden" name="defaultBuyCustId" id="defaultBuyCustId">
		<input type="hidden" name="defaultBuyDeptId" id="defaultBuyDeptId">
		<input type="hidden" name="defaultBuyStaffId" id="defaultBuyStaffId">
	    <input type="hidden" name="defaultSSido" id="defaultSSido">
	    <input type="hidden" name="defaultSGungu" id="defaultSGungu">
	    <input type="hidden" name="defaultSDong" id="defaultSDong">
	    <input type="hidden" name="defaultSLat" id="defaultSLat">
	    <input type="hidden" name="defaultSLon" id="defaultSLon">
		<div class="modalHeader">
            <div class="form-group row gray_box" style="margin-bottom: 0.225rem">
                <label class="col-form-label modal-big-name">운송사</label>
                <div class="input-group input-group-sm wd190 mr10 middle-name form-group" style="text-align: left; margin-bottom: 0;">
                <strong>거래처명</strong>
                    <input style="width: 100%;" name="defaultBuyCustName" id="defaultBuyCustName" type="text">
                </div>
                <div class="input-group input-group-sm wd90 mr10 middle-name form-group" style="text-align: left; margin-bottom: 0;">
                <strong>담당자</strong>
                    <input style="width: 100%;" name="defaultBuyStaff" id="defaultBuyStaff" type="text">
                </div>
                <div class="input-group input-group-sm wd110 middle-name form-group" style="text-align: left; margin-bottom: 0;">
                	<strong>요청사항</strong>
                    <input type="text" id="defaultReqMemo" name="defaultReqMemo" class="form-control form-control-sm">
                </div>
            </div>
            
			<div class="form-group row gray_box">
                <label class="col-form-label modal-big-name">상차지</label>
                <div class="input-group input-group-sm wd190 mr10 middle-name form-group" style="text-align: left; margin-bottom: 0;">
                	<strong>상차지명</strong>
                    <input style="width: 100%;" name="defaultSComName" id="defaultSComName" type="text">
                </div>
                <div class="input-group input-group-sm wd90 mr10 middle-name form-group" style="text-align: left; margin-bottom: 0;">
                	<strong>담당자</strong>
                    <input type="text" id="defaultSStaff" name="defaultSStaff" class="form-control form-control-sm">
                </div>
            	<div class="input-group input-group-sm wd110 middle-name form-group" style="text-align: left; margin-bottom: 0;">
	                <strong>연락처</strong>
	                    <input type="text" id="defaultSTel" name="defaultSTel" class="form-control form-control-sm" maxlength="13">
                </div>
				<div class="form-group row mt5">
	                <label class="col-form-label modal-big-name"></label>
	                <div class="input-group input-group-sm wd290 mr10 middle-name form-group" style="text-align: left; margin-bottom: 0;">
	                	<strong>주소</strong>
						<div class="textBox-in-icon">
							<input id="defaultSAddr" name="defaultSAddr" type="text" class="form-control form-control-sm" readonly="readonly">
							<i id="iDefaultSAddr"><img src="/images/icon/icon_search.png"></i>
						</div> 
	                </div>
	                <div class="input-group input-group-sm wd110 middle-name form-group" style="text-align: left; margin-bottom: 0;">
	                <strong>상세주소</strong>
	                    <input type="text" id="defaultSAddrDetail" name="defaultSAddrDetail" class="form-control form-control-sm">
	                </div>
	            </div>
				<div class="form-group row mt5">
	                <label class="col-form-label modal-big-name"></label>
	                
	                <div class="input-group input-group-sm wd290 middle-name form-group" style="text-align: left; margin-bottom: 0;">
	                <strong>메모</strong>
	                    <input type="text" id="defaultSMemo" name="defaultSMemo" class="form-control form-control-sm">
	                </div>
	            </div>
            </div>
            
            <div class="form-group row gray_box">
                <label class="col-form-label modal-big-name">화물</label>
                <div class="input-group input-group-sm wd210 mr10 middle-name form-group" style="text-align: left; margin-bottom: 0;">
                	<strong>요청차종</strong>
                    <select class="custom-select col-12" id="defaultCarTypeCode" name="defaultCarTypeCode"></select>
                </div>
                <div class="input-group input-group-sm wd190 middle-name form-group" style="text-align: left; margin-bottom: 0;">
                	<strong>요청톤수</strong>
                    <select class="custom-select col-12" id="defaultCarTonCode" name="defaultCarTonCode"></select>
                </div>
            
	            <div class="form-group row mt5">
	                <label class="col-form-label modal-big-name"></label>
	                <div class="input-group input-group-sm wd210 mr10 middle-name form-group" style="text-align: left; margin-bottom: 0;">
	                	<strong>화물정보</strong>
	                    <input type="text" class="form-control form-control-sm" id="defaultGoodsName" name="defaultGoodsName">
	                </div>
	                <div class="input-group input-group-sm wd190 middle-name form-group" style="text-align: left; margin-bottom: 0;">
	                	<strong>중량(ton)</strong>
	                    <input type="text" class="form-control form-control-sm" id="defaultGoodsWeight" name="defaultGoodsWeight">
	                </div>
	            </div>
	            
	            
	            <div class="form-group row mt5">
	                <label class="col-form-label modal-big-name"></label>
	                <div class="input-group input-group-sm wd100 mr10 middle-name form-group" style="text-align: left; margin-bottom: 0;">
	                	<strong class="required">수출입구분</strong>
	                    <select id="defaultInOutSctn" name="defaultInOutSctn" class="custom-select col-12" required></select>
	                    <div style="position: absolute;" class="help-block with-errors"></div>
	                </div>
	                <div class="input-group input-group-sm wd100 mr10 middle-name form-group" style="text-align: left; margin-bottom: 0;">
	                	<strong class="required">운송유형</strong>
	                    <select class="custom-select col-12" id="defaultTruckTypeCode" name="defaultTruckTypeCode" required></select>
	                    <div style="position: absolute;" class="help-block with-errors"></div>
	                </div>
	
	                <div class="input-group input-group-sm wd190 middle-name form-group" style="text-align: left; margin-bottom: 0;">
	                	<strong>운송품목</strong>
	                    <select class="custom-select col-12" id="defaultItemCode" name="defaultItemCode"></select>
	                    <div style="position: absolute;" class="help-block with-errors"></div>
	                </div>
	            </div>
	            
	            <div class="form-group row mt5">
	                <label class="col-form-label modal-big-name"></label>
	                <div class="input-group input-group-sm wd210 mr10 middle-name form-group" style="text-align: left; margin-bottom: 0;">
	                	<strong class="required">상차방법</strong>
	                	<select class="custom-select col-12" id="defaultSWayCode"name="defaultSWayCode" required></select>
	                	<div style="position: absolute;" class="help-block with-errors"></div>
	                </div>
	                <div class="input-group input-group-sm wd190 middle-name form-group" style="text-align: left; margin-bottom: 0;">
	                	<strong class="required">하차방법</strong>
	                    <select class="custom-select col-12" id="defaultEWayCode"name="defaultEWayCode" required></select>
	                    <div style="position: absolute;" class="help-block with-errors"></div>
	                </div>
	            </div>
            </div>
            <div class="form-group row gray_box">
                <label class="col-form-label modal-big-name">배차</label>
                <div class="input-group input-group-sm wd210 mr10 middle-name form-group" style="text-align: left; margin-bottom: 0;">
                	<strong>지불운임</strong>
                    <input type="text" class="form-control form-control-sm" id="defaultBuyCharge" name="defaultBuyCharge">
                </div>
                <div class="input-group input-group-sm wd190 middle-name form-group" style="text-align: left; margin-bottom: 0;">
                	<strong>차주확인사항</strong>
                    <input type="text" class="form-control form-control-sm" id="defaultDriverMemo" name="defaultDriverMemo">
                </div>
            </div>
			<div class="editor_btns" style="padding-top: 15px;">
				<div class="padding">
			        <button type="submit" class="k-pager-refresh k-button btn_b"><strong><b id="codeBtnSave" class="btn-b">저장</b></strong></button>
			        <button type="button" onclick="userOptionModalClose()" class="k-pager-refresh k-button"><strong><b class="btn-g">닫기</b></strong></button>
		        </div>
	        </div>
		</div>
	</form>
</div>

<div id="side-nav" class="side-nav">
    <nav>
        <div class="side-nav-ul base">
            <div class="nav-li logo">
                <div style="text-align: center;">
                    <a href="${sessionScope.userInfo.userMainPage}"><img style="width: 65px; height: auto;" src="/images/logo.png"></a>
                </div>
            </div>
        </div>    
	    <div class="side-menu" id="leftmenu" style="margin-top:45px;">
	        
	       <!--  <div class="side-nav-ul order">
	            <div class="nav-li">
	                <span>
	                    <img src="/images/icon/1.png"/><br />
	                    <a class="">상황실</a>
	                </span>
	            </div>
	        </div> -->
	
	  <!--       <div class="side-nav-ul order">
	            <div class="nav-li">
	                <span>
	                    <img src="/images/icon/2.png"/><br />
	                    <a class="">배차관리</a>
	                </span>
	            </div>
	        </div>
	
	        <div class="side-nav-ul count">
	            <div class="nav-li">
	                <span>
	                    <img src="/images/icon/3.png"/><br />
	                    <a class="">운송사관리</a>
	                </span>
	            </div>
	        </div>
	
	        <div class="side-nav-ul board">
	            <div class="nav-li">
	                <span>
	                    <img src="/images/icon/4.png"/><br />
	                    <a class="">정산관리</a>
	                </span>
	            </div>
	        </div>
	        
	        <div class="side-nav-ul board">
	            <div class="nav-li">
	                <span>
	                    <img src="/images/icon/5.png"/><br />
	                    <a class="">통계관리</a>
	                </span>
	            </div>
	        </div> -->
	        <!-- 
	        <div class="side-nav-ul board">
	            <div class="nav-li">
	                <span>
	                    <img src="/images/icon/6.png"/><br />
	                    <a class="">설정관리</a>
	                </span>
	            </div>
	        </div>
	        
	        <div class="side-nav-ul board">
	            <div class="nav-li">
	                <span>
	                    <img src="/images/icon/7.png"/><br />
	                    <a class="">고객센터</a>
	                </span>
	            </div>
	        </div>
	        
	        <div class="side-nav-ul board">
	            <div class="nav-li">
	                <span>
	                    <img src="/images/icon/8.png"/><br />
	                    <a class="">도움말</a>
	                </span>
	            </div>
	        </div> -->
		</div>
		<div class="mem-info-wrapper">
			<div class="mem-info">
	            <div style="text-align: center;padding-bottom: 15px;" class="manager-profile">
	            	<div>${fn:substring(sessionScope.userInfo.userName, 0, 1)}</div>
	                <!-- <img src="" class="mem-pic"> -->
	            </div>
	            <div style="color: white;font-size: unset;width: 58px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;" class="manager-name">${sessionScope.userInfo.userName} </div>
	            <div style="color: white;font-size: x-small;" class="manager-role">${sessionScope.userInfo.grade}</div>
	            <div style="color: white;font-size: x-small;" class="carrier-name">${sessionScope.userInfo.bizName}</div>
	            <div class="side-logout"><a style="color: white;" href="/logout.do" class="side-logout-link">로그아웃</a></div>
				<div class="mem-setting" style="color: white;font-size: x-small;">
					<i id="userOption" class="k-icon k-i-gear" style="cursor: pointer;" title="업무초기값 설정"></i>
					<a class="mem-setting" href="javascript:setMainPage();"><img src="/images/home_icon.png" style="width:20px;height:20px;" title="시작페이지로 설정"></a>
				</div>
	        </div>
        </div>
        <!-- mem-info-wrapper -->
    </nav>
</div>

<div id="popList"></div>
<script type="text/javascript">
var defaultBuyCustName, defaultBuyStaff;
var defaultSComName;
var defaultCarTypeData = Util.getComCode("CAR_TYPE_CD");
var defaultCarTonData = Util.getComCode("CAR_TON_CD");
var defaultTruckTypeData = Util.getComCode("TRUCK_TYPE_CD");
var menuList = ${sessionScope.MenuList};

$(document).ready(function(){
	Util.setCmmCode("select", "defaultItemCode", "ITEM_CD", "", "선택하세요");
	Util.setCmmCode("select", "defaultSWayCode", "WAY_TYPE_CD", "", "선택하세요");
	Util.setCmmCode("select", "defaultEWayCode", "WAY_TYPE_CD", "", "선택하세요");
	Util.setCmmCode("select", "defaultInOutSctn", "IN_OUT_SCTN", "", "선택하세요");
	setFrtSelect(defaultCarTypeData, "defaultCarTypeCode", "TR", "");
	setFrtSelect(defaultCarTonData, "defaultCarTonCode", "TR", "");
	setFrtSelect(defaultTruckTypeData, "defaultTruckTypeCode", "01", "");

	$("#defaultInOutSctn").on("change", function(){
		setFrtSelect(defaultTruckTypeData, "defaultTruckTypeCode", $(this).val(), "");
	});
	
	$("#defaultTruckTypeCode").on("change", function(){
		setFrtSelect(defaultCarTypeData, "defaultCarTypeCode", $(this).val(), "");
		setFrtSelect(defaultCarTonData, "defaultCarTonCode", $(this).val(), "");		
	});

	setLeftMenu();
	
	//검색값 입력 후 enter key event
	if($(".searchValue").length > 0) {
		$(".searchValue").on("keypress", function (event){
			if(event.keyCode==13){
				goList();
			}
		});
	}

	userOptionModal = $("#divUserOption");
	
	userOptionModal.kendoDialog({
		width: "560px",
		visible: false,
		title: "업무 초기값 설정",
		closable: true,
		modal: false,
		close: function(){
			$("#fUserOption")[0].reset();
		}
	});
	
	$("#defaultInOutSctn").on("change", function(){
		setFrtSelect(defaultTruckTypeData, "defaultTruckTypeCode", $(this).val(), "");
	});
	
	defaultSComName = MultiColumnComboBox.setComName("defaultS", "${sessionScope.userInfo.deptId}");
	defaultBuyCustName = MultiColumnComboBox.setCustName("defaultBuy", "02", "${sessionScope.userInfo.deptId}");
	defaultBuyCustName.bind("select", defaultBuyCust);
	defaultBuyCustName.bind("change", defaultBuyCustSelectTrigger);
	defaultBuyStaff = MultiColumnComboBox.setStaff("defaultBuy");
});

function defaultBuyCust(e) {
	var dataItem = e.dataItem;
	if(dataItem != null) {
		$("#defaultBuyCustId").val(dataItem.custId);
		$("#defaultBuyDeptId").val(dataItem.deptId);
	}else{
		var index = e.sender.selectedIndex
		if(index != -1){
			var data = e.sender.listView._view[e.sender.selectedIndex];
			defaultBuyCustName.select(e.sender.selectedIndex);
			$("#defaultBuyCustId").val(data.item.custId);
			$("#defaultBuyDeptId").val(data.item.deptId);
		}
	}
}

function defaultBuyCustSelectTrigger(e) {
	if(this.value() != ""){
		defaultBuyCustName.trigger("select");
	}else{
		$("#defaultBuyCustId").val("");
		$("#defaultBuyDeptId").val("");
	}
}

function setLeftMenu() {
	var s = "";
	var currPage = $(location).attr("pathname");
	var currMenuSeq;
	var currMenuName = "";
	var manual1Type;
	var manual1Url;
	var manual2Type;
	var manual2Url;
	var manual3Type;
	var manual3Url;
	var tutorial1Type;
	var tutorial1Url;
	var tutorial2Type;
	var tutorial2Url;
	var tutorial3Type;
	var tutorial3Url;	
		
	for(var item, i=0; item=menuList.menu[i]; i++) {
		if(item.depth.toString() == "2"){
			s += "<div class=\"side-nav-ul board\">";
			s += "	<div class=\"nav-li\">";
			s += "		<span style=\"cursor: pointer;\" onclick=\"location.href='"+ item.pageUrl +"'\">";
			s += "			<a id=\"nav-a" + item.menuSeq + "\" href=\"" + item.pageUrl + "\"";
			if(currPage.trim() == item.pageUrl.trim()) {
				s += " style=\"color:#ffffff;\"";

				currMenuName = item.menuName;
				
				manual1Type = item.manual1Type;
				manual1Url = item.manual1Url;
				manual2Type = item.manual21Type;
				manual2Url = item.manual2Url;
				manual3Type = item.manual3Type;
				manual3Url = item.manual3Url;
				
				tutorial1Type = item.tutorial1Type;
				tutorial1Url = item.tutorial1Url;
				tutorial2Type = item.tutorial2Type;
				tutorial2Url = item.tutorial2Url;
				tutorial3Type = item.tutorial3Type;
				tutorial3Url = item.tutorial3Url;
			}
			//s += "><img src=\"/images/menu/" + item.menuCode + ".png\"/><br />";
			//s += "><img class=\"side-nav-img\" src=\"/images/icon/icon_left_dev.png\"/><br />";
			s += "><span class=\"side-nav-img\"/>";
			s += "<h7>"+item.menuName + "</h7></a>";
			s += "		</span>";
			s += "	</div>";
			s += "</div>";

		
		}
	}	
	$("#leftmenu").html(s);

	if(currMenuName != "") {
		var title = currMenuName + " ";
		if(manual1Url != null && manual1Url != ""){
			if(manual1Type == "L") {
				title += "<a href=\"" + manual1Url + "\" target=\"_blank\" style=\"font-weight:bold;color:#336191;\">ⓜ </a>" 
			} else {
				title += "<a href=\"/cmm/guideDownload.do?fileName=" + escape(manual1Url) + "\" style=\"font-weight:bold;color:#336191;\">ⓜ </a>" 
			}
		}
		if(manual2Url != null && manual2Url != ""){
			if(manual2Type == "L") {
				title += "<a href=\"" + manual2Url + "\" target=\"_blank\" style=\"font-weight:bold;color:#570008;\">ⓜ </a>" 
			} else {
				title += "<a href=\"/cmm/guideDownload.do?fileName=" + escape(manual2Url) + "\" style=\"font-weight:bold;color:#570008;\">ⓜ </a>" 
			}
		}
		if(manual3Url != null && manual3Url != ""){
			if(manual3Type == "L") {
				title += "<a href=\"" + manual3Url + "\" target=\"_blank\" style=\"font-weight:bold;color:#4D5700;\">ⓜ </a>" 
			} else {
				title += "<a href=\"/cmm/guideDownload.do?fileName=" + escape(manual3Url) + "\" style=\"font-weight:bold;color:#4D5700;\">ⓜ </a>" 
			}
		}
		
		if(tutorial1Url != null && tutorial1Url != ""){
			if(tutorial1Type == "L") {
				title += "<a href=\"" + tutorial1Url + "\" target=\"_blank\" style=\"font-weight:bold;color:#49A29F;\">ⓣ </a>" 
			} else {
				title += "<a href=\"/cmm/guideDownload.do?fileName=" + escape(tutorial1Url) + "\" style=\"font-weight:bold;color:#49A29F;\">ⓣ </a>" 
			}
		}
		if(tutorial2Url != null && tutorial2Url != ""){
			if(tutorial2Type == "L") {
				title += "<a href=\"" + tutorial2Url + "\" target=\"_blank\" style=\"font-weight:bold;color:#002B57;\">ⓣ </a>" 
			} else {
				title += "<a href=\"/cmm/guideDownload.do?fileName=" + escape(tutorial2Url) + "\" style=\"font-weight:bold;color:#002B57;\">ⓣ </a>" 
			}
		}
		if(tutorial3Url != null && tutorial3Url != ""){
			if(tutorial3Type == "L") {
				title += "<a href=\"" + tutorial3Url + "\" target=\"_blank\" style=\"font-weight:bold;color:#1C657C;\">ⓣ </a>" 
			} else {
				title += "<a href=\"/cmm/guideDownload.do?fileName=" + escape(tutorial3Url) + "\" style=\"font-weight:bold;color:#1C657C;\">ⓣ </a>" 
			}
		}
		$("#headerTitle").html(title);
	}
}

function getPopup(){
	$.ajax({
		url: "/contents/notice/data/boardList.do",
		type: "POST",
		dataType: "json",
		data: "type=popup",
		success: function(data){
			var s = "";
			if(data.result) {
				for(var item, i=0; item=data.data[i]; i++) {
					var rCookie = $.cookie("pop" + item.boardSeq);
					if(rCookie == null) {
						s+= "<div id=\"pop" + item.boardSeq + "\" style=\"display:scroll;position:absolute;top:0px;left:107px;width:500px;min-height:500px;border:1px solid #333333;background:#ffffff;padding:20px;z-index:1000\">";
						s+= "<div class=\"form-group row\">";
						s+= "	<label class=\"col-form-label modal-big-name\">제목</label>"
						s+= "	<div class=\"input-group input-group-sm col middle-name form-group\">"
						s+= "		<input type=\"text\" class=\"form-control form-control-sm\" value=\"" + item.title + "\">"
						s+= "	</div>"
						s+= "</div>"
						s+= "<div class=\"form-group row\">";
						s+= "	<label class=\"col-form-label modal-big-name\">내용</label>"
						s+= "	<div class=\"input-group input-group-sm col middle-name form-group\">"
						s+= "		<textarea rows=\"16\" class=\"form-control form-control-sm textarea\">"
						s+= item.content;
						s+= "		</textarea>";
						s+= "	</div>";
						s+= "</div>";
						if(item.fileCnt > 0) {
							for(var item2, j=0; item2=item.fileList[j]; j++){
								if(item.fileCnt > j) {
									s+= "<div class=\"form-group row\">";
									s+= "	<label class=\"col-form-label modal-big-name\">첨부파일</label>";
									s+= "	<div class=\"input-group input-group-sm col middle-name form-group\">";									
									s+= "		<input type=\"button\" onclick=\"location.href=\'/contents/notice/data/fileDownload.do?fileSeq=" + item2.fileSeq + "\'\" class=\"upload-name col\" value=\"" + item2.fileRealName + "\">";
									s+= "	</div>";
									s+= "</div>";
								}
							}
						}
						s+= "<div style=\"width:70px;margin:10px auto;\">"
						s+= "<button type=\"button\" onClick=\"popClose(" + item.boardSeq + ")\" style=\"border-radius:4px\" class=\"form-control form-control-sm middle-button-dark\"><i class=\"k-icon k-i-check\"></i>읽음</button>"
						s+= "</div>"
						s+= "</div>";
					}
					
				}
				
				if(s != "") $("#popList").html(s);
			}
		}
	});
}

function popClose(){
	var boardSeq = arguments[0];	
	$.cookie("pop" + boardSeq, 1, {expires:60, path:"/"});
	$("#pop" + boardSeq).hide();
}

function setMainPage() {
	var currPage = $(location).attr("pathname");
	$.ajax({
		url: "/contents/basic/data/userMainPage.do",
		type: "POST",
		dataType: "json",
		data: "userMainPage=" + currPage,
		success: function(data) {
			alert(data.msg);
		}
	});
}

$("#userOption").click(function(){
	$("#divUserOption").show();
	getDefaultUserOption();
	userOptionModal.data("kendoDialog").open();
});

function userOptionModalClose(){
	$("#divUserOption").hide();
	userOptionModal.data("kendoDialog").close();
	$("#fUserOption")[0].reset();
}

$("#defaultSAddr, #iDefaultSAddr").click(function(){
	Util.dummyPopSearchPost('defaultS');
});

function defaultAddressInfo(data) {
	var addr = data.jibunAddr; // 주소 변수
	var sido = data.siNm;
	var gungu = data.sggNm;
    var dong = data.emdNm;
    var mode = data.mode;
    
	$.ajax({
		url: "/contents/basic/data/getLatLon.do",
		type: "POST",
		dataType: "json",
		data: {
			searchAddress: addr,
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
				$("#"+data.mode+"Addr").val(addr);
                $("#"+data.mode+"Sido").val(addressData.region_1depth_name);
                $("#"+data.mode+"Gungu").val(addressData.region_2depth_name);
                $("#"+data.mode+"Dong").val(addressData.region_3depth_name);
                $("#"+data.mode+"Lon").val(lon);
                $("#"+data.mode+"Lat").val(lat);
                $("#"+data.mode+"AddrDetail").focus();
			}
		}
	});
}

function defaultDummyAddressInfo(data) {
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
				$("#"+data.mode+"Addr").val(data.sido+" "+data.gungu);
                $("#"+data.mode+"Sido").val(addressData.region_1depth_name);
                $("#"+data.mode+"Gungu").val(addressData.region_2depth_name);
                $("#"+data.mode+"Dong").val(addressData.region_3depth_name);
                $("#"+data.mode+"Lon").val(lon);
                $("#"+data.mode+"Lat").val(lat);
                $("#"+data.mode+"AddrDetail").focus();
			}
		}
	});
}

function getDefaultUserOption(){
	$.ajax({
		url: "/oms/user/data/getUserOption.do",
		type: "POST",
		dataType: "json",
		data: $("#fUserOption").serialize(),				
		success: function(data){
			if(data.result) {
				var data = data.data;
				if(data != null){
					setFrtSelect(defaultTruckTypeData, "defaultTruckTypeCode", data.defaultInOutSctn, data.truckTypeCode);
					setFrtSelect(defaultCarTypeData, "defaultCarTypeCode", data.defaultTruckTypeCode, data.defaultCarTypeCode);
					setFrtSelect(defaultCarTonData, "defaultCarTonCode", data.defaultTruckTypeCode, data.defaultCarTonCode);
					Util.setPageData(data);
					setTimeout(function(){
						var name = data.defaultBuyCustName;
						defaultBuyCustName.select(function(dataItem) {
						    return dataItem.custName === name;
						});
						defaultBuyCustName.value(name);
						defaultBuyCustName.trigger("change");
						defaultBuyStaff.value(data.defaultBuyStaffName);
						defaultSComName.value(data.defaultSComName);
					}, 50);
				}
			}
		}
	});
}

$('#fUserOption').validator().on('submit', function (e) {
	if (e.isDefaultPrevented()) {
		alert("항목을 입력해 주세요.")
	}else {
  		e.preventDefault();
		if($("#defaultSAddr").val() == "" && defaultSComName.value() != ""){
			alert("상차지 주소를 입력해 주세요.");
			return
		}else if($("#defaultSAddr").val() != "" && defaultSComName.value() == ""){
			alert("상차지명을 입력해 주세요.");
			return
		}else{
	  		if($("#defaultSLat").val() == '') $("#defaultSLat").val("0");
	  		if($("#defaultSLon").val() == '') $("#defaultSLon").val("0");
	  		$("#defaultSTel").val($("#defaultSTel").val().replace(/\-/g, ""));
	  		$("#defaultBuyCharge").val($("#defaultBuyCharge").val().replace(/,/g, ""));
	  		
	  		$.ajax({
	  			url: "/oms/user/data/insertUserOption.do",
	  			type: "POST",
	  			dataType: "json",
	  			data: $("#fUserOption").serialize(),				
	  			success: function(data){
	  				if(data.result) {
	  					alert(data.msg);
	  					userOptionModalClose();
	  				} else {
	  					alert(data.msg);
	  				}
	  			}
	  		});
		}
		
	}
});

$("#defaultBuyCharge").on("input", function(){
	$(this).val(Util.formatNumberInput($(this).val()));
});

$("#defaultSTel").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});
</script>