package com.books.entity;

import java.io.Serializable;

/**
 * 
 * 
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2020-02-03 19:39:13
 */
public class HistoryEntity implements Serializable {

	/**
	 * 主键
	 */
	private Integer hid;
	/**
	 * 学生主键
	 */
	private Integer sid;
	/**
	 * 图书主键
	 */
	private Integer bid;
	/**
	 * 开始时间
	 */
	private String begintime;
	/**
	 * 结束时间
	 */
	private String endtime;
	/**
	 * 是否超时（0表示未超时，1表示超时）
	 */
	private Integer timeout;
	public Integer getHid() {
		return hid;
	}
	public void setHid(Integer hid) {
		this.hid = hid;
	}
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public Integer getBid() {
		return bid;
	}
	public void setBid(Integer bid) {
		this.bid = bid;
	}
	public String getBegintime() {
		return begintime;
	}
	public void setBegintime(String begintime) {
		this.begintime = begintime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public Integer getTimeout() {
		return timeout;
	}
	public void setTimeout(Integer timeout) {
		this.timeout = timeout;
	}
	@Override
	public String toString() {
		return "HistoryEntity [hid=" + hid + ", sid=" + sid + ", bid=" + bid + ", begintime=" + begintime + ", endtime="
				+ endtime + ", timeout=" + timeout + "]";
	}
	public HistoryEntity() {
		super();
		// TODO Auto-generated constructor stub
	}
	public HistoryEntity(Integer hid, Integer sid, Integer bid, String begintime, String endtime, Integer timeout) {
		super();
		this.hid = hid;
		this.sid = sid;
		this.bid = bid;
		this.begintime = begintime;
		this.endtime = endtime;
		this.timeout = timeout;
	}

}
