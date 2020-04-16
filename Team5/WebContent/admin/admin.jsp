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
		location.href='<%=url%>/admin/admin.jsp?search='+$('#sel option:selected').val()+'&content='+$('#search').val();
		//alert($('#sel option:selected').val());
	});
	$('#list').click(function() {
		location.href='<%=url%>/admin/admin.jsp';		
	});
	$('.show').click(function() {
		location.href='<%=url%>/admin/client.jsp?id='+$(this).find('td.id').html();
	});
});
</script>
<style type="text/css">
tr:hover{
	background-color: pink;
	cursor: pointer;
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
<table>
<thead>
<tr>
<th>아이디</th>
<th>이름</th>
<th>전화번호</th>
<th>이메일</th>
<th>권한</th>
</tr>
</thead>
<tbody>
<%if(totalCount==0){%>
		<tr>
			<td colspan="5" align="center">회원이 없습니다</td>
		</tr>
<%}
for(ClientDto c:clientList){%>
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
	<div style="width: 600px;text-align: center;margin: 0 auto;">      
      <ul>   
      <%
      if(startPage!=1){%>
         <li><a href="<%=url%>/admin/admin.jsp?pageNum=<%=startPage-1 %>">이전</a></li>
      <%}
      for(int i=startPage; i<=endPage;i++){
         if(i==currentPage){%>
            <li class="pnum">
               <a href="<%=url %>//admin/admin.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>         
         <%}else{%>
            <li>
               <a href="<%=url %>/admin/admin.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>
         <%}
      } 
      if(currentPage<totalPage){%>
         <li><a href="<%=url %>/admin/admin.jsp?pageNum=<%=endPage+1 %>">다음</a></li>
      <%}%>
      </ul>
   </div>

</body>
</html>