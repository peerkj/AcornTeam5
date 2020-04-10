<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<ul>

	
	<li><a href="index.jsp?main=mypage/mypage.jsp?select=../login/updateclient.jsp">회원정보수정</a></li>
	<li><a href="index.jsp?main=mypage/mypage.jsp?select=../login/updatepass.jsp">비밀번호변경</a></li>
	<%
		String select=request.getParameter("select");
		if(select!=null){
	%>
	<jsp:include page="<%=select%>"></jsp:include>
	<%}%>
</ul>
</body>
</html>