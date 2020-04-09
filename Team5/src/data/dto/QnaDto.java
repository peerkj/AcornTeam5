package data.dto;

import java.sql.Timestamp;

public class QnaDto {
	private String qnum;
	private String subject;
	private String content;
	private String secret;
	private Timestamp qwriteday;
	private String viewcount;
	private String id;
	public String getQnum() {
		return qnum;
	}
	public void setQnum(String qnum) {
		this.qnum = qnum;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSecret() {
		return secret;
	}
	public void setSecret(String secret) {
		this.secret = secret;
	}
	public Timestamp getQwriteday() {
		return qwriteday;
	}
	public void setQwriteday(Timestamp qwriteday) {
		this.qwriteday = qwriteday;
	}
	public String getViewcount() {
		return viewcount;
	}
	public void setViewcount(String viewcount) {
		this.viewcount = viewcount;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
		
}
