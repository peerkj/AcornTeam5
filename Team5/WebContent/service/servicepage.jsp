<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SERVICE</title>
<style type="text/css">
html,body{ 
	margin:0; 
	padding:0; 
	width:100%; 
	height:100%;
	z-index: -999;
}
  
.box{ 
	width:100%; 
	height: 100%;
	position:relative; 
	color:#ffffff; 
	font-size:24pt;    
	-ms-overflow-style: none;  
}
/* body::-webkit-scrollbar {
	display: none;
} */
  
.full_image{
	width: 100%;
	height: 100vh;
	padding: 310px 0px; 
	background-size: cover;     
}
  
.textbox{
	position: absolute;
	height: 80px;
	width: 100%;
	background-color: rgba(0, 0, 0, 0.3);                                                                 
	z-index:1;
	padding: 70px 0px;
}
.service_font{
	font-size: 50px; 
	line-height: 50px; 
	font-style: normal; 
	font-weight: 600; 
	color: #fff; 
	text-decoration: none; 
	text-align: center;
}
.service_font_mt{
	font-size: 20px; 
	line-height: 50px; 
	font-style: normal; 
	font-weight: 600; 
	color: #fff; 
	text-decoration: none; 
	text-align: center;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/2.0.2/anime.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
    window.onload = function () {
        var elm = ".box";
        $(".service_font").hide();
        $(".service_font_mt").hide();
        $(".service_font").fadeIn(1500); //1000=1초
        $(".service_font_mt").fadeIn(1500);           
        $(elm).each(function (index) {
            // 개별적으로 Wheel 이벤트 적용
            $(this).on("mousewheel DOMMouseScroll", function (e) {
                e.preventDefault();
                var delta = 0;
                if (!event) event = window.event;
                if (event.wheelDelta) {
                    delta = event.wheelDelta / 120;
                    if (window.opera) delta = -delta;
                } 
                else if (event.detail)
                    delta = -event.detail / 3;
                var moveTop = $(window).scrollTop();
                var elmSelecter = $(elm).eq(index);
                // 마우스휠을 위에서 아래로
                if (delta < 0) {
                    if ($(elmSelecter).next() != undefined) {
                        try{
                            moveTop = $(elmSelecter).next().offset().top;
                            $(".service_font").hide();
                            $(".service_font_mt").hide();
                            $(".service_font").fadeIn(1500); //1000=1초
                            $(".service_font_mt").fadeIn(1500);
                        }catch(e){}
                    }
                    if ($(elmSelecter).next() == undefined){
                    	try {
							moveTop = $("#footer").offset().bottom;
						} catch (e) {
							// TODO: handle exception
						}
                    }
                // 마우스휠을 아래에서 위로
                } else {
                    if ($(elmSelecter).prev() != undefined) {
                        try{
                            moveTop = $(elmSelecter).prev().offset().top;
                            $(".service_font").hide();
                            $(".service_font_mt").hide();
                            $(".service_font").fadeIn(1500);
                            $(".service_font_mt").fadeIn(1500);   
                        }catch(e){}
                    }
                }
                 
                // 화면 이동 0.8초(800)
                $("html,body").stop().animate({
                    scrollTop: moveTop + 'px'
                }, {
                    duration: 800, complete: function () {
                    }
                });
            });
        });
    }
    
</script>
</head>
<body>
    <div class="box">
	<div class="full_image" style="background-image: url('image/7.jpg');">
		<div class="textbox">
			<div class="service_font">해변</div>
			<div class="service_font_mt">해변입니다</div>
		</div>
	</div>
</div>
<div class="box">
	<div class="full_image" style="background-image: url('image/8.jpg');">
		<div class="textbox">
			<div class="service_font">한라봉</div>
			<div class="service_font_mt">한라봉입니다</div>
		</div>	
	</div>
</div>
<div class="box">
	<div class="full_image" style="background-image: url('image/9.jpg');">
		<div class="textbox">
			<div class="service_font">하늘</div>
			<div class="service_font_mt">하늘입니다</div>
		</div>
	</div>
</div>
<div class="box">
	<div class="full_image" style="background-image: url('image/10.jpg');">
		<div class="textbox">
			<div class="service_font">바다</div>
			<div class="service_font_mt">바다입니다</div>
		</div>
	</div>
</div>
<div class="box">
	<div class="full_image" style="background-image: url('image/11.jpg');">
		<div class="textbox">
			<div class="service_font">말</div>
			<div class="service_font_mt">말입니다</div>
		</div>
	</div>
</div>
</body>
</html>