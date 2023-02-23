<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>
	// $(document).ready(function () {
	// 	if ($.cookie('my_cookie') == 'mini-nav') {  //쿠키에 저장된 값
	// 		$('.side-nav-btn').toggleClass('side-nav-btn-atv');
	// 		$('.nav').toggleClass('nav-atv');
	// 		$('.side-nav').toggleClass('side-nav-atv');
	// 		$('.logo-area .logo-title').toggleClass('logo-title-atv');
	// 		$('.nav .side-nav-ul a.dropBtn').toggleClass('dropBtn-atv');
	// 		$('.nav .side-nav-ul span').toggleClass('side-nav-img-atv');
	// 		$('.sub-li-wrap').toggleClass('sub-li-wrap-atv');
	// 		$('.mem-info-wrapper').toggleClass('mem-info-wrapper-atv');
	// 		$('.manager-name').toggleClass('none-atv');
	// 		$('.manager-role').toggleClass('none-atv');
	// 		$('.carrier-name').toggleClass('none-atv');
	// 		$('.side-logout a').toggleClass('side-logout-link-atv');
	// 		$('.mem-setpage a').toggleClass('side-logout-link-atv');
	// 		$('.mem-setpage').toggleClass('none-atv');
	// 		$('.side-logout').toggleClass('side-logout-link-atv');
	// 		$('.mem-info > .mem-setting i').toggleClass('icon-mem-setting-atv');
	// 		$('.mem-info > .mem-setting').toggleClass('mem-setting-atv');
	// 		$('.mem-info .manager-profile').toggleClass('manager-profile-atv');
	// 		$('.insert_pop.block').toggleClass('block-atv');
	// 		$('.insert_pop').toggleClass('insert_pop-atv');
	// 		$('.insert_pop').removeClass('insert_pop.block').toggleClass('m-side-nav-atv');
	// 		$('.header').toggleClass('header-atv');
	// 		$('.cont-body').toggleClass('cont-body-atv');
	// 		$('.sub-li-wrap-atv').hide();
	// 		$('.nav-li').removeClass('backColor');
	// 	}
	//
	// 	$('.side-nav-btn').on('click', function() {
	// 		$(this).toggleClass('side-nav-btn-atv');
	// 		if ($('.side-nav-btn').hasClass('side-nav-btn-atv')){
	// 			$.cookie('my_cookie', 'mini-nav', {path: '/', secure: false});
	// 			alert('쿠키를 추가합니다.')
	// 		} else {
	// 			$(this).toggleClass('side-nav-btn');
	// 			$.removeCookie('my_cookie', {path: '/'});
	// 			alert('쿠키를 삭제합니다..')
	// 		}
	// 		//GNB 사이즈 작아짐
	// 		$('.side-nav-btn').toggleClass('side-nav-btn-atv');
	// 		$('.nav').toggleClass('nav-atv');
	// 		$('.side-nav').toggleClass('side-nav-atv');
	// 		$('.logo-area .logo-title').toggleClass('logo-title-atv');
	// 		$('.nav .side-nav-ul a.dropBtn').toggleClass('dropBtn-atv');
	// 		$('.nav .side-nav-ul span').toggleClass('side-nav-img-atv');
	// 		$('.sub-li-wrap').toggleClass('sub-li-wrap-atv');
	// 		$('.mem-info-wrapper').toggleClass('mem-info-wrapper-atv');
	// 		$('.manager-name').toggleClass('none-atv');
	// 		$('.manager-role').toggleClass('none-atv');
	// 		$('.carrier-name').toggleClass('none-atv');
	// 		$('.side-logout a').toggleClass('side-logout-link-atv');
	// 		$('.mem-setpage a').toggleClass('side-logout-link-atv');
	// 		$('.mem-setpage').toggleClass('none-atv');
	// 		$('.side-logout').toggleClass('side-logout-link-atv');
	// 		$('.mem-info > .mem-setting i').toggleClass('icon-mem-setting-atv');
	// 		$('.mem-info > .mem-setting').toggleClass('mem-setting-atv');
	// 		$('.mem-info .manager-profile').toggleClass('manager-profile-atv');
	// 		$('.insert_pop.block').toggleClass('block-atv');
	// 		$('.insert_pop').toggleClass('insert_pop-atv');
	// 		$('.insert_pop').removeClass('insert_pop.block').toggleClass('m-side-nav-atv');
	// 		$('.header').toggleClass('header-atv');
	// 		$('.cont-body').toggleClass('cont-body-atv');
	// 		$('.sub-li-wrap-atv').hide();//GNB 미니에서 메뉴안보임
	// 		$('.nav-li').removeClass('backColor');
	// 	});
	// });
