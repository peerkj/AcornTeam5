<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>   
@import url('https://fonts.googleapis.com/css2?family=Rozha+One&display=swap'); 
   .map_wrap, .map_wrap * {margin:0; padding:0;font-size:12px;}
   .map_wrap {position:relative;width:100%;height:500px;}
   #category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
   #category li {float:left;list-style: none;width:50px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
   #category li.on {background: #eee;}
   #category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
   #category li:last-child{margin-right:0;border-right:0;}
   #category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
   #category li .category_bg {background:url(https://k.kakaocdn.net/dn/wNnfw/btqDxK0wj6t/jdGxKRcuQmRdkm7GiV23HK/img.png) no-repeat;}
   #category li .bank {background-position:-10px 0;}
   #category li .mungso {background-position: -10px -36px;}
   #category li .pharmacy {background-position: -10px -72px;}
   #category li .food {background-position: -10px -108px;}
   #category li .cafe {background-position: -10px -144px;}
   #category li .store {background-position: -10px -180px;}
   #category li.on .category_bg {background-position-x:-46px;}
   .placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
   .placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
   .placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
   .placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
   .placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
   .placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
   .placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
   .placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
   .placeinfo .tel {color:#0f7833;}
   .placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
  
.hd_img{
   height: 400px;
   width: 100%;
   background-size: cover;
   background-image: url('image/mapservice.jpg');
   position: relative;
   margin-bottom: 50px;
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
</style>
</head>
<body>
<div class="hd_img">
   <div class="img_title"><span>ATTRACTION</span></div>
</div>
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
    <ul id="category">
        <li id="BK9" data-order="0"> 
            <span class="category_bg bank"></span>
            은행
        </li>       
        <li id="AT4" data-order="1"> 
            <span class="category_bg mungso"></span>
            명소
        </li>  
        <li id="PM9" data-order="2"> 
            <span class="category_bg pharmacy"></span>
            약국
        </li>  
        <li id="FD6" data-order="3"> 
            <span class="category_bg food"></span>
            음식점
        </li>  
        <li id="CE7" data-order="4"> 
            <span class="category_bg cafe"></span>
            카페
        </li>  
        <li id="CS2" data-order="5"> 
            <span class="category_bg store"></span>
            편의점
        </li>      
    </ul>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4fc65f171a18ebd0b095c3cd23b9119c&libraries=services"></script>
<script>
   // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
   var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
       contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
       markers = [], // 마커를 담을 배열입니다
       currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
    
   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       mapOption = {
           center: new kakao.maps.LatLng(33.5551925, 126.7971304), // 지도의 중심좌표
           level: 2 // 지도의 확대 레벨
       };  
   
   // 지도를 생성합니다    
   var map = new kakao.maps.Map(mapContainer, mapOption);
   
   // 마커가 표시될 위치입니다 
   var markerPosition  = new kakao.maps.LatLng(33.5551925, 126.7971304); 

   // 마커를 생성합니다
   var marker = new kakao.maps.Marker({
       position: markerPosition
   });

   // 마커가 지도 위에 표시되도록 설정합니다
   marker.setMap(map);

   var iwContent = '<div style="padding:5px;width:150px;font-size:11pt;">라봉펜션 <br><a href="https://map.kakao.com/link/map/라봉펜션,33.5551925, 126.7971304" style="color:#384abe;font-size:10pt;" target="_blank">큰 지도 보기</a> | <a href="https://map.kakao.com/link/to/라봉펜션,33.5551925, 126.7971304" style="color:#384abe;font-size:10pt;" target="_blank">길 찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
       iwPosition = new kakao.maps.LatLng(33.5551925, 126.7971304); //인포윈도우 표시 위치입니다

   // 인포윈도우를 생성합니다
   var infowindow = new kakao.maps.InfoWindow({
       position : iwPosition, 
       content : iwContent 
   });
     
   // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
   infowindow.open(map, marker);
   
   // 장소 검색 객체를 생성합니다
   var ps = new kakao.maps.services.Places(map); 
   
   // 지도에 idle 이벤트를 등록합니다
   kakao.maps.event.addListener(map, 'idle', searchPlaces);
   
   // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
   contentNode.className = 'placeinfo_wrap';
   
   // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
   // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
   addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
   addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);
   
   // 커스텀 오버레이 컨텐츠를 설정합니다
   placeOverlay.setContent(contentNode);  
   
   // 각 카테고리에 클릭 이벤트를 등록합니다
   addCategoryClickEvent();
   
   // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
   function addEventHandle(target, type, callback) {
       if (target.addEventListener) {
           target.addEventListener(type, callback);
       } else {
           target.attachEvent('on' + type, callback);
       }
   }
   
   // 카테고리 검색을 요청하는 함수입니다
   function searchPlaces() {
       if (!currCategory) {
           return;
       }
       
       // 커스텀 오버레이를 숨깁니다 
       placeOverlay.setMap(null);
   
       // 지도에 표시되고 있는 마커를 제거합니다
       removeMarker();
       
       ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
   }
   
   // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
   function placesSearchCB(data, status, pagination) {
       if (status === kakao.maps.services.Status.OK) {
   
           // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
           displayPlaces(data);
       } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
           // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요
   
       } else if (status === kakao.maps.services.Status.ERROR) {
           // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
           
       }
   }
   
   // 지도에 마커를 표출하는 함수입니다
   function displayPlaces(places) {
   
       // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
       // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
       var order = document.getElementById(currCategory).getAttribute('data-order');
   
       
   
       for ( var i=0; i<places.length; i++ ) {
   
               // 마커를 생성하고 지도에 표시합니다
               var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);
   
               // 마커와 검색결과 항목을 클릭 했을 때
               // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
               (function(marker, place) {
                   kakao.maps.event.addListener(marker, 'click', function() {
                       displayPlaceInfo(place);
                   });
               })(marker, places[i]);
       }
   }
   
   // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
   function addMarker(position, order) {
       var imageSrc = 'https://k.kakaocdn.net/dn/wNnfw/btqDxK0wj6t/jdGxKRcuQmRdkm7GiV23HK/img.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
           imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
           imgOptions =  {
               spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
               spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
               offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
           },
           markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
               marker = new kakao.maps.Marker({
               position: position, // 마커의 위치
               image: markerImage 
           });
   
       marker.setMap(map); // 지도 위에 마커를 표출합니다
       markers.push(marker);  // 배열에 생성된 마커를 추가합니다
   
       return marker;
   }
   
   // 지도 위에 표시되고 있는 마커를 모두 제거합니다
   function removeMarker() {
       for ( var i = 0; i < markers.length; i++ ) {
           markers[i].setMap(null);
       }   
       markers = [];
   }
   
   // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
   function displayPlaceInfo (place) {
       var content = '<div class="placeinfo">' +
                       '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   
   
       if (place.road_address_name) {
           content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                       '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
       }  else {
           content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
       }                
      
       content += '    <span class="tel">' + place.phone + '</span>' + 
                   '</div>' + 
                   '<div class="after"></div>';
   
       contentNode.innerHTML = content;
       placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
       placeOverlay.setMap(map);  
   }
   
   
   // 각 카테고리에 클릭 이벤트를 등록합니다
   function addCategoryClickEvent() {
       var category = document.getElementById('category'),
           children = category.children;
   
       for (var i=0; i<children.length; i++) {
           children[i].onclick = onClickCategory;
       }
   }
   
   // 카테고리를 클릭했을 때 호출되는 함수입니다
   function onClickCategory() {
       var id = this.id,
           className = this.className;
   
       placeOverlay.setMap(null);
   
       if (className === 'on') {
           currCategory = '';
           changeCategoryClass();
           removeMarker();
       } else {
           currCategory = id;
           changeCategoryClass(this);
           searchPlaces();
       }
   }
   
   // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
   function changeCategoryClass(el) {
       var category = document.getElementById('category'),
           children = category.children,
           i;
   
       for ( i=0; i<children.length; i++ ) {
           children[i].className = '';
       }
   
       if (el) {
           el.className = 'on';
       } 
   } 
</script>
</body>
</html>