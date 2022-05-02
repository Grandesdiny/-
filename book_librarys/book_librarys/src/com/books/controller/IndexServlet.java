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

@WebServlet("/Index")
public class IndexServlet extends HttpServlet {
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
		// 全局变量类----------------------------------------------------------------------------------------------------------
		String method = request.getParameter("method");
		System.out.println(method);
		out = response.getWriter();

		if ("books".equals(method)) {//图书清单
			try {
				JSONArray books = dao.findJSONArray("select * from book order by bid ");
				request.setAttribute("books", books);
				request.getRequestDispatcher("books-list.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("book_add".equals(method)) {//添加图书
			try {
				JSONArray books = dao.findJSONArray("select * from booktype");
				request.setAttribute("books", books);
				request.getRequestDispatcher("book-add.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("book_add1".equals(method)) {//确认添加图书
			String num = request.getParameter("num");
			if (!service.isNumeric(num)) {
				out.write("2");
				out.flush();
				out.close();
			} else {
				try {
					Object[] params = { boo.getBname(), boo.getAuther(), boo.getPress(), boo.getTname(), boo.getNum(), 0 };
					int i = dao.update("insert into book(bname,auther,press,tname,num,residuals) values(?,?,?,?,?,?)", params);
					if(i>0) {
						out.write("1");
						out.flush();
						out.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		} else if ("book_update".equals(method)) {//修改图书
			try {
				JSONArray books = dao.findJSONArray("select * from booktype");
				BookEntity book = dao.findBean(BookEntity.class, "select * from book where bid=? ", boo.getBid());
				System.out.println(book);
				request.setAttribute("books", books);
				request.setAttribute("book", book);
				request.getRequestDispatcher("book-update.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("book_update1".equals(method)) {//确认修改图书
			String num = request.getParameter("num");
			if (!service.isNumeric(num)) {
				out.write("2");
				out.flush();
				out.close();
			} else {
				try {
					Object[] params = { boo.getBname(), boo.getAuther(), boo.getPress(), boo.getTname(), boo.getNum(),
							boo.getBid() };
					int i = dao.update("update book set bname=?,auther=?,press=?,tname=?,num=? where bid=?", params);
					if(i>0) {
						out.write("1");
						out.flush();
						out.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		} else if ("book_delete".equals(method)) {//删除图书
			try {
				Object[] params = { boo.getBid() };
				dao.update("delete from book where bid=?", params);
				response.sendRedirect("Index?method=books");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("book_search".equals(method)) {//查找图书
			try {
				String utype = "" + session.getAttribute("utype");
				JSONArray books = dao
						.findJSONArray("select * from book where bname like '%" + boo.getBname() + "%' order by bid");
				System.out.println(books);
				request.setAttribute("books", books);
				if(utype.equals("3")) {
					request.getRequestDispatcher("users-books.jsp").forward(request, response);
				}else {
				request.getRequestDispatcher("books-list.jsp").forward(request, response);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
