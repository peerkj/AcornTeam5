<%@page import="data.dao.ClientDao"%>
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
<link rel="stylesheet" href="<%=url%>/css/style_header.css">
<style type="text/css">
#logout,#join,#login,#home:hover{
	cursor: pointer;
}
</style>
<script type="text/javascript">
$(function(){
	$(".dropouter").hide();
	$('.mainitem > a').mouseover(function() {
        $(this).parent().children().slideDown('slow');
    })
    $("#home").click(function() {
    	location.href="index.jsp";
    });
	$("#login").click(function() {
		location.href="login/loginform.jsp";		
	});
	$("#join").click(function() {
		location.href="register/registerform.jsp";		
	});
	$("#logout").click(function() {
		location.href="login/logoutaction.jsp";		
	});
});
</script>
</head>
<body>
<h1 class="logo"><img id="home" src="image/logo.png" style="height: 120px;"></h1>
<ul class="info">
	<%
	String id=(String)session.getAttribute("id");
	ClientDao db=new ClientDao();
	String name=db.getName(id);
	if(id==null){
	%>
	<li id="login">login</li>
	<li id="join">join</li>
	<%}else{%>
	<li id="mypage"><%=name%> 페이지</li>
	<li id="logout">로그아웃</li>
	<%}%>
</ul>
<ul class="mainmenu">
	<li class="mainitem"><a>ROOM</a>
		<div class="dropouter">
			<ul class="dropmenu" >
				<li class="dropitem"><a href="#">ROOM01</a></li>
				<li class="dropitem"><a href="#">ROOM02</a></li>
				<li class="dropitem"><a href="#">ROOM03</a></li>
				<li class="dropitem"><a href="#">ROOM04</a></li>
				<li class="dropitem"><a href="#">ROOM05</a></li>
				<li class="dropitem"><a href="#">ROOM06</a></li>
				<li class="dropitem"><a href="#">ROOM07</a></li>
				<li class="dropitem"><a href="#">ROOM08</a></li>
				<li class="dropitem"><a href="#">ROOM09</a></li>
				<li class="dropitem"><a href="#">ROOM10</a></li>
			</ul>
		</div>
	</li>
	<li class="mainitem"><a href="index.jsp?main=service/servicepage.jsp">SERVICE</a></li>
	<li class="mainitem"><a>INFORMATION</a></li>
	<li class="mainitem"><a>RESERVATION</a></li>
	<li class="mainitem"><a href="index.jsp?main=qna/qnalist.jsp">Q&A</a></li>
</ul>
</body>
</html>