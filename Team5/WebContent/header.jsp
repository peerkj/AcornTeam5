<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/style_header.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
$(function(){
	$(".dropouter").hide();
	$('.mainitem > a').mouseover(function() {
        $(this).parent().children().slideDown('slow');
    })
    /* $('.mainitem > a').mouseout(function() {
        $(this).parent().children().slideUp('fast');
    })
	

   $('.dropouter').on('mouseover', function() {
        $(this).siblings('a').addClass('change')
    })
    $('.dropouter').on('mouseout', function() {
        $(this).siblings('a').removeClass('change')
    }) */
});
</script>
</head>
<body>
<h1 class="logo"><img src="image/logo.png" style="height: 120px;"></h1>
<ul class="info">
	<li>login</li>
	<li>join</li>
</ul>
<ul class="mainmenu">
	<li class="mainitem"><a>ROOM</a>
		<div class="dropouter">
			<ul class="dropmenu" >
				<li class="dropitem"><a href="#">ROOM01</a></li>
				<li class="dropitem"><a href="#">ROOM02</a></li>
				<li class="dropitem"><a href="#">ROOM03</a></li>
				<li class="dropitem"><a href="#">ROOM04</a></li>
				<li class="dropitem"><a href="#">ROOM05</a></li>
				<li class="dropitem"><a href="#">ROOM06</a></li>
				<li class="dropitem"><a href="#">ROOM07</a></li>
				<li class="dropitem"><a href="#">ROOM08</a></li>
				<li class="dropitem"><a href="#">ROOM09</a></li>
				<li class="dropitem"><a href="#">ROOM10</a></li>
			</ul>
		</div>
	</li>
	<li class="mainitem"><a>SERVICE</a></li>
	<li class="mainitem"><a>INFORMATION</a></li>
	<li class="mainitem"><a>RESERVATION</a></li>
	<li class="mainitem"><a>Q&A</a></li>
</ul>
</body>
</html>