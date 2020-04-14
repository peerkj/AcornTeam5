<%@page import="data.dto.ReservationDto"%>
<%@page import="data.dao.ReservationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String id=(String)session.getAttribute("id");
	//String id="peerkj";
	//String name=request.getParameter("name");
	//String email=request.getParameter("email");
	//String hp=request.getParameter("hp");
	//String price=request.getParameter("price");
	//String additional=request.getParameter("additional");
	//String startday=request.getParameter("startday");
	//String endday=request.getParameter("endday");
	//String pcount=request.getParameter("pcount");
	//String rnum=request.getParameter("rnum");
	
	ReservationDao dao=new ReservationDao();
	ReservationDto dto=new ReservationDto();
	dto.setId(id);
	dto.setName(request.getParameter("name"));
	dto.setEmail(request.getParameter("email"));
	dto.setHp(request.getParameter("hp"));
	dto.setPrice(request.getParameter("price"));
	dto.setAdditional(request.getParameter("additional"));
	dto.setStartday(request.getParameter("startday"));
	dto.setEndday(request.getParameter("endday"));
	dto.setPcount(request.getParameter("pcount"));
	dto.setRnum(request.getParameter("rnum"));
	int result=dao.insertReservation(dto);
%>
<%=result%>