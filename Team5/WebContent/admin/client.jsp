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
						location.href='<%=request.getContextPath()%>/admin/client.jsp?id='+id;		
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
						location.href='<%=request.getContextPath()%>/admin/client.jsp?id='+id;		
					}
				}
			});
		});
	});
</script>
</head>
<body>
	아이디:<%=id%>&nbsp;&nbsp;&nbsp;&nbsp;<br>
	등급:<%if(m==1){
		%>
		매니저
		<button id="addmanager">관리자권한해제</button>
	<%}else{
		%>
		일반
		<button id="deletemanager">관리자권한주기</button>
		<%}
	%>
	<br> 
	고객명:<%=cd.getName(id)%><br> 이용건수:<%=list.size()%><br>
	총 이용금액:<%=nf.format(rd.getMoney(id))%><br>
	<table>
		<caption>이용 내역</caption>
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

	<button onclick="history.back()">목록으로</button>
</body>
</html>