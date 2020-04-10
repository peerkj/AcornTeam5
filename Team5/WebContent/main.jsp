<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/jquery.bxslider.css">
<script src="js/jquery-3.4.1.js"></script>
<script src="js/jquery.bxslider.js"></script>
<script type="text/javascript">
$(function(){
    $('#btn-blue').on('click', function(){
        $('.dimmed').show();
        $('.popup-wrap').show();
    })
    $('#popup_close').on('click', function(){
        $('.dimmed').hide();
        $('.popup-wrap').hide();
    })

    $('.bxslider').bxSlider({
        auto: true, // 자동으로 애니메이션 시작 여부 (true면 자동 슬라이드, false는 자동 슬라이드 안함)
        speed: 200, // 애니메이션 속도
        pause: 2000, // 애니메이션 유지 시간 (1000은 1초)
        autoControls: false, // 시작 및 중지버튼 여부 (true면 보여짐, false는 안보임)
        pager: true, // 페이지 표시 여부 (true면 보여짐, false는 안보임)
        mode: 'horizontal', // 슬라이드 모드 ('fade', 'horizontal', 'vertical' 이 있음)
        captions: false // img 태그에 사용되는 title 속성을 이용해서 이미지 위에 텍스트를 넣을 수 있음 (true면 보여짐, false는 안보임)
    }); 
});
</script>
<style type="text/css">
	*{
		margin: 0;
	    padding: 0;
	    list-style: none;
	}
	a {
		text-decoration: none;
		display: block;
	}
	li {
		display: inline-block;
	}
	#header{
		width: 100%;
		height: 130px;
		border-top: 10px solid #fff;
		z-index: 999;
	}
	#contentarea{
		width: 100%;
	    height: 100%;
	    /* border: 1px solid red; */
	    z-index: -999;
	    background-color: #fff;
	}
	#bxslider{
		position: relative;
	}
	#content{
		width: 1400px;
		height: 2000px;
		margin: 0 auto;
		background-color: #f7f7f7;
	}
	#footer{
		width: 100%;
		height: 130px;
		border-top: 1px solid #ddd;
		background-color: #f7f7f7;
	}
	.main-image {
	    position: relative;
	    width: 100%;
	    height: 700px;
	    background-image: url(image/01.jpg);
	    background-repeat: no-repeat;
	    background-size: cover; /* contain:비율에 맞게 | cover: 비율무시  */    
	}
	.main-image02 { background-image: url(image/02.jpg); }
	.main-image03 { background-image: url(image/03.jpg); }
</style>
</head>
<body>
<div id="wrapper">
	<div id="header"><jsp:include page="header.jsp"/></div>
	<div id="contentarea">
		<div id="bxslider"><jsp:include page="bxslider.jsp"/></div>
		<div id="content"><jsp:include page="content.jsp"/></div>
	</div>
	<div id="footer"><jsp:include page="footer.jsp"/></div>
</div>
</body>
</html>