</script>




<div id="divUserOption" class="editor-warp p-0" style="display: none;">
	<form class="modalEditor" id="fUserOption" data-toggle="validator" role="form" autocomplete="off">
		<input type="hidden" name="defaultReqCustId" id="defaultReqCustId">
		<input type="hidden" name="defaultReqDeptId" id="defaultReqDeptId">
		<input type="hidden" name="defaultReqStaffId" id="defaultReqStaffId">
	    <input type="hidden" name="defaultSSido" id="defaultSSido">
	    <input type="hidden" name="defaultSGungu" id="defaultSGungu">
	    <input type="hidden" name="defaultSDong" id="defaultSDong">
	    <input type="hidden" name="defaultSLat" id="defaultSLat">
	    <input type="hidden" name="defaultSLon" id="defaultSLon">
		<div class="modalHeader">
            <div class="form-group row gray_box" style="margin-bottom: 0.225rem">
                <label class="col-form-label modal-big-name">운송사</label>
                <div class="input-group input-group-sm wd90 mr10 mt0 middle-name form-group" style="text-align: left;">
                <strong>거래처명</strong>
                    <input style="width: 100%;" name="defaultReqCustName" id="defaultReqCustName" type="text">
                </div>
                <div class="input-group input-group-sm wd90 mr10 mt0 middle-name form-group" style="text-align: left;">
                <strong>담당자</strong>
                    <input style="width: 100%;" name="defaultReqStaff" id="defaultReqStaff" type="text">
                </div>
                <div class="input-group input-group-sm wd190 mt0 middle-name form-group" style="text-align: left;">
                <strong>요청사항</strong>
                    <input style="width: 100%;" name="defaultReqStaff" id="defaultReqStaff" type="text">
                </div>
            </div>
            
			<!-- <div class="form-group row gray_box" style="margin-bottom: 0.225rem">
                <label class="col-form-label modal-big-name"></label>
                <div class="input-group input-group-sm col middle-name form-group" style="text-align: left;">
                <strong>주소</strong>
                	<div class="textBox-in-icon">
	                    <input id="defaultReqAddr" name="defaultReqAddr" type="text" class="form-control form-control-sm" readonly="readonly">
						<i id="iDefaultReqAddr"><img src="/images/icon/icon_search.png"></i>
					</div>
                </div>
                <div class="input-group input-group-sm col middle-name form-group" style="text-align: left;">
                	<strong>상세주소</strong>
                    <input type="text" id="defaultReqAddrDetail" name="defaultReqAddrDetail" class="form-control form-control-sm">
                </div>
            </div> 
            
			<div class="form-group row gray_box" style="margin-bottom: 0.225rem">
                <label class="col-form-label modal-big-name"></label>
                <div class="input-group input-group-sm col middle-name form-group" style="text-align: left;">
                	<strong>연락처</strong>
                    <input type="text" id="defaultReqTel" name="defaultReqTel" class="form-control form-control-sm" maxlength="13">
                </div>
                <div class="input-group input-group-sm col middle-name form-group" style="text-align: left;">
                	<strong>메모</strong>
                    <input type="text" id="defaultReqMemo" name="defaultReqMemo" class="form-control form-control-sm">
                </div>
            </div>-->
			<div class="form-group row gray_box" style="margin-bottom: 0.225rem">
                <label class="col-form-label modal-big-name">상차지</label>
                <div class="input-group input-group-sm wd190 mr10 mt0 middle-name form-group" style="text-align: left;">
                	<strong>상차지명</strong>
                    <input style="width: 100%;" name="defaultSComName" id="defaultSComName" type="text">
                </div>
                <div class="input-group input-group-sm wd190 mr10 mt0 middle-name form-group" style="text-align: left;">
                	<strong>담당자</strong>
                    <input type="text" id="defaultSStaff" name="defaultSStaff" class="form-control form-control-sm">
                </div>
            
				<div class="form-group row" style="margin-bottom: 0.225rem">
	                <label class="col-form-label modal-big-name"></label>
	                <div class="input-group input-group-sm wd190 mr10 middle-name form-group" style="text-align: left;">
	                	<strong>주소</strong>
						<div class="textBox-in-icon">
							<input id="defaultSAddr" name="defaultSAddr" type="text" class="form-control form-control-sm" readonly="readonly">
							<i id="iDefaultSAddr"><img src="/images/icon/icon_search.png"></i>
						</div> 
	                </div>
	                <div class="input-group input-group-sm wd190 mr10 middle-name form-group" style="text-align: left;">
	                <strong>상세주소</strong>
	                    <input type="text" id="defaultSAddrDetail" name="defaultSAddrDetail" class="form-control form-control-sm">
	                </div>
	            </div>
            </div>
			<!-- <div class="form-group row" style="margin-bottom: 0.225rem">
                <label class="col-form-label modal-big-name"></label>
                <div class="input-group input-group-sm col middle-name form-group" style="text-align: left;">
                <strong>연락처</strong>
                    <input type="text" id="defaultSTel" name="defaultSTel" class="form-control form-control-sm" maxlength="13">
                </div>
                <div class="input-group input-group-sm col middle-name form-group" style="text-align: left;">
                <strong>메모</strong>
                    <input type="text" id="defaultSMemo" name="defaultSMemo" class="form-control form-control-sm">
                </div>
            </div>-->
            
            <div class="form-group row gray_box" style="margin-bottom: 0.225rem">
                <label class="col-form-label modal-big-name">화물</label>
                <div class="input-group input-group-sm wd190 mr10 mt0 middle-name form-group" style="text-align: left;">
                	<strong>요청차종</strong>
                    <select class="custom-select wd190" id="defaultCarTypeCode" name="defaultCarTypeCode"></select>
                </div>
                <div class="input-group input-group-sm wd190 mr10 mt0 middle-name form-group" style="text-align: left;">
                	<strong>요청톤수</strong>
                    <select class="custom-select wd190" id="defaultCarTonCode" name="defaultCarTonCode"></select>
                </div>
            
	            <div class="form-group row" style="margin-bottom: 0.225rem">
	                <label class="col-form-label modal-big-name"></label>
	                <div class="input-group input-group-sm wd190 mr10 middle-name form-group" style="text-align: left;">
	                	<strong>화물정보</strong>
	                    <input type="text" class="wd190 form-control form-control-sm" id="defaultGoodsName" name="defaultGoodsName">
	                </div>
	                <div class="input-group input-group-sm wd190 mr10 middle-name form-group" style="text-align: left;">
	                	<strong>중량(ton)</strong>
	                    <input type="text" class="wd190 form-control form-control-sm" id="defaultGoodsWeight" name="defaultGoodsWeight">
	                </div>
	            </div>
	            
	            
	            <div class="form-group row" style="margin-bottom: 0.225rem">
	                <label class="col-form-label modal-big-name"></label>
	                <div class="input-group input-group-sm wd90 mr10 middle-name form-group" style="text-align: left;">
	                	<strong class="required">수출입구분</strong>
	                    <select id="defaultInOutSctn" name="defaultInOutSctn" class="custom-select col-12" required></select>
	                    <div style="position: absolute;" class="help-block with-errors"></div>
	                </div>
	                <div class="input-group input-group-sm wd90 mr10 middle-name form-group" style="text-align: left;">
	                	<strong class="required">운송유형</strong>
	                    <select class="custom-select col-12" id="defaultTruckTypeCode" name="defaultTruckTypeCode" required></select>
	                    <div style="position: absolute;" class="help-block with-errors"></div>
	                </div>
	
	                <div class="input-group input-group-sm wd190 mr10 middle-name form-group" style="text-align: left;">
	                	<strong>운송품목</strong>
	                    <select class="custom-select wd190" id="defaultItemCode" name="defaultItemCode"></select>
	                    <div style="position: absolute;" class="help-block with-errors"></div>
	                </div>
	            </div>
	            
	            <div class="form-group row" style="margin-bottom: 0.225rem">
	                <label class="col-form-label modal-big-name"></label>
	                <div class="input-group input-group-sm wd190 mr10 middle-name form-group" style="text-align: left;">
	                	<strong class="required">상차방법</strong>
	                	<select class="custom-select wd190" id="defaultSWayCode"name="defaultSWayCode" required></select>
	                	<div style="position: absolute;" class="help-block with-errors"></div>
	                </div>
	                <div class="input-group input-group-sm wd190 mr10 middle-name form-group" style="text-align: left;">
	                	<strong class="required">하차방법</strong>
	                    <select class="custom-select wd190" id="defaultEWayCode"name="defaultEWayCode" required></select>
	                    <div style="position: absolute;" class="help-block with-errors"></div>
	                </div>
	            </div>
            </div>
            
            <!-- 
            <div class="form-group row" style="margin-bottom: 0.225rem">
                <label class="col-form-label modal-big-name" style="align-self: flex-end;">운임</label>
                <div class="input-group input-group-sm col middle-name form-group" style="text-align: left;">
                	<strong>운임구분</strong>
                    <select id="defaultUnitPriceType" name="defaultUnitPriceType" class="custom-select col-12"></select>
                </div>
                <div class="input-group input-group-sm col middle-name form-group" style="text-align: left;">
                	<strong>단가</strong>
                    <input type="text" class="form-control form-control-sm" id="defaultUnitCharge" name="defaultUnitCharge">
                </div>
                <div class="input-group input-group-sm col middle-name form-group" style="text-align: left;">
                	<strong>청구운임</strong>
                    <input type="text" class="form-control form-control-sm" id="defaultSellCharge" name="defaultSellCharge">
                </div>
            </div> -->
            
            <div class="form-group row gray_box">
                <label class="col-form-label modal-big-name">배차</label>
                <div class="input-group input-group-sm wd190 mr10 mt0 middle-name form-group" style="text-align: left;">
                	<strong>지불운임</strong>
                    <input type="text" class="wd190 form-control form-control-sm" id="defaultBuyCharge" name="defaultBuyCharge">
                </div>
                <div class="input-group input-group-sm wd190 mr10 mt0 middle-name form-group" style="text-align: left;">
                	<strong>차주확인사항</strong>
                    <input type="text" class="wd190 form-control form-control-sm" id="defaultDriverMemo" name="defaultDriverMemo">
                </div>
            </div>
			<div class="editor_btns">
				<div class="padding">
			        <button type="submit" class="k-pager-refresh k-button btn_b"><strong><b id="codeBtnSave" class="btn-b">저장</b></strong></button>
			        <button type="button" onclick="userOptionModalClose()" class="k-pager-refresh k-button"><strong><b class="btn-g">닫기</b></strong></button>
		        </div>
	        </div>
		</div>
	</form>
