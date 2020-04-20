<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.ReviewDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ReviewDao"%>
<%@page import="data.dao.PageMaker"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<style>
#fullbox{
	margin-left: 630px;
	margin-top: 150px;
	width: 615px;
}
#star_grade a{
	text-decoration: none;
	color: gray;
	float: left;
}
#star_grade a.on{
	color: #faa727;
}
#star_grade{
	min-width: 400px;
}
.joayo{
	color: #cccccc;
	margin-left: 15px;
}
.heart{
	color: #ef1843;
}
#del:hover{
	cursor: pointer;
}
#infodel{
	color: #aaaaaa;
	font-size: 10pt;
	font-weight: 400;
}
#infodel a{
	display: liline;
	color: #aaaaaa;
}
#pagenum{
	text-align: center;
	width: 600px;
}
#pagenum li{
	list-style: none;
}
#reviewimg{
	min-width:150px;
}
#textbox{
	min-height: 100px;
}
#hearttd{
	align: center;
	min-width: 50px;
}
#writereview{
	width: 100px;
	height: 35px;
	background-color: #eeeeee;
	border: none;
	font-size: 10pt;
	font-style: none;
	font-weight: 700;
	float: right;
	color: #000;
	border-radius: 15px;
}
#writereview:hover{
	background-color: #e5e4e4;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	$(function(){
		var url = $("#url").attr("url");			
		var check = $("#check").attr("check");			
		
		$(".joayo").click(function() {
			if(check=="0"){
				alert("로그인을 해주세요");
				return;
			}
	         var joayo=$(this).children().attr("value");//빨간 하트는 1로 변경
	         var revnum =$(this).attr("revnum");
	         if($(this).hasClass("heart")){
	        	 $(this).removeClass("heart");
	        	 joayo=0;
	         } else{
	        	 $(this).addClass("heart");
	        	 joayo=1;
	         }
	         var inter = $(this).next(".joayosu");
	         $.ajax({
	            type: "post",
	            url:url+"/review/joayoDb.jsp",
	            dataType: "json",
	            data:{"joayo":joayo,"revnum":revnum},
	            success:function(data){
	               $.each(data,function(idx,entry){
	                  //console.log(entry.joayo);
	                  inter.html(entry.joayo);
	               });               
	            }
	        });
	    });
		
		$("#del").click(function() {
			alert("삭제하시겠습니까?");
			var revnum = $(this).attr("revnum");
			var rnum = $(this).attr("rnum");
			var pageNum = $(this).attr("pageNum");
			
			$.ajax({
				type : "post",
				url : url+"/review/reviewdeleteaction.jsp",
				dataType : "html",
				data : {"revnum":revnum},
				success : function(data){
					location.href=url+"/review/reviewlist.jsp?rnum="+rnum+"&pageNum="+pageNum;
				}
			});
		});
		
	});
</script>
</head>
<%
	String url = request.getContextPath();
	String rnum = request.getParameter("rnum");
	String pageNum = request.getParameter("pageNum");
	ReviewDao db = new ReviewDao();
	PageMaker pm = new PageMaker();
	int totalCount = db.getTotalCount(rnum);
	int totalPage = pm.getTotalPage(totalCount);
	int currentPage = pm.getCurrentPage(pageNum, totalPage);
	int startPage = pm.getStartPage(currentPage);
	int endPage = pm.getEndPage(startPage, totalPage);
	int start = pm.getStart(currentPage);
	int end = pm.getEnd(start, totalCount);
	
	String id = (String)session.getAttribute("id");
		
	List<ReviewDto> list = db.getAllReview(start, end, rnum);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	String check="0";
	if(id!=null)
		check = "1";
	
%>
<body>
<div id="fullbox">
<input type="hidden" id="url" url="<%=url%>">
<input type="hidden" id="check" check="<%=check%>">
<h3>리뷰(<%=totalCount %>건)</h3>
<br>
<%
	for(ReviewDto dto:list){
		int joayosu = db.getJoayo(dto.getRevnum());
		int checkjoayo = db.joayocheck(dto.getRevnum(), id);
	%>	
		<table id="reviewtb">
			<tr>
				<td>
					<p id="star_grade">
						<%for(int i=1;i<=Integer.parseInt(dto.getStar());i++){ %>
				    		<a class="on">★</a>
				    	<%} 
						for(int i=1;i<=5-Integer.parseInt(dto.getStar());i++){ %>
					   		<a>★</a>
					   	<%}%>
					   	<b><%=dto.getStar() %></b>
					</p>				
				</td>
				<td rowspan="3" id="reviewimg">
					<img src="<%=url%>/review/reviewimg/<%=dto.getImg()%>" style="width: 150px;height: 100px;">
				</td>
				<td id="hearttd" rowspan="3">	
					<%if(db.joayocheck(dto.getRevnum(), id)!=1){%>
						<span class="joayo" style="cursor: pointer;" revnum="<%=dto.getRevnum()%>">						
					<%}else{%>
						<span class="joayo heart" style="cursor: pointer;" revnum="<%=dto.getRevnum()%>">
					<%} %>
					♥</span>
					<span class="joayosu"><%=joayosu %></span>
				</td>			
			</tr>
			<tr>
				<td id="infodel">
					<%=dto.getId() %> · <%=sdf.format(dto.getRwriteday())%>
					<%if(dto.getId().equals(id)){%>
					|<a id="del" rnum="<%=dto.getRnum()%>" revnum="<%=dto.getRevnum()%>" pageNum="<%=currentPage%>">&nbsp;삭제</a>
				<%}%>					
				</td>
			</tr>
			<tr>
				<td>
					<pre id="textbox"><%=dto.getContent() %></pre>					
				</td>
				<%if(!dto.getImg().equals("..")){ %>
				
				<%}%>				
			</tr>			
		</table>
		<hr style="width:610px;">
	<%}
%>
<!-- 페이지번호 출력 -->
	<div id="pagenum">      
      <ul>   
      <%
      if(startPage!=1){%>
         <li><a href="<%=url %>/index.jsp?main=room/room1.jsp&rnum=<%=rnum %>&pageNum=<%=startPage-1 %>">이전</a></li>
      <%}
      for(int i=startPage; i<=endPage;i++){
         if(i==currentPage){%>
            <li class="active">
               <a href="<%=url %>/index.jsp?main=room/room1.jsp&rnum=<%=rnum %>&pageNum=<%=i %>"><%=i %></a>
            </li>         
         <%}else{%>
            <li>
               <a href="<%=url %>/index.jsp?main=room/room1.jsp&rnum=<%=rnum %>&pageNum=<%=i %>"><%=i %></a>
            </li>
         <%}
      } 
      if(currentPage<totalPage){%>
         <li><a href="<%=url %>/index.jsp?main=room/room1.jsp&rnum=<%=rnum %>&pageNum=<%=endPage+1 %>">다음</a></li>
      <%}%>
      </ul>
   </div>
</div>
</body>
</html>