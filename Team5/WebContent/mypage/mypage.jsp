<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(function(){
	});
</script>
</head>
<body>
<ul>
	<li><a href="<%=request.getContextPath()%>/index.jsp?main=mypage/mypage.jsp?select=checkpass.jsp?ck=1">회원정보수정</a></li>
	<li><a href="<%=request.getContextPath()%>/index.jsp?main=mypage/mypage.jsp?select=updatepass.jsp">비밀번호변경</a></li>
	<li><a href="<%=request.getContextPath()%>/index.jsp?main=mypage/mypage.jsp?select=checkpass.jsp?ck=2">탈퇴하기</a></li>

</ul>	
	<%
		String select=request.getParameter("select");
		if(select!=null){
	%>
	<jsp:include page="<%=select%>"/>
	<%}%>

</body>
</html>