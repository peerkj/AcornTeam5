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
					else if(pageNum!="null")
						location.href=url+"/index.jsp?main=qna/qnalist.jsp?pageNum="+pageNum;
					else
						history.back();
				}
			});
		});
		
		$("#answer").click(function() {
			$("#ansform").slideToggle('fast');
		});
		
		$("#list").click(function() {
			var pageNum = $(this).attr("pageNum");
			if(pageNum!="null")
				location.href="<%=url%>/index.jsp?main=qna/qnalist.jsp?pageNum="+pageNum;
			else
				history.back();
		});
	});
</script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Rozha+One&display=swap');
.qnaseltb {
	margin: 45px auto 40px;
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
.qnaimg{
	background: url('image/qnapage.jpg');
	background-size: cover;
	width: 100%;
	height: 400px;
	margin-bottom: 30px;
	position: relative;
}
.qnaback{
	background-color:  rgba(0, 0, 0, 0.1);
	width: 100%;
	height: 100%;
}
.qnatext{
	font-family: 'Rozha One', serif;
	font-weight: 700;
	font-size: 90px;
	color: #fff;
	position: absolute;
	bottom: -38px;
    left: 300px;
}
.btn {
    width: 100px;
    padding: 10px;
    color: #fff;
    background-color: #faa727;
    border-radius: 15px;
    border: none;
    cursor: pointer;
}
.re{
	position: absolute;
	margin: 250px 0 0 10px;
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
	<div class="allseltb">
		<div class="qnaimg">
			<div class="qnaback">
				<span class="qnatext">Q&A</span>
			</div>
		</div>
		<table class="qnaseltb">
			<caption><b style="font-size: 20pt;">내용 보기</b></caption>
			<tr>
				<th>작성자</th>
				<td><%=dto.getId() %></td>
				<th>조회수</th>
				<td><%=dto.getViewcount() %></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td colspan="3"><%=dto.getQwriteday() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3"><%=dto.getSubject() %></td>
			</tr>
			<tr>
				<th>  </th>
				<td colspan="3" class="content"><pre><%=dto.getContent() %></pre></td>
			</tr>
			<%
			adto=adb.getAnswer(dto.getQnum());
			if(adto!=null){%>
			<tr style="border-top: 2px solid #ddd;background-color: #f8f8f8;">
				<td colspan="3" style="padding:30px 40px;min-height: 300px;max-width: 600px;">
					
					<span style="font-weight: 700;font-size: 13pt;">답변</span>
					<pre><%=adto.getContent() %></pre>
				
				</td>
				<td style="text-align: right;color: #666;font-size: 11pt;width: 150px;padding:30px 20px;"><%=adto.getWriteday() %>
					<%if(cdb.checkManage(id)==1){%>
					<a href="<%=url%>/qna/answerdeleteaction.jsp?qnum=<%=num%>&pageNum=<%=pageNum%>" 
					style="text-decoration: none;color: #000;">삭제</a>				
					<%}%>
				</td>				
			
			</tr>
			<%}%>
			<%-- <tr>
				<th>조회수</th>
				<td colspan="2"><%=dto.getViewcount() %></td>
			</tr> --%>
			<tr align="center">
				<td colspan="4" style="padding:50px 20px 20px;">
					<%
					if(dto.getId().equals(id)){%>
						<button type="button" class="btn del" id="del" num="<%=num%>" pageNum="<%=pageNum%>">
					삭제</button>
					<%}
					if(cdb.checkManage(id)==1&&adto==null){%>
						<button type="button" class="btn ans" id="answer">
					답변</button>
					<%}
					%>				
					<button type="button" class="btn list" id="list" pageNum="<%=pageNum%>">
					목록으로</button>
				</td>
			</tr>
			<%if(cdb.checkManage(id)==1){%>
				<tr id="ansform" style="border-top: 0.5px solid #676767;">
					<td colspan="4" style="padding: 60px 20px 20px;">
						<form action="<%=url %>/qna/answerinsertaction.jsp" method="post">
							<input type="hidden" name="qnum" value="<%=num%>">
							<input type="hidden" name="pageNum" value="<%=pageNum%>">
							<textarea name="content" cols="80" rows="15"></textarea>
							<button type="submit" class="btn re">답변하기</button>
						</form>
					</td>
				</tr>
			<%}%>	
		</table>
	</div>
</body>
</html>