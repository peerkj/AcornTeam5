<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Information</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&family=Noto+Serif+KR:wght@300;600;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Rozha+One&display=swap');
*{ 
   margin: 0;
   padding: 0;
}

body, html {
   height: 100%;
}

.info1,.info2{
   margin-left: 560px;   
}
.mapbox{
   padding-bottom: 30px;
}
#map {
   width: 100%;
   height: 100%;
}
#title{
   font-family: 'Noto Serif KR', serif;
   font-weight: 700;
   font-size: 22pt;
   margin-top: 50px;
}
#subtitle{
   font-family: 'Noto Serif KR', serif;
   font-weight: 300;
   font-size: 18pt;
}
#text,#addr{
   font-family: 'Noto Serif KR', serif;
   font-weight: 300;
   font-size: 13pt;
}
.hd_img{
   height: 400px;
   width: 100%;
   background-size: cover;
   background-image: url('image/infopage.jpg');
   position: relative;
}
.img_title{
   width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.1);
}
.img_title span{
   font-size: 70pt;
   font-weight: 700;
   color: #fff;
   position: absolute;
   bottom: -40px;
    left: 300px;
    font-family: 'Rozha One', serif;
}
#line1{
   size: 1;
   width: 800px;
   margin-left: 560px;
}

</style>
</head>
<body>
<div class="contentbody">
<div class="hd_img">
   <div class="img_title"><span>INFORMATION</span></div>
</div>
<div class="info1">
   <div id="title">인사말</div><br>
   <div id="subtitle">달이 머물다 가는 곳, 월정리</div><br>
   <pre id="text">
서정적인 풍경의 월정리 해변을 거닐어 보신 적이 있나요.

낮에는 믿기지 않을 법한 에메랄드빛 바다의 파도가 마음을 씻겨주고,
밤이 되면 그 위로 밝은 달이 비치며 지친 일상에 고요함과 평온함을 가져다주곤 합니다.

월정리 해변에서의 힐링, 그 신묘한 매력을 함께 즐길 수 있는 오감만족 공간을 그렸습니다.

시작함에 있어 찾아 주시는 분들께 아직 미흡한 점 양해를 구하며, 
항상 주변의 소리에 귀 기울이며 누구나 함께, 쉽게, 행복하게 즐길 수 있는 공간이 되도록 노력하겠습니다. 

오늘도 찾아주셔서 고맙습니다.
   </pre>
</div><br>
<hr id="line1" color="e8ebeb">
<div class="info2">   
   <div id="title">오시는 길</div><br>
   <div id="addr">주소 : 제주특별자치도 제주시 구좌읍 해맞이해안로 474</div><br>
   <div class="mapbox">
   <div id="map" style="width:500px;height:350px;"></div>
      <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4fc65f171a18ebd0b095c3cd23b9119c"></script>
      <script>
         var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
         var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new kakao.maps.LatLng(33.5551925, 126.7971304), //지도의 중심좌표.
            level: 3 //지도의 레벨(확대, 축소 정도)
         };
         var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
         
         // 마커가 표시될 위치입니다 
            var markerPosition  = new kakao.maps.LatLng(33.5551925, 126.7971304); 

            // 마커를 생성합니다
            var marker = new kakao.maps.Marker({
                position: markerPosition
            });

            // 마커가 지도 위에 표시되도록 설정합니다
            marker.setMap(map);
         
         var iwContent = '<div style="padding:5px;font-size:11pt;">라봉펜션 <br>'+
         '<a href="https://map.kakao.com/link/map/라봉펜션,33.5551925, 126.7971304" style="color:#384abe;font-size:10pt;" target="_blank">큰 지도 보기</a><span style="color:#384abe;font-size:10pt;"> | </span>'+ 
         '<a href="https://map.kakao.com/link/to/라봉펜션,33.5551925, 126.7971304" style="color:#384abe;font-size:10pt;" target="_blank">길 찾기</a></div>', 
         // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
            iwPosition = new kakao.maps.LatLng(33.5551925, 126.7971304); //인포윈도우 표시 위치입니다

           // 인포윈도우를 생성합니다
           var infowindow = new kakao.maps.InfoWindow({
               position : iwPosition, 
               content : iwContent 
           });
             
           // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
           infowindow.open(map, marker);
      </script>
   </div>
</div>
</div>
</body>
</html>