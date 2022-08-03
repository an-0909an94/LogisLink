<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core"       %>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="ui"      uri="http://egovframework.gov/ctl/ui"         %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"     %>
<%@ taglib prefix="tiles" 	uri="http://tiles.apache.org/tags-tiles" %>
<%
response.setHeader ("Pragma", "No-cache");
response.setDateHeader ("Expires", 0);
response.setHeader ("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Cache-Control" content="No-Cache">
<meta http-equiv="pragma" content="No-cache">
<meta http-equiv="expires" content="0">
<title>로지스링크</title>
<!-- kendo ui CSS -->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.common.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.default-v2.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.default.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendo.default.mobile.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css?v=2'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css?v=7'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/left.css?v=2'/>">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bcPicker.css'/>">

<!-- jQuery JS -->
<script type="text/javascript" src="<c:url value='/js/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/kendo.all.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jszip.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/grid.js?v=2'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common.js?v=1'/>"></script>
<script type="text/javascript" src="<c:url value='/js/util.js?v=7'/>"></script>
<script type="text/javascript" src="<c:url value='/js/order.js?v=13'/>" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ==" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/bcPicker.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/privateCommon.js?v=3'/>" ></script>

<!-- validator JS -->
<script src="/js/validator.min.js"></script>

</head>
<body>
	<tiles:insertAttribute name="header" />
	<tiles:insertAttribute name="left" />	
	<tiles:insertAttribute name="body" />
	<tiles:insertAttribute name="footer"/>
</body>
</html>