</div>
<div id="side-nav" class="side-nav">
<div class="side-nav-btn">접기</div>
	<div class="logo-area">
		<div class="">
			<a href="${sessionScope.userInfo.userMainPage}"><img src="/images/logislink_logo.png" class="logo-title"></a>
		</div>  
	</div>            
	<div class="nav">
		<div id="leftMenu"></div>
<!-- member -->
	</div>
	<div class="mem-info-wrapper">
		<div class="mem-info">
			<div class="manager-profile">${fn:substring(sessionScope.userInfo.userName, 0, 1)} </div>
			<div class="manager-name">${sessionScope.userInfo.userName} </div>
           	<div class="manager-role">${sessionScope.userInfo.grade}</div>
           	<div class="carrier-name">${sessionScope.userInfo.bizName}</div>
           	<div class="side-logout" style="">
				<a href="/logout.do" class="side-logout-link">로그아웃</a>
			</div>
			<div class="mem-setting"><i id="userOption" class="k-icon k-i-gear" style="cursor: pointer;" title="업무초기값 설정"></i></div>
           	<div class="mem-setpage"><a href="javascript:setMainPage();" style="color:#ffffff;">현재페이지를 시작페이지로</a></div>
           	
		</div>
	</div>
    <!-- mem-info-wrapper -->

	
