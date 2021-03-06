<%@page import="java.util.Map"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="data.dto.ClientDto"%>
<%@page import="data.dao.ClientDao"%>
<%@page import="java.util.Set"%>
<%@page import="data.dao.ReservationDao"%>
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
	int strYear = Integer.parseInt(request.getParameter("year"));
	int strMonth = Integer.parseInt(request.getParameter("month"));
	int strDay = Integer.parseInt(request.getParameter("day"));
	String rnum = request.getParameter("rnum");
	String id=(String)session.getAttribute("id");
	Calendar cal = Calendar.getInstance();
	cal.set(strYear, strMonth, 1);
	int startDay = cal.getMinimum(Calendar.DATE);
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	int start = cal.get(Calendar.DAY_OF_WEEK);
	int newLine = 0;
	
	RoomDao roomdao = new RoomDao();
	double rate=roomdao.getRate();
	//년-월 형태
	String sm = String.format("%02d", strMonth + 1);
	String selectDay = strYear + "-" + sm;
	//시작일 년-월-일 형태
	String submit_start = selectDay + "-" + strDay;

	Map<Integer,Double> peaklist=roomdao.peak(selectDay);
	
	//예약체크
	Set<Integer> list = roomdao.check(rnum, selectDay);
	//rnum에 해당하는 방정보 얻기
	RoomDto roomdto = roomdao.getRoom(rnum);
	int roomSize = Integer.parseInt(roomdto.getAcception().trim());
	//세션에 저장된 아이디로 고객 정보 얻어오기
	ClientDao clientdao = new ClientDao();
	ClientDto clientdto = clientdao.getClientData(id);		

%>
<style type="text/css">
</style>
<script type="text/javascript">
$(function(){
	var room=Number(<%=roomdto.getPrice()%>);
	var startday="<%=strDay%>";
	var price=0;
	
	$('.sel').click(function() {
		price=0;
		var endDay=Number.parseInt($(this).text());
		var add=0;
		if(startday-endDay>=0){
			alert(startday+"일보다 다음날을 선택하세요");
			return;
		}
		else if($(this).attr('soldout')==1){
			alert("이미 예약된 날입니다.");
			return;	
		}
		else if(endDay-startday>=5){
			alert("최대 4박 5일까지 예약 가능\n5박 이상은 문의 바랍니다");
			return;
		}
		for(var i=startday;i<=endDay;i++){
			if($('[date='+i+']').attr('soldout')==1){
				$(this).si
				alert('중간에 이미 예약된 날이 있습니다.');
				return;
			}
		}
		for(var i=endDay;i<=31;i++){
			$('[date='+i+']').css('background-color','#EFEFEF');			
		}
		for(var i=startday;i<=endDay;i++){
			$('[date='+i+']').css('background-color','#fbc777');			
			if($('[date='+i+']').attr('day')==6||$('[date='+i+']').attr('day')==0)
			add+=room*<%=rate%>;
		}
		for(var i=startday;i<endDay;i++){
			price+=Number($('[date='+i+']').attr('price'));
		}
		var z=endDay-startday;
		$("#use").html(z+"박 "+(z+1)+"일");
		$("#price").html(numberWithCommas((room*z)+"원"));
		$("#add").html(numberWithCommas((price+add-room*z)+"원"));
		$("#sum").html(numberWithCommas((price+add)+"원"));
		$("#total").val(price+add);
		//input hidden 채우기
		$("#submit_start").val('<%=submit_start%>');
		$("#submit_end").val('<%=selectDay%>'+"-"+endDay);
		$("#submit_rnum").val('<%=rnum%>');
					$("#submit_price").val(price);
					$("#submit_add").val(add);

				});
	});
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	function check() {
		if ($("#total").val() == 0 || $('#s option:selected').val() == '선택') {
			alert("결제정보를 모두 입력해주세요.");
			return false;
		}
		elas
		return true;
	}
</script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Rozha+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;600;700&display=swap');
.sel:hover {
	cursor: pointer;
}
#selectdays{
	border: none;
	margin-right: 200px;
	float: left;	
}
#selectdays td,#rvbox td{
	width: 50px;
	height: 50px;
	text-align: center;
}

