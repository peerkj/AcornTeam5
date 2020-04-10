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
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(function(){
		$("#del").click(function() {
			var pass = prompt("비밀번호를 입력해주세요");			
			var num = $(this).attr("num");
			var pageNum = $(this).attr("pageNum");
			
			$.ajax({
				type : "post",
				url : "qdeleteaction.jsp",
				dataType : "html",
				data : {"num":num, "pageNum":pageNum, "pass":pass},
				success : function(data){
					var eql = data.trim();
					if(eql==0)
						alert("비밀번호가 일치하지 않습니다");
					else
						location.href="qnalist.jsp?pageNum="+pageNum;
				}
			});
		});
	});
</script>
</head>
<%
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	QnaDao db = new QnaDao();
	db.updateViewCount(num);
	QnaDto dto = db.getData(num);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<body>
	<table>
		<caption><b>내용보기</b></caption>
		<tr>
			<th>작성자</th>
			<td><%=dto.getId() %></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><%=dto.getQwriteday() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=dto.getSubject() %></td>
		</tr>
		<tr>
			<td colspan="2"><pre><%=dto.getContent() %></pre></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=dto.getViewcount() %></td>
		</tr>
		<tr align="right">
			<td colspan="2">
				<button type="button" id="del" num="<%=num%>" pageNum="<%=pageNum%>">
				삭제</button>
				<button type="button" id="list" num="<%=num%>" pageNum="<%=pageNum%>">
				목록으로</button>
			</td>
		</tr>
	</table>
</body>
</html>