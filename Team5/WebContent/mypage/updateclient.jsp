<%@page import="data.dto.ClientDto"%>
<%@page import="data.dao.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<%
String url=request.getContextPath();
%>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">

   $(function() {
      $("#email3").change(function() {
         //해당 이메일 주소 값 얻기
         var addr = $(this).val();
         console.log(addr);
         //직접입력 경우
         if (addr == '-') {
            //입력된 이메일 주소 지우기
            $("#email2").val('');
            $("#email2").focus();
         } else {
            //선택한 이메일 주소 출력
            $("#email2").val(addr);
         }
      });

      $("#hp1").keyup(function() {
         var len = $(this).val().length;
         if (len == 3)
            $("#hp2").focus();

         $("#hp2").keyup(function() {
            var len = $(this).val().length;
            if (len == 4)
               $("#hp3").focus();
         });
      });
      
   });
</script>
<style type="text/css">
#updateclient_body{
	border: 1px solid #fc9740;
	padding: 70px;
	width: 600px;
}
#updateclient_title{
	font-size: 20pt;
	margin-left: 200px;
	font-weight: 700;
}
form input {
	outline: 0;
	background: #ececee;
	width: 30%;
	border: 0;
    margin: 10px 0 15px 0;
    padding: 2%;
    box-sizing: border-box;
    font-size: 14px;
   }
form b{
	font-weight: 500;
	font-size: 12pt;
}
#submit {
     text-transform: uppercase;
     outline: 0;
     background: #fc9740;
     width: 250px;
     border: 0;
     margin-top:25px;
     margin-left: 165px;
     padding: 2%;
     color: #FFFFFF;
     font-size: 14px;
     -webkit-transition: all 0.3 ease;
     transition: all 0.3 ease;
     cursor: pointer;     
   }
select {
   width: 30%;
   padding: 1.5%;
   border: 1px solid #999;
   font-family: inherit;
   border-radius: 0px;
   -webkit-appearance: none;
   -moz-appearance: none;
   appearance: none;
   }
#focusform input:active, #focusform input:focus {
	border: 0.2px solid #fc9740;
}
</style>
</head>
<%

String id = (String)session.getAttribute("id");

ClientDao dao=new ClientDao(); 

ClientDto dto = dao.getClientData(id);
%>
<body>
<div id="updateclient_full">
<div id="updateclient_body">
   <form action="<%=request.getContextPath()%>/mypage/updateclientaction.jsp" method="post">
            <span id="updateclient_title">회원 정보 수정</span><br><br>
            <b>이름</b><br>
            <input type="text" name="name" id="name"
               readonly="readonly" value="<%= dto.getName() %>"><br>
            <b>아이디</b><br>
            <input type="text" name="id" id="id" readonly="readonly"
            value="<%=dto.getId() %>"><br>
         <div id="focusform">
         <%
         String[] hp = dto.getHp().split("-");
            
         %>
            <b>핸드폰</b><br>
            <input type="text" name="hp1" id="hp1" required="required"
            maxlength="4" pattern="^[0-9]{3}" value="<%=hp[0] %>"> <b>-</b> 
            <input type="text" name="hp2" id="hp2" required="required" maxlength="4"
            pattern="^[0-9]{4}" value="<%=hp[1] %>"> <b>-</b> 
            <input type="text" name="hp3" id="hp3" required="required" maxlength="4" 
            pattern="^[0-9]{4}" value="<%=hp[2] %>"><br>
         <%
         String[] email = dto.getEmail().split("@");
         %>
         <b>이메일</b><br>
         <input type="text" name="email1" id="email1"
               required="required" pattern="[a-z0-9._%+-]{5,}"
               value = "<%=email[0]%>"> <b>@</b> <input
               type="text" name="email2" id="email2" required="required"
               value = "<%=email[1]%>">
	        <select name="email3" id="email3" style="background: url('<%=url%>/image/icon.jpg') no-repeat 95% 50%;">
		        <option value="-">직접 입력</option>
		        <option value="naver.com">naver.com</option>
		        <option value="nate.com">nate.com</option>
		        <option value="gmail.com">gmail.com</option>
		        <option value="daum.net">daum.net</option>
	        </select><br>
	    </div>
        <button id="submit" type="submit">수정하기</button>
   </form>
</div>
</div>
</body>
</html>