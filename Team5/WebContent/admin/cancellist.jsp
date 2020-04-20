<%@page import="data.dto.CanrvDto"%>
<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="data.dao.PageMaker"%>
<%@page import="data.dao.ReservationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
   request.setCharacterEncoding("utf-8");
   String pageNum=request.getParameter("pageNum");
   String url=request.getContextPath();
   ReservationDao rdao=new ReservationDao();

   PageMaker pm = new PageMaker();
   int totalCount=0;
   totalCount=rdao.getCanrvCount();
   
   int totalPage = pm.getTotalPage(totalCount);
   int currentPage = pm.getCurrentPage(pageNum, totalPage);
   int startPage = pm.getStartPage(currentPage);
   int endPage = pm.getEndPage(startPage, totalPage);
   int start = pm.getStart(currentPage);
   int end = pm.getEnd(start, totalCount);
   
   NumberFormat nf=NumberFormat.getInstance();
   
   List<CanrvDto> list=rdao.getCancelList(start, end);
%>
<style type="text/css">
th,td{
   padding: 10px;
   text-align: center;
}
th{
   background-color: #ffe5bd;
}
</style>
</head>
<body>
<b style="margin-left: -60px;">환불 건수:<%=totalCount %></b><br>
<table style="width: 1000px;margin: 20px 0;border-collapse: collapse;margin-left: -60px;">
<thead>
<tr>
<th>번호</th>
<th>아이디</th>
<th>이름</th>
<th>전화번호</th>
<th>방이름</th>
<th>입실날짜</th>
<th>퇴실날짜</th>
<th>기본요금</th>
<th>추가요금</th>
<th>총 요금</th>
</tr>
</thead>
<tbody>
<%if(totalCount==0){%>
      <tr>
         <td colspan="10" align="center">내역이 없습니다</td>
      </tr>
<%}int n=1;
for(CanrvDto r:list){
%>
   <tr>
      <td><%=n %></td>
      <td><%=r.getId()%></td>
      <td><%=r.getName() %></td>
      <td><%=r.getHp() %></td>
      <td><%=rdao.getRoomName(r.getRnum()) %></td>
      <td><%=r.getStartday().substring(0,10) %></td>
      <td><%=r.getEndday().substring(0,10)%></td>
      <td><%=nf.format(Integer.parseInt(r.getPrice())) %></td>
      <td><%=nf.format(Integer.parseInt(r.getAdditional()))%></td>
      <td><%=nf.format(Integer.parseInt(r.getPrice())+Integer.parseInt(r.getAdditional()))%></td>
   </tr>
<%
n++;
}
%>
</tbody>

   </table>
   
      <!-- 페이지번호 출력 -->
   <div style="width: 600px;text-align: center;margin: 0 auto;">      
      <ul>   
      <%
      if(startPage!=1){%>
         <li><a href="<%=url%>/index.jsp?main=admin/adminmain.jsp?select=cancellist.jsp?pageNum=<%=startPage-1 %>">이전</a></li>
      <%}
      for(int i=startPage; i<=endPage;i++){
         if(i==currentPage){%>
            <li class="pnum">
               <a href="<%=url %>/index.jsp?main=admin/adminmain.jsp?select=cancellist.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>         
         <%}else{%>
            <li>
               <a href="<%=url %>/index.jsp?main=admin/adminmain.jsp?select=cancellist.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>
         <%}
      } 
      if(currentPage<totalPage){%>
         <li><a href="<%=url %>/index.jsp?main=admin/adminmain.jsp?select=cancellist.jsp?pageNum=<%=endPage+1 %>">다음</a></li>
      <%}%>
      </ul>
   </div>
   
</body>
</html>