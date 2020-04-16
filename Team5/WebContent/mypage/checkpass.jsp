<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
String ck=request.getParameter("ck");
%>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(function(){
		$('#submit').click(function() {
			$.ajax({
				type:"post",
				dataType:"html",
				url:'<%=request.getContextPath()%>/mypage/passaction.jsp',
				data:"pass="+$('#pass').val(),
				success:function(data){
					if(data.trim()==0){
						alert("비밀번호가 일치하지 않습니다.");
					}else{
						if(<%=ck%>==1)
							location.href="<%=request.getContextPath()%>/index.jsp?main=mypage/mypage.jsp?select=updateclient.jsp";
						else
							location.href="<%=request.getContextPath()%>/index.jsp?main=mypage/mypage.jsp?select=withdraw.jsp";	
					}
				}
			});
		});
	});
</script>
<style type="text/css">
/* @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap'); */
/* body{
	font-family: 'Noto Sans KR', serif;
} */
.checkform input {
	outline: 0;
	background: #ececee;
	width: 200px;
	border: 0;
	margin: 15px 0 15px 0;
	padding: 2%;
	box-sizing: border-box;
	font-size: 14px;
}
#submit {
	text-transform: uppercase;
	outline: 0;
	background: #fc9740;
	width: 200px;
	border: 0;
	margin-top:5px;
	padding: 2%;
	color: #FFFFFF;
	font-size: 16px;
	/* -webkit-transition: all 0.3 ease;
	transition: all 0.3 ease; */
	cursor: pointer;  
   }
#submit:hover,#submit:active,#submit:focus {
	background: #ffb05c;
	cursor:pointer;
}
#passtext{
	font-weight: 400;
	font-size: 15pt;
	margin-left: 2px;
}
#pass:active,#pass:focus{
     border: 0.1px solid #fc9740;
   }
.checkform img{
	width: 100px;
	margin-left: 50px;
}

</style>
</head>
<body>
<div class="checkform">
<img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fk.kakaocdn.net%2Fdn%2FkDN1L%2FbtqDhuX4ooQ%2FWY72cyF2e4frBUyLACEryK%2Fimg.png"><br>
<span id="passtext">비밀번호를 입력하세요!</span><br>
<input type="password" name="pass" id="pass"><br>
<button type="button" id="submit">확인</button>
</div>
</body>
</html>