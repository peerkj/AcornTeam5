<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">

var idchk = 0;//아이디 체크
var passchk = 0;//비밀번호 체크

	$(function() {
		
		//아이디체크
		$('#id').keyup(function(e) {
			//아이디 길이 저장
			var l = $(this).val().length;
			$.ajax({
				type : "get",
				dataType : "json",
				url : "idchk.jsp",
				data : "id=" + $('#id').val(),
				success : function(data) {
					$.each(data, function(i, elt) {
						if (l >= 5) {
							if (elt.result == 1) {
								$('#idchk').html('이미 사용중인 아이디<br><br>');
								$('#idchk').attr('color', '#f82a2aa3');
								idchk = 0;
							} else if (elt.result == 0) {
								$('#idchk').html('사용 가능<br><br>');
								$('#idchk').attr('color', '#199894b3');
								idchk = 1;
							}
						} else {
							$('#idchk').html('5자 이상 입력<br><br>');
							$('#idchk').attr('color', '#f82a2aa3');
							idchk = 0;
						}
					});
				}
			});
		});

		$("#email3").change(function() {
			//해당 이메일 주소 값 얻기
			var addr = $(this).val();
			//직접입력 경우
			if (addr == '-') {
				//입력된 이메일 주소 지우기
				$("#email2").val('');
				$("#email2").focus();
			} else {
				//선택한 이메일 주소 출력
				$("#email2").val(addr);
			}
		});

		$("#hp1").keyup(function() {
			var len = $(this).val().length;
			if (len == 3)
				$("#hp2").focus();

			$("#hp2").keyup(function() {
				var len = $(this).val().length;
				if (len == 4)
					$("#hp3").focus();
			});
		});

		$('#pass').keyup(function() {
			$('#passchk').html('');
		});

		$('#pass1').keyup(function() {

			if ($('#pass').val() != $('#pass1').val()) {
				$('#passchk').html('비밀번호 일치하지 않음<br><br>');
				$('#passchk').attr('color', '#f82a2aa3');
				passchk=0;

			} else {
				$('#passchk').html('비밀번호 일치함<br><br>');
				$('#passchk').attr('color', '#199894b3');
				passchk=1;
			}

		});

	});
	
</script>
</head>
<body>

	<form action="registeraction.jsp" method="post">
		<table>
			<caption>
				<b>회원가입</b>
			</caption>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" id="name"
					required="required" pattern="^[가-힣]{2,}" placeholder="한글만 입력해주세요">
				</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="id" id="id" required="required"
					pattern="[a-z0-9._%+-]{5,}"> <font id="idchk" size="2"></font>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pass" id="pass"
					required="required"></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" name="pass1" id="pass1"
					required="required"> <font id="passchk" size="2"></font></td>
			</tr>

			<tr>
				<th>핸드폰</th>
				<td><input type="text" name="hp1" id="hp1" required="required"
					maxlength="4" pattern="^[0-9]{3}"> <b>-</b> <input
					type="text" name="hp2" id="hp2" required="required" maxlength="4"
					pattern="^[0-9]{4}"> <b>-</b> <input type="text" name="hp3"
					id="hp3" required="required" maxlength="4" pattern="^[0-9]{4}">
				</td>
			</tr>
			<tr>
				<th>e-mail</th>
				<td><input type="text" name="email1" id="email1"
					required="required" pattern="[a-z0-9._%+-]{5,}"> <b>@</b> <input
					type="text" name="email2" id="email2" required="required">
					<select name="email3" id="email3">
						<option value="-">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="nate.com">nate.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
				</select></td>
			</tr>
			<tr>
				<td colspan="2">
					<input id="submit" type="submit" value="가입하기">
				</td>
		</table>
	</form>

</body>
</html>