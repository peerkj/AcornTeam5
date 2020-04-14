<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&family=Noto+Serif+KR:wght@300;600;700&display=swap');
body{
	font-family: 'Noto Sans KR', serif;
}
body::-webkit-scrollbar {
	display: none;
}
.contentbody{
	height: 600px;
}
.alltb{
	margin-top: 45px;
}
.qnatb{
	margin: 0 auto;
	border-collapse: collapse;
	width: 800px;
}
th{
	background-color: #ffe5bd;
	padding: 10px 10px;
	font-weight: 400;
}
td{
	padding: 10px 30px;
	font-weight: 400;
}
#content{
	resize: none;
	width: 550px;
	height: 300px;
}
#subject{
	height: 30px;
}
button{
	width: 100px;
    padding: 10px;
    border-radius: 15px;
    color: #fff;
    background-color: #faa727;
    border: none;
    cursor: pointer;
}
</style>
</head>
<%
	//id세션 얻기
	String id = (String)session.getAttribute("id");
	String url = request.getContextPath();
%>
<body style="background-color: rgb(252, 240, 215, 0.2);">
<div class="contentbody">
<form action="<%=url %>/qna/qinsertaction.jsp" method="post">
	<input type="hidden" name="id" value="<%=id%>">
	<div class="alltb" style="background-color: rgb(252, 240, 215, 0.2);">
	<table class="qnatb">
		<caption><b style="font-weight: 700;font-size: 20pt;">질문하기</b></caption>	
		<tr>
			<th>작성자</th>
			<td>
				<b><%=id %></b>
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="subject" id="subject" required="required" autofocus="autofocus">&nbsp;&nbsp;
				<input type="checkbox" name="secret">비밀글
			</td>
		</tr>
		<tr>
			<th>  </th>
			<td>
				<textarea name="content" id="content" required="required"></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit">저장하기</button>
				<button type="button" onclick="history.back()">목록보기</button>
			</td>
		</tr>
	</table>
	</div>
</form>
</div>
</body>
</html>