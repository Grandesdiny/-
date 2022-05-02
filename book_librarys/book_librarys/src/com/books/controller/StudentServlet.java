package com.books.controller;
/*学生功能*/
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
import com.books.entity.StudentEntity;
import com.books.entity.UsersEntity;
import com.books.service.CarRentalService;

@WebServlet("/Student")
public class StudentServlet extends HttpServlet {
	BaseDao dao = new BaseDaoImpl();
	PrintWriter out = null;

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		// service
		// 方法类-----------------------------------------------------------------------------------------------------
		CarRentalService service = new CarRentalService();
		HttpSession session = request.getSession();
		UsersEntity use = service.setObject(request, UsersEntity.class);
		BookEntity boo = service.setObject(request, BookEntity.class);
		StudentEntity stu = service.setObject(request, StudentEntity.class);
		// 全局变量类----------------------------------------------------------------------------------------------------------
		String method = request.getParameter("method");
		System.out.println(method);
		out = response.getWriter();

		if ("students".equals(method)) {//用户列表
			try {
				JSONArray student = dao.findJSONArray("select * from student order by sid ");
				request.setAttribute("student", student);
				request.getRequestDispatcher("student-list.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("student_add".equals(method)) {//添加用户
			try {
				Object[] params = { stu.getUname(), stu.getSname(), stu.getTel() };
				Object[] params1 = { stu.getUname() };
				dao.update("insert into student(uname,sname,tel) values(?,?,?)", params);
				int i = dao.update("insert into users(uname,password,utype) values(?,123456,3)", params1);
				if (i > 0) {
					out.write("1");
					out.flush();
					out.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("student_update".equals(method)) {//修改用户信息
			try {
				StudentEntity student = dao.findBean(StudentEntity.class, "select * from student where sid=? ",
						stu.getSid());
				System.out.println(student);
				request.setAttribute("student", student);
				request.getRequestDispatcher("student-update.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("student_update1".equals(method)) {//确认修改用户信息
			try {
				String grade = request.getParameter("grade");
				String maxnum = request.getParameter("maxnum");
				if (!service.isNumeric(grade) || !service.isNumeric(maxnum)) {
					out.write("2");
					out.flush();
					out.close();
				} else {
					Object[] params = { stu.getUname(), stu.getSname(), stu.getTel(), stu.getGrade(), stu.getMaxnum(),
							stu.getSid() };
					int i = dao.update("update student set uname=?,sname=?,tel=?,grade=?,maxnum=? where sid=?", params);
					if (i > 0) {
						out.write("1");
						out.flush();
						out.close();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("student_delete".equals(method)) {//删除用户
			try {
				Object[] params = { stu.getSid() };
				dao.update("delete from student where sid=?", params);
				dao.update("delete from users where uname=?", stu.getUname());
				response.sendRedirect("Student?method=students");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("student_search".equals(method)) {//查找用户
			try {
				JSONArray student = dao
						.findJSONArray("select * from student where uname like '%" + stu.getUname() + "%'");
				System.out.println(student);
				request.setAttribute("student", student);
				request.getRequestDispatcher("student-list.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("student_recover".equals(method)) {//恢复用户信用
			try {
				Object[] params = { stu.getSid() };
				dao.update("update student set grade=3 where sid=?", params);
				response.sendRedirect("Student?method=students");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("student_password".equals(method)) {//重置用户密码
			try {
				Object[] params = { stu.getUname() };
				dao.update("update users set password=123456 where uname=?", params);
				response.sendRedirect("Student?method=students");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("users_books".equals(method)) {//用户查看图书清单
			try {
				String uname = (String) session.getAttribute("uname");
				JSONArray books = dao.findJSONArray("select * from book order by bid ");
				StudentEntity student = dao.findBean(StudentEntity.class, "select * from student where uname=?", uname);
				request.setAttribute("books", books);
				session.setAttribute("sname", student.getSname());
				session.setAttribute("sid", student.getSid());
				request.getRequestDispatcher("users-books.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("bespoke_book".equals(method)) {//判断是否可以借书
			try {
				StudentEntity student = dao.findBean(StudentEntity.class, "select * from student where sid=?",
						stu.getSid());
				String flag;
				if (student.getGrade() > 0 && student.getMaxnum() > 0) {
					flag = "1";
				} else if (student.getGrade() <= 0) {
					flag = "2";
				} else if (student.getMaxnum() <= 0) {
					flag = "3";
				} else {
					flag = "4";
				}
				out.write(flag);
				out.flush();
				out.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
