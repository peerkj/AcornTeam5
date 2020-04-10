<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 엔코딩
request.setCharacterEncoding("utf-8");
String url=request.getContextPath();
%>
<jsp:useBean id="dao" class="data.dao.ClientDao"/>
<jsp:useBean id="dto" class="data.dto.ClientDto"/>
<%
String id = request.getParameter("id");
String name = request.getParameter("name");

String hp1 = request.getParameter("hp1");
String hp2 = request.getParameter("hp2");
String hp3 = request.getParameter("hp3");
String hp = hp1 +"-"+ hp2 +"-"+ hp3;

String email1 = request.getParameter("email1");
String email2 = request.getParameter("email2");
String email = email1 + "@" + email2;

dto.setId(id);
dto.setName(name);
dto.setEmail(email);
dto.setHp(hp);
dao.updateClient(dto);

response.sendRedirect(url+"/index.jsp");
%>