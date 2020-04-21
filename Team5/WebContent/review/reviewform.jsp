<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&family=Noto+Serif+KR:wght@300;600;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Rozha+One&display=swap');
#star_grade a{
   text-decoration: none;
   color: gray;
   float: left;
   
}
#star_grade a.on{
   color: #faa727;
}
#star_grade:hover{
   cursor: pointer;
}
#reid{
   width: 500px;
   margin: 50px auto;
   border-collapse: collapse;
}
#reid th{
   width: 100px;
   background-color: #ffe5bd;
   padding: 10px 20px;
}
#reid td{
   padding: 10px 20px;
}
#reid caption{
   font-size: 18pt;
}
#reid button{
   width: 100px;
   height: 35px;
   background-color: #faa727;
   border: none;
   font-size: 10pt;
   font-style: none;
   font-weight: 400;
   float: center;
   color: #fff;
   border-radius: 15px;
   cursor: pointer;
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
#tbcontent{
   width: 300px;
   height: 200px;
   resize: none;
}
</style>
<script type="text/javascript">
   $(function(){
      $('#btnsave').click(function() {
         if($("#star").attr("value")==0){
            alert("별점을 선택해주세요");
            return false;
         }
      });
      
      $('#star_grade a').click(function(){
            $(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
            $(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
            $(this).off('mouseleave');
            $("#star").attr("value",$("a.on").length);
            return false;
        });
      
      $('#star_grade a').mouseover(function() {
         $(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
            $(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
      });
      
      $('#star_grade a').mouseleave(function() {
         $(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */            
      });
   });
</script>
</head>
<%
   String url = request.getContextPath();
   String id = (String)session.getAttribute("id");
   String rnum = request.getParameter("rnum");
%>
<body>
<div class="hd_img" style="background-image: url('<%=url%>/image/room1.jpg')">
   <div class="img_title"><span>REVIEW</span></div>
</div>
<div id="tbfull">
<form action="<%=url %>/review/reviewinsertaction.jsp" method="post" enctype="multipart/form-data">
   <input type="hidden" name="id" value="<%= id%>">
   <input type="hidden" name="rnum" value="<%= rnum%>">
   <input type="hidden" name="star" id="star" value="">
   <table id="reid">
      <caption><b>리뷰 작성</b></caption>
      <tr>
         <th>작성자</th>
         <td>
            <b><%=id %></b>
         </td>
      </tr>
      <tr>
         <th>별점</th>
         <td>
            <p id="star_grade" style="font-size: 30px;">
                <a href="#">★</a>
                <a href="#">★</a>
                <a href="#">★</a>
                <a href="#">★</a>
                <a href="#">★</a>
            </p>
         </td>
      </tr>
      <tr>
         <th></th>
         <td>
            <textarea id="tbcontent" name="content" required="required"></textarea>
         </td>
      </tr>
      <tr>
         <th>사진 첨부</th>
         <td>
            <input type="file" name="photo">
         </td>
      </tr>
      <tr>
         <td colspan="2" align="center">
            <button type="submit" id="btnsave">저장하기</button>
         </td>
      </tr>
   </table>
</form>
</div>
</body>
</html>