<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//엔코딩
	request.setCharacterEncoding("utf-8");

	String content = request.getParameter("content");
	String qnum = request.getParameter("qnum");
	String pageNum = request.getParameter("pageNum");
%>

<jsp:useBean id="dto" class="data.dto.AnswerDto"></jsp:useBean>

<%
	String url = request.getContextPath();
	response.sendRedirect(url+"/qna/qnaselect.jsp?num="+qnum+"pageNum="+pageNum);
%>