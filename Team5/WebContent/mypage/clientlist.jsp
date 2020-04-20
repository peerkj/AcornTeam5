<%@page import="java.text.ParseException"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.ReservationDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="data.dao.ReservationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
   String url=request.getContextPath();
   String id = (String)session.getAttribute("id");
   ReservationDao db = new ReservationDao();
   int count = db.useCount(id);
   List<ReservationDto> list = db.getUse(id,1,5);
   DecimalFormat formatter = new DecimalFormat("###,###");
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   
   Calendar cal = Calendar.getInstance();
   int year = cal.get(Calendar.YEAR);
   //month는 +1 해줘야함
   int month = cal.get(Calendar.MONTH);
   //오늘날짜
   int date = cal.get(Calendar.DATE);
   String s_month = String.format("%02d", month + 1);
   String s_date = String.format("%02d", date);
   String selectDay = year + "-" + s_month+ "-" +s_date;
   Date today = null;
   Date endday = null;
   try{
      today = sdf.parse(selectDay);
   } catch(ParseException e){
      System.out.println(e.getMessage());
   }
%>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
   $(function(){
      var start = 1;
      var end = 5;
      
      if(end>=<%=count%>){
          $("#add").html("");
      }
 
      $("#add").click(function() {
         start+=5;
         end+=5;
         $.ajax({
            type: "get",
            datatype:"json",
            url:"<%=request.getContextPath()%>/mypage/listadd.jsp",
            data: {"start" : start, "end" : end},
            success : function(data){
               var str="";
               $.each(JSON.parse(data),function(i,item){
                  str += "<tr>";
                  str +=    "<td>"+item.rname+"</td>";
                  str +=    "<td>"+item.pcount+"</td>";
                  str +=    "<td>"+item.startday+"</td>";
                  str +=    "<td>"+item.endday+"</td>";
                  str +=    "<td>"+item.price+"</td>";
                  str +=    "<td>"+item.additional+"</td>";
                  str +=    "<td>"+item.totalprice+"</td>";
                  str +=    "<td>"+item.cancel+"</td>";
                  str += "</tr>";
               });
               $("tbody").append(str);
            }
         });
         if(end>=<%=count%>){
            $("#add").html("");
            return;
         }
      });
      
      $(document).on("click", ".cancel", function() {
         var ans = confirm("예약을 취소하시겠습니까?");
            if (ans == false)
               return;
            var resnum = $(this).attr("resnum");
            $.ajax({
               type : "get",
               url :"<%=request.getContextPath()%>/mypage/resvcancel.jsp",
               dataType : "html",
               data : {"resnum" : resnum},
               success : function(data) {
                 alert("예약취소 요청을 완료하였습니다");
                 location.reload();
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
button.cancel{
    border: none;
    font-size: 16px;
    color: #ff3c3c;
    FONT-WEIGHT: 600;
    cursor: pointer;
}
button.writere{
	border: none;
    font-size: 16px;
    FONT-WEIGHT: 600;
    cursor: pointer;
}
#add{
	cursor: pointer;
    text-align: center;
    font-weight: bold;
    color: #2f2b2b;
}
</style>
</head>
<body>
<table style="width: 800px;margin: 20px 0;border-collapse: collapse;">
   <caption style="font-size: 30px;margin-bottom: 10px;"><b>나의 예약내역</b></caption>
   <tr>
      <th>방이름</th>
      <th>인원</th>
      <th>입실일</th>
      <th>퇴실일</th>
      <th>기본요금</th>
      <th>추가요금</th>
      <th>총요금</th>
      <th>예약상태</th>
   </tr>
   <%if(list.size()==0) {%>
      <tr>
         <td colspan="8">예약내역이 없습니다</td>
      </tr>
   <%}%>
   <%
   for(ReservationDto dto:list){
      String rname = db.getRoomName(dto.getRnum());
      int price = Integer.parseInt(dto.getPrice());
      int additional = Integer.parseInt(dto.getAdditional());
      int totalPrice = Integer.parseInt(dto.getPrice()) + Integer.parseInt(dto.getAdditional());
      try{
         endday = sdf.parse(dto.getEndday().substring(0, 10));
      } catch(ParseException e){
         System.out.println(e.getMessage());
      }
      int compare = today.compareTo(endday);
   %>
      
      <tr>
         <td><%=rname %></td>
         <td><%=dto.getPcount() %></td>
         <td><%=dto.getStartday().substring(0, 10) %></td>
         <td><%=dto.getEndday().substring(0, 10) %></td>
         <td><%=formatter.format(price) %></td>
         <td><%=formatter.format(additional) %></td>
         <td><%=formatter.format(totalPrice) %></td>
         <td>
         <%if(compare<0){
            if(dto.getCan()==1){%>
               예약 / <button type="button" class="cancel" resnum="<%=dto.getResnum()%>">취소</button>
            <%}else{%>
               취소승인 중
            <%}
         }else{%>
            이용완료 / <button type="button" class="writere" onclick="location.href='<%=url%>/index.jsp?main=review/reviewform.jsp?rnum=<%=dto.getRnum()%>'">리뷰작성</button>
         <%}%>
         </td>
      </tr>
   <%}%>

</table>
<div id="add">더보기(+)</div>
</body>
</html>