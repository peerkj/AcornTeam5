<%@page import="data.dao.RoomDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Double rate=Double.parseDouble(request.getParameter("rate"));
	RoomDao dao=new RoomDao();
	int result=dao.updateRate(rate);
%>
<%=result%>