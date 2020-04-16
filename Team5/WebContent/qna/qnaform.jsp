<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Rozha+One&display=swap');
/* body::-webkit-scrollbar {
	display: none;
} */

.qnatb{
	margin: 45px auto 40px;
	border-collapse: collapse;
	width: 800px; 
}
th{
	background-color: #ffe5bd;
	padding: 10px 20px;
	font-weight: 600;
	width: 100px;
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
<body>
	<form action="<%=url %>/qna/qinsertaction.jsp" method="post">
		<input type="hidden" name="id" value="<%=id%>">
		<div class="alltb">
			<div class="qnaimg">
				<div class="qnaback">
					<span class="qnatext">Q&A</span>
				</div>
			</div>
			
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

</body>
</html>