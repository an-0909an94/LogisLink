package com.logislink.cmm.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.AbstractView;

import com.logislink.cmm.vo.FileVO;
import com.logislink.notice.vo.BoardFileVO;


@Component
public class FileUtil extends AbstractView {

	Logger logger = LogManager.getLogger();
	
	public FileVO fileUpload(MultipartFile uploadFile, String path, 
							int serviceSeq, int midSeq, String codeFile, int fileNo, String mid) {
		
		String fileName = "";
		OutputStream out = null;
		PrintWriter printWriter = null;
		FileVO fileVO = null;

		try {
			fileName = uploadFile.getOriginalFilename();
			byte[] bytes = uploadFile.getBytes();
			long fileSize = uploadFile.getSize();
			String fileType = uploadFile.getContentType();
			
			String genId = UUID.randomUUID().toString();
			String saveFileName = "";

			File file = new File(path);
			
			if(!file.isDirectory()) {
				file.mkdirs();
			}
			
			if(fileName != null && !"".equals(fileName)) {
				if(file.exists()) {
					if("guide".equals(mid)) {
						saveFileName = fileName;		//가이드 파일인 경우, 파일 이름 그대로 저장
					} else {
						saveFileName = genId + "." + getExtention(fileName);
					}

					file = new File(path + saveFileName);	
				}
			}
			
			fileVO = new FileVO();		
			fileVO.setfPath(path);
			fileVO.setfNameOrg(fileName);
			fileVO.setfName(saveFileName);
			fileVO.setfSize(fileSize);
			fileVO.setfType(fileType);
			fileVO.setServiceSeq(serviceSeq);
			fileVO.setMid(mid);
			fileVO.setMidSeq(midSeq);
			fileVO.setCodeFile(codeFile);
			fileVO.setfNo(fileNo);
			fileVO.setAsort(fileNo);
			fileVO.setRegSeq(midSeq);
			
			
			out = new FileOutputStream(file);
			out.write(bytes);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(out != null) {
					out.close();
				}
				if(printWriter != null) {
					printWriter.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return fileVO;
	}
	
	public BoardFileVO boardFileUpload(MultipartFile uploadFile, String path, int boardSeq, int fileNo, String regid) {

		String fileName = "";
		OutputStream out = null;
		PrintWriter printWriter = null;
		BoardFileVO fileVO = null;
		
		try {
			fileName = uploadFile.getOriginalFilename();
			byte[] bytes = uploadFile.getBytes();
			long fileSize = uploadFile.getSize();
			String fileType = uploadFile.getContentType();
			
			String genId = UUID.randomUUID().toString();
			String saveFileName = "";
			
			File file = new File(path);
			
			if(!file.isDirectory()) {
			file.mkdirs();
		}
		
		if(fileName != null && !"".equals(fileName)) {
			if(file.exists()) {
				saveFileName = genId + "." + getExtention(fileName);
				file = new File(path + saveFileName);
			}
		}
		
			fileVO = new BoardFileVO();		
			fileVO.setFilePath(path);
			fileVO.setFileRealName(fileName);
			fileVO.setFileName(saveFileName);
			fileVO.setFileSize(fileSize);
			fileVO.setMimeType(fileType);
			fileVO.setBoardSeq(boardSeq);
			fileVO.setfNo(fileNo);
			fileVO.setRegid(regid);
			
			
			out = new FileOutputStream(file);
			out.write(bytes);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		try {
		if(out != null) {
			out.close();
		}
		if(printWriter != null) {
			printWriter.close();
		}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return fileVO;
	}

	private String getExtention(String fileName) {
		return fileName.substring(fileName.lastIndexOf(".")+1, fileName.length());		
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub

		setContentType("application/download; charset=utf-8");
		
		File file = (File)model.get("downloadFile");
		response.setContentType(getContentType());
		response.setContentLength((int) file.length());
		
		String header = request.getHeader("User-Agent");
		boolean b = header.indexOf("MSIE") > -1;
		String fileName = null;
		
		if(b) {
			fileName = URLEncoder.encode(file.getName(), "utf-8");			
		} else {
			fileName = new String(file.getName().getBytes("utf-8"), "iso-8859-1");
		}
		
		response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\";");
		response.setHeader("content-Transter-Encoding", "binary");
		
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(fis!=null) {
				try {
					fis.close();
				} catch(IOException e) {
					e.printStackTrace();
				}
			}
			out.flush();
		}
		
	}

	public void DelFile(String path){
		File file = new File(path);
		boolean delYN = true;
		if(file.exists()) {
			delYN = file.delete();
			/*if(delYN) {
				logger.info("File Delete Success");
			}else {
				logger.info("File Delete Fail");
			}*/
		}
		/*else {
			logger.info("File Not Found.");
		}
		logger.info(path);*/
	}
}
