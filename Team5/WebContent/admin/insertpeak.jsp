<%@page import="data.dto.PeakDto"%>
<%@page import="data.dao.RoomDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String startday=request.getParameter("startday");
	String endday=request.getParameter("endday");
	String url=request.getContextPath();
	Double rate=Double.parseDouble( request.getParameter("rate"));

	RoomDao rdao=new RoomDao();
	PeakDto dto=new PeakDto();
	dto.setStartday(startday);
	dto.setEndday(endday);
	dto.setPeak_rate(rate);
	rdao.insertPeak(dto);

	response.sendRedirect(url+"/index.jsp?main=admin/adminmain.jsp?select=room.jsp");
	
%>