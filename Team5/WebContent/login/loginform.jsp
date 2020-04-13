<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
String url=request.getContextPath();
%>
<link rel="stylesheet" href="<%=url%>/css/style_login.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(function() {
		//경로얻기
		var url=$("#url").val();		
		
		$("#pass").keyup(function(e) {
			if (e.keyCode == 13) {
				$("#loginbtn").click();
			}
		});

		$("#loginbtn").click(function() {
			var id = $("#id").val();
			var pass = $("#pass").val();
			if (id == "") {
				alert("아이디를 입력하세요");
			} else if (pass == "") {
				alert("비밀번호를 입력하세요");
			} else {
				$.ajax({
					type : "post",
					url : url+"/login/loginaction.jsp",
					dataType : "html",
					data : "id=" + id + "&pass=" + pass,
					success : function(data) {
						var result = data.trim();
						if (result == 1) {
							location.href=url+"/index.jsp";
						} else if (result == 0) {
							alert("비밀번호가 틀렸습니다.");
						} else if (result == -1) {
							alert("아이디가 일치하지 않습니다.");
						} else {
							alert("연결오류");
						}
					}
				});
			}
		});
	});
</script>
</head>
<body>
	<div class="login-page">
		<div class="form">
			<a href="../index.jsp" title="메인 화면으로 이동">
			<img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fk.kakaocdn.net%2Fdn%2FkDN1L%2FbtqDhuX4ooQ%2FWY72cyF2e4frBUyLACEryK%2Fimg.png"></a>
			<form class="login-form" action="#" method="post">
				<input type="text" name="id" id="id" placeholder="아이디 입력"
					required="required" /> <br> <input type="password"
					name="pass" id="pass" placeholder="비밀번호 입력" required="required" />
				<br>
				<input type="hidden" id="url" value="<%=url%>">				
				<button type="button" id="loginbtn" required="required">로그인</button>
				<br>
				<p class="message">
					계정이 없으신가요? <a href="<%=url%>/register/registerform.jsp">회원가입</a>
				</p>
			</form>
		<div class="copyright">Copyright © 라봉펜션. All Rights Reserved.</div>
		</div>		
	</div>	
</body>
</html>