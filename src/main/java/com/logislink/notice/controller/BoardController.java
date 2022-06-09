package com.logislink.notice.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.logislink.cmm.util.EtcUtil;
import com.logislink.cmm.util.FileUtil;
import com.logislink.cmm.vo.FileVO;
import com.logislink.login.vo.LoginMenuVO;
import com.logislink.login.vo.LoginVO;
import com.logislink.notice.service.BoardService;
import com.logislink.notice.vo.BoardFileVO;
import com.logislink.notice.vo.BoardVO;

@Controller
public class BoardController {

	private Logger log = Logger.getLogger(this.getClass());
	private String menuCode = "D4110";
	
	@Resource(name="boardService")
	private BoardService boardService;

	@Resource(name="globalProperties")
	private Properties globalProperties;

	@GetMapping(value="/contents/notice/boardList.do")
	public String getTalkList(HttpServletRequest request, HttpSession session, ModelMap model) {

		LoginMenuVO loginMenu = EtcUtil.checkAuth(request, menuCode);
		model.put("menuAuth", loginMenu);
		
		return "contents/notice/boardList";
	}
	
	@PostMapping(value="/contents/notice/data/boardList.do")
	public String boardListData(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception {
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String custId = login.getCustId();

		param.put("custId", custId);
		
		if(login.getAuthSeq() != 100) {
			param.put("custTypeCode", login.getCustTypeCode());
		}
		
		List<BoardVO> list = boardService.getBoardList(param);
		int count = boardService.getCnt(param);
		
		//팝업창 호출인 경우, filelist 같이 호출한다.
		if("popup".equals(param.get("type"))) {
			for(BoardVO board : list) {
				if(board.getFileCnt() > 0) {
					param.put("boardSeq", board.getBoardSeq());
					List<BoardFileVO> fileList = boardService.getFiles(param);
					board.setFileList(fileList);
				}
			}
		}
		
		map.put("result", Boolean.TRUE);
		map.put("data", list);
		map.put("total", count);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/notice/data/boardDetail.do")
	public String boardDetailData(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
							@RequestParam Map<String, Object> param) throws Exception {
		param.put("boardSeq", param.get("boardSeq"));
		BoardVO board = boardService.getBoardDetail(param);
		
		map.put("data", board);
		map.put("result", Boolean.TRUE);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/notice/data/boardReadCount.do")
	public String boardReadCount(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param) throws Exception {
		boardService.boardReadCount(param);
		
		map.put("result", Boolean.TRUE);
		map.put("data", param);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/notice/data/boardWrite.do")
	public String boardWrite(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
								@RequestParam Map<String, Object> param) throws Exception {
		String resMsg = "";
		String boardTarget = String.valueOf(param.get("boardTarget"));
		
		if(boardTarget.indexOf("02") >= 0 || boardTarget.indexOf("03") >=0) {
			boardTarget = "01," + boardTarget;
		}
		if("".equals(boardTarget)) {
			boardTarget = "01,02,03,04,09";
		}
		param.put("boardTarget", boardTarget);
		
		if("E".equals(param.get("mode"))) {
			if(!EtcUtil.checkAuth(request, menuCode, "E")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}
			param.put("editId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
			boardService.boardWrite(param);
		} else if("N".equals(param.get("mode"))) {
			if(!EtcUtil.checkAuth(request, menuCode, "W")) {
				map.put("result", Boolean.FALSE);
				map.put("msg", "해당 권한이 없습니다.");
				
				return "jsonView";
			}			
			boardService.boardWrite(param);
			BoardVO boardInfo = boardService.lastBoardSeq(param);
			param.put("boardSeq", boardInfo.getBoardSeq());
			param.put("regId", ((LoginVO) session.getAttribute("userInfo")).getUserId());
		}
		
		resMsg = (String) param.get("retMsg");
		
		map.put("result", Boolean.TRUE);
		map.put("data", param);
		map.put("msg", resMsg);
		
		return "jsonView";
	}

	@PostMapping(value="/contents/notice/data/fileList.do")
	public String fileListData(HttpServletRequest request, Model model, ModelMap map, HttpSession session,
						@RequestParam Map<String, Object> param) throws Exception {
		
		List<BoardFileVO> list = boardService.getFiles(param);

		map.put("data", list);
		map.put("result", Boolean.TRUE);
		return "jsonView";
	}
	
	@PostMapping(value="/contents/notice/data/fileWrite.do")
	public String fileUpload(HttpServletRequest request, HttpSession session, Model model, ModelMap map,
								@RequestParam Map<String, Object> param, MultipartHttpServletRequest multipart) {

		FileUtil fileUtil = new FileUtil();
		List<BoardFileVO> fileList = new ArrayList<>();
		
		LoginVO login = (LoginVO) session.getAttribute("userInfo");
		String boardSeq = String.valueOf(param.get("fileBoardSeq"));

		String filePath = globalProperties.getProperty("Globals.filepath");
		String realFilePath = filePath + "board/" +  boardSeq + "/";

		//첨부된 파일이 있으면 파일을 업로드한다.
		MultipartFile uploadFile = null;
		List<String> noList = new ArrayList<>();
		
		for(int i=1; i<=3; i++) {
			uploadFile = multipart.getFile("uploadFile" + i);
			if(uploadFile != null && !uploadFile.isEmpty()) {
				noList.add(String.valueOf(i));
				BoardFileVO file = fileUtil.boardFileUpload(uploadFile, realFilePath, Integer.parseInt(boardSeq), i, login.getUserId());
				fileList.add(file);
			}
		}
		
		if(!fileList.isEmpty()) {
			Map<String, Object> fileMap = new HashMap<>();
			fileMap.put("list", fileList);
			boardService.insertFiles(fileMap);
		}

		
		return "jsonView";
	}
	
	@GetMapping(value="/contents/notice/data/fileDownload.do")
	public ModelAndView fileDownload(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception{
		
		BoardFileVO boardFileVO = boardService.getFile(param);
		
		File downloadFile = new File(boardFileVO.getFilePath() + boardFileVO.getFileName());
		
		return new ModelAndView("fileDownloadView", "downloadFile", downloadFile);
	}

	@PostMapping(value="/contents/notice/data/fileDelete.do")
	public String fileDelete(@RequestParam Map<String, Object> param, HttpServletRequest request, Model model,
								ModelMap map, HttpSession session) throws Exception {

		FileUtil fileUtil = new FileUtil();
		List<String> codeList = new ArrayList<>();
		
		BoardFileVO boardFileVO = boardService.getFile(param);
		
		if(boardFileVO != null) {
			fileUtil.DelFile(boardFileVO.getFilePath() + boardFileVO.getFileName());
			codeList.add(boardFileVO.getFileTypeCode());
		}
		
		if(!codeList.isEmpty()) {
			Map<String, Object> delFileMap = new HashMap<>();
			delFileMap.put("boardSeq", boardFileVO.getBoardSeq());
			delFileMap.put("fileSeq", boardFileVO.getFileSeq());
			boardService.deleteFiles(delFileMap);
		}
		
		map.put("data", boardFileVO);
		
		return "jsonView";
	}
	
	@PostMapping(value="/contents/notice/data/boardDelete.do")
	public String boardDelete(@RequestParam Map<String, Object> param, HttpServletRequest request, Model model,
								ModelMap map, HttpSession session) throws Exception {

		if(!EtcUtil.checkAuth(request, menuCode, "D")) {
			map.put("result", Boolean.FALSE);
			map.put("msg", "해당 권한이 없습니다.");
			
			return "jsonView";
		}
		boardService.deleteBoard(param);

		map.put("result", Boolean.TRUE);
		map.put("msg", "공지사항을 삭제했습니다.");
		return "jsonView";
	}
}
