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
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;600;700&display=swap');
#msg{
	display: none;
}
#fullbox{
	border: 1px solid #fc9740;
	width: 400px;
	height: 200px;
	padding: 40px;
	float: center;
}
#reason{
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	font-size: 15pt;
}
#btn{
	font-family: 'Noto Sans KR', sans-serif;
    text-transform: uppercase;
    outline: 0;
    background: #fc9740;
    width: 150px;
    height: 50px;
    border: 0;
    margin: 20px 75px;
    padding: 5px;
    color: #FFFFFF;
    font-size: 16px;
    -webkit-transition: all 0.3 ease;
    transition: all 0.3 ease;
    cursor: pointer;
    margin-top: 40px;   
}
#ta{
	margin-top: 10px;
}
</style>
</head>
<body>
<div id="fullbox">
<span id="reason">탈퇴 사유를 선택하세요</span><br>
<select id="sel">
	<option selected disabled hidden>선택</option>
	<option>서비스 불만</option>
	<option>홈페이지 정보 부족</option>	
	<option>특별한 이유 없음</option>	
	<option>기타</option>					
</select>
<br>
<div id="msg">
	<textarea id="ta" rows="3" cols="25" maxlength="50"></textarea>
</div>
<button id="btn">탈퇴하기</button>
</div>
</body>
</html>