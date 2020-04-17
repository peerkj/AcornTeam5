<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(function(){
	});
</script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Rozha+One&display=swap');
/* @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Noto+Serif+KR:wght@300;600;700&display=swap'); */
#allmypage{ 
	width:100%;
    height:540px;
    position:relative;
} 
#mypagebox{
	width: 200px;
	heiht: 200px;
	margin: 0 40px 20px;
	float: left;
}
#mypagebox ul{ 
	background-color: #faa727;
	list-style-type: none;
	margin: 0;
	padding: 0;
}
#mypagebox li{
	display: block;
	padding: 10px;
	text-decoration: none;
	font-weight: bold;
	font-weight: 500;
	background-color: #faa727;
}
#mypagebox li:hover {
	background-color: #fbc777;
}
.mylist a{
	color: #fff;
}
#select{
	width:400px;
    height:200px;
    margin-left: 850px;
    margin-top: 100px;
    float: center;
}
.hd_img{
   height: 400px;
   width: 100%;
   background-size: cover;
   background-image: url('image/mypage.jpg');
   position: relative;
}
.img_title{
   width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.1);
} 
.img_title span{
   font-size: 70pt;
   font-weight: 700;
   color: #fff;
   position: absolute;
   bottom: -40px;
    left: 300px;
    font-family: 'Rozha One', serif;
}
</style>
</head>
<body>
<div class="hd_img">
   <div class="img_title"><span>MY PAGE</span></div>
</div>
<div id="allmypage">
<div id="mypagebox">
<ul>
	<li class="mylist"><a href="<%=request.getContextPath()%>#">예약 내역</a></li>
	<li class="mylist"><a href="<%=request.getContextPath()%>#">질문 내역</a></li>
	<li class="mylist"><a href="<%=request.getContextPath()%>/index.jsp?main=mypage/mypage.jsp?select=checkpass.jsp?ck=1">회원정보 수정</a></li>
	<li class="mylist"><a href="<%=request.getContextPath()%>/index.jsp?main=mypage/mypage.jsp?select=updatepass.jsp">비밀번호 변경</a></li>
	<li class="mylist"><a href="<%=request.getContextPath()%>/index.jsp?main=mypage/mypage.jsp?select=checkpass.jsp?ck=2">탈퇴하기</a></li>

</ul>
</div>
<div id="select">	
	<%
		String select=request.getParameter("select");
		if(select!=null){
	%>
	<jsp:include page="<%=select%>"/>
	<%}%>
</div>
</div>
</body>
</html>