package com.books.entity;

import java.io.Serializable;

/**
 * 
 * 
 * @author Mark
 * @email sunlightcs@gmail.com
 * @date 2020-02-03 19:39:13
 */
public class BooktypeEntity implements Serializable {
	/**
	 * 主键
	 */
	private Integer tid;
	/**
	 * 分类名称
	 */
	private String tname;
	public Integer getTid() {
		return tid;
	}
	public void setTid(Integer tid) {
		this.tid = tid;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public BooktypeEntity(Integer tid, String tname) {
		super();
		this.tid = tid;
		this.tname = tname;
	}
	public BooktypeEntity() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "BooktypeEntity [tid=" + tid + ", tname=" + tname + "]";
	}

}
