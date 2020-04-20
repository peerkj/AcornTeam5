<%@page import="data.dto.PeakDto"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.RoomDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.RoomDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%

	request.setCharacterEncoding("utf-8");
	//방정보 얻어오기
	RoomDao rdao=new RoomDao();
	List<RoomDto> rlist= rdao.getAllRoom();
	NumberFormat nf=NumberFormat.getInstance();
	
	Calendar cal=Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH);
	int date = cal.get(Calendar.DATE);
	
	String f_month = String.format("%02d", month + 1);
	String f_date = String.format("%02d",date);
	String start_value=year+"-"+f_month+"-"+f_date;

	List<PeakDto> plist=rdao.getPeak();
%>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(function(){
		$('.sel').click(function() {
			var rnum=$(this).attr('num');
			location.href='<%=request.getContextPath()%>/index.jsp?main=admin/adminmain.jsp?select=roomupdate.jsp?rnum='+rnum;
		});
		$('#btnchange').click(function() {
			var rate=$('#rate').val();
			$.ajax({
				url:"<%=request.getContextPath()%>/admin/ratechange.jsp",
				type:"post",
				dataType:"html",
				data:"rate="+rate,
				success:function(e){
					if(e.trim()!=-1){
						alert("변경완료");
					}
				}
			});
		});
		$('#addPeak').click(function() {
			var startday=$('#startday').val();
			var endday=$('#endday').val();
			var rate=$('#peak_rate').val();
			
			location.href='<%=request.getContextPath()%>/admin/insertpeak.jsp?startday='+startday+'&endday='+endday+'&rate='+rate;
		});
		
		$('.deletepeak').click(function() {
			var pnum=$(this).attr('pnum');
			var y=confirm("삭제?");
			if(y)
			location.href='<%=request.getContextPath()%>/admin/deletepeak.jsp?pnum='+pnum;	
		});
	});
</script>

<style type="text/css">
tr:hover{
   cursor: pointer;
   background-color: #fafafa;
}
th,td{
   padding: 10px;
   text-align: center;
}
th{
   background-color: #ffe5bd;
}
#addPeak,#btnchange{
	width: 80px;
    border-radius: 10px;
    background-color: #faa727;
    color: #fff;
    font-weight: 600;
    cursor: pointer;
    padding: 5px 2px;
    border: none;
}
.deletepeak{
	border: none;
    padding: 3px 5px;
    font-weight: 600;
    cursor: pointer;
    color: red;
}
</style>
</head>
<body>
<b style="font-size: 15pt;">기간별 요금 관리</b><br>
<div style="margin: 10px 0;">
	<b>주말 추가 요금 비율 : </b><input id="rate" type="text" value="<%=rdao.getRate()%>">
	<button type="button" id="btnchange">변경</button><br>
</div>
<input id="startday" type="date" value="<%=start_value%>"> ~ 
<input id="endday" type="date" value="<%=start_value%>"><br>
<div style="margin-top: 5px;">
	<b>추가/할인 요금 비율 : </b><input type="text" id="peak_rate">
	<button type="button" id="addPeak">추가</button><br>
</div>

<table style="border-collapse: collapse;margin: 20px 0;">
<caption style="margin-bottom: 10px;"><b>요금관리</b></caption>
<thead>
<tr>
<th>시작</th>
<th>종료</th>
<th>추가/할인</th>
<th>관리</th>
</tr>
</thead>
<tbody>
<%
for(PeakDto p:plist){
%>
	<tr>
	<td><%=p.getStartday().substring(0, 10) %></td>
	<td><%=p.getEndday().substring(0, 10) %></td>
	<td><%=p.getPeak_rate() %></td>
	<td><button type="button" pnum="<%=p.getPnum() %>" class='deletepeak'>삭제</button></td>
	</tr>
<%}%>
</tbody>
</table>



<table style="width: 800px;border-collapse: collapse;margin: 20px 0;">
<caption style="font-size: 15pt;margin: 10px 0;"><b>방정보</b></caption>
<thead>
<tr>
<th>번호</th>
<th>방이름</th>
<th>가격</th>
<th>수용인원</th>
</tr>
</thead>
<tbody>
<% 
   int i=1;
   for(RoomDto dto:rlist){
   %>
   <tr class="sel" num="<%=dto.getRnum()%>">
   <td><%=i%></td>
   <td><%=dto.getRname()%></td>
   <td><%=nf.format(Integer.parseInt(dto.getPrice()))%></td>
   <td><%=dto.getAcception()%></td>
   </tr>   
   <%
   i++;
   }
%>
</tbody>
</table>
</body>
</html>