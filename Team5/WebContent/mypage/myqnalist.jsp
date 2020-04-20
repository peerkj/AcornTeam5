<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.QnaDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
   String id = (String)session.getAttribute("id");
   QnaDao db = new QnaDao();
   int count = db.useCount(id);
   List<QnaDto> list = db.getClientQnaList(id, 1, 5);
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   String url = request.getContextPath();
%>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
   $(function(){
      var start = 1;
      var end = 5;
      
      if(end>=<%=count%>){
         $("#add").html("");
         return;
      }
      
      $("#add").click(function() {
         start+=5;
         end+=5;
         $.ajax({
            type: "get",
            datatype:"json",
            url:"<%=request.getContextPath()%>/mypage/myqnalistadd.jsp",
            data: {"start" : start, "end" : end},
            success : function(data){
               var str="";
               $.each(JSON.parse(data),function(i,item){
                  str += "<tr>";
                  str +=    "<td>"+item.answer+"</td>";
                  str +=    "<td><a href='<%=request.getContextPath() %>/qna/qnaselect.jsp?num="+item.qnum+"'>"
                        +item.subject+"</a></td>";
                  str +=    "<td>"+item.writeday+"</td>";
                  str +=    "<td>"+item.view+"</td>";
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
   });
</script>
<style type="text/css">
tr:hover{
	background-color: #fafafa;
}
th,td{
	padding: 10px;
	text-align: center;
}
th{
	background-color: #ffe5bd;
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
   <caption style="font-size: 30px;margin-bottom: 10px;"><b>나의 질문내역</b></caption>
   <tr>
      <th>답변여부</th>
      <th>제목</th>
      <th>작성일</th>
      <th>조회수</th>
   </tr>
   <%if(list.size()==0) {%>
      <tr>
         <td colspan="4">질문내역이 없습니다</td>
      </tr>
   <%}%>
   <%
   for(QnaDto dto:list){%>
      
      <tr>
         <td>
         <%
         if(db.getAnswer(dto.getQnum())){%>
            답변완료
         <%}else{%>
            답변대기
         <%}%>
         </td>
         <td><a href="<%=url %>/index.jsp?main=qna/qnaselect.jsp?num=<%=dto.getQnum()%>">
            <%=dto.getSubject() %></a></td>
         <td><%=sdf.format(dto.getQwriteday()) %></td>
         <td><%=dto.getViewcount() %></td>
      </tr>
   <%}%>

</table>
<div id="add">더보기(+)</div>
</body>
</html>