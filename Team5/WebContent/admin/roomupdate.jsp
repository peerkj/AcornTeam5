<%@page import="data.dao.RoomDao"%>
<%@page import="data.dto.RoomDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방정보 수정</title>
<%

   request.setCharacterEncoding("utf-8");
   String rnum=request.getParameter("rnum");
   RoomDao dao=new RoomDao();
   RoomDto dto= dao.getRoom(rnum);
%>
<style type="text/css">
b,input{
   padding: 5px;
}
button{
   font-size: 15px;
    width: 110px;
    height: 35px;
    padding: 5px 10px;
    background-color: #faa727;
    border: none;
    border-radius: 10px;
    color: #fff;
   cursor: pointer;
}
</style>
</head>
<body>
   <form action="<%=request.getContextPath()%>/admin/roomaction.jsp" method="post">
   <div style="padding: 20px;border: 4px solid #ddd;display: inline-block;box-sizing: border-box;">
      <div style="margin-bottom: 8px;"><b>방이름</b>&nbsp;<input type="text" name="rname" value="<%=dto.getRname()%>"><br></div>
      <div style="margin-bottom: 8px;"><b>가&nbsp;&nbsp;&nbsp;격</b>&nbsp;<input type="text" name="price" value="<%=dto.getPrice() %>"><br></div>
      <div style="margin-bottom: 8px;"><b>수용인원</b>&nbsp;<input type="text" name="acception" style="width: 160px;" value="<%=dto.getAcception() %>"><br></div>
      <input type="hidden" name="rnum" value="<%=rnum%>">
      <button type="submit" style="margin-left: 15px;">수정하기</button>
      <button onclick="history.back();">뒤로가기</button>
   </div>
   </form>
</body>
</html>