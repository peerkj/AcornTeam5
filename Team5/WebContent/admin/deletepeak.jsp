<%@page import="data.dao.RoomDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pnum=request.getParameter("pnum");
	String url=request.getContextPath();

	RoomDao dao=new RoomDao();
	dao.deletePeak(pnum);
	response.sendRedirect(url+"/index.jsp?main=admin/adminmain.jsp?select=room.jsp");
%>