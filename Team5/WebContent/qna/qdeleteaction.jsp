<%@page import="data.dto.QnaDto"%>
<%@page import="data.dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	String pass = request.getParameter("pass");
	
	QnaDao db = new QnaDao();
	QnaDto dto = new QnaDto();
	
	int eql = db.deleteQna(num, pass);
		
%>
<%=eql%>