#info {
	height: 300px;
	width: 600px;
	border: 1px solid gray;
	padding: 25px;
	float: left;
	margin-bottom: 100px;
	margin-left: -50px;
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
#rvbox th{
	width: 100px;	
}
#rvbox{
	margin: 40px 190px;
}
#personinfo{
	margin: 40px 340px;
}
#submit {
     font-family: 'Noto Sans KR', sans-serif;
     text-transform: uppercase;
     outline: 0;
     background: #fc9740;
     width: 250px;
     height: 50px;
     border: 0;
     margin: 20px 360px;
     padding: 10px;
     color: #FFFFFF;
     font-size: 16px;
     -webkit-transition: all 0.3 ease;
     transition: all 0.3 ease;
     cursor: pointer;   
   }
.contentbody{
	position: relative;
	margin: 50px 240px 0 420px;
}
.contentbody::after {
    content: "";
    clear: both;
    display: block;
}
.personinput{
	  outline: 0;
	  background: #ececee;
	  width: 100%;
	  border: 0;
	  margin: 0 0 15px;
	  padding: 10px;
	  box-sizing: border-box;
	  font-size: 14px;
}
.personinput:active,.personinput:focus {
	  border: 0.2px solid #fc9740;
}
</style>
</head>
<body>
<div class="hd_img">
	<div class="img_title"><span>RESERVATION</span></div>
</div>
<div class="contentbody">
	<table id="selectdays">
		<caption><%=strYear%>년 <%=strMonth + 1%>월
		</caption>
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
		<tbody>
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
						String backColor = "#EFEFEF";
						if (i == strDay)
							backColor = "#fbc777";
						if (list.contains(i)) {
				%>
				<td style="color: white" day="<%=newLine%>" bgcolor="<%=backColor%>"
				price="<%=peaklist.containsKey(i)?(int)Math.floor(Integer.parseInt(roomdto.getPrice())*peaklist.get(i)):roomdto.getPrice()%>"
					date="<%=i%>" class="sel" soldout="1"><%=i%> <%
 	} else {
 %>
				<td style="color:<%=color%>" day="<%=newLine%>" 
					bgcolor="<%=backColor%>" date="<%=i%>" class="sel" price="<%=peaklist.containsKey(i)?(int)Math.floor(Integer.parseInt(roomdto.getPrice())*peaklist.get(i)):roomdto.getPrice()%>"><%=i%> <%
 	}

 		out.println("<br></td>");
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
	<div id="info"><pre>
선택일 :<%=strYear + "-" + (strMonth+1) + "-" + strDay%> 부터

펜션 전화번호
010-5181-6558

결제 방법
카카오페이

이용 안내
- 퇴실일을 선택하고 예약 내용과 본인 정보를 확인해 주세요.
- 예약 전 예약 안내(예약 규정)를(을) 반드시 숙지하시고 예약하시기 바랍니다.
- 하단의 결제하기 버튼을 누르시면 예약이 진행됩니다.
</pre></div>
	<form action="<%=request.getContextPath()%>/rv/iamp.jsp"
		onsubmit="return check();" method="post">
		<div class="twobox">
		<table id="rvbox">
			<caption style="font-size: 17pt;font-weight: 700;">객실 예약</caption>
			<thead>
				<tr>
					<th>객실명</th>
					<th>이용일</th>
					<th>인원수</th>
					<th>기본요금</th>
					<th>추가요금</th>
					<th>합계</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%=roomdto.getRname()%></td>
					<td id="use" name="use"></td>
					<td><select id="s" required="required" name="pcount">
							<option selected disabled hidden>선택</option>
							<%
								for (int i = 1; i <= roomSize; i++) {
							%>
							<option><%=i%></option>
							<%
								}
							%>
					</select></td>
					<td id="price"></td>
					<td id="add"></td>
					<td id="sum"></td>
				</tr>
			</tbody>
		</table>
		<table id="personinfo">
			<caption style="font-size: 16pt;font-weight: 700;">예약자 정보</caption>
			<tr>
				<th>예약자명&nbsp;</th>
				<td><input name="name" type="text" class="personinput" value="<%=clientdto.getName()%>"></td>
			</tr>
			<tr>
				<th>핸드폰</th>
				<td><input name="hp" type="text" class="personinput" value="<%=clientdto.getHp()%>"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input name="email" type="text" class="personinput" value="<%=clientdto.getEmail()%>"></td>
			</tr>
		</table><br>
		<input type="hidden" id="total" name="total" value="0"> 
		<input type="hidden" id="submit_price" name="price" value="0">
		<input type="hidden" id="submit_add" name="additional" value="0">
		<input type="hidden" id="submit_start" name="startday" value="0">
		<input type="hidden" id="submit_end" name="endday" value="0">
		<input type="hidden" id="submit_rnum" name="rnum" value="0">
		<button type="submit" id="submit">결제하기</button>
		</div>
	</form>
</div>
</body>
</html>