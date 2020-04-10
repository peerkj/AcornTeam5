<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="data.dao.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=request.getParameter("id");
	ClientDao db = new ClientDao();
	JSONArray array = new JSONArray();
	JSONObject ob=new JSONObject();
	ob.put("result",db.isEqualId(id));
	array.add(ob);
%>
<%=array.toString()%>