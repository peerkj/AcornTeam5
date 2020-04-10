<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	//id세션 얻기
	String id = (String)session.getAttribute("id");
	String url = request.getContextPath();
%>
<body>
<form action="<%=url %>/qna/qinsertaction.jsp" method="post">
	<input type="hidden" name="id" value="<%=id%>">
	<table>
		<caption><b>질문하기</b></caption>
		<tr>
			<th>작성자</th>
			<td>
				<b><%=id %></b>
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="subject" required="required" autofocus="autofocus">
				<input type="checkbox" name="secret">비밀글
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<textarea name="content" required="required"></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit">저장하기</button>
				<button type="button" onclick="history.back()">목록보기</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>