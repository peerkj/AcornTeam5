<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Roboto:300');
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&family=Noto+Serif+KR:wght@300;600;700&display=swap');
#success_text{
	font-family: 'Noto Sans KR', serif;
	font-weight: 400;
	font-size: 15pt;
	margin-left: 2px;
}
#success_body button {
	font-family: "Roboto", sans-serif;
	text-transform: uppercase;
	outline: 0; 
	background: #fc9740; 
	width: 200px;
	height: 50px;
	border: 0;
	margin-top:10px;
	margin-left:8px;
	padding: 5px;
	color: #FFFFFF;
	font-size: 14px;
	-webkit-transition: all 0.3 ease;
	transition: all 0.3 ease;
	cursor: pointer;  
   }
#success_body{
	border: 1px solid #fc9740;
	padding: 70px;
	width: 225px;
}
</style>
</head>
<body>
<div id="success_body">
<span id="success_text">&nbsp;탈퇴가 완료되었습니다.<br>
이용해 주셔서 감사합니다.</span>
<button onclick="location.href='<%=request.getContextPath()%>/index.jsp'">메인화면 가기</button>
</div>
</body>
</html>