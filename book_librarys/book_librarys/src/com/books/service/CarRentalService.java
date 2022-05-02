package com.books.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;

import com.books.dao.BaseDao;
import com.books.dao.BaseDaoImpl;

/*
 * @auther JJ
 * Backstageservlet 对应方法
 */
public class CarRentalService {
	/*
	 * auther JJ
	 * 读取excel文件
	 */
	public static class ReadExcel {
		static DecimalFormat df = new DecimalFormat("###.##");
		static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		BaseDao baseDao = new BaseDaoImpl();

//处理信息----------------------------------------------------------------------------------------------
	public static <T> Object getValue(String value, String type) {
		Object obj = null;
		if (value != null) {
			switch (type) {
			case "Integer":
//				try {
//					obj = new Integer(value);
//				} catch (Exception e) {
//					throw new Exception("转化成Integer对象错误");
//				}
				obj = new Integer(value);
				break;
			case "int":
				obj = Integer.parseInt(value);
				break;
			case "double":
				obj = Double.parseDouble(value);
				break;
			case "Double":
				obj = new Double(value);
				break;
			case "long":
				obj = Long.parseLong(value);
				break;
			case "Long":
				obj = new Long(value);
				break;
			default:
				obj = value;
				break;
			}
		}
		return obj;
	}
	}
//创建getpar反射--------------------------------------------------------------------------------------------
	public <T> T setObject(HttpServletRequest request, Class<T> clas) {
		// 1.获取每一个字段
		Field[] fields = clas.getDeclaredFields();

		// 2.创建反射的一个实例对象
		T obj = null;
		try {
			obj = clas.newInstance();
			// 3.遍历
			for (Field field : fields) {
				// 从request中获取值

				String value = request.getParameter(field.getName());
				// System.out.println(field.getName());
				if (value != null) {
					// 将值对应类型进行转换
					Object objValue = getValue(value, field.getType().getSimpleName());

					// 字段名称
					String name = field.getName();

					String methodName = "set" + name.substring(0, 1).toUpperCase() + name.substring(1);

					// set方法
					Method method = clas.getDeclaredMethod(methodName, field.getType());

					// 将值设置到实例obj中
					method.invoke(obj, objValue);
				}
			}
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}

		return obj;
	}
	

	//设置到实体类
	//根据实体类的类型，将字符串类型转化
	/**
	 * 	将单元格的String值转化为实体类对应的类型
	 * @param value cell的值
	 * @param type 字段的类型简称
	 */
	public static Object getValue(String value, String type) {
		Object obj = null;
		if (value != null) {
			switch (type) {
			case "Integer":
				obj = new Integer(value);
				break;
			case "int":
				obj = Integer.parseInt(value);
				break;
			case "double":
				obj = Double.parseDouble(value);
				break;
			case "Double":
				obj = new Double(value);
				break;
			case "long":
				obj = Long.parseLong(value);
				break;
			case "Long":
				obj = new Long(value);
				break;
			default:
				obj = value;
				break;
			}
		}
		return obj;
	}
	

//文件写入-------------------------------------------------------------------------------------------
	public String imagepath(Part part) {
		File[] files = File.listRoots();
		String rootpath = files[files.length - 1].getPath() + "Carrental";
		File file = new File(rootpath);
		if (file == null || !file.exists()) {
			file.mkdirs();
		}
		String savepath = rootpath + File.separator + part.getSubmittedFileName();
		InputStream in;
		try {
			in = part.getInputStream();
			OutputStream out = new FileOutputStream(savepath);// 论文
			// System.out.println(savepath);
			int len = 0;
			byte[] b = new byte[1024 * 4];
			while ((len = in.read(b)) != -1) {
				out.write(b, 0, len);
			}
			System.out.println("写入成功");
			out.close();
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return savepath;

	}
	//方法一：用JAVA自带的函数
	public boolean isNumeric(String str){
	   for (int i = str.length();--i>=0;){  
	       if (!Character.isDigit(str.charAt(i))){
	           return false;
	       }
	   }
	   return true;
	}
	
	/**
	 * 计算两个时间点之间的天数
	 */
	public long getBetweenDay(LocalDate start, LocalDate end) {
		return end.toEpochDay() - start.toEpochDay();
	}
	
	}

