<%@page import="data.dao.ReservationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String resnum = request.getParameter("resnum");

	ReservationDao db = new ReservationDao();
	
	db.CancelRequest(resnum);
%>