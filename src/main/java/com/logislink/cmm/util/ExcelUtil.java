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
	
	/*
	 * 22.07.08 이건욱 T1 > J6 배차일괄등록 기능개선 -> Excel to Json 배차일괄등록용 메소드 추가 
	 */
	@SuppressWarnings("unchecked")
	public static JSONArray getOrderBundleExcelData(String filePath) throws Exception  {
		JSONArray json = new JSONArray();
		
		FileInputStream inputStream = new FileInputStream(filePath);			
		XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
		XSSFSheet sheet = workbook.getSheetAt(0);
		
		// 엑셀 시트 검증
		int rowCnt = sheet.getPhysicalNumberOfRows();
		// 헤더만 1차 검증
		int cellCnt = sheet.getRow(0).getPhysicalNumberOfCells();
		if (cellCnt != 35)
			// 예외처리
			throw new Exception("배차양식 엑셀 파일을 처리하는데 문제가 발생했습니다.\\n올바른 배차양식 엑셀 파일을 업로드 해주세요.");
		
		// i = 1 ? 헤더 제외
		for (int i = 1; i < rowCnt; i++) {
			Row row = sheet.getRow(i);
			JSONArray cells = new JSONArray();
			
			// 각 Row에서 컬럼 사이즈가 안맞으면 정지
			cellCnt = row.getLastCellNum();
			if (cellCnt != 35)
				break;
			
			// 일정한 포맷이 없는 Row (빈 Row)가 있을 시 정지
			if (!row.isFormatted())
				break;
			
			for (int j = 0; j < cellCnt; j++) {
				Cell cell = row.getCell(j, Row.CREATE_NULL_AS_BLANK);
				
				Object value = null;
				switch (cell.getCellType()) {
				case Cell.CELL_TYPE_NUMERIC:
					// 날짜 형식의 경우 
					if(DateUtil.isCellDateFormatted(cell)) {
						Date date = cell.getDateCellValue();
						value = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(date);
						if ("00:00".equals(((String)value).split(" ")[1])) {
							value = ((String)value).split(" ")[0];
						} else {
							value = ((String)value).split(" ")[1];
						}
					} else {
						//숫자일 경우, String형으로 변환하여 값을 읽는다.
						cell.setCellType(Cell.CELL_TYPE_STRING);
						value = cell.getStringCellValue();
					}
					break;
				case Cell.CELL_TYPE_STRING:
					value = cell.getStringCellValue();
					break;
				case Cell.CELL_TYPE_BLANK:
					value = "";
					break;
				case Cell.CELL_TYPE_BOOLEAN:
					value = cell.getBooleanCellValue();
					break;
				default:
					value = getStringValue(cell);
				}
				
				cells.add(value);
			}
			
			// Row number 추가
			cells.add(i);
						
//			System.out.println(row.isFormatted());
			
			if (!cells.isEmpty())
				json.add(cells);
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
