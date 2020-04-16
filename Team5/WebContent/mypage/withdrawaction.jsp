<%@page import="data.dto.ClientDto"%>
<%@page import="data.dao.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String id=(String)session.getAttribute("id");
	String reason=request.getParameter("reason");
	
	ClientDao dao=new ClientDao();
	ClientDto dto= dao.getClientData(id);
	
	dao.deleteClient(id);
	//세션 삭제
	session.removeAttribute("id");
	
	//탈퇴db저장 아이디,이름,번호,날짜,사유
	dao.insertClient2(dto, reason);
%>