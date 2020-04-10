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
<link rel="stylesheet" href="<%=url%>/css/style.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<%
	String main=request.getParameter("main");
%>
<body>
<div id="wrapper">
	<div id="header"><jsp:include page="header.jsp"/></div>
	<div id="contentarea">
	<%if(main==null){ %>
		<div id="bxslider"><jsp:include page="bxslider.jsp"/></div>
		<div id="content"><jsp:include page="content.jsp"/></div>
		<%}else{ %>
		<jsp:include page="<%=main %>"/>
		<%} %>
	</div>
	<div id="footer"><jsp:include page="footer.jsp"/></div>
</div>
</body>
</html>