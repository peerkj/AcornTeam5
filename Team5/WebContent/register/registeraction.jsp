<%@page import="data.dto.ClientDto"%>
<%@page import="data.dao.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String url=request.getContextPath();

String name = request.getParameter("name");
String id = request.getParameter("id");
String pass = request.getParameter("pass");

String hp1 = request.getParameter("hp1");
String hp2 = request.getParameter("hp2");
String hp3 = request.getParameter("hp3");
String hp = hp1+"-"+hp2+"-"+hp3;

String email1 = request.getParameter("email1");
String email2 = request.getParameter("email2");
String email = email1+"@"+email2;



%>
<!-- usebean 이용해서 dto,dao 선언 -->
<jsp:useBean id="dao" class="data.dao.ClientDao"/>
<jsp:useBean id="dto" class="data.dto.ClientDto"/>

<%
//받아온 데이터를 dto에 넣기
dto.setName(name);
dto.setId(id);
dto.setPass(pass);
dto.setHp(hp);
dto.setEmail(email);
//DB insert
dao.insertClient(dto);
//메인페이지이동
response.sendRedirect(url+"/register/registerform.jsp");
%>