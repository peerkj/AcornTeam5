<%@page import="java.text.DecimalFormat"%>
<%@page import="data.dto.CanrvDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ReservationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
th,td{
	padding: 10px;
	text-align: center;
}
th{
	background-color: #ffe5bd;
}
</style>
</head>
<%
   String id = (String)session.getAttribute("id");
   ReservationDao db = new ReservationDao();
   List<CanrvDto> list = db.getCancelUse(id);
   DecimalFormat formatter = new DecimalFormat("###,###");   
%>
<body>
<table style="width: 800px;margin: 20px 0;border-collapse: collapse;">
   <caption style="font-size: 30px;margin-bottom: 10px;"><b>취소내역</b></caption>
   <tr>
      <th>방이름</th>
      <th>입실일</th>
      <th>퇴실일</th>
      <th>기본요금</th>
      <th>추가요금</th>
      <th>총요금</th>
   </tr>
   <%if(list.size()==0) {%>
      <tr>
         <td colspan="6">예약취소내역이 없습니다</td>
      </tr>
   <%}%>
   <%
   for(CanrvDto dto:list){
      String rname = db.getRoomName(dto.getRnum());
      int price = Integer.parseInt(dto.getPrice());
      int additional = Integer.parseInt(dto.getAdditional());
      int totalPrice = Integer.parseInt(dto.getPrice()) + Integer.parseInt(dto.getAdditional());      
   %>
      
      <tr>
         <td><%=rname %></td>
         <td><%=dto.getStartday().substring(0, 10) %></td>
         <td><%=dto.getEndday().substring(0, 10) %></td>
         <td><%=formatter.format(price) %></td>
         <td><%=formatter.format(additional) %></td>
         <td><%=formatter.format(totalPrice) %></td>         
      </tr>
   <%}%>

</table>
</body>
</html>