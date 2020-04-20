<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="data.dto.ReservationDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ReservationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String url = request.getContextPath();
	int start = Integer.parseInt(request.getParameter("start"));
	int end = Integer.parseInt(request.getParameter("end"));
	
	String id = (String)session.getAttribute("id");
	
	ReservationDao db = new ReservationDao();
	List<ReservationDto> list = db.getUse(id,start,end);
	DecimalFormat formatter = new DecimalFormat("###,###");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	//month는 +1 해줘야함
	int month = cal.get(Calendar.MONTH);
	//오늘날짜
	int date = cal.get(Calendar.DATE);
	String s_month = String.format("%02d", month + 1);
	String s_date = String.format("%02d", date);
	String selectDay = year + "-" + s_month+ "-" +s_date;
	Date today = null;
	Date endday = null;
	try{
		today = sdf.parse(selectDay);
	} catch(ParseException e){
		System.out.println(e.getMessage());
	}
	
	JSONArray array = new JSONArray();
	
	for(ReservationDto dto:list){
		String rname = db.getRoomName(dto.getRnum());
		int price = Integer.parseInt(dto.getPrice());
		int additional = Integer.parseInt(dto.getAdditional());
		int totalPrice = price+additional;
		try{
			endday = sdf.parse(dto.getEndday().substring(0, 10));
		} catch(ParseException e){
			System.out.println(e.getMessage());
		}
		int compare = today.compareTo(endday);
		
		String cancel=null;
		
		if(compare<0){
			if(dto.getCan()==1){
				cancel = "예약 / <button type='button' class='cancel' resnum='"+dto.getResnum()+"'>취소</button>";
			}else{
				cancel = "취소승인 중";
			}
		}else{
			cancel = "이용완료 / <button type='button' onclick=\"location.href='"+url+"/index.jsp?main=review/reviewform.jsp?rnum="+dto.getRnum()+"'\">리뷰작성</button>";	
		}
		
		JSONObject ob = new JSONObject();
		ob.put("rname",rname);
		ob.put("pcount",dto.getPcount());
		ob.put("startday",dto.getStartday().substring(0, 10));
		ob.put("endday",dto.getEndday().substring(0, 10));
		ob.put("price",formatter.format(price));
		ob.put("additional",formatter.format(additional));
		ob.put("totalprice",formatter.format(totalPrice));
		ob.put("cancel",cancel);
		
		array.add(ob);
	}
%>

<%=array.toString()%>