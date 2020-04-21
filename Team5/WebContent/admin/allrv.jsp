<%@page import="data.dao.RoomDao"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="data.dao.ReservationDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="data.dto.ReservationDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.PageMaker"%>
<%@page import="data.dao.GetDate"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약정보</title>
<%
   NumberFormat nf=NumberFormat.getInstance();
   request.setCharacterEncoding("utf-8");
   String url=request.getContextPath();

   String pageNum = request.getParameter("pageNum");
   PageMaker pm = new PageMaker();
   int totalCount =0; 
   
   //시작일 끝일 받기.
   String startday=request.getParameter("startday");
   String endday=request.getParameter("endday");
   String roomnum=request.getParameter("roomnum");

   //값이 없으면 전체 리스트 출력
   ReservationDao rdao=new ReservationDao();
   List<ReservationDto> rlist=null;
   if(startday==null){
      totalCount=rdao.getAllCount();
   }else if(roomnum==null){
      totalCount=rdao.getSearchCount(startday, endday);   
   }else{
      totalCount=rdao.getRoomCount(roomnum, startday, endday);   
   }
   //나머지 페이징 처리 변수
   int totalPage = pm.getTotalPage(totalCount);
   int currentPage = pm.getCurrentPage(pageNum, totalPage);
   int startPage = pm.getStartPage(currentPage);
   int endPage = pm.getEndPage(startPage, totalPage);
   int start = pm.getStart(currentPage);
   int end = pm.getEnd(start, totalCount);
   //리스트 만들기
   if(startday==null){
      rlist=rdao.getAllRv(start, end);      
   }else if(roomnum==null){
      rlist=rdao.getSearchRv(startday, endday, start, end);
   }else{
      rlist=rdao.getRoomRv(roomnum, startday, endday, start, end);
   }
   Calendar cal = Calendar.getInstance();
   RoomDao roomdao=new RoomDao();
   List<String> numlist=roomdao.getAllRnum();
   int year = cal.get(Calendar.YEAR);
   //달 저장(넘겨받으면 변경)
   int month = cal.get(Calendar.MONTH);
   //오늘 년 저장
   int today_year = cal.get(Calendar.YEAR);
   //오늘 달 저장
   int today_month = cal.get(Calendar.MONTH)+1;
   
   //오늘날짜
   int date = cal.get(Calendar.DATE);
   
   String f_month=String.format("%02d",month+1);
   String f_date=String.format("%02d",date);
   String date_value=year+"-"+f_month+"-"+f_date;
   String date_value2=year+"-"+f_month+"-"+f_date;
   if(startday!=null){
      date_value=startday;
      date_value2=endday;
   }
   GetDate gd=new GetDate();
%>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
   $(function(){
      
      $('#list').click(function() {
         location.href='<%=url%>/index.jsp?main=admin/adminmain.jsp?select=allrv.jsp';      
      });
      $('#btnshow').click(function() {
         
         var startday=$('#start').val();
         var endday=$('#end').val();
         var roomnum=$('#sel option:selected').val();
         if(roomnum=='전체')
            location.href='<%=url%>/index.jsp?main=admin/adminmain.jsp?select=allrv.jsp?startday='+startday+'&endday='+endday;         
         else
            location.href='<%=url%>/index.jsp?main=admin/adminmain.jsp?select=allrv.jsp?startday='+startday+'&endday='+endday+'&roomnum='+roomnum;         
      });
      
      $('.btnmonth').click(function() {
         var month=$(this).text();
         var year=$(this).attr('y');
         month=month.substring(0,month.length-1)-1;
         
         $.ajax({
            url:'<%=request.getContextPath()%>/admin/getdate.jsp',
            type:'post',
            dataType:'html',
            data:'year='+year+'&month='+month,
            success:function(e){
               data=e.trim();
               start=data.substring(0,8)+'01';
               $('#start').val(start);
               $('#end').val(data);   
            }
         });
      });
   });
