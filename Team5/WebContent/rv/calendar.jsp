<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="data.dto.RoomDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.RoomDao"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	String url=request.getContextPath();
	String id = (String) session.getAttribute("id");
	//넘기기위해,,+DB에서 X월 정보 얻기위해?
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");

	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	//현재 달 저장
	int today_month = cal.get(Calendar.MONTH);
	//month는 +1 해줘야함
	int month = cal.get(Calendar.MONTH);
	//오늘날짜
	int date = cal.get(Calendar.DATE);
	if (strYear != null) {
		if (month != Integer.parseInt(strMonth))
			date = 1;
		year = Integer.parseInt(strYear);
		month = Integer.parseInt(strMonth);
	}
	cal.set(year, month, 1);
	int startDay = cal.getMinimum(Calendar.DATE);
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	int start = cal.get(Calendar.DAY_OF_WEEK);
	int newLine = 0;

	RoomDao roomdao = new RoomDao();
	List<RoomDto> roomlist = roomdao.getAllRoom();
	//년-월 형태
	String s_month = String.format("%02d", month + 1);
	String selectDay = year + "-" + s_month;
	//주말추가금
	double addrate=roomdao.getRate();
	//성수기인지 확인
	Map<Integer,Double> peaklist=roomdao.peak(selectDay);

	//qnum 리스트 얻기
	List<String> rnumList = roomdao.getAllRnum();
	//qnum, 달 넣고 set 받기
	int[][] soldOut = new int[rnumList.size()][endDay];
	for (int i = 0; i < rnumList.size(); i++) {
		String rnum = rnumList.get(i);
		Set<Integer> set = roomdao.check(rnum, selectDay);
		for (int j = 0; j < endDay; j++) {
			if (set.contains(j + 1))
				soldOut[i][j] = -1;
			else
				soldOut[i][j] = 0;
		}
	} 
