package com.books.controller;
/*登录功能*/
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSONObject;
import com.books.dao.BaseDao;
import com.books.dao.BaseDaoImpl;
import com.books.entity.StudentEntity;
import com.books.entity.UsersEntity;
import com.books.service.CarRentalService;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	BaseDao dao = new BaseDaoImpl();
	PrintWriter out = null;

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
		// 全局变量类----------------------------------------------------------------------------------------------------------
		String method = request.getParameter("method");
		System.out.println(method);
		out = response.getWriter();
//		File[] files = File.listRoots();
//		String rootpath = files[files.length - 1].getPath();
		if ("login".equals(method)) {// 登录
			Object[] params = { use.getUname(), use.getPassword() };
			System.out.println(use.getUname() + use.getPassword());
			JSONObject user = null;
			try {
				user = dao.findJSONObject("select * from users where uname = ? and password = ?", params);
//				System.out.println(user);
//				System.out.println(user.get("uname"));
//				System.out.println(user.get("utype"));
				request.getSession().setAttribute("uname", user.get("uname"));
				request.getSession().setAttribute("utype", user.get("utype"));
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (user.size() > 0) {
					out.write("1");
					out.flush();
					out.close();
				}
			}
		} else if ("exit".equals(method)) {// 退出登录
			request.getSession().removeAttribute("uname");
			request.getSession().removeAttribute("utype");
			session.removeAttribute("sname");
			session.removeAttribute("sid");
			response.sendRedirect("login.jsp");
		} else if ("index".equals(method)) {// 进入首页
			String uname = (String) session.getAttribute("uname");
			System.out.println(uname);
			String utype = "" + session.getAttribute("utype");
			System.out.println(utype);
			if (utype.equals("3")) {
				response.sendRedirect("Student?method=users_books");
			} else {
				response.sendRedirect("Index?method=books");
			}
		} else if ("updateUsers".equals(method)) {// 修改密码
			String pwd = request.getParameter("pwd");
			String pwd1 = request.getParameter("pwd1");
			System.out.println(pwd);
			System.out.println(pwd1);
			String uname = (String) request.getSession().getAttribute("uname");
			Object[] params = { pwd1, uname };
			try {
				int m = (int) dao.getCount("select count(*) from users where password = ?", pwd);
				if (m > 0) {
					System.out.println("jinlail1" + m);
					dao.update("update users set password = ? where uname = ?", params);
					out.write("1");
					out.flush();
					out.close();
				} else {
					out.write("2");
					out.flush();
					out.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
}
