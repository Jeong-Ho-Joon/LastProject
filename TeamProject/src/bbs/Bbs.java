package bbs;

public class Bbs {
	
	private int num;
	private String title;
	private String content;
	private String userID;
	private String bbsDate;
	private int bbsPage;
	private String content2;
	private String ctg;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public int getBbsPage() {
		return bbsPage;
	}
	public void setBbsPage(int bbsPage) {
		this.bbsPage = bbsPage;
	}
	
	public String getContent2() {
		return content2;
	}
	public void setContent2(String content2) {
		this.content2 = content2;
	}
	
	
	public String getCtg() {
		return ctg;
	}
	public void setCtg(String ctg) {
		this.ctg = ctg;
	}
	@Override
	public String toString() {
		return "Bbs [num=" + num + ", title=" + title + ", content=" + content + ", userID=" + userID + ", bbsDate="
				+ bbsDate + ", bbsPage=" + bbsPage + ", content2=" + content2 + ", ctg=" + ctg + "]";
	}
	
	
}