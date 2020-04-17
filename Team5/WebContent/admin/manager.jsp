<%@page import="data.dao.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	int m=Integer.parseInt(request.getParameter("m"));
	ClientDao dao=new ClientDao();
	if(m==1){
		m=0;
	}
	else{
		m=1;
	}
	int result=dao.updateManager(id, m);
%>
<%=result%>