%>
<script type="text/javascript">
	$(function() {
		$(document).on("mousemove","a.show_price",function(e) {
			var day=$(this).attr('newLine');		
			var price=Number($(this).attr('price'));
			var p_rate=Number($(this).attr('rate'));
			var w_rate=Number(<%=roomdao.getRate()%>);
			$("#v").css({
					"top" : e.pageY + 8,
					"left" : e.pageX + 13
			});		
			$("#v").show();
			//주말
			if(day==0||day==6||day==5){
				//주말+성수기
				if(p_rate!=0){
					var total=price*(p_rate+w_rate);
					$('#v').html("<b>객실 정보</b><br>"+"객실:"+$(this).text()+"<br>"
							+"<span style='text-decoration:line-through;text-decoration-color:red;'>기본요금:"
							+numberWithCommas(price)+"</span><br>주말성수기요금:"+numberWithCommas(total));
				}else{
				//주말
					var total=price*(1+w_rate);
					$('#v').html("<b>객실 정보</b><br>"+"객실:"+$(this).text()+"<br>"
							+"<span style='text-decoration:line-through;text-decoration-color:red;'>기본요금:"
							+numberWithCommas(price)+"</span><br>주말요금:"+numberWithCommas(total));			
				
				}
			//평일	
			}else{
				//평일성수기
				if(p_rate!=0){
					var total=price*p_rate;
					$('#v').html("<b>객실 정보</b><br>"+"객실:"+$(this).text()+"<br>"
							+"<span style='text-decoration:line-through;text-decoration-color:red;'>기본요금:"
							+numberWithCommas(price)+"</span><br>평일성수기요금:"+numberWithCommas(total));
				}else{
				//평일
				$('#v').html("<b>객실 정보</b><br>"+"객실:"+$(this).text()+"<br>"
						+"기본요금:"+numberWithCommas(price));	
				}
			}		
		});
					
		$(document).on("mouseout", "a.show_price", function(e) {
			$("#v").hide();
		});

		$('.show_price').click(function() {
			var id='<%=id%>';
			if(id=='null'){
				alert("로그인 후 이용하세요.");
				location.href='<%=request.getContextPath()%>/login/loginform.jsp';
				return false;
			}
		});		
	});
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Rozha+One&display=swap');
table{
   margin: 0 auto 50px;
}
.calcon td {
   width: 150px;
   height: 150px;
   
   padding: 5px 0 0 5px;
}
.calsub td{
   font-weight: 700;
   font-size: 17pt;
   padding: 50px 0 30px;
}
td>a{
   margin-bottom: 15px;
}
.calcon thead tr:first-child td{
   height: 80px;
   font-weight: 600;
}
#v {
   border: 2px solid #fbc777;
   position: absolute;
   display: none;
   width: 220px;
   height: 100px;
   background-color: white;
   padding: 10px;
}
.hd_img{
   height: 400px;
   width: 100%;
   background-size: cover;
   background-image: url('image/rvpage.jpg');
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
a.show_price {
    display: block;
}
</style>
</head>
<body>
	<div class="hd_img">
		<div class="img_title"><span>RESERVATION</span></div>
	</div>
	<!-- 날짜 네비게이션 -->
	<table class="calsub" width="80%">
		<tr>
			<td align="center">
				<%
					if (month > today_month) {
						if (month > 0) {
				%> <a style="display: inline-block;"
				href="<%=request.getContextPath()%>/index.jsp?main=rv/calendar.jsp?year=<%=year%>&month=<%=month - 1%>">&lt;&nbsp;&nbsp;</a>
				<%
					} else {
				%> <a style="display: inline-block;"
				href="<%=request.getContextPath()%>/index.jsp?main=rv/calendar.jsp?year=<%=year - 1%>&month=11">&lt;&nbsp;&nbsp;</a>
				<%
					}
					}
				%> <%=year%>년 <%=month + 1%>월 <%
 	if (today_month + 1 >= month) {
 		if (month < 11) {
 %> <a style="display: inline-block;"
				href="<%=request.getContextPath()%>/index.jsp?main=rv/calendar.jsp?year=<%=year%>&month=<%=month + 1%>">&nbsp;&nbsp;&gt;</a>
				<%
					} else {
				%> <a style="display: inline-block;"
				href="<%=request.getContextPath()%>/index.jsp?main=rv/calendar.jsp?year=<%=year + 1%>&month=0">&nbsp;&nbsp;&gt;</a>
				<%
					}
					}
				%>
			</td>
		</tr>
	</table>
	<table class="calcon" width="80%">
		<thead>
			<tr align="center">
				<td><font color="red">일</font></td>
				<td>월</td>
				<td>화</td>
				<td>수</td>
				<td>목</td>
				<td>금</td>
				<td><font color="blue">토</font></td>
			</tr>
		</thead>
		<tbody valign="top">
			<tr>
				<%
					for (int i = 1; i < start; i++) {
						out.println("<td>&nbsp;</td>");
						newLine++;
					}
					for (int i = 1; i <= endDay; i++) {
					
						String color = "";
						if (newLine == 0)
							color = "RED";
						else if (newLine == 6)
							color = "BLUE";
						else
							color = "BLACK";
						String backColor = "#FAFAFA";
						if (i == date)
							backColor = "#ffe5bd";
						out.println("<td bgcolor='" + backColor + "'>");
				%>
				<font color="<%=color%>" style="font-weight: 600;"><%=i%></font>
				<br>
				<%
					for (int j = 0; j < roomlist.size(); j++) {
							if (i < date)
								continue;
							if (soldOut[j][i - 1] == 0) {
				%>
				<a href="<%=url%>/index.jsp?main=rv/reservation.jsp?rnum=<%=roomlist.get(j).getRnum()%>&year=<%=year%>&month=<%=month%>&day=<%=i%>"
				 rate="<%=peaklist.containsKey(i)?peaklist.get(i):0 %>" price="<%=roomlist.get(j).getPrice() %>"
				 newline="<%=newLine%>" class="show_price" ><%=roomlist.get(j).getRname()%></a>
				<%
				}
						}
						out.println("</td>");
						newLine++;
						if (newLine == 7) {
							out.println("</tr>");
							if (i <= endDay) {
								out.println("<tr>");
							}
							newLine = 0;
						}
					}
					while (newLine > 0 && newLine < 7) {
						out.println("<td>&nbsp;</td>");
						newLine++;
					}
				%>

			</tr>
		</tbody>
	</table>
	<div id="v"></div>
</body>
</html>