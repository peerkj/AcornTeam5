<%@page import="data.dto.ClientDto"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="data.dao.ClientDao"%>
<%@page import="data.dto.ReservationDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ReservationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세정보</title>
<%
   request.setCharacterEncoding("utf-8");
   String id = request.getParameter("id");
   String pageNum=request.getParameter("pageNum");
   //dao
   ReservationDao rd = new ReservationDao();
   ClientDao cd = new ClientDao();
   //이용내역
   List<ReservationDto> list = rd.getUse(id);
   //화폐
   NumberFormat nf=NumberFormat.getInstance();   
   //권한 확인
   ClientDto cdto=cd.getClientData(id);
   int m=Integer.parseInt(cdto.getManager());
%>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
   $(function(){
      //권한주기
      var id='<%=id%>';
      var m='<%=m%>';
      $('#addmanager').click(function() {
         $.ajax({
            url:'<%=request.getContextPath()%>/admin/manager.jsp',
            type:'post',
            dataType:'html',
            data:'id='+id+'&m='+m,
            success:function(e){
               if(e!=-1){
            		location.href='<%=request.getContextPath()%>/index.jsp?main=admin/adminmain.jsp?select=client.jsp?pageNum='+<%=pageNum%>+'&id='+id;		
				}
            }
         });
      });
      $('#deletemanager').click(function() {
         $.ajax({
            url:'<%=request.getContextPath()%>/admin/manager.jsp',
            type:'post',
            dataType:'html',
            data:'id='+id+'&m='+m,
            success:function(e){
               if(e!=-1){
            		location.href='<%=request.getContextPath()%>/index.jsp?main=admin/adminmain.jsp?select=client.jsp?pageNum='+<%=pageNum%>+'&id='+id;		
				}
            }
         });
      });
   });
</script>
<style type="text/css">
th,td{
   padding: 10px;
   text-align: center;
}
th{
   background-color: #ffe5bd;
}
#addmanager,#deletemanager{
   border: none;
    background-color: #ffe5bd;
    margin-left: 10px;
    padding: 8px;
    font-weight: 600;
    position: absolute;
    left: 200px;
    top: 42px;
    width: 110px;
    height: 70px;
    font-size: 16px;
}
.clientbox{
   border-radius: 15px;
   position: relative;
   border: 1px solid #fbc777;
   width: 800px;
   padding: 35px 30px 20px;
   box-sizing: border-box;
   font-weight: 600;
   font-size: 18px;
   height: 180px;
}
.clientbox::after{
   content: "";
   display: block;
   clear: both;
}
.clientlist{
   width: 120px;
    border: none;
    background-color: #faa727;
    height: 50px;
    color: white;
    font-weight: 600;
    font-size: 16px;
    border-radius: 15px;
    margin-left: 340px;
}
</style>
</head>
<body>
   <div class="clientbox">
   <span style="float: left">아이디:<%=id%>&nbsp;&nbsp;&nbsp;&nbsp;<br> 
   고객명:<%=cd.getName(id)%><br>
   등급:<%if(m==1){
      %>
      매니저
      <button id="addmanager">관리자<br>권한해제</button>
   <%}else{
      %>
      일반
      <button id="deletemanager">관리자<br>권한주기</button>
      <%}
   %>
   </span>
   <span style="float: left;margin-left: 250px;">이용건수:<%=list.size()%><br>
   총 이용금액:<%=nf.format(rd.getMoney(id))%></span>
   
   </div>
   <table style="width: 800px;margin: 20px 0;border-collapse: collapse;">
      <caption style="font-size: 30px;margin-bottom: 10px;"><b>이용 내역</b></caption>
      <thead>
         <tr>
            <th>번호</th>
            <th>방이름</th>
            <th>입실날짜</th>
            <th>퇴실날짜</th>
            <th>기본요금</th>
            <th>추가요금</th>
            <th>총 요금</th>
         </tr>
      </thead>
      <tbody>

         <%
            if (list.size() == 0) {
         %>
            <tr><td colspan="7">이용 내역이 없습니다.</td></tr>
         <%
            } else {
               int i=1;
               for (ReservationDto dto : list) {
         %>
         <tr>
            <td><%=i%></td>
            <td><%=rd.getRoomName(dto.getRnum()) %></td>
            <td><%=dto.getStartday().substring(0, 10)%></td>
            <td><%=dto.getEndday().substring(0, 10)%></td>
            <td><%=nf.format(Integer.parseInt(dto.getPrice()))%></td>
            <td><%=nf.format(Integer.parseInt(dto.getAdditional()))%></td>
            <td><%=nf.format(Integer.parseInt(dto.getAdditional())+Integer.parseInt(dto.getPrice()))%></td>
         </tr>
         <%
            i++;}
            }
         %>
      </tbody>
   </table>
   <button onclick="history.back()" class="clientlist">목록으로</button>
</body>
</html>