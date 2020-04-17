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
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/roomaction.jsp" method="post">
	방이름<input type="text" name="rname" value="<%=dto.getRname()%>"><br>
	가격<input type="text" name="price" value="<%=dto.getPrice() %>"><br>
	수용인원<input type="text" name="acception" value="<%=dto.getAcception() %>"><br>
	<input type="hidden" name="rnum" value="<%=rnum%>">
	<button type="submit">수정하기</button>
	<button onclick="history.back();">뒤로가기</button>
	</form>
</body>
</html>