</script>
<style type="text/css">
button{
   cursor: pointer;
    padding: 5px 2px;
    border: none;
    background-color: #fee5bd;
}
.btnmonth{
   width: 60px;
    margin: 10px 0;
}
#btnshow,#list{
   width: 100px;
   border-radius: 10px;
    background-color: #faa727;
    color: #fff;
    font-weight: 600;
}
th,td{
   padding: 5px 0;
   text-align: center;
}
th{
   background-color: #ffe5bd;
}

</style>
</head>
<body>
<%if(startday==null){%>
이용 건수<%=totalCount%>/총 매출<%=nf.format(rdao.getAllPrice()) %>
<%}else if(roomnum==null){%>
이용 건수<%=totalCount%>/총 매출<%=nf.format(rdao.getSearchPrice(startday, endday)) %>
<%}else{%>
이용 건수<%=totalCount%>/총 매출<%=nf.format(rdao.getRoomPrice(roomnum,startday, endday)) %>
<%} %>
<br>
<!-- 선택에 따라 다르게 한다. -->

<%
   for(int i=today_month-5;i<=today_month+2;i++){
      int b_i=i;
      int btn_year=today_year;
      if(b_i<=0){
         b_i=12+i;
         btn_year--;
      }%>
   <button y="<%=btn_year%>" class="btnmonth"><%=b_i%>월</button>
<%}%><br>
<input id="start" type="date" value="<%=date_value%>"> ~ <input id="end" type="date" value="<%=date_value2%>">
<select id="sel" >
<option selected="selected">전체</option>
<%for(String n:numlist){%>
<option value="<%=n%>"><%=rdao.getRoomName(n) %></option>
<%}%>
</select>
<button type="button" id="btnshow">조회</button>
<button type="button" id="list">전체리스트</button>

<table style="margin: 40px 0;width: 900px;border-collapse: collapse;">
<thead>
<tr>
<th>번호</th>
<th>아이디</th>
<th>이름</th>
<th>전화번호</th>
<th>방이름</th>
<th>인원수</th>
<th>입실날짜</th>
<th>퇴실날짜</th>
<th>기본요금</th>
<th>추가요금</th>
<th>총 요금</th>
</tr>
</thead>
<tbody>
<%if(totalCount==0){%>
      <tr>
         <td colspan="11" align="center">내역이 없습니다</td>
      </tr>
<%}int n=1;
for(ReservationDto r:rlist){
%>
   <tr>
      <td><%=n %></td>
      <td><%=r.getId()%></td>
      <td><%=r.getName() %></td>
      <td><%=r.getHp() %></td>
      <td><%=rdao.getRoomName(r.getRnum()) %></td>
      <td><%=r.getPcount() %></td>
      <td><%=r.getStartday().substring(0,10) %></td>
      <td><%=r.getEndday().substring(0,10)%></td>
      <td><%=nf.format(Integer.parseInt(r.getPrice())) %></td>
      <td><%=nf.format(Integer.parseInt(r.getAdditional()))%></td>
      <td><%=nf.format(Integer.parseInt(r.getPrice())+Integer.parseInt(r.getAdditional()))%></td>
   </tr>
<%
n++;
}
%>
</tbody>
</table>
   <!-- 페이지번호 출력 -->
   <div style="width: 600px;text-align: center;margin: 0 auto;">      
      <ul>   
      <%
      if(startPage!=1){%>
         <li><a href="<%=url%>/index.jsp?main=admin/adminmain.jsp?select=allrv.jsp?pageNum=<%=startPage-1 %>">이전</a></li>
      <%}
      for(int i=startPage; i<=endPage;i++){
         if(i==currentPage){%>
            <li class="pnum">
               <a href="<%=url %>/index.jsp?main=admin/adminmain.jsp?select=allrv.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>         
         <%}else{%>
            <li>
               <a href="<%=url %>/index.jsp?main=admin/adminmain.jsp?select=allrv.jsp?pageNum=<%=i %>"><%=i %></a>
            </li>
         <%}
      } 
      if(currentPage<totalPage){%>
         <li><a href="<%=url %>/index.jsp?main=admin/adminmain.jsp?select=allrv.jsp?pageNum=<%=endPage+1 %>">다음</a></li>
      <%}%>
      </ul>
   </div>


</body>
</html>