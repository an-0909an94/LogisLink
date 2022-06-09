package com.logislink.cmm.controller;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.logislink.cmm.service.CmmService;
import com.logislink.notice.vo.BoardFileVO;

@Controller
public class FileController {

	@Value("#{globalProperties['Globals.filepath']}")
	private String filepath;
	
	@Resource(name="cmmService")
	private CmmService cmmService;

	@GetMapping(value="/cmm/appDownload.do")
	public ModelAndView fileDownload(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception{
		
		String fileName = String.valueOf(param.get("fileName"));
	
		File downloadFile = new File("/NAS/app/" + fileName);
		
		return new ModelAndView("fileDownloadView", "downloadFile", downloadFile);
	}

	@GetMapping(value="/cmm/guideDownload.do")
	public ModelAndView fileGuideDownload(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception{
		
		String fileName = String.valueOf(param.get("fileName"));
	
		File downloadFile = new File("/NAS/upload/guide/" + fileName);
		
		return new ModelAndView("fileDownloadView", "downloadFile", downloadFile);
	}

	@GetMapping(value="/cmm/manualDownload.do")
	public ModelAndView fileManualDownload(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception{
		
		String fileName = String.valueOf(param.get("fileName"));
	
		File downloadFile = new File("/NAS/upload/manual/" + fileName);
		
		return new ModelAndView("fileDownloadView", "downloadFile", downloadFile);
	}

	
	@GetMapping(value="/cmm/fileDownloadEtc.do")
	public ModelAndView fileDownloadEtc(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
				
		String path = request.getServletContext().getRealPath("");
						
		String fileName = String.valueOf(param.get("fileName"));
		
		File downloadFile = new File(path + fileName);
		
		return new ModelAndView("fileDownloadView", "downloadFile", downloadFile);
	}
	
	@GetMapping(value="/cmm/downloadInvoice.do")
	public ModelAndView downloadInvoice(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
				
		//String root_path = request.getServletContext().getRealPath("\\");
		String attach_path = "/reportsTemp/";
	    
		File invoicePdf = new File(filepath + attach_path + String.valueOf(param.get("fileName")));
		
		return new ModelAndView("fileDownloadView", "downloadFile", invoicePdf);
	}
    
}
