<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.QnaDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	int start = Integer.parseInt(request.getParameter("start"));
	int end = Integer.parseInt(request.getParameter("end"));
	
	String id = (String)session.getAttribute("id");
	
	QnaDao db = new QnaDao();
	List<QnaDto> list = db.getClientQnaList(id,start,end);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String answer = null;
	
	JSONArray array = new JSONArray();
	
	for(QnaDto dto:list){
		if(db.getAnswer(dto.getQnum())){
			answer = "답변완료";
		}else{
			answer = "답변대기";
		}
		JSONObject ob = new JSONObject();
		ob.put("qnum",dto.getQnum());
		ob.put("answer",answer);
		ob.put("subject",dto.getSubject());
		ob.put("writeday",sdf.format(dto.getQwriteday()));
		ob.put("view",dto.getViewcount());
		
		array.add(ob);
	}
%>

<%=array.toString()%>