<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.ReservationDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ReservationDao"%>
<%@page import="data.dao.PageMaker"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취소페이지</title>
<%
   request.setCharacterEncoding("utf-8");
   String url=request.getContextPath();
   String pageNum = request.getParameter("pageNum");   

   ReservationDao rdao=new ReservationDao();

   PageMaker pm = new PageMaker();
   int totalCount=0;
   totalCount=rdao.getCancelCount();
   
   int totalPage = pm.getTotalPage(totalCount);
   int currentPage = pm.getCurrentPage(pageNum, totalPage);
   int startPage = pm.getStartPage(currentPage);
   int endPage = pm.getEndPage(startPage, totalPage);
   int start = pm.getStart(currentPage);
   int end = pm.getEnd(start, totalCount);
   
   NumberFormat nf=NumberFormat.getInstance();
   List<ReservationDto> list=rdao.getCanRv(start, end);
%>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
   $(function(){
      $('.btncancel').click(function() {
         var num=$(this).attr('resnum');
         var q=confirm("환불처리를 진행하시겠습니까?");
         if(q){
        		location.href="<%=url%>/admin/cancelaction.jsp?resnum="+num+"&pageNum="+<%=currentPage%>;
    	 }
      });
   });
</script>
<style type="text/css">
th,td{
   padding: 10px;
   text-align: center;
}
th{
   background-color: #ffe5bd;
}
.btncancel{
   border: none;
    padding: 3px 5px;
    font-weight: 600;
    cursor: pointer;
    color: red;
}
</style>
</head>
<body>
<table style="width: 1000px;margin: 20px 0;border-collapse: collapse;margin-left: -60px;">
<thead>
<tr>
<th>번호</th>
<th>아이디</th>
<th>이름</th>
<th>전화번호</th>
<th>방이름</th>
<th>인원수</th>
<th>입실날짜</th>
<th>퇴실날짜</th>
<th>기본요금</th>
<th>추가요금</th>
<th>총 요금</th>
<th>승인</th>
</tr>
</thead>
<tbody>
<%if(totalCount==0){%>
      <tr>
         <td colspan="11" align="center">내역이 없습니다</td>
      </tr>
<%}int n=1;
for(ReservationDto r:list){
%>
   <tr>
      <td><%=n %></td>
      <td><%=r.getId()%></td>
      <td><%=r.getName() %></td>
      <td><%=r.getHp() %></td>
      <td><%=rdao.getRoomName(r.getRnum()) %></td>
      <td><%=r.getPcount() %></td>
      <td><%=r.getStartday().substring(0,10) %></td>
      <td><%=r.getEndday().substring(0,10)%></td>
      <td><%=nf.format(Integer.parseInt(r.getPrice())) %></td>
      <td><%=nf.format(Integer.parseInt(r.getAdditional()))%></td>
      <td><%=nf.format(Integer.parseInt(r.getPrice())+Integer.parseInt(r.getAdditional()))%></td>
      <td><button class="btncancel" resnum="<%=r.getResnum()%>">환불</button></td>
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
         <li><a href="<%=url%>/index.jsp?main=admin/adminmain.jsp?select=cancel.jsp?pageNum=<%=startPage-1 %>">이전</a></li>
      <%}
      for(int i=startPage; i<=endPage;i++){
         if(i==currentPage){%>
            <li class="pnum">
               <a href="<%=url %>/index.jsp?main=admin/adminmain.jsp?select=cancel.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>         
         <%}else{%>
            <li>
               <a href="<%=url %>/index.jsp?main=admin/adminmain.jsp?select=cancel.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>
         <%}
      } 
      if(currentPage<totalPage){%>
         <li><a href="<%=url %>/index.jsp?main=admin/adminmain.jsp?select=cancel.jsp?pageNum=<%=endPage+1 %>">다음</a></li>
      <%}%>
      </ul>
   </div>
   
</body>
</html>