package com.books.test;

import java.time.LocalDate;

public class TimesUtils {
	public static void main(String[] args) {
		String[] s = "2020-1-11".split("-");
		LocalDate start = LocalDate.of(Integer.parseInt(s[0]),Integer.parseInt(s[1]),Integer.parseInt(s[2]));
		LocalDate now = LocalDate.now();
		System.out.println("两个时间之间的天数是：" + TimesUtils.getBetweenDay(start, now) + " 天。");
	}

	/**
	 * 计算两个时间点之间的天数
	 */
	public static long getBetweenDay(LocalDate start, LocalDate end) {
		return end.toEpochDay() - start.toEpochDay();
	}

}
