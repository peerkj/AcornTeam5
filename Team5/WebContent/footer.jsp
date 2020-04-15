<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.copyright{
	width: 100%;
	position: relative;
    color: #c0c1c1;
    font-size: 10pt;
    text-align: center;
    height: 80px;
  	line-height: 80px;
}
#mainlink{
	cursor: pointer;
	display: inline;
}
.footer_info{
	position: relative;
    color: #c0c1c1;
    font-size: 10pt;
    text-align: center;
}
</style>
<script type="text/javascript">
$(function(){
	$("#mainlink").click(function() {
		location.href="index.jsp";		
	});
});
</script>
<title>Insert title here</title>
</head>
<body>
<div class="footer_info" style="margin-top:20px;">사업주:오경석</div>
<div class="footer_info">전화번호:010-5181-6558</div>
<div class="footer_info">본사 주소지:충청북도 청주시 상당구 당산로 83-7</div>
<div class="copyright">Copyright © <p id="mainlink">라봉펜션</p>. All Rights Reserved.</div>
</body>
</html>