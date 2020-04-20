<%@page import="data.dao.ReservationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
   String url = request.getContextPath();
	ReservationDao dao=new ReservationDao();

%>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300;400;500;600;700&display=swap');
.roombox{
   background-color: #fff;
   width: 600px;
   height: 750px;
}
#room1,#room3,#room5{
   margin: 150px 0;
}
#room2,#room4,#room6{
   float: right;
   margin-top: -900px;
}
.roomimg img{
   width: 100%;
   height: 350px;   
}
.roominfo {   
   width: 500px;
   height: 350px;
   padding: 50px;
   text-align: center;
}
.roomnum{
   font-size: 22pt;
   font-weight: 700;
   border-bottom: 1px solid #dfdfdf;
   padding-bottom: 10px;
}
.roomtxt{
   margin: 50px 0;
   color: #888888;
   font-weight: 300;
   font-size: 14pt;
}
.roombox button{
   width: 150px;
   height: 50px;
   background-color: #eeeeee;
   border: none;
   font-size: 12pt;
}
.roombox button:hover{
   background-color: #e5e4e4;
   cursor: pointer;
}
</style>
</head>
<body>
<div class="roombox" id="room1">
   <div class="roomimg">
      <img src="<%=url %>/image/room1-3.jpg">
   </div>
   <div class="roominfo">
      <span class="roomnum"><%=dao.getRoomName("7")%></span>
      <p class="roomtxt">객실은 공간 활용이 돋보이는 크기로 심플하고 모던한 방입니다.<br>깨끗하고 정돈된 침구 용품과 가구 및 다양한 편의 용품을 비치<br>하여 편안한 휴식을 제공합니다.</p>
      <a href="index.jsp?main=room/room1.jsp"><button type="button">자세히</button></a>
   </div>
</div>
<div class="roombox" id="room2">
   <div class="roomimg">
      <img src="<%=url %>/image/room2-3.jpg">
   </div>
   <div class="roominfo">
      <span class="roomnum"><%=dao.getRoomName("8")%></span>
      <p class="roomtxt">객실은 공간 활용이 돋보이는 크기로 심플하고 모던한 방입니다.<br>깨끗하고 정돈된 침구 용품과 가구 및 다양한 편의 용품을 비치<br>하여 편안한 휴식을 제공합니다.</p>
      <a href="index.jsp?main=room/room2.jsp"><button type="button">자세히</button></a>
   </div>
</div>
<div class="roombox" id="room3">
   <div class="roomimg">
      <img src="<%=url %>/image/room3-4.jpg">
   </div>
   <div class="roominfo">
      <span class="roomnum"><%=dao.getRoomName("9")%></span>
      <p class="roomtxt">Room 3은 복층 구조의 거실과 침실을 갖추고 있습니다.<br>
      독창적인 시설의 조화가 어우러진 고급형 객실입니다.</p>
      <a href="index.jsp?main=room/room3.jsp"><button type="button">자세히</button></a>
   </div>
</div>
<div class="roombox" id="room4">
   <div class="roomimg">
      <img src="<%=url %>/image/room4-4.jpg">
   </div>
   <div class="roominfo">
      <span class="roomnum"><%=dao.getRoomName("10")%></span>
      <p class="roomtxt">Room 4는 복층 구조의 거실과 침실을 갖추고 있습니다.<br>
      독창적인 시설의 조화가 어우러진 고급형 객실입니다.</p>
      <a href="index.jsp?main=room/room4.jsp"><button type="button">자세히</button></a>
   </div>
</div>
<div class="roombox" id="room5">
   <div class="roomimg">
      <img src="<%=url %>/image/room5-2.jpg">
   </div>
   <div class="roominfo">
      <span class="roomnum"><%=dao.getRoomName("42")%></span>
      <p class="roomtxt">복층 구조로 이루어져 가족 단위 숙박에 제격입니다.<br>
      숙소 내에서 개인 스파 시설을 이용하실 수 있습니다.</p>
      <a href="index.jsp?main=room/room5.jsp"><button type="button">자세히</button></a>
   </div>
</div>
<div class="roombox" id="room6">
   <div class="roomimg">
      <img src="<%=url %>/image/room6-2.jpg">
   </div>
   <div class="roominfo">
      <span class="roomnum"><%=dao.getRoomName("43")%></span>
      <p class="roomtxt">복층 구조로 이루어져 가족 단위 숙박에 제격입니다.<br>
      테라스가 있어 아이들과 함께하기 좋은 방입니다.</p>
      <a href="index.jsp?main=room/room6.jsp"><button type="button">자세히</button></a>
   </div>
</div>
</body>
</html>