package data.dto;

import java.sql.Timestamp;

public class ReservationDto {

	private String resnum;
	private Timestamp startday;
	private Timestamp endday;
	private String pcount;
	private String id;
	private String rnum;
	
	public String getResnum() {
		return resnum;
	}
	public void setResnum(String resnum) {
		this.resnum = resnum;
	}
	public Timestamp getStartday() {
		return startday;
	}
	public void setStartday(Timestamp startday) {
		this.startday = startday;
	}
	public Timestamp getEndday() {
		return endday;
	}
	public void setEndday(Timestamp endday) {
		this.endday = endday;
	}
	public String getPcount() {
		return pcount;
	}
	public void setPcount(String pcount) {
		this.pcount = pcount;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
}
