package com.books.test;

import java.sql.SQLException;

import com.books.dao.BaseDao;
import com.books.dao.BaseDaoImpl;
import com.books.entity.UsersEntity;

public class test {
	public static void main(String[] args) {
		BaseDao dao = new BaseDaoImpl(); 
		UsersEntity users;
		try {
			users = dao.findBean(UsersEntity.class, "select * from users");
			System.out.println(users);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
			
	}

}
