<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="data.dao.ReviewDao"%>
<%@page import="data.dto.ReviewDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String url = request.getContextPath();
	ReviewDto dto = new ReviewDto();
	ReviewDao db = new ReviewDao();
	
	String uploadFolder = getServletContext().getRealPath("/review/reviewimg");
	
	int uploadSize = 1024*1024;
	
	MultipartRequest multi = null;
	
	try{
		multi= new MultipartRequest(request,uploadFolder,uploadSize,"utf-8",new DefaultFileRenamePolicy());
		
		String id = multi.getParameter("id");
		String rnum = multi.getParameter("rnum");
		//String id= "kihong";
		//String rnum = "4";
		String content = multi.getParameter("content");
		String star = multi.getParameter("star");
		String photo = multi.getFilesystemName("photo");
		
		dto.setId(id);
		dto.setRnum(rnum);
		dto.setContent(content);
		dto.setStar(star);
		dto.setImg(photo);
		
		db.insertReview(dto);
		
		response.sendRedirect(url+"/review/reviewlist.jsp?rnum="+rnum);
	} catch(Exception e){
		System.out.println("업로드오류:"+e.getMessage());
	}

%>