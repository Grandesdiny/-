package com.books.entity;

import java.io.Serializable;

/**
 * 
 * 
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2020-02-03 19:39:13
 */
public class StudentEntity implements Serializable {

	/**
	 * 主键
	 */
	private Integer sid;
	/**
	 * 账号
	 */
	private String uname;
	/**
	 * 姓名
	 */
	private String sname;
	/**
	 * 电话号码
	 */
	private String tel;
	/**
	 * 信誉分
	 */
	private Integer grade;
	/**
	 * 可借阅数
	 */
	private Integer maxnum;
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public Integer getGrade() {
		return grade;
	}
	public void setGrade(Integer grade) {
		this.grade = grade;
	}
	public Integer getMaxnum() {
		return maxnum;
	}
	public void setMaxnum(Integer maxnum) {
		this.maxnum = maxnum;
	}
	public StudentEntity(Integer sid, String uname, String sname, String tel, Integer grade, Integer maxnum) {
		super();
		this.sid = sid;
		this.uname = uname;
		this.sname = sname;
		this.tel = tel;
		this.grade = grade;
		this.maxnum = maxnum;
	}
	public StudentEntity() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "StudentEntity [sid=" + sid + ", uname=" + uname + ", sname=" + sname + ", tel=" + tel + ", grade="
				+ grade + ", maxnum=" + maxnum + "]";
	}

}