</div>    

<div id="popList"></div>
<script type="text/javascript">
var defaultReqCustName, defaultReqStaff;
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
	Util.setCmmCode("select", "defaultUnitPriceType", "UNIT_PRICE_TYPE", "01", "선택하세요");
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
	
	setLeftmenu();
	
	$(".nav-li").on('click',function(){
		
		$(".sub-li-wrap").slideUp(100);		
				
		if($(this).is(".backColor") === true) {
			//메뉴 닫기
			$(this).removeClass("backColor");
			
			//$(this).next(".sub-li-wrap").removeClass("backColor");
		}
		
		else {
			//메뉴 열기
			$(".nav-li").removeClass("backColor");
			$(this).addClass("backColor");
			$(this).addClass("backColor");
			$(this).next(".sub-li-wrap").slideDown(100);
			
			//$(".nav-li").next(".sub-li-wrap").removeClass("backColor");
			//$(this).next(".sub-li-wrap").addClass("backColor");
		}
	});
    //쿠키가 받을 값
	function toggleGNBSize() {
		$('.side-nav-btn').toggleClass('side-nav-btn-atv');
		$('.nav').toggleClass('nav-atv');
		$('.side-nav').toggleClass('side-nav-atv');
		$('.logo-area .logo-title').toggleClass('logo-title-atv');
		$('.nav .side-nav-ul a.dropBtn').toggleClass('dropBtn-atv');
		$('.nav .side-nav-ul span').toggleClass('side-nav-img-atv');
		$('.sub-li-wrap').toggleClass('sub-li-wrap-atv');
		$('.mem-info-wrapper').toggleClass('mem-info-wrapper-atv');
		$('.manager-name').toggleClass('none-atv');
		$('.manager-role').toggleClass('none-atv');
		$('.carrier-name').toggleClass('none-atv');
		$('.side-logout a').toggleClass('side-logout-link-atv');
		$('.mem-setpage a').toggleClass('side-logout-link-atv');
		$('.mem-setpage').toggleClass('none-atv');
		$('.side-logout').toggleClass('side-logout-link-atv');
		$('.mem-info > .mem-setting i').toggleClass('icon-mem-setting-atv');
		$('.mem-info > .mem-setting').toggleClass('mem-setting-atv');
		$('.mem-info .manager-profile').toggleClass('manager-profile-atv');
		$('.insert_pop.block').toggleClass('block-atv');
		$('.insert_pop').toggleClass('insert_pop-atv');
		$('.insert_pop').removeClass('insert_pop.block').toggleClass('m-side-nav-atv');
		$('.header').toggleClass('header-atv');
		$('.cont-body').toggleClass('cont-body-atv');
		$('.sub-li-wrap-atv').hide();
		$('.nav-li').removeClass('backColor');
	}

	if ($.cookie('my_cookie') == 'mini-nav') {  // 쿠키 이름과 벨류
		toggleGNBSize();
	}

	$('.side-nav-btn').on('click', function() {
		$(this).toggleClass('side-nav-btn-atv');
		if ($('.side-nav-btn').hasClass('side-nav-btn-atv')){
			$.cookie('my_cookie', 'mini-nav', {path: '/', secure: false});
			alert('쿠키를 추가합니다.')
		} else {
			$('.side-nav-btn-atv').hasClass('side-nav-btn');
			$.removeCookie('my_cookie', {path: '/'});
			alert('쿠키를 삭제합니다..')
		}
		// GNB 사이즈 작아짐
		toggleGNBSize();
	});



	//펼쳐진 네비메뉴의 서브메뉴가 열린 상태에서 메뉴 접을 시 서브메뉴 없어짐


	//nav 접기 펼치기
	// $('.side-nav-btn').on('click',function(){
	//
	// 	//nav 사이드메뉴 영역
	// 	$('.side-nav').toggleClass('side-nav-atv'); //nav 가로 사이즈 작아짐
	// 	$('.nav').toggleClass('nav-atv'); //nav 가로 사이즈 작아짐
	// 	$('.logo-area .logo-title').toggleClass('logo-title-atv'); //로고 사이즈 작아짐
	// 	//$('.side-nav-btn').toggleClass('side-nav-btn-atv');
	//  $('.sub-li-wrap-atv').hide();
	//  $('.nav-li').removeClass('backColor');
	//
	//
	// 	$('.nav .side-nav-ul a.dropBtn').toggleClass('dropBtn-atv'); //접었을 때 메뉴 텍스트 삭제
	// 	$('.nav .side-nav-ul span').toggleClass('side-nav-img-atv'); //접었을 때 아이콘 작아짐
	// 	//$('.nav-li').toggleClass('backColor'); //메뉴 접었을 때 1depth 메뉴 색상 변경
	// 	$('.sub-li-wrap').toggleClass('sub-li-wrap-atv'); //서브메뉴 디자인 변경
	//
	//
	// 	// 로그인 정보
	// 	$('.mem-info-wrapper').toggleClass('mem-info-wrapper-atv');
	// 	$('.manager-name').toggleClass('none-atv');
	// 	$('.manager-role').toggleClass('none-atv');
	// 	$('.carrier-name').toggleClass('none-atv');
	// 	$('.side-logout a').toggleClass('side-logout-link-atv');
	// 	$('.mem-setpage a').toggleClass('side-logout-link-atv');
	// 	$('.mem-setpage').toggleClass('none-atv');
	// 	$('.side-logout').toggleClass('side-logout-link-atv');
	// 	$('.mem-info > .mem-setting i').toggleClass('icon-mem-setting-atv');
	// 	$('.mem-info > .mem-setting').toggleClass('mem-setting-atv');
	// 	$('.mem-info .manager-profile').toggleClass('manager-profile-atv');
	//
	// 	//오더등록
	// 	$('.insert_pop.block').toggleClass('block-atv');
	// 	$('.insert_pop').toggleClass('insert_pop-atv');
	// 	$('.insert_pop').removeClass('insert_pop.block').toggleClass('m-side-nav-atv');//nav 접기열기 버튼 클릭 시 오더등록 창
	//
	// 	//content 영역
	// 	$('.header').toggleClass('header-atv');
	//
	// 	// 그리드
	// 	$('.cont-body').toggleClass('cont-body-atv');
	// });



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
		width: "556px",
		//height: "895px",
		visible: false,
		title: "개인 정보",
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
	defaultReqCustName = MultiColumnComboBox.setCustName("defaultReq", "01", "${sessionScope.userInfo.deptId}");
	defaultReqCustName.bind("select", defaultReqCust);
	defaultReqCustName.bind("change", defaultReqCustSelectTrigger);
	defaultReqStaff = MultiColumnComboBox.setStaff("defaultReq");
	if("${sessionScope.userInfo.authSeq}" != "100")	getPopup();
});

