<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String secret = request.getParameter("secret");
%>

<jsp:useBean id="dto" class="data.dto.QnaDto"></jsp:useBean>
<jsp:useBean id="db" class="data.dao.QnaDao"></jsp:useBean>


<%	
	dto.setId(id);
	dto.setSubject(subject);
	dto.setContent(content);
	if(secret==null)
		dto.setSecret("0");
	else
		dto.setSecret("1");
	
	db.insertQna(dto);
	response.sendRedirect("qnalist.jsp");
%>