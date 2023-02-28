<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="Author" content="">
	<meta name="Keywords" content="">
	<meta name="Description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>logslink-login</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/css/common.css">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <link rel="stylesheet" type="text/css" href="/css/media.css">
    <link rel="stylesheet" type="text/css" href="/css/main.css">
    <link rel="stylesheet" type="text/css" href="/css/style_V2.css">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.common.min.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.default-v2.min.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.default.min.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.default.mobile.min.css'/>">
	<script type="text/javascript" src="<c:url value='/js/jquery.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/kendo.all.min.js'/>"></script>
</head>
<body>

<style>
.video-wrap {position:relative; padding-bottom:56.25%; padding-top:0px; height:0; overflow:hidden; pointer-events: none; }
.video-wrap iframe,
.video-wrap object,
.video-wrap embed {position:absolute; top:0; left:0; width:100%; height:100%;}

input:focus {outline: none;}
</style>


<div class="login_wrap">
	<div class="login_cont01">
		<h2>최적의 운송 관리 시스템 로지스링크</h2>
	</div>
	
	<div class="login_cont02">
		
	    <div class="logo pb50">
	    	<img src="/images/logislink_logo_b.png">
	    </div>
		
		<div class="i-1cont">
		    <div class="form">
		      <form id="f" name="f" method="post">
			      <div class="f-w">
			            <div class="id pb20">
			                <label for="" class="pb5" style="display:block;" >아이디</label>
			                <input type="text" autofocus="autofocus" name="userId" id="userId" placeholder="" oninput="handleOnInput(this)" onkeypress="if(event.which==13){goLogin();}" style="background-color:#ffffff; filter: zoom: 1; alpha(opacity=20);border:1px solid #797979;-webkit-box-shadow: 0 0 0 1000px #ffffff inset; -webkit-text-fill-color: #000000;">
			            </div>
			            <div class="pw pb30">
			                <label for="" class="pb5" style="display:inline-block;">비밀번호</label>
			                <input type="password" name="passwd" id="passwd" placeholder="" onkeypress="if(event.which==13){goLogin();}" style="background-color:#ffffff; filter: zoom: 1; alpha(opacity=20);border:1px solid #797979;-webkit-box-shadow: 0 0 0 1000px #ffffff inset;-webkit-text-fill-color: #000000;">
			            </div>
			            <div class="go-log btn_b">
			                <button type="button" onclick="goLogin();">로그인</button>
			            </div>
			            <div class="id pt10 id_find">
			                <label style="display: block;text-align:center;">
			                <a href="/join.do">회원가입</a> |
			                <a href="#" onclick="popFindUserInfo();">ID / 비밀번호 찾기</a>
			                </label>
			            </div>
			      </div>
		      </form>
		    </div>
		</div>
		
		<!-- 카피라이트 / 기존소스  -->
		<div class="copyRight">
			<span>로지스링크 | 전화 : 02-783-1436 | 메일: contact@logis-link.co.kr <br> | 서울시 영등포구 국회대로 70길 12 대산빌딩 1203호 | (c) 2021 Logislink All Rights Reserved</span>
		</div>
		
	</div>
</div>
<!-- 팝업시 -->
<!-- <div id="hd_pop" style="display:none;"> -->
<!--     <div id="hd_pops_35" class="hd_pops" style="top:300px;left:50px"> -->
<!--         <div class="hd_pops_con" style="width:400px;height:550px"> -->
<!--             <p><img src="이미지경로.png" title=""><br style="clear:both;">&nbsp;</p> -->
<!-- 		</div> -->
<!-- 		<div class="hd_pops_footer"> -->
<!--             <button class="hd_pops_reject hd_pops_35 24"><strong>24</strong>시간 동안 다시 열람하지 않습니다.</button> -->
<!--             <button class="hd_pops_close hd_pops_35">닫기 <i class="fa fa-times" aria-hidden="true"></i></button> -->
<!--         </div> -->
<!--     </div> -->
<!-- </div> -->


<!-- 영상컨트롤 -->
<div class="video-wrap" style="display: none;">
    <iframe id="video" width="100%" height="315" src="https://player.vimeo.com/video/701761428?background=1&autoplay=1&loop=1&byline=0&title=0&quality=720" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen="" allow="autoplay"></iframe>
</div>


<!-- // 영상소스 보류
<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/701761428?h=1b9c5270d8&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen style="position:absolute;top:0;left:0;width:100%;height:100%;" title="sr_2020.04.20.mp4"></iframe></div>
<script src="https://player.vimeo.com/api/player.js"></script>
-->



<div id="divFindUserInfo"></div>


<script type="text/javascript">

var mUser;
var mPasswd ;
var mMobile;
var mAuthSeq;
var mUserMainPage;

function goLogin(){

	let defaultPage;

	if(!$("#f input[name=userId]").val()) {
		alert("ID를 입력해주세요.");
		$("#f input[name=userId]").focus();
		return;
	}

	if(!$("#f input[name=passwd]").val()) {
		alert("비밀번호를 입력해주세요.");
		$("#f input[name=passwd]").focus();
		return;
	}

	/*
 	$("#f").attr("action", "/login.do");
	$("#f").submit(); */

	$.ajax({
		url: "/login.do",
		type: "POST",
		data: $("#f").serialize(),
		dataType: "json",
		success: function(data, status, xhr) {

			if(data.result == false){
				alert(data.msg);
				return;
			} else {

				if(data.login.authSeq == "210"){
					defaultPage = "/oms/order/omsOrderList.do";
				} else{
					defaultPage = "/contents/order/orderList.do";
				}

				AgreeCheckLogin(data.login.userId);

				if(data.login.userMainPage == null || data.login.userMainPage == "") {
					location.href = defaultPage;
				} else {
					location.href = data.login.userMainPage;

				}

				loginTalk(data.login.userId, data.login.mobile, data.login.userName);
			}
		},
		error: function(xhr, status, error) {
			alert(xhr.responseText);
			alert(error);
		}
	});
}

function AgreeCheckLogin(userName){
	$.ajax({
		url:"/terms/AgreeUserIndex.do",
		type: "POST",
		data:{
			userId:userName
		},
		dataType: "json",
		success:function(data){

			//console.log("data.result:"+data.result+" data.mode:"+data,mode);
			if(data.result == false && data.mode == "insert"){
				alert("이용약관이 업데이트 되었습니다 갱신이 필요합니다.")
				location.href = "/terms/termsAgree.do";
				//location.href= "/terms/termsAgree.do?&userId="+userName+"&passwd="+passWord+"&mobile="+mobile+"&authSeq="+authSeq+"&userMainPage="+userMainPage;
			}
		}
	});
}

function popFindUserInfo(){
	viewLocation = $("#divFindUserInfo").data("kendoWindow");
	if(viewLocation == null) {
		viewLocation = $("#divFindUserInfo").kendoWindow({
			width: 550,
			height: 623,
			content: {
				url: "/findUserInfo.do"
			},
			iframe: true,
			visible:false
		}).data("kendoWindow");
	} else {
		viewLocation.refresh({url: "/findUserInfo.do"});
	}
	viewLocation.center().open();
}


function loginTalk(userId,mobile,userName){
	$.ajax({
		url:"/loginTalk.do",
		type: "POST",
		data:{
			userId:userId,
			mobile: mobile,
			userName: userName
		},
		dataType: "json",
		success:function(data){

		}
	});
}

//function handleOnInput(e)  {
	//  e.value = e.value.replace(/[^A-Za-z]/ig, '')
	//}
</script>
</body>
</html>
