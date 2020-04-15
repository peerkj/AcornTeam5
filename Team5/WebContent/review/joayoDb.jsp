<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String joayo = request.getParameter("joayo");
   String revnum = request.getParameter("revnum");
   String id = (String)session.getAttribute("id");
   
   ReviewDao db = new ReviewDao();
   
   if(db.joayocheck(revnum, id)==-1)
   		db.insertjoayo(id, revnum);
   
   db.updateJoayo(joayo, revnum);
   int joayosu= db.getJoayo(revnum);
   
   String sb = "[{\"joayo\":"+joayosu+"}]";
%>   

<%=sb.toString()%>