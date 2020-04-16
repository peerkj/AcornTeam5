<%@page import="data.dao.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pass=request.getParameter("pass");
	String newpass=request.getParameter("newpass");
	String id=(String)session.getAttribute("id");
	//비밀번호 체크하고
	ClientDao dao=new ClientDao();
	int result=dao.login(id, pass);
	//1이면 비번일치/0이면 틀림
	if(result==1&&newpass!=null){
		//여기서 비밀번호 변경
		result=dao.updatePass(id, newpass);
	}
%>
<%=result%>