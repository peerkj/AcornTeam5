<%@page import="data.dto.ClientDto"%>
<%@page import="data.dao.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
</head>
<%

String id = (String)session.getAttribute("id");

ClientDao dao=new ClientDao();

ClientDto dto = dao.getClientData(id);
%>
<body>

   <form action="<%=request.getContextPath()%>/mypage/updateclientaction.jsp" method="post">
      <table>
         <caption>
            <b>회원정보수정</b>
         </caption>
         <tr>
            <th>이름</th>
            <td><input type="text" name="name" id="name"
               readonly="readonly" value="<%= dto.getName() %>">
            </td>
         </tr>
         <tr>
            <th>아이디</th>
            <td><input type="text" name="id" id="id" readonly="readonly"
            value="<%=dto.getId() %>">
            </td>
         </tr>
         
         <tr>
         <%
         String[] hp = dto.getHp().split("-");
            
         %>
            <th>핸드폰</th>
            <td><input type="text" name="hp1" id="hp1" required="required"
               maxlength="4" pattern="^[0-9]{3}" value="<%=hp[0] %>"> <b>-</b> 
               <input type="text" name="hp2" id="hp2" required="required" maxlength="4"
               pattern="^[0-9]{4}" value="<%=hp[1] %>"> <b>-</b> 
               <input type="text" name="hp3" id="hp3" required="required" maxlength="4" 
               pattern="^[0-9]{4}" value="<%=hp[2] %>">
            </td>
         </tr>
         <tr>
         <%
         String[] email = dto.getEmail().split("@");
         %>
            <th>e-mail</th>
            <td><input type="text" name="email1" id="email1"
               required="required" pattern="[a-z0-9._%+-]{5,}"
               value = "<%=email[0]%>"> <b>@</b> <input
               type="text" name="email2" id="email2" required="required"
               value = "<%=email[1]%>">
               <select name="email3" id="email3">
                  <option value="-">직접입력</option>
                  <option value="naver.com">naver.com</option>
                  <option value="nate.com">nate.com</option>
                  <option value="gmail.com">gmail.com</option>
                  <option value="daum.net">daum.net</option>
            </select></td>
         </tr>
         <tr>
            <td colspan="2">
               <input id="submit" type="submit" value="수정하기">
            </td>
      </table>
   </form>

</body>
</html>