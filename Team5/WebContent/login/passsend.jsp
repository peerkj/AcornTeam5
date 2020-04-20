<%@page import="data.dao.ClientDao"%>
<%@page import="data.dao.MailSend"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<%
	String url =request.getContextPath();
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	String newPass = null;

	ClientDao db = new ClientDao();
	String pass= db.findPass(id, email);
	
	if(!pass.equals("0")){
		MailSend ms = new MailSend();
		newPass = ms.naverMailSend(email);
	}
	
	if(newPass!=null)
		db.updatePass(id, newPass);	
%>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
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
.findpasstb {
	margin: 10px 0 0 270px;
	font-family: 'Noto Sans KR', sans-serif;
}
.findpasstb h3{
	margin: 20px 0 10px 70px;
}
.findpass_info {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	outline: 0;
	background: #ececee;
	width: 250px;
	border: 0;
	margin: 0 0 15px;
	padding: 15px;
	box-sizing: border-box;
	font-size: 14px;
}
.findpass_info:active, .findpass_info:focus {
	border: 0.2px solid #fc9740;
}
.findpasstb button {
	font-family: 'Noto Sans KR', sans-serif;
	text-transform: uppercase;
	outline: 0;
	background: #fc9740;
	width: 230px;
	border: 0;
	padding: 15px;
	color: #FFFFFF;
	font-size: 15px;
	-webkit-transition: all 0.3 ease;
	transition: all 0.3 ease;
}
.findpasstb button:hover, .findpasstb button:active, .findpasstb button:focus {
	background: #ffb05c;
	cursor: pointer;
}
.findpasstb p {
	margin:30px 0 30px -28px;
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
	<div class="findpasstb">
		<%if(newPass!=null){%>	
			<p>이메일로 임시 비밀번호가 전송되었습니다.</p>
			<button type="button" onclick="location.href='<%=url%>/login/loginform.jsp'">로그인</button>
		<%}else{%>
			<script type="text/javascript">
		         alert("입력하신 정보가 올바르지 않습니다");
		         history.back();
		    </script>
		<%} %>
	</div>
	<div class="copyright">Copyright © 
			<p id="mainlink">라봉펜션</p>. All Rights Reserved.</div>
	</div>
</div>
</body>
</html>