<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SERVICE</title>
    <style type="text/css"> 
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500;700&display=swap');
        html,body{ 
	        margin:0; 
	        padding:0; 
	        width:100%; 
	        height:100%;
        }        
        .box{ 
	        width:100%; 
	        height: 100%;
	        position:relative;  
	        font-size:24pt;      
        }        
        .full_image{        	
        	width: 100%;
        	height: 100%;
        	padding: 250px 0px;   	
        }        
        .textbox{
			position: relative;
			height: 80px;
			width: 100%;
			background-color: rgba(0, 0, 0, 0.3);                                                                 
			z-index:1;
			padding: 100px 0;
			margin-top: 2%;
		}
		.service_font{
			font-size: 50px; 
			line-height: 50px; 
			font-style: normal; 
	    	font-weight: 600; 
	    	color: #fff; 
	    	text-decoration: none; 
	    	text-align: center;
			font-family: 'Noto Sans KR', sans-serif;
		}
		.service_font_mt{
			font-size: 20px; 
			line-height: 50px; 
			font-style: normal; 
	    	font-weight: 400; 
	    	color: #fff; 
	    	text-decoration: none; 
	    	text-align: center;
			font-family: 'Noto Sans KR', sans-serif;
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
    	<div class="full_image">
    	<img src="https://k.kakaocdn.net/dn/VNmPO/btqDlOiprVO/Rz6icXmvdNj2VNzTiTQhG1/img.png")>
    		<div class="textbox">
	    		<div class="service_font">바비큐장</div>
	    		<div class="service_font_mt">정원 내 바비큐장에서는 날씨에 관계없이 분위기 있는 식사를 즐길 수 있습니다.</div>
    		</div>
    	</div>
    </div>
    <div class="box">
    	<div class="full_image" style="background-image: url('https://k.kakaocdn.net/dn/bDb94Z/btqDmlUyNr3/2ywRgAEwLqVSBe4lKsG6UK/img.jpg');">
    		<div class="textbox">
	    		<div class="service_font">카페</div>
	    		<div class="service_font_mt">모든 투숙객에게 하루 한 잔의 커피를 제공합니다.</div>
    		</div>
    	</div>
    </div>
    <div class="box">
    	<div class="full_image" style="background-image: url('https://k.kakaocdn.net/dn/cdHKOy/btqDnwg1G5M/bakVSwf8JEDOraq22NefPk/img.jpg');">
    		<div class="textbox">
	    		<div class="service_font">수영장</div>
	    		<div class="service_font_mt">​제주의 싱그러운 자연과 함께 즐길 수 있는 야외 수영장입니다.</div>
    		</div>
    	</div>
    </div>
    <div class="box">
    	<div class="full_image" style="background-image: url('https://k.kakaocdn.net/dn/cXNjOk/btqDmnrmwGM/dhKpWz3o8n1kKHEUPuwp01/img.jpg');">
    		<div class="textbox">
	    		<div class="service_font">감귤 따기 체험</div>
	    		<div class="service_font_mt">새콤달콤한 제주 감귤을 직접 수확하여 마음껏 먹을 수 있습니다.</div>
    		</div>
    	</div>
    </div>
</body>
</html>