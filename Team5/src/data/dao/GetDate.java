package data.dao;

import java.util.Calendar;

public class GetDate {
	public String getDate(int year,int month) {
		Calendar cal= Calendar.getInstance();
		cal.set(year,month,1);
		int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		String f_month=String.format("%02d",month+1);
		String result=year+"-"+f_month+"-"+endDay;
		return result;
	}
}
