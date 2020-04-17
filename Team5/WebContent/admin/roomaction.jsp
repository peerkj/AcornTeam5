<%@page import="data.dao.RoomDao"%>
<%@page import="data.dto.RoomDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8");
	String rnum=request.getParameter("rnum");
	String rname=request.getParameter("rname");
	String acception=request.getParameter("acception");
	String price=request.getParameter("price");
	
	RoomDto dto= new RoomDto();
	RoomDao dao= new RoomDao();
	dto.setRnum(rnum);
	dto.setRname(rname);
	dto.setPrice(price);
	dto.setAcception(acception);
	
	dao.updateRoom(dto);
	response.sendRedirect(request.getContextPath()+"/admin/room.jsp");
%>