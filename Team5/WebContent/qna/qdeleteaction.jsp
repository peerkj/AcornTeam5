<%@page import="data.dto.QnaDto"%>
<%@page import="data.dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num = request.getParameter("num");
	String pass = request.getParameter("pass");
	
	QnaDao db = new QnaDao();
	
	int eql = db.deleteQna(num, pass);
		
%>
<%=eql%>