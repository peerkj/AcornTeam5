<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.ClientDto"%>
<%@page import="data.dao.ClientDao"%>
<%@page import="data.dao.PageMaker"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<%
   request.setCharacterEncoding("utf-8");
   String url=request.getContextPath();
   String search=request.getParameter("search");
   String content=request.getParameter("content");
   //ClientDao에서 data가져오기
   ClientDao clientDao=new ClientDao();
   ClientDto clientDto=new ClientDto();   
   
   String pageNum = request.getParameter("pageNum");
   PageMaker pm = new PageMaker();
   
   List<ClientDto> clientList=null;
   int totalCount =0; 
   if(search==null){
      totalCount=clientDao.getCount();
   }else{
      totalCount=clientDao.getSearchCount(search, content);
   }
   int totalPage = pm.getTotalPage(totalCount);
   int currentPage = pm.getCurrentPage(pageNum, totalPage);
   int startPage = pm.getStartPage(currentPage);
   int endPage = pm.getEndPage(startPage, totalPage);
   int start = pm.getStart(currentPage);
   int end = pm.getEnd(start, totalCount);

   if(search==null){
      clientList=clientDao.getAllClientList(start,end);   
   }else{
      clientList=clientDao.getSearchList(start, end, search, content);
   }
%>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
$(function(){
   $('#btnSearch').click(function() {
      if($('#sel option:selected').val()=='선택'){
         alert("검색할 항목을 선택하세요.");
         return false;
      }else if($('#search').val()==''){
         alert("검색할 항목을 입력하세요.");   
         return false;
      }
      location.href='<%=url%>/index.jsp?main=admin/adminmain.jsp?select=admin.jsp?search='+$('#sel option:selected').val()+'&content='+$('#search').val();
      //alert($('#sel option:selected').val());
   });
   $('#list').click(function() {
      location.href='<%=url%>/index.jsp?main=admin/adminmain.jsp?select=admin.jsp';      
   });
   $('.show').click(function() {
		location.href='<%=url%>/index.jsp?main=admin/adminmain.jsp?select=client.jsp?pageNum='+<%=currentPage%>+'&id='+$(this).find('td.id').html();
	});
});
</script>
<style type="text/css">
tbody>tr:hover{
   cursor: pointer;
}
#sel{
   margin-left: 3px;
    height: 33px;
    width: 130px;
}
#search{
   width: 430px;
    height: 30px;
}
button {
   font-size: 15px;
    width: 110px;
    height: 35px;
    padding: 5px 10px;
    background-color: #faa727;
    border: none;
    border-radius: 10px;
    color: #fff;
   cursor: pointer;
}
.tablehead th{
    padding: 10px;
    text-align: center;
    background-color: #ffe5bd;
}
.show td{
   padding: 10px;
    text-align: center;
}
</style>
</head>
<body>
<select id="sel">
<option selected disabled hidden>선택</option>
<option value="id">아이디</option>
<option value="name">이름</option>
<option value="hp">번호</option>
<option value="email">이메일</option>
</select>
<input type="text" id="search" name="search">
<button type="button" id="btnSearch">검색</button>
<button type="button" id="list">전체 리스트</button>
<table style="width: 800px;border-collapse: collapse;margin: 20px 0;">
   <thead>
      <tr class="tablehead">
         <th style="width: 20%;">아이디</th>
         <th style="width: 20%;">이름</th>
         <th style="width: 25%;">전화번호</th>
         <th style="width: 25%;">이메일</th>
         <th style="width: 10%;">권한</th>
      </tr>
   </thead>
<tbody>
<%if(totalCount==0){%>
      <tr>
         <td colspan="5" align="center">회원이 없습니다</td>
      </tr>
<%}
for(ClientDto c:clientList){
   if(c.getId().equals("admin"))
      continue;
%>
   <tr class="show">
      <td class="id"><%=c.getId()%></td>
      <td><%=c.getName() %></td>
      <td><%=c.getHp() %></td>
      <td><%=c.getEmail() %></td>
      <td><%=c.getManager() %></td>
   </tr>
<%
}
%>
</tbody>
</table>
   <!-- 페이지번호 출력 -->
   <div style="text-align: center;">      
      <ul>   
      <%
      if(startPage!=1){%>
         <li><a href="<%=url%>/index.jsp?main=admin/adminmain.jsp?select=admin.jsp?pageNum=<%=startPage-1 %>">이전</a></li>
      <%}
      for(int i=startPage; i<=endPage;i++){
         if(i==currentPage){%>
            <li class="pnum">
               <a href="<%=url %>/index.jsp?main=admin/adminmain.jsp?select=admin.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>         
         <%}else{%>
            <li>
               <a href="<%=url %>/index.jsp?main=admin/adminmain.jsp?select=admin.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>
         <%}
      } 
      if(currentPage<totalPage){%>
         <li><a href="<%=url %>/index.jsp?main=admin/adminmain.jsp?select=admin.jsp?pageNum=<%=endPage+1 %>">다음</a></li>
      <%}%>
      </ul>
   </div>

</body>
</html>