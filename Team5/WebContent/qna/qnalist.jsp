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
	String url = request.getContextPath();
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
	
	if(id!=null)
		check = "1";
%>
<body>
<input type="hidden" id="url" url="<%=url%>">
<table>
	<tr>
		<th>답변여부</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
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
			<%if(dto.getSecret().equals("0")){%>
				<td><a href="<%=url %>/qna/qnaselect.jsp?num=<%=dto.getQnum()%>&pageNum=<%=currentPage%>">
				<%=dto.getSubject() %></a></td>
			<%}else{%>
				<td>비밀글 입니다</td>
			<%}%>
			<td><%=dto.getId() %></td>
			<td><%=sdf.format(dto.getQwriteday()) %></td>
			<td><%=dto.getViewcount() %></td>
		</tr>
	

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