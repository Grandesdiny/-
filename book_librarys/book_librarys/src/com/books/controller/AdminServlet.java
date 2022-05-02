package com.books.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSONArray;
import com.books.dao.BaseDao;
import com.books.dao.BaseDaoImpl;
import com.books.entity.BookEntity;
import com.books.entity.UsersEntity;
import com.books.service.CarRentalService;

@WebServlet("/Admin")
public class AdminServlet extends HttpServlet {
	BaseDao dao = new BaseDaoImpl();
	PrintWriter out = null;

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		// service
		// 方法类-----------------------------------------------------------------------------------------------------
		CarRentalService service = new CarRentalService();
		HttpSession session = request.getSession();
		UsersEntity use = service.setObject(request, UsersEntity.class);
		BookEntity boo = service.setObject(request, BookEntity.class);
		// 全局变量类----------------------------------------------------------------------------------------------------------
		String method = request.getParameter("method");
		System.out.println(method);
		out = response.getWriter();
		
		if("users".equals(method)) {//超级管理员首页
			try {
				JSONArray users = dao.findJSONArray("select * from users where utype=2");
				request.setAttribute("users", users);
				request.getRequestDispatcher("admin-list.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if("admin_add".equals(method)) {//添加管理员
			try {
				Object[] params= {use.getUname(),123456,2};
				int i = dao.update("insert into users(uname,password,utype) values(?,?,?)", params);
				if(i>0) {
					out.write("1");
					out.flush();
					out.close();
				}else {
					out.write("2");
					out.flush();
					out.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if("admin_delete".equals(method)) {//删除管理员
			try {
				Object[] params= {use.getUname()};
				dao.update("delete from users where uname=?", params);
				response.sendRedirect("Admin?method=users");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if("admin_password".equals(method)) {//重置管理员密码
			try {
				dao.update("update users set password = 123456 where uname=?", use.getUname());
				response.sendRedirect("Admin?method=users");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
