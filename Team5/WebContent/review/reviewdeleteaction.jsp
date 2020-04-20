<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="data.dao.RoomDao"%>
<%@page import="data.dto.ReviewDto"%>
<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String revnum = request.getParameter("revnum");
	String rnum = request.getParameter("rnum");
	RoomDao roomdao=new RoomDao();
	String[] roomnum={"room1","room2","room3","room4","room5","room6"};
	Map<String,String> map=new HashMap<String,String>();
	List<String> roomlist=roomdao.getAllRnum();
	
	int i=0;
	for(String s:roomlist){
		map.put(s,roomnum[i]);
		i++;
	}	
	ReviewDao db = new ReviewDao();
	db.deleteReview(revnum);
%>
<%=map.get(rnum)%>