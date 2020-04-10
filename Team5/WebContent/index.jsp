<%@page import="data.dao.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
var url="";
$(function(){
	url=$("#url").val();		
});
function logout() {
	location.href=url+"/login/logoutaction.jsp";
}
</script>
</head>
<body>
<%String url=request.getContextPath(); %>
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
	<%if(id!=null){ %>
	<input type="hidden" id="url" value="<%=url%>">
	<button onclick="logout()">로그아웃</button>
	<%} %>
</body>
</html>