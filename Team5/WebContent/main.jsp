<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
String url=request.getContextPath();
%>
<link rel="stylesheet" href="<%=url%>/css/bxslider.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<style type="text/css">
	*{
		margin: 0;
	    padding: 0;
	    list-style: none;
	}
	a {
		text-decoration: none;
		display: block;
	}
	li {
		display: inline-block;
	}
	#header{
		width: 100%;
		height: 130px;
		border-top: 10px solid #fff;
		z-index: 999;
	}
	#contentarea{
		width: 100%;
	    height: 100%;
	    /* border: 1px solid red; */
	    z-index: -999;
	    background-color: #fff;
	}
	#bxslider{
		position: relative;
	}
	#content{
		width: 1400px;
		height: 2000px;
		margin: 0 auto;
		background-color: #f7f7f7;
	}
	#footer{
		width: 100%;
		height: 130px;
		border-top: 1px solid #ddd;
		background-color: #f7f7f7;
	}
</style>
</head>
<body>
<div id="wrapper">
	<div id="header"><jsp:include page="header.jsp"/></div>
	<div id="contentarea">
		<div id="bxslider"><jsp:include page="bxslider.jsp"/></div>
		<div id="content"><jsp:include page="content.jsp"/></div>
	</div>
	<div id="footer"><jsp:include page="footer.jsp"/></div>
</div>
</body>
</html>