function defaultReqCust(e) {
	var dataItem = e.dataItem;
	if(dataItem != null) {
		$("#defaultReqCustId").val(dataItem.custId);
		$("#defaultReqDeptId").val(dataItem.deptId);
	}else{
		var index = e.sender.selectedIndex
		if(index != -1){
			var data = e.sender.listView._view[e.sender.selectedIndex];
			defaultReqCustName.select(e.sender.selectedIndex);
			$("#defaultReqCustId").val(data.item.custId);
			$("#defaultReqDeptId").val(data.item.deptId);
		}
	}
}

function defaultReqCustSelectTrigger(e) {
	if(this.value() != ""){
		defaultReqCustName.trigger("select");
	}else{
		$("#defaultReqCustId").val("");
		$("#defaultReqDeptId").val("");
	}
}

function setLeftmenu() {
	var s = "";
	var currPage = $(location).attr("pathname");
	var currMenuSeq;
	var parentMenuSeq;
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
		if(item.depth.toString() == "1"){
			s += "<div class=\"side-nav-ul\">";
			s += "	<div class=\"nav-li\" id=\"nav-li" + item.menuSeq + "\">";
			s += "		<span>";
			s += "			<span class=\"side-nav-img\"></span><a class=\"dropBtn\">" + item.menuName + "</a>";
			s += "		</span>"; 
			s += "	</div>";
			s += "<ul class=\"sub-li-wrap\">";
			for(var item2, j=0; item2=menuList.menu[j]; j++) {
				if(item.menuSeq == item2.parentSeq && item2.depth.toString() == "2") {
					s += "	<li class=\"sub-li\" id=\"sub-li" + item2.menuSeq + "\"><a href=\"" + item2.pageUrl + "\">" + item2.menuName + "</a></li>";
					
					if(currPage.trim() == item2.pageUrl.trim()) {
						parentMenuSeq = item2.parentSeq;
						currMenuSeq = item2.menuSeq;
						currMenuName = item2.menuName;
						
						manual1Type = item2.manual1Type;
						manual1Url = item2.manual1Url;
						manual2Type = item2.manual21Type;
						manual2Url = item2.manual2Url;
						manual3Type = item2.manual3Type;
						manual3Url = item2.manual3Url;
						
						tutorial1Type = item2.tutorial1Type;
						tutorial1Url = item2.tutorial1Url;
						tutorial2Type = item2.tutorial2Type;
						tutorial2Url = item2.tutorial2Url;
						tutorial3Type = item2.tutorial3Type;
						tutorial3Url = item2.tutorial3Url;
					}
				}
			}
			s += "</ul>";
			s += "</div>";
		}
	}
	$("#leftMenu").html(s);	
	$("#nav-li" + parentMenuSeq).addClass("backColor");
	$("#nav-li" + parentMenuSeq).next(".sub-li-wrap").slideDown(100);
	$("#sub-li" + currMenuSeq + " a").css("text-decoration", "underline");
	
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
						s+= "<div id=\"pop" + item.boardSeq + "\" style=\"display:scroll;position:absolute;top:0px;left:207px;width:500px;min-height:500px;border:1px solid #333333;background:#ffffff;padding:20px;z-index:1000\">";
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

