<%@page import="java.text.NumberFormat"%>
<%@page import="data.dao.RoomDao"%>
<%@page import="data.dao.ReservationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
String url=request.getContextPath();
ReservationDao dao =new ReservationDao();

RoomDao roomdao=new RoomDao();
NumberFormat nf=NumberFormat.getInstance();
int price=Integer.parseInt(roomdao.getRoom("42").getPrice());
int add=(int)(price+price*roomdao.getRate());
%>
<link rel="stylesheet" href="<%=url%>/css/jquery.bxslider_room.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="<%=url %>/js/jquery.bxslider.js"></script>
<script type="text/javascript">
$(function(){ 
   /* 이미지 슬라이더 */
    $('.bxslider').bxSlider({
        auto: true, // 자동으로 애니메이션 시작 여부 (true면 자동 슬라이드, false는 자동 슬라이드 안함)
        speed: 300, // 애니메이션 속도
        pause: 3000, // 애니메이션 유지 시간 (1000은 1초)
        autoControls: false, // 시작 및 중지버튼 여부 (true면 보여짐, false는 안보임)
        pager: true, // 페이지 표시 여부 (true면 보여짐, false는 안보임)
        mode: 'fade', // 슬라이드 모드 ('fade', 'horizontal', 'vertical' 이 있음)
        captions: false // img 태그에 사용되는 title 속성을 이용해서 이미지 위에 텍스트를 넣을 수 있음 (true면 보여짐, false는 안보임)
    }); 
});
</script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300;400;500;600;700&display=swap');
.room1-image {
    position: relative;
    width: 100%;
    height: 1000px;
    background-image: url(image/room5.jpg);
    background-repeat: no-repeat;
    background-size: cover; /* contain:비율에 맞게 | cover: 비율무시  */    
}
.room1-02 { background-image: url(image/room5-2.jpg); }
.room1-03 { background-image: url(image/room5-3.jpg); }
.room1-04 { background-image: url(image/room5-4.jpg); }
.room1-05 { background-image: url(image/room5-5.jpg); }
.room1-06 { background-image: url(image/room5-6.jpg); }
.roomcontent-group{
   width: 100%;
   height: 100%;
   /* background-image: url('image/bb.jpg');
   background-size: cover; */
}
.roomcontent{
   width: 80%;
   margin: 0 auto;
}
.roomname{
   font-weight: 700;
    font-size: 50px;
    color: #3f3b3b;
}
.box1::after{
   content: "";
   display: block;
   clear: both;
}
.box1,.box2,.box3{
   padding-top: 120px;
}
.box2{
   position: relative;
   margin: 70px 0;
}
.text1{
   font-family: 'Noto Serif KR', serif;
   position: absolute;
   top: 450px;
    right: 280px;
   font-size: 14pt;
	font-weight: 400;
   color: #666;
}
.text2{
   font-family: 'Noto Serif KR', serif;
   position: absolute;
   top: 530px;
   right: 290px;
   font-size: 14pt;
   font-weight: 600;
    color: #3f3b3b;
}
#pricegroup{
	margin:100px 0 50px 750px;
}
#pricetb{
	margin:0 0 50px 30px;
	border-collapse: collapse;
	border: 1px solid #cccccc;
}
#pricetb th{
	background-color: #eeeeee;
	border: 1px solid #cccccc;
	padding: 5px;
}
#pricetb td{
	border: 1px solid #cccccc;
	width: 150px;
	text-align: center;
	padding: 5px;
}
#pricetb caption{
	padding-bottom: 15px;
	font-size: 13pt;
	font-weight: 700;
}
#gorv{
	width: 200px;
	height: 50px;
	background-color: #eeeeee;
	border: none;
	font-size: 12pt;
	font-style: none;
	margin-left: 90px;
	font-weight: 700;
}
#gorv:hover{
	background-color: #e5e4e4;
	cursor: pointer;
}
#reviewbox{
	width:900px;
} 
</style>
</head>
<body>
<div class="room1-image-group">
   <ul class="bxslider">
       <!-- 첫번째 이미지 -->
        <li>
            <div class="room1-image">
            </div>                           
        </li>
        <!-- //첫번째 이미지 -->

        <!-- 두번째 이미지 -->
        <li>
            <div class="room1-image room1-02">
            </div>
        </li>
        <!-- //두번째 이미지 -->

        <!-- 세번째 이미지 -->
        <li>
            <div class="room1-image room1-03">
            </div>
        </li>
        <!-- //세번째 이미지 -->
        <!-- 네번째 이미지 -->
        <li>
            <div class="room1-image room1-04">
            </div>
        </li>
        <!-- //네번째 이미지 -->
        <!-- 다섯번째 이미지 -->
        <li>
            <div class="room1-image room1-05">
            </div>
        </li>
        <!-- //다섯번째 이미지 -->
        <!-- 여섯번째 이미지 -->
        <li>
            <div class="room1-image room1-06">
            </div>
        </li>
        <!-- //여섯번째 이미지 -->
    </ul>
</div>
<div class="roomcontent-group">
   <div class="roomcontent">
      <div class="box1" style="width: 100%;">
         <div style="padding: 100px 50px;float: left;">
            <span class="roomname"><%=dao.getRoomName("42") %></span>
            <div style="font-family: 'Montserrat', sans-serif; font-size:40px;margin-top: 50px;">Room Information </div>
            <div style="font-size:18px;">객실정보</div>
            <div style="font-size:16px; line-height:25px; margin-top:40px;">
            
            평수 : 30평<br>
            기준 : 4명　최대 : 6명<br><br>
            ※ TV, 냉장고, 전자렌지, 주방용품, 욕실용품
            </div>
         </div>
         <img src="<%=url %>/image/room5-2.jpg" style="width: 1000px; height: 600px; float: right;">
         
      </div>
      <br>
      <div class="box2" style="width: 100%;">
         <img src="<%=url %>/image/room5-4.jpg" style="width: 900px; height: 500px;">
         <p class="text1">당신의 완벽한 하루를 위해,<br>편안하게 쉴 수 있는 공간을 마련했어요</p>
         <p class="text2">Labong Pension<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rest for you..</p>
      </div>
      <br>
      <div class="box3" style="width: 100%;">
         <img src="<%=url %>/image/room5-3.jpg" style="width: 1050px; height: 600px; margin-left: 200px;">
      </div>
   </div>
   <div id="pricegroup">
		<table id="pricetb">
			<caption>가격 정보</caption>
			<tr>
				<th>주중</th>
				<th>주말</th>
			</tr>
			<tr>
				<td><%=nf.format(price) %></td>
				<td><%=nf.format(add) %></td>
			</tr>
			<tr>
				<td colspan="2">※성수기는 위 요금의 1.5배</td>
			</tr>
		</table>
		<button type="button" id="gorv" onclick="location.href='<%=url%>/index.jsp?main=rv/calendar.jsp'">예약하기</button>
   </div>
   <div id="reviewbox">
	<jsp:include page="../review/reviewlist.jsp">
		<jsp:param value="42" name="rnum"/>
	</jsp:include>
	</div>
</div>
</body>
</html>