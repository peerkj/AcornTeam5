<%@page import="data.dao.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=request.getParameter("id");
	String pass=request.getParameter("pass");	
	ClientDao dao=new ClientDao();
	int result=dao.login(id, pass);
	if(result==1){
		session.setAttribute("id",id);
	}
%>
<%=result%>