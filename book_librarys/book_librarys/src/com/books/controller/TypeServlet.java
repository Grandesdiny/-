package com.books.controller;
/*图书种类*/
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

@WebServlet("/Type")
public class TypeServlet extends HttpServlet {
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
		
		if("types".equals(method)) {//图书分类清单
			try {
				JSONArray types = dao.findJSONArray("select * from booktype order by tid ");
				request.setAttribute("types", types);
				request.getRequestDispatcher("type-list.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if("type_add".equals(method)) {//添加分类
			try {
				Object[] params= {typ.getTname()};
				dao.update("insert into booktype(tname) values(?)", params);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if("type_update".equals(method)) {//修改分类
			try {
				BooktypeEntity booktype=dao.findBean(BooktypeEntity.class, "select * from booktype where tid=? ",typ.getTid() );
				System.out.println(booktype);
				request.setAttribute("type", booktype);
				request.getRequestDispatcher("type-update.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if("type_update1".equals(method)) {//确认修改图书分类
			try {
				Object[] params= {typ.getTname(),typ.getTid()};
				dao.update("update booktype set tname = ? where tid=?", params);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if("type_delete".equals(method)) {//删除分类
			try {
				Object[] params= {typ.getTid()};
				dao.update("delete from booktype where tid=?", params);
				response.sendRedirect("Type?method=types");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
