package data.dto;

import java.sql.Timestamp;

public class ReviewDto {
	private String revnum;
	private String content;
	private Timestamp rwriteday;
	private String star;
	private String id;
	private String rnum;
	public String getRevnum() {
		return revnum;
	}
	public void setRevnum(String revnum) {
		this.revnum = revnum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getRwriteday() {
		return rwriteday;
	}
	public void setRwriteday(Timestamp rwriteday) {
		this.rwriteday = rwriteday;
	}
	public String getStar() {
		return star;
	}
	public void setStar(String star) {
		this.star = star;
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