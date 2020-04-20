<%@page import="data.dao.ReservationDao"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.RoomDao"%>
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
RoomDao dao=new RoomDao();
ReservationDao rdao=new ReservationDao();
List<String> list=dao.getAllRnum();


%>
<link rel="stylesheet" href="<%=url%>/css/style_header.css">
<style type="text/css">
#logout,#join,#login,#home,#mypage1,#adminpage1:hover{
   cursor: pointer;
}
.mainmenu a{
   display: block;
}
</style>
<script type="text/javascript">
$(function(){
   $(".dropouter").hide();
   $('.mainitem > a').mouseover(function() {
        $(this).parent().find(".dropouter").slideDown('fast');
    }); 
   $('.mainitem > a').mouseover(function() {
        $(this).parent().find(".dropouter2").slideDown('fast');
    });
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
   $("#mypage").click(function(){
     location.href="<%=url%>/index.jsp?main=mypage/mypage.jsp";         
   });
   $('#adminpage').click(function() {
   location.href="<%=url%>/index.jsp?main=admin/adminmain.jsp";            
   });
});


</script>
<style type="text/css">
.dropouter2{
   display: none;
} 
</style>
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
   <%}else if(id.equals("admin")){
   %>
   <li id="adminpage">&nbsp;&nbsp;&nbsp;<span id="adminpage1">관리페이지</span></li>
   <li id="logout">logout</li>
   <%   
   }else{%>
   <li id="mypage"><b><%=name%> 님</b>&nbsp;&nbsp;&nbsp;<span id="mypage1">mypage</span></li>
   <li id="logout">logout</li>
   <%}%>
</ul>
<ul class="mainmenu">
   <li class="mainitem"><a href="index.jsp?main=service/infopage.jsp">INFO</a></li>
   <li class="mainitem">
      <a>ROOM</a>
      <div class="dropouter">
         <ul class="dropmenu">
         	<%for(int i=0;i<list.size();i++){ %>
         	<li class="dropitem"><a href="index.jsp?main=room/room<%=(i+1)%>.jsp"><%=rdao.getRoomName(list.get(i))%></a></li>
            
         	<%} %>
         </ul>
      </div>
   </li>
   <li class="mainitem">
      <a>SERVICE</a>
      <div class="dropouter2">
         <ul class="dropmenu2" >
            <li class="dropitem2"><a href="index.jsp?main=service/servicepage.jsp" id="faci1">FACILITIES</a></li>
            <li class="dropitem2"><a href="index.jsp?main=service/mapservice.jsp" id="faci2">ATTRACTION</a></li>
         </ul>
      </div>
   </li>
   <li class="mainitem"><a href="index.jsp?main=rv/calendar.jsp">RESERVATION</a></li>
   <li class="mainitem"><a href="index.jsp?main=qna/qnalist.jsp">Q&A</a></li>
</ul>
</body>
</html>