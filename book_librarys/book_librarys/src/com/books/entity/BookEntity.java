package com.books.entity;

import java.io.Serializable;

/**
 * 
 * 
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2020-02-03 19:39:13
 */
public class BookEntity implements Serializable {

	/**
	 * 图书主键
	 */
	private Integer bid;
	/**
	 * 图书名
	 */
	private String bname;
	/**
	 * 已借阅数
	 */
	private Integer residuals;
	/**
	 * 作者
	 */
	private String auther;
	/**
	 * 库存
	 */
	private Integer num;
	/**
	 * 出版社
	 */
	private String press;
	/**
	 * 分类
	 */
	private String tname;
	public Integer getBid() {
		return bid;
	}
	public void setBid(Integer bid) {
		this.bid = bid;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public Integer getResiduals() {
		return residuals;
	}
	public void setResiduals(Integer residuals) {
		this.residuals = residuals;
	}
	public String getAuther() {
		return auther;
	}
	public void setAuther(String auther) {
		this.auther = auther;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public String getPress() {
		return press;
	}
	public void setPress(String press) {
		this.press = press;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public BookEntity(Integer bid, String bname, Integer residuals, String auther, Integer num, String press,
			String tname) {
		super();
		this.bid = bid;
		this.bname = bname;
		this.residuals = residuals;
		this.auther = auther;
		this.num = num;
		this.press = press;
		this.tname = tname;
	}
	public BookEntity() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "BookEntity [bid=" + bid + ", bname=" + bname + ", residuals=" + residuals + ", auther=" + auther
				+ ", num=" + num + ", press=" + press + ", tname=" + tname + "]";
	}
	
	
}
