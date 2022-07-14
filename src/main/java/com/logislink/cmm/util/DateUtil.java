package com.logislink.cmm.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class DateUtil {

	/**
	 * yyyyMNdd
	 * 
	 * @param sepStr
	 */
	public static String getDate(String sepStr) {
		String date = new SimpleDateFormat("yyyyMMdd").format(new Date());

		if (sepStr != null && !sepStr.equals("")) {
			date = date.substring(0, 4) + sepStr + date.substring(4, 6) + sepStr + date.substring(6, 8);
		}

		return date;
	}

	/**
	 * HH:mm:ss
	 */
	public static String getHHmmss() {
		String time = new SimpleDateFormat("HH:mm:ss").format(new Date());

		return time;
	}
	
	/**
	 * date의 어제 날짜
	 */
	public static String getYesterday(String date, String sepStr) {
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("Asia/Seoul"));
		cal.set(Integer.parseInt(date.substring(0, 4)), Integer.parseInt(date.substring(4, 6)) - 1, Integer.parseInt(date.substring(6, 8)) - 1);

		SimpleDateFormat fm = new SimpleDateFormat("yyyyMMdd");
		String yesterday = fm.format(cal.getTime());
		if (sepStr != null && !sepStr.equals("")) {
			yesterday = yesterday.substring(0, 4) + sepStr + yesterday.substring(4, 6) + sepStr + yesterday.substring(6, 8);
		}

		return yesterday;
	}

	/**
	 * date의 내일 날짜
	 */
	public static String getTomorrow(String date, String sepStr) {
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("Asia/Seoul"));
		cal.set(Integer.parseInt(date.substring(0, 4)), Integer.parseInt(date.substring(4, 6)) - 1, Integer.parseInt(date.substring(6, 8)) + 1);

		SimpleDateFormat fm = new SimpleDateFormat("yyyyMMdd");
		String tomorrow = fm.format(cal.getTime());
		if (sepStr != null && !sepStr.equals("")) {
			tomorrow = tomorrow.substring(0, 4) + sepStr + tomorrow.substring(4, 6) + sepStr + tomorrow.substring(6, 8);
		}

		return tomorrow;
	}

	/**
	 * 입력받은 date를 sepStr 형식에 맞춰서
	 * 
	 * @param date
	 * @param sepStr
	 * @return yyyy_MM_dd 형태
	 */
	public static String dateYYYYmmdd(String date, String sepStr) {
		if (date != null && !date.equals("") && sepStr != null && !sepStr.equals("")) {
			date = date.substring(0, 4) + sepStr + date.substring(4, 6) + sepStr + date.substring(6, 8);
		}

		return date;
	}

	
	/**
	 * HHmmssff -> HH:mm:ss
	 * @param time
	 * @param sepStr
	 * @return
	 */
	/*public static String timeHHmmss(String time) {
		String convertTime = "";
		if (!time.equals("") && time != null) {
			convertTime = time.substring(0, 2) + sepStr + time.substring(2, 4) + sepStr + time.substring(4, 6);
		}

		return convertTime;
	}*/

	/**
	 * epoch time 시간 형식 -> yyyy.MM.dd HH:mm:ss
	 */
	public static String convertFormatStr(long time, String convertformat) {
		SimpleDateFormat sdf = new SimpleDateFormat(convertformat);
		Date dt = new Date(time * 1000L);
		String convertTime = sdf.format(dt);

		return convertTime;

	}

	/**
	 * yyyy.MM.dd HH:mm:ss -> epoch time 시간 형식
	 */
	public static Long convertFormatLong(String datetime, String currentFormat) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat(currentFormat);

		Date dt = sdf.parse(datetime);
		Long unix_stime = new Long(dt.getTime() / 1000);

		return unix_stime;

	}

	public static int convertFormatSec(String time) throws Exception {
		int total_sec = 0;
		if (!time.equals("") && time != null) {
			time = time.replaceAll(":","");
			int hours = Integer.parseInt(time.substring(0, 2)) * (60 * 60);
			int min = Integer.parseInt(time.substring(2, 4)) * 60;
			int sec = Integer.parseInt(time.substring(4, 6));

			total_sec = hours + min + sec;
		}
		return total_sec;

	}

	/**
	 * 초 -> HH:mm:ss
	 */
	public static String secConvertFormatHHmmss(int second) throws Exception {
		String time = "";

		int hours = second / (60 * 60);
		int min = (second - (hours * 60 * 60)) / 60;
		int sec = second - (hours * 60 * 60) - (min * 60);

		time = String.format("%02d:%02d:%02d", hours, min, sec);

		return time;

	}
	
	
	public static String nowTime() throws Exception{
		return getDate(".")+" "+getHHmmss();
	}
	
	// 22.07.14 이건욱 T1 > J5, J6 배차일괄등록 기능 개선 -> Date validation check
	public static boolean checkDate(String date, String dateFormat) {
		try {
			SimpleDateFormat dateFormatParser = new SimpleDateFormat(dateFormat);
	        dateFormatParser.setLenient(false);
	        dateFormatParser.parse(date);
	        return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	// 22.07.14 이건욱 T1 > J5, J6 배차일괄등록 기능 개선 -> Time validation check
	public static boolean checkTime(String time, String timeFormat) {
		try {
			SimpleDateFormat dateFormatParser = new SimpleDateFormat(timeFormat);
	        dateFormatParser.setLenient(false);
	        dateFormatParser.parse(time);
	        return true;
		} catch (Exception e) {
			return false;
		}
	}
}
