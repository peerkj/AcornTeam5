<%@page import="data.dto.CanrvDto"%>
<%@page import="data.dto.ReservationDto"%>
<%@page import="data.dao.ReservationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String url=request.getContextPath();
	String resnum=request.getParameter("resnum");
	String pageNum=request.getParameter("pageNum");
	
	ReservationDao dao=new ReservationDao();
	ReservationDto rdto=dao.getRv(resnum);
	CanrvDto candto=new CanrvDto();
	
	candto.setId(rdto.getId());
	candto.setName(rdto.getName());
	candto.setHp(rdto.getHp());
	candto.setRnum(rdto.getRnum());
	candto.setStartday(rdto.getStartday());
	candto.setEndday(rdto.getEndday());
	candto.setPrice(rdto.getPrice());
	candto.setAdditional(rdto.getAdditional());
	
	dao.deleteRv(resnum);
	dao.insertCanrv(candto);
	response.sendRedirect(request.getContextPath()+"/index.jsp?main=admin/adminmain.jsp?select=cancel.jsp?pageNum="+pageNum);
%>