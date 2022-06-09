package com.logislink.cmm.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONArray;

//import com.ibm.icu.text.SimpleDateFormat;

public class ExcelUtil {

	public static JSONArray getExcelData(String filePath) {
		JSONArray json = new JSONArray();
		try {
			FileInputStream inputStream = new FileInputStream(filePath);			
			XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
			XSSFSheet sheet = workbook.getSheetAt(0);
			for(Iterator<Row> rowsIT = sheet.rowIterator(); rowsIT.hasNext();) {
				Row row = rowsIT.next();
				JSONArray cells = new JSONArray();
				for(int cn=0; cn<row.getLastCellNum(); cn++) {					
					Cell cell = row.getCell(cn, Row.CREATE_NULL_AS_BLANK);
					
					String value = "";
					if(cell == null || cell.getCellType() == Cell.CELL_TYPE_BLANK) {
						value = "";
					} else {
						switch(cell.getCellType()) {
						case Cell.CELL_TYPE_NUMERIC:
							if(DateUtil.isCellDateFormatted(cell)) {
								Date date = cell.getDateCellValue();
								value = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(date);
								if ("00:00".equals(value.split(" ")[1])) {
									value = value.split(" ")[0];
								} else {
									value = value.split(" ")[1];
								}
							} else {
								//숫자일 경우, String형으로 변환하여 값을 읽는다.
								cell.setCellType(Cell.CELL_TYPE_STRING);
								value = cell.getStringCellValue();
							}
							break;
						default:
							value = getStringValue(cell);
						}	
					}
					if(cn == 0 && "".equals(value)) {
						break;
					} else {
						cells.add(value);	
					}
				}
				if(!cells.isEmpty()) {
					json.add(cells);
				} 
			}
			
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}
	
	private static String getStringValue(Cell cell) {
		String str = "";
		
		try {
			str = cell.getStringCellValue();	
		} catch (IllegalStateException e) {
			str = Integer.toString((int)cell.getNumericCellValue());
		}
		
		return str;
	}
}
