<%@page import="data.dao.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	메인페이지;;
	<%
	String id=(String)session.getAttribute("id");
	String name="비회원";
	if(id!=null){
	ClientDao dao=new ClientDao();
	name=dao.getName(id);
	}
	%>
	<%=name %>님 환영합니다^^<br>
	<button onclick="location.href='logoutaction.jsp'">로그아웃</button>
</body>
</html>