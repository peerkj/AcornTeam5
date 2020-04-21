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
<%
	String url=request.getContextPath();
%>
<link rel="stylesheet" href="<%=url %>/css/style_qnalist.css">
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Rozha+One&display=swap');
#write{
	cursor: pointer;
}
#answer_color{
	color: #ff9b4f;
}
.hd_img{
	height: 400px;
	width: 100%;
	background-size: cover;
	background-image: url('image/qnapage.jpg');
	position: relative;
}
.img_title{
	width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.1);
}
.img_title span{
	font-size: 70pt;
	font-weight: 700;
	color: #fff;
	position: absolute;
	bottom: -40px;
    left: 300px;
    font-family: 'Rozha One', serif;
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
				location.href=url+"/index.jsp?main=qna/qnaform.jsp"
			}
		})
	});
</script>
</head>
<%
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
<div class="hd_img">
	<div class="img_title"><span>Q&A</span></div>
</div>

<button type="button" id="write" check="<%=check%>">글쓰기</button>
<table class="qnatb">
	<tr bgcolor="#ffe5bd">
		<th style="width:100px;">답변여부</th>
		<th style="width:500px;">제목</th>
		<th style="width:150px;">작성자</th> 
		<th style="width:150px;">작성일</th>
		<th style="width:100px;">조회수</th>
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
				<span id="answer_color">답변대기</span>
			<%}%>
			</td>
			<%if(dto.getSecret().equals("0")||dto.getId().equals(id)||cdb.checkManage(id)==1){%>
				<td>
				<a href="<%=url %>/index.jsp?main=qna/qnaselect.jsp?num=<%=dto.getQnum()%>&pageNum=<%=currentPage%>">
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
	<div style="width: 600px;text-align: center;margin: 0 auto;">      
      <ul>   
      <%
      if(startPage!=1){%>
         <li><a href="<%=url %>/index.jsp?main=qna/qnalist.jsp?pageNum=<%=startPage-1 %>">이전</a></li>
      <%}
      for(int i=startPage; i<=endPage;i++){
         if(i==currentPage){%>
            <li class="pnum">
               <a href="<%=url %>/index.jsp?main=qna/qnalist.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>         
         <%}else{%>
            <li>
               <a href="<%=url %>/index.jsp?main=qna/qnalist.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>
         <%}
      } 
      if(currentPage<totalPage){%>
         <li><a href="<%=url %>/index.jsp?main=qna/qnalist.jsp?pageNum=<%=endPage+1 %>">다음</a></li>
      <%}%>
      </ul>
   </div>
   
</body>
</html>