<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
String url=request.getContextPath();
%>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#allform{
   border: 1px solid #fc9740;
   padding: 70px;
   width: 400px;
   margin-left: 690px;
   margin-top: 200px;
}
#submit1 {
     text-transform: uppercase;
     outline: 0;
     background: #fc9740;
     width: 150px;
     height: 45px;
     border: 0;
     margin-top: 25px;
     margin-left: 35px;
     padding: 5px;
     color: #FFFFFF;
     font-size: 14px;
     -webkit-transition: all 0.3 ease;
     transition: all 0.3 ease;
     cursor: pointer;     
}
#submit2 {
     text-transform: uppercase;
     outline: 0;
     background: #fc9740;
     width: 150px;
     height: 45px;
     border: 0;
     margin-top: 25px;
     margin-left: 10px;
     padding: 5px;
     color: #FFFFFF;
     font-size: 14px;
     -webkit-transition: all 0.3 ease;
     transition: all 0.3 ease;
     cursor: pointer;     
}
#text{
   font-weight: 700;
   font-size: 15pt;
   text-align: center;
   
}
#lagbongimg{
   size: 100px;
   margin-left: 130px;
}
#btns button:hover{
   background-color: #ffb05c;
   cursor:pointer;
}
</style>
</head>
<body>
<div id="allform">
<img id="lagbongimg" src="<%=url %>/image/labong.png">
<br><br><br>
<div id="text">결제가 정상적으로 완료되었습니다.<br>
라봉펜션을 이용해 주셔서 감사합니다.</div><br>
<div id="btns">
<button id="submit1" onclick="location.href='<%=request.getContextPath()%>/index.jsp'">메인화면 가기</button>
<button id="submit2" onclick="location.href='<%=request.getContextPath()%>/index.jsp?main=mypage/mypage.jsp'">마이페이지 가기</button>
</div>
</div>
</body>
</html>