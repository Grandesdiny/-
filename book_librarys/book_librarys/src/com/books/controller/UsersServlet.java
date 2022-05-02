package com.books.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

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
import com.books.entity.BooktypeEntity;
import com.books.entity.StudentEntity;
import com.books.entity.UsersEntity;
import com.books.service.CarRentalService;

@WebServlet("/Users")
public class UsersServlet extends HttpServlet {
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
		BooktypeEntity typ = service.setObject(request, BooktypeEntity.class);
		StudentEntity stu = service.setObject(request, StudentEntity.class);
		// 全局变量类----------------------------------------------------------------------------------------------------------
		String method = request.getParameter("method");
		System.out.println(method);
		out = response.getWriter();
		
		if("users".equals(method)) {//用户查看个人信息
			try {
				String uname = (String) session.getAttribute("uname");
				StudentEntity student = dao.findBean(StudentEntity.class,"select * from student where uname=? ",uname);
				request.setAttribute("student", student);
				request.getRequestDispatcher("users-information.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if("updateStudent".equals(method)) {//修改个人信息
			try {
				Object[] params= {stu.getSname(),stu.getTel(),stu.getSid()};
				dao.update("update student set sname = ?,tel=? where sid=?", params);
				response.sendRedirect("Users?method=users");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
