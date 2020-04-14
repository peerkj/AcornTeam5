<%@page import="data.dto.ReviewDto"%>
<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String revnum = request.getParameter("revnum");

	ReviewDao db = new ReviewDao();
	
	db.deleteReview(revnum);		
%>