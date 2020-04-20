<%@page import="data.dao.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	ClientDao db = new ClientDao();
	
	String id = db.findId(name, email);
	
	String url =request.getContextPath();
%>
<title>아이디 찾기</title>
<script type="text/javascript">
$(function(){
	$("#mainlink").click(function() {
		location.href="<%=url %>/index.jsp";		
	});
});
</script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap');

* {
	margin: 0;
	padding: 0;
}
body {
	background-color: #ececee;
}
.form {
	position: relative;
	width: 768px;
	height: 100vh;
	background-color: white;
	margin-left: 576px;
	padding-top: 0;
}

.form img {
	margin-left: 327px;
	padding-top: 230px;
}

.findidtb {
	margin: 10px 0 0 259px;
}
.findidtb p{
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	margin: 30px 0 30px 10px;
}
.btn_findid {
	font-family: 'Noto Sans KR', sans-serif;
	text-transform: uppercase;
	outline: 0;
	background: #fc9740;
	width: 121px;
	border: 0;
	padding: 15px;
	color: #FFFFFF;
	font-size: 14px;
	-webkit-transition: all 0.3 ease;
	transition: all 0.3 ease;
}
.btn_findid:hover, .btn_findid:active, .btn_findid:focus {
	background: #ffb05c;
	cursor: pointer;
}
#mainlink {
	cursor: pointer;
	display: inline;
}
.copyright {
	position: absolute;
	color: #c0c1c1;
	font-size: 9pt;
	bottom: 10px;
	left: 260px;
}
</style>
</head>
<body>
<div class="form">
	<a href="<%=url %>/index.jsp" title="메인 화면으로 이동"><img src="<%=url %>/image/labong.png"></a>
	<div class="findidtb">
		<p>
		<%if(!id.equals("0")){%>
		<b><%=name %></b> 님의 아이디는 <b><%=id %></b>입니다
		<%}else{%>
			입력하신 정보와 일치하는 ID가 없습니다
		<%}%>
		</p>
		<button type="button" onclick="location.href='<%=url%>/login/loginform.jsp'" class="btn_findid">로그인</button>
		<button type="button" onclick="history.back()" class="btn_findid">뒤로 가기</button>
	</div>
	<div class="copyright">Copyright © 
			<p id="mainlink">라봉펜션</p>. All Rights Reserved.</div>
	</div>
</div>
</body>
</html>