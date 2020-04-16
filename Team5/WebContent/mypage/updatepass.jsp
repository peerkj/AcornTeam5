<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<title>비밀번호 변경</title>
<script type="text/javascript">
	var passchk = 0;//비밀번호 체크
	$(function() {
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
					$('#passchk').html('비밀번호 일치함<br><br>');
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
						alert("비밀번호가 틀렸습니다.");
					}else{
						alert("비밀번호가 변경되었습니다!.");
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

</head>

<body>
		<table>
			<tr>
				<td>현재 비밀번호 : <input type="password" name="pass" id="pass"
					required="required">
				</td>
			</tr>

			<tr>
				<td>새로운 비밀번호 : <input type="password" name="pass1" id="pass1"
					required="required">
				</td>
			</tr>

			<tr>
				<td>새로운 비밀번호 확인 : <input type="password" name="pass2"
					id="pass2" required="required"> <font id="passchk" size="2"></font>
				</td>
			</tr>
			<tr>
				<td><button type="button" id="btnchange">변경</button></td>
			</tr>
		</table>
</body>
</html>