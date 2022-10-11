package PMS.vo;

import java.util.Date;

public class mySchedule {
	private String userno;
	private String title;
	private String dept;
	private int sno;
	private int pno;
	private String sname;
	private String status;
	private int progress;
	private Date startDate;
	private Date endDate;
	private double budget;
	public mySchedule() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public mySchedule(String userno, String title, String dept, int sno, int pno, String sname, String status,
			int progress, Date startDate, Date endDate, double budget) {
		super();
		this.userno = userno;
		this.title = title;
		this.dept = dept;
		this.sno = sno;
		this.pno = pno;
		this.sname = sname;
		this.status = status;
		this.progress = progress;
		this.startDate = startDate;
		this.endDate = endDate;
		this.budget = budget;
	}

	public mySchedule(String title, String dept, int sno, int pno, String sname, String status, int progress,
			Date startDate, Date endDate, double budget) {
		super();
		this.title = title;
		this.dept = dept;
		this.sno = sno;
		this.pno = pno;
		this.sname = sname;
		this.status = status;
		this.progress = progress;
		this.startDate = startDate;
		this.endDate = endDate;
		this.budget = budget;
	}

	public String getUserno() {
		return userno;
	}
	public void setUserno(String userno) {
		this.userno = userno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getProgress() {
		return progress;
	}
	public void setProgress(int progress) {
		this.progress = progress;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public double getBudget() {
		return budget;
	}

	public void setBudget(double budget) {
		this.budget = budget;
	}
	
	
}
