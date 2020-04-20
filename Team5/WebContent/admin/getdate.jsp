<%@page import="data.dao.GetDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int year=Integer.parseInt(request.getParameter("year"));
	int month=Integer.parseInt(request.getParameter("month"));
	GetDate gd=new GetDate();
	String result=gd.getDate(year, month);
%>
<%=result%>