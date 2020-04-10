<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String url=request.getContextPath();
//세션 삭제
session.removeAttribute("id");
//메인화면 이동(우선)
response.sendRedirect(url+"/index.jsp");
%>