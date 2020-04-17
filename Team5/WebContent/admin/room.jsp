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
	
%>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(function(){
		$('.sel').click(function() {
			var rnum=$(this).attr('num');
			location.href='<%=request.getContextPath()%>/admin/roomupdate.jsp?rnum='+rnum;
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
	});
</script>
<style type="text/css">
tr:hover{
	background-color: pink;
	cursor: pointer;
}
</style>
</head>
<body>
주말 추가 요금 비율:<input id="rate" type="text" value="<%=rdao.getRate()%>">
<button type="button" id="btnchange">변경</button><br>

<table>
<caption>방정보</caption>
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