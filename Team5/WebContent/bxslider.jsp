<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
String url=request.getContextPath();
%>
<link rel="stylesheet" href="<%=url%>/css/jquery.bxslider.css">
<script src="<%=url %>/js/jquery.bxslider.js"></script>
<script type="text/javascript">
$(function(){
	/* 이미지 슬라이더 */
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
<div class="main-image-group">
	<ul class="bxslider">
	    <!-- 첫번째 이미지 -->
        <li>
            <div class="main-image">
                <!-- <img src="images/img-bg02.png" title="이미지 설명을 추가할까요"> -->
                
            </div>                           
        </li>
        <!-- //첫번째 이미지 -->

        <!-- 두번째 이미지 -->
        <li>
            <div class="main-image main-image02">
                <div class="main-text-box">
                    <p class="main-text text-large">두번째 이미지</p>
                    <p class="main-text">두번째 이미지가 보입니다</p>
                </div>
            </div>
        </li>
        <!-- //두번째 이미지 -->

        <!-- 세번째 이미지 -->
        <li>
            <div class="main-image main-image03">
                <div class="main-text-box">
                    <p class="main-text text-large">세번째 이미지</p>
                </div>
            </div>
        </li>
        <!-- //세번째 이미지 -->
    </ul>
</div>
</body>
</html>