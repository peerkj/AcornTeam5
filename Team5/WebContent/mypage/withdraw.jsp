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
		$("#sel").change(function() {
			if($(this).val()=='기타'){
				$('#msg').show();
			}else{
				$('#msg').hide();	
			}
		});
		
		$('#btn').click(function() {
			if($('#sel option:selected').val()=='선택'){
				alert('탈퇴사유를 선택하세요.');
				return;
			}else if($('#sel option:selected').val()=='기타' && $('#ta').val().length<10){
				alert('10자 이상 입력하세요.');
				return;
			}else{
				var y=confirm("정말로 탈퇴하시겠습니까?");
				if(y){
					var msg="";
					if($('#sel option:selected').val()=='기타'){
						msg=$('#ta').val();
					}else{
						msg=$('#sel option:selected').val();
					}
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=request.getContextPath()%>/mypage/withdrawaction.jsp",
						data:"reason="+msg,
						success:function(data){
							location.href="<%=request.getContextPath()%>/index.jsp?main=mypage/successwithdraw.jsp";
						}
					});
				}
			}
		});
	});
</script>
<style type="text/css">
#msg{
	display: none;
}
</style>
</head>
<body>
탈퇴사유를 선택하세요<br>
<select id="sel">
	<option selected disabled hidden>선택</option>
	<option>서비스 불만</option>
	<option>홈페이지 정보 부족</option>	
	<option>특별한 이유 없음</option>	
	<option>기타</option>					
</select>
<br>
<div id="msg">
	<textarea id="ta" rows=5 cols="45" maxlength="50"></textarea>
</div>
<button id="btn">탈퇴하기</button>
</body>
</html>