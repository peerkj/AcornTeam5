<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
String url=request.getContextPath();
%>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<title>비밀번호 변경</title>
<script type="text/javascript">
	var passchk = 0;//비밀번호 체크
	$(function() {
		
		$("#pass2").keyup(function(e) {
			if (e.keyCode == 13) {
				$("#btnchange").click();
			}
		});
		$('#pass2').keyup(function() {
			if ($(this).val().length == 0) {
				$('#passchk').html('');
				passchk = 0;
			} else {
				if ($('#pass1').val() != $('#pass2').val()) {
					$('#passchk').html('비밀번호 일치하지 않음<br><br>');
					$('#passchk').attr('color', '#f82a2aa3');
					passchk = 0;

				} else {
					$('#passchk').html('비밀번호 일치<br><br>');
					$('#passchk').attr('color', '#199894b3');
					passchk = 1;
				}
			}
		});
		
		$("#btnchange").click(function() {
			if(!idpasschk())
				return;
			$.ajax({
				type:"post",
				dataType:"html",
				url:"<%=request.getContextPath()%>/mypage/passaction.jsp",
				data:"pass="+$('#pass').val()+"&newpass="+$('#pass1').val(),
				success:function(data){
					if(data.trim()==0){
						alert("비밀번호가 올바르지 않습니다.");
					}else{
						alert("비밀번호가 변경되었습니다!");
						location.href="<%=request.getContextPath()%>/index.jsp?main=mypage/mypage.jsp";
					}
				}
			});
		});
		
	});
	function idpasschk() {
		if (passchk == 0) {
			alert("비밀번호를 확인하세요");
			return false;
		}else{
			return true;
		}
	}
</script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Roboto:300');
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&family=Noto+Serif+KR:wght@300;600;700&display=swap');
#pass,#pass1,#pass2 {
	font-family: "Roboto", sans-serif;
	outline: 0;
	background: #ececee;
	width: 200px;
	height: 35px;
	border: 0;
	margin: 8px 0 20px 0;
	padding: 2%;
	box-sizing: border-box;
	font-size: 14px;
}
#btnchange {
	font-family: "Roboto", sans-serif;
	text-transform: uppercase;
	outline: 0;
	background: #fc9740;
	width: 200px;
	height: 40px;
	border: 0;
	margin-top:5px;
	padding: 2%;
	color: #FFFFFF;
	font-size: 14px;
	-webkit-transition: all 0.3 ease;
	transition: all 0.3 ease;
	cursor: pointer;  
   }
#btnchange:hover,#btnchange:active,#btnchange:focus {
	background: #ffb05c;
	cursor:pointer;
}
.tabletext{
	font-family: 'Noto Sans KR', serif;
	font-weight: 400;
	font-size: 15pt;
	margin-left: 2px;
}
#updatebody{
	margin-left: 300px;
}
#updatepass_table input:active,#updatepass_table input:focus{
     border: 0.1px solid #fc9740;
   }
#logoimg{
	width: 100px;
	margin-left: 50px;
}
</style> 
</head>
<body>
<div id="updatebody">
	<div id="updateform">
	<img id="logoimg" src="<%=url %>/image/labong.png"><br>
	<table id="updatepass_table"> 
		<tr>
			<td><span class="tabletext">현재 비밀번호</span><br>
			<input type="password" name="pass" id="pass" required="required">
			</td>
		</tr>
		<tr>
			<td><span class="tabletext">새로운 비밀번호</span><br>
			<input type="password" name="pass1" id="pass1" required="required">
			</td>
		</tr>
		<tr>
			<td><span class="tabletext">새로운 비밀번호 확인</span><br>
			<input type="password" name="pass2" id="pass2" required="required">
			<font id="passchk" size="2"></font>
			</td>
		</tr>
		<tr>
			<td><button type="button" id="btnchange">변경</button></td>
		</tr>
	</table>
	</div>
</div>
</body>
</html>