<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <meta name="Author" content="">
	<meta name="Keywords" content="">
	<meta name="Description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>로지스링크</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/css/common.css">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <link rel="stylesheet" type="text/css" href="/css/media.css">
    <link rel="stylesheet" type="text/css" href="/css/main.css">
	<script type="text/javascript" src="<c:url value='/js/jquery.min.js'/>"></script>
	<script>
		$.ajax({
			url:"/terms/content.do",
			data:"",
			success:function (data) {

				$('#result tr:gt(0)').remove();
				let str ="";

				str += data.tResult[4].detail;
				$("#result").append(str);
			},
			dataType:"json"
		});
	</script>
</head>
<body id="result"></body>
</body>
</html>