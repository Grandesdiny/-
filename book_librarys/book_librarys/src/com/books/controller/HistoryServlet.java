package com.books.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

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
import com.books.entity.HistoryEntity;
import com.books.entity.StudentEntity;
import com.books.service.CarRentalService;

@WebServlet("/History")
public class HistoryServlet extends HttpServlet {
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
		StudentEntity stu = service.setObject(request, StudentEntity.class);
		BookEntity boo = service.setObject(request, BookEntity.class);
		HistoryEntity his = service.setObject(request, HistoryEntity.class);
		// 全局变量类----------------------------------------------------------------------------------------------------------
		String method = request.getParameter("method");
		System.out.println(method);
		out = response.getWriter();

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDateTime ldt = LocalDateTime.now();

		if ("history".equals(method)) {//图书借阅历史
			try {
				JSONArray history = dao.findJSONArray(
						"select s.uname,s.sname,h.*,b.bname from history h join student s  JOIN book b on h.bid = b.bid and h.sid=s.sid  order by h.hid desc");
				request.setAttribute("history", history);
				request.getRequestDispatcher("history-list.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("history_delete".equals(method)) {//删除借阅历史
			try {
				Object[] params = { his.getHid() };
				dao.update("delete from history where hid=?", params);
				response.sendRedirect("History?method=history");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("history_search".equals(method)) {//查找借阅历史
			String search = request.getParameter("string");
			try {
				JSONArray history = null;
				if (service.isNumeric(search)) {
					history = dao.findJSONArray(
							"select s.uname,s.sname,h.*,b.bname from history h join student s  JOIN book b on h.bid = b.bid and h.sid=s.sid where s.uname like '%"
									+ search + "%' order by h.hid desc");
				} else {
					history = dao.findJSONArray(
							"select s.uname,s.sname,h.*,b.bname from history h join student s  JOIN book b on h.bid = b.bid and h.sid=s.sid where b.bname like '%"
									+ search + "%' order by h.hid desc");
				}
				System.out.println(history);
				request.setAttribute("history", history);
				request.getRequestDispatcher("history-list.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("history_add".equals(method)) {//用户借书
			try {
				String starttime = ldt.format(formatter); // 日期
				Object[] params = { stu.getSid(), boo.getBid(), starttime };
				dao.update("insert into history(sid,bid,begintime) values(?,?,?)", params);
				dao.update("update book set residuals=residuals+1 where bid=?", boo.getBid());
				dao.update("update student set maxnum=maxnum-1 where sid=?", stu.getSid());
				response.sendRedirect("History?method=users_history");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("users_history".equals(method)) {//用户查看自己的借阅历史
			try {
				String uname = (String) session.getAttribute("uname");
				JSONArray history = dao.findJSONArray(
						"select s.uname,s.sname,h.*,b.bname from history h join student s  JOIN book b on h.bid = b.bid and h.sid=s.sid where s.uname=? order by h.hid desc",
						uname);
				request.setAttribute("history", history);
				request.getRequestDispatcher("users-history.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("history_update".equals(method)) {//用户还书操作
			try {
				String[] s = his.getBegintime().split("-");
				LocalDate start = LocalDate.of(Integer.parseInt(s[0]), Integer.parseInt(s[1]), Integer.parseInt(s[2]));
				LocalDate now = LocalDate.now();
				String endtime = now.format(formatter); // 日期
				Object[] params = { endtime, his.getHid() };
				long n = service.getBetweenDay(start, now);
				System.out.println(n);
				System.out.println(endtime);
				if (n > 60) {
					System.out.println(">60");
					dao.update("update history set endtime=?,timeout=1 where hid=?", params);
					dao.update("update student set maxnum=maxnum+1,grade=grade-1 where sid=?", stu.getSid());
					dao.update("update book set residuals=residuals-1 where bid=?", his.getBid());
					response.sendRedirect("History?method=users_history");
				} else if (n >= 0 && n <= 60) {
					System.out.println("<60");
					dao.update("update history set endtime=?,timeout=0 where hid=?", params);
					dao.update("update student set maxnum=maxnum+1 where sid=?", stu.getSid());
					dao.update("update book set residuals=residuals-1 where bid=?", his.getBid());
					response.sendRedirect("History?method=users_history");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
	}
}
