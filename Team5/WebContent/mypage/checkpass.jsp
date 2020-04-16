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
		$('#btn').click(function() {
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
</head>
<body>
비밀번호를 입력하세요!<br>
<input type="password" name="pass" id="pass"><br>
<button type="button" id="btn">확인</button>
</body>
</html>