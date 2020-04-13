<%@page import="data.dao.ClientDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dao.PageMaker"%>
<%@page import="data.dao.QnaDao"%>
<%@page import="data.dto.QnaDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qna리스트</title>

<style type="text/css">
.qnatb{ 
	width: 1000px;
	margin: 0 auto;
	border-collapse: collapse;
}
.qnatb th,.qnatb td{
	padding: 10px 20px;
}
#write{
	width: 100px;
    padding: 10px;
    border-radius: 15px;
    color: #fff;
    background-color: #faa727;
    border: none;
}
</style>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(function(){
		var check = $("#write").attr("check");
		var url = $("#url").attr("url");
		$("#write").click(function() {
			if(check=="0"){
				alert("로그인을 해주세요");
				location.href=url+"/login/loginform.jsp"
			}else{
				location.href=url+"/qna/qnaform.jsp"
			}
		})
	});
</script>
</head>
<%
	String url=request.getContextPath();
	String pageNum = request.getParameter("pageNum");
	PageMaker pm = new PageMaker();
	int totalCount = pm.getTotalCount();
	int totalPage = pm.getTotalPage(totalCount);
	int currentPage = pm.getCurrentPage(pageNum, totalPage);
	int startPage = pm.getStartPage(currentPage);
	int endPage = pm.getEndPage(startPage, totalPage);
	int start = pm.getStart(currentPage);
	int end = pm.getEnd(start, totalCount);
	QnaDao db = new QnaDao();
		
	List<QnaDto> list = db.getAllQnaList(start, end);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	String id = (String)session.getAttribute("id");
	String check="0";
	ClientDao cdb = new ClientDao();
	
	if(id!=null)
		check = "1";
%>
<body>
<input type="hidden" id="url" url="<%=url%>">
<div style="background: url('<%=url%>/image/qnapage.jpg');background-size: cover;width: 100%;height: 400px; margin-bottom: 30px;">
	<div>
		<div style="font-size: 50px;text-align: center;line-height: 400px;font-weight: bold;">Q&A</div>
	</div>
</div>
<table class="qnatb">
	<tr bgcolor="#ffe5bd">
		<th width="10">답변여부</th>
		<th width="50">제목</th>
		<th width="10">작성자</th> 
		<th width="20">작성일</th>
		<th width="10">조회수</th>
	</tr>
<%if(totalCount==0){%>
		<tr>
			<td colspan="5" align="center">질문이 없습니다</td>
		</tr>
	<%}

for(QnaDto dto:list){%>
	
		<tr>
			<td>
			<%
			if(db.getAnswer(dto.getQnum())){%>
				답변완료
			<%}else{%>
				답변대기
			<%}%>
			</td>
			<%if(dto.getSecret().equals("0")||dto.getId().equals(id)||cdb.checkManage(id)==1){%>
				<td><a href="<%=url %>/qna/qnaselect.jsp?num=<%=dto.getQnum()%>&pageNum=<%=currentPage%>">
				<%=dto.getSubject() %></a></td>
			<%}else{%>
				<td>비밀글 입니다</td>
			<%}%>
			<td><%=dto.getId() %></td>
			<td><%=sdf.format(dto.getQwriteday()) %></td>
			<td><%=dto.getViewcount() %></td>
		</tr>
		<tr height="1" bgcolor="#ddd"></tr>
	

<%}
%>		
</table>
	<!-- 페이지번호 출력 -->
	<div style="width: 600px;text-align: center;">      
      <ul>   
      <%
      if(startPage!=1){%>
         <li><a href="<%=url %>/qna/qnalist.jsp?pageNum=<%=startPage-1 %>">이전</a></li>
      <%}
      for(int i=startPage; i<=endPage;i++){
         if(i==currentPage){%>
            <li class="active">
               <a href="<%=url %>/qna/qnalist.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>         
         <%}else{%>
            <li>
               <a href="<%=url %>/qna/qnalist.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>
         <%}
      } 
      if(currentPage<totalPage){%>
         <li><a href="<%=url %>/qna/qnalist.jsp?pageNum=<%=endPage+1 %>">다음</a></li>
      <%}%>
      </ul>
   </div>
   <button type="button" id="write" check="<%=check%>">글쓰기</button>
   
</body>
</html>