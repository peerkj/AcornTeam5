package data.dto;

public class PeakDto {
	private String pnum;
	private String startday;
	private String endday;
	private Double peak_rate;
	
	public String getPnum() {
		return pnum;
	}
	public void setPnum(String pnum) {
		this.pnum = pnum;
	}
	public String getStartday() {
		return startday;
	}
	public void setStartday(String startday) {
		this.startday = startday;
	}
	public String getEndday() {
		return endday;
	}
	public void setEndday(String endday) {
		this.endday = endday;
	}
	public Double getPeak_rate() {
		return peak_rate;
	}
	public void setPeak_rate(Double peak_rate) {
		this.peak_rate = peak_rate;
	}
}
