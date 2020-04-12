<%@page import="data.dao.AnswerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String url = request.getContextPath();
	String qnum = request.getParameter("qnum");
	String pageNum = request.getParameter("pageNum");
	
	AnswerDao db = new AnswerDao();
	db.deleteAnswer(qnum);
	
	response.sendRedirect(url+"/qna/qnalist.jsp?pageNum="+pageNum);
%>