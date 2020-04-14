<%@page import="data.dao.AnswerDao"%>
<%@page import="data.dto.AnswerDto"%>
<%@page import="data.dao.ClientDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.QnaDto"%>
<%@page import="data.dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	String url = request.getContextPath();
%>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(function(){
		var url = $("#url").attr("url");
		$("#ansform").hide();
		
		$("#del").click(function() {
			var pass = prompt("비밀번호를 입력해주세요");			
			var num = $(this).attr("num");
			var pageNum = $(this).attr("pageNum");
			
			$.ajax({
				type : "post",
				url : url+"/qna/qdeleteaction.jsp",
				dataType : "html",
				data : {"num":num, "pass":pass},
				success : function(data){
					var eql = data.trim();
					if(eql==0)
						alert("비밀번호가 일치하지 않습니다");
					else
						location.href="qnalist.jsp?pageNum="+pageNum;
				}
			});
		});
		
		$("#answer").click(function() {
			$("#ansform").slideToggle('fast');
		});
		
		$("#list").click(function() {
			var pageNum = $(this).attr("pageNum");
			location.href="<%=url%>/index.jsp?main=qna/qnalist.jsp?pageNum="+pageNum;
		});
	});
</script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap');
body{
	font-family: 'Noto Sans KR', sans-serif;
}
.qnaseltb {
	margin: 10px auto 40px;
	width: 800px;
	border-collapse: collapse;
}
th{
	background-color: #ffe5bd;
	width: 100px;
}
th,td{
	padding: 10px 20px;
}  
.content{
	width: 500px;
	height: 300px;
	font-size: 12pt;
}
.btn {
    width: 100px;
    padding: 10px;
    color: #fff;
    background-color: #faa727;
    border-radius: 10px;
    border: none;
}

</style>
</head>
<%
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	QnaDao db = new QnaDao();
	db.updateViewCount(num);
	QnaDto dto = db.getData(num);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	ClientDao cdb = new ClientDao();
	String id = (String)session.getAttribute("id");
	
	AnswerDto adto = new AnswerDto();
	AnswerDao adb = new AnswerDao();
%>
<body>
	<input type="hidden" id="url" url="<%=url%>">
	<table class="qnaseltb">
		<caption><b>내용보기</b></caption>
		<tr>
			<th>작성자</th>
			<td colspan="2"><%=dto.getId() %></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td colspan="2"><%=dto.getQwriteday() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="2"><%=dto.getSubject() %></td>
		</tr>
		<tr>
			<th>  </th>
			<td colspan="2" class="content"><pre><%=dto.getContent() %></pre></td>
		</tr>
		<%
		adto=adb.getAnswer(dto.getQnum());
		if(adto!=null){%>
			<tr>
				<td colspan="2">
					<hr style="border: 0.5px solid;">
					<pre>답변: <%=adto.getContent() %></pre>
					&nbsp;
					<%if(cdb.checkManage(id)==1){%>
					<a href="<%=url%>/qna/answerdeleteaction.jsp?qnum=<%=num%>&pageNum=<%=pageNum%>">삭제</a>				
					<%}%>
				</td>
				<td><%=adto.getWriteday() %></td>				
			</tr>
		<%}%>
		<tr>
			<th>조회수</th>
			<td colspan="2"><%=dto.getViewcount() %></td>
		</tr>
		<tr align="right">
			<td colspan="3">
				<%
				if(dto.getId().equals(id)){%>
					<button type="button" class="btn del" id="del" num="<%=num%>" pageNum="<%=pageNum%>">
				삭제</button>
				<%}
				if(cdb.checkManage(id)==1&&adto==null){%>
					<button type="button" id="answer">
				답변</button>
				<%}
				%>				
				<button type="button" class="btn list" id="list" pageNum="<%=pageNum%>">
				목록으로</button>
			</td>
		</tr>
		<%if(cdb.checkManage(id)==1){%>
			<tr id="ansform">
				<td colspan="2">
					<hr style="border: 0.5px solid;">
					<form action="<%=url %>/qna/answerinsertaction.jsp" method="post">
						<input type="hidden" name="qnum" value="<%=num%>">
						<input type="hidden" name="pageNum" value="<%=pageNum%>">
						<textarea name="content"></textarea>
						<button type="submit">답변하기</button>
					</form>
				</td>
			</tr>
		<%}%>
		
		
	</table>
</body>
</html>