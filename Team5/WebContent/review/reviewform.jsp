<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<style>
     #star_grade a{
        text-decoration: none;
        color: gray;
    }
    #star_grade a.on{
        color: yellow;
    }
    #star_grade:hover{
    	cursor: pointer;
    }
</style>
<script type="text/javascript">
	$(function(){
		$('#star_grade a').click(function(){
            $(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
            $(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
            $(this).off('mouseleave');
            $("#star").attr("value",$("a.on").length);
            return false;
        });
		
		$('#star_grade a').mouseover(function() {
			$(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
            $(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
		});
		
		$('#star_grade a').mouseleave(function() {
			$(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */            
		});
	});
</script>
</head>
<%
	String url = request.getContextPath();
	String id = (String)session.getAttribute("id");
	String rnum = request.getParameter("rnum");
%>
<body>
<form action="<%=url %>/review/reviewinsertaction.jsp" method="post" enctype="multipart/form-data">
	<input type="hidden" name="id" value="<%= id%>">
	<input type="hidden" name="rnum" value="<%= rnum%>">
	<input type="hidden" name="star" id="star" value="">
	<table>
		<caption><b>리뷰작성</b></caption>
		<tr>
			<th>작성자</th>
			<td>
				<b><%=id %></b>
			</td>
		</tr>
		<tr>
			<th>별점</th>
			<td>
				<p id="star_grade">
			    	<a href="#">★</a>
				   	<a href="#">★</a>
				    <a href="#">★</a>
				    <a href="#">★</a>
				    <a href="#">★</a>
				</p>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<textarea name="content" required="required"></textarea>
			</td>
		</tr>
		<tr>
			<th>사진첨부</th>
			<td>
				<input type="file" name="photo">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit">저장하기</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>