$("#defaultSAddr, #iDefaultSAddr, #defaultReqAddr, #iDefaultReqAddr").click(function(){
	if($(this).attr('id') != "defaultSAddr"){
		Util.dummyPopSearchPost('defaultReq');
	}else{
		Util.dummyPopSearchPost('defaultS');
	}
});

function getDefaultUserOption(){
	$.ajax({
		url: "/contents/basic/data/getUserOption.do",
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
						var name = data.defaultReqCustName;
						defaultReqCustName.select(function(dataItem) {
						    return dataItem.custName === name;
						});
						defaultReqCustName.value(name);
						defaultReqCustName.trigger("change");
						defaultReqStaff.value(data.defaultReqStaffName);
						defaultSComName.value(data.defaultSComName);
					}, 50);
				}
			}
		}
	});
}

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
	  		$("#defaultReqTel").val($("#defaultReqTel").val().replace(/\-/g, ""));
	  		$("#defaultSTel").val($("#defaultSTel").val().replace(/\-/g, ""));
	  		$("#defaultUnitCharge").val($("#defaultUnitCharge").val().replace(/,/g, ""));
	  		$("#defaultSellCharge").val($("#defaultSellCharge").val().replace(/,/g, ""));
	  		$("#defaultBuyCharge").val($("#defaultBuyCharge").val().replace(/,/g, ""));
	  		
	  		$.ajax({
	  			url: "/contents/basic/data/insertUserOption.do",
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

$("#defaultUnitCharge, #defaultSellCharge, #defaultBuyCharge").on("input", function(){
	$(this).val(Util.formatNumberInput($(this).val()));
});

$("#defaultReqTel, #defaultSTel").on("input", function(){
	$(this).val(Util.formatPhone($(this).val()));
});

</script>
