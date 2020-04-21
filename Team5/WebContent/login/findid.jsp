<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>라봉 아이디 찾기</title>
<%
String url=request.getContextPath();
%>
<script type="text/javascript">
$(function(){
	$("#mainlink").click(function() {
		location.href="<%=url %>/index.jsp";		
	});
});
</script>
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap')
	;

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
	font-family: 'Noto Sans KR', sans-serif;
}
.form img {
	margin-left: 327px;
	padding-top: 230px;
}
.findidtb {
	margin: 10px 0 0 259px;
}
.findidtb h3{
	margin: 20px 0 10px 70px;
}
.findid_info {
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
.findid_info:active, .findid_info:focus {
	border: 0.2px solid #fc9740;
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
<a href="<%=url %>/index.jsp" title="메인 화면으로 이동"><img src="<%=url %>/image/la2.png"></a>
	<div class="findidtb">
		<h3>아이디 찾기</h3>
		<form action="<%=request.getContextPath()%>/login/findidresult.jsp" method="post">
			이름<br>
			<input type="text" name="name" required="required" class="findid_info"><br>
			이메일<br>
			<input type="text" name="email" required="required" class="findid_info"><br>
			<input type="submit" value="아이디 찾기" class="btn_findid">
			<button type="button" onclick="history.back()" class="btn_findid">뒤로 가기</button>
		</form>
	</div>
	<div class="copyright">Copyright © 
		<p id="mainlink">라봉펜션</p>. All Rights Reserved.</div>
	</div>
</div>
</body>
</html>