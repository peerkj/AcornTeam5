<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
String url=request.getContextPath();
%>
<link rel="stylesheet" href="<%=url%>/css/bxslider.css">
<link rel="stylesheet" href="<%=url%>/css/style.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<style type="text/css">
div#header{/* 
	position:fixed;
	width:100%; */
	background-color: white;
}

.act{
	position: fixed; 
	top: 0; 
}
#footer{
	height: 150px;
	bottom: 0;
	position: relative;
}
</style>
<script type="text/javascript">
$( document ).ready( function() {
	  var navOffset = $( '#header' ).offset();
	  $( window ).scroll( function() {
	    if ( $( document ).scrollTop() > navOffset.top ) {
	      $( '#header' ).addClass( 'act' );
	    }
	    else {
	      $( '#header' ).removeClass( 'act' );
	    }
	  });
	});

</script>
</head>
<%
	String main=request.getParameter("main");
%>
<body>
<div id="wrapper">
	<div id="header"><jsp:include page="header.jsp"/></div>
	<div id="contentarea">
	<%if(main==null){ 
		main="1";
		%> 
		<div id="bxslider"><jsp:include page="bxslider.jsp"/></div>
		<div id="content"><jsp:include page="content.jsp"/></div>
		<%}else{ 
		%>
		<jsp:include page="<%=main %>"/>
		
		<%} %>
	</div>
	<%if(main.equals("service/servicepage.jsp")) {
	}else{%>
	<div id="footer"><jsp:include page="footer.jsp"/></div>
	<%} %>
</div>
</body>
</html>