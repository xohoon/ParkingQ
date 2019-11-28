package kr.parkingq.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mchange.v2.cfg.PropertiesConfigSource.Parse;

import kr.parkingq.domain.freeboard.Criteria;
import kr.parkingq.domain.freeboard.FreeBoardVO;
import kr.parkingq.domain.freeboard.FreeFileVO;
import kr.parkingq.domain.freeboard.FreeLikeCountVO;
import kr.parkingq.domain.freeboard.FreeLikeVO;
import kr.parkingq.domain.freeboard.PagingDTO;
import kr.parkingq.service.freeboard.FreeBoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/freeboard/*")
public class FreeBoardController {

	private FreeBoardService service;
	
	//목록
	@GetMapping("/list")
	public String list(Model model, Criteria cri, FreeLikeVO like, FreeFileVO file,
			@CookieValue(value="userId", required=false) String userId, 
			@CookieValue(value="userNick", required=false) String userNick){
		
		if( userId == null ) {
			model.addAttribute("msg","로그인 정보가 없습니다.");
			model.addAttribute("movePath","/");
			return "common/message";
		}
		
		log.info("connect list >>>>>>>>>>>>>");
		log.info("list :"+ cri);
		model.addAttribute("id", userId);
		model.addAttribute("nick", userNick);
		int total = service.getTotal(cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PagingDTO(cri, total));
		model.addAttribute("best", service.getBestList());
		
		return "freeboard/list";
	}
	
	//글등록
	@PostMapping("/register")
	public String register(FreeBoardVO board, RedirectAttributes rttr, 
			@CookieValue("userId") String userId, @CookieValue("userNick") String userNick) {
		
		board.setId(userId);
		board.setNick(userNick);
		log.info("register: "+ board);
		service.register(board);
		rttr.addFlashAttribute("result", board.getNo());
		
		return "redirect:/freeboard/list";
	}
	
	@GetMapping("/register")
	public void register(Model model,FreeBoardVO board,
			@CookieValue("userId") String userId, @CookieValue("userNick") String userNick) {
		
		board.setNowDate(service.selectDate());
		
		model.addAttribute("date", board.getNowDate());
		
		log.info("Cookie ID: " + userId);
		log.info("Cookie Nick: "+ userNick);
	}

	//답글
	@GetMapping("/rewrite")
	public void rewrite(FreeBoardVO board,Model model,
			@CookieValue("userId") String userId, @CookieValue("userNick") String userNick) {
		model.addAttribute("seq",board.getSeq());
		model.addAttribute("ref",board.getRef());
		model.addAttribute("lev",board.getLev());
		model.addAttribute("id", userId);
		model.addAttribute("nick", userNick);
		
		board.setNowDate(service.selectDate());
		model.addAttribute("date", board.getNowDate());
		
		log.info(board.getSeq()+"!@##!@#!@#!@#!@#!@#!@#");
		log.info(board.getRef()+"!@#!@$!@$!@$!@#!@");
		log.info(board.getLev()+"!@#!@#!@#!@#@!@#");
		log.info(userId);
	}
	@PostMapping("/rewrite")
	public String rewrite(FreeBoardVO board, RedirectAttributes rttr, 
			@CookieValue("userId") String userId, @CookieValue("userNick") String userNick) {
		board.setId(userId);
		board.setNick(userNick);
		
		log.info("register: "+ board);
		service.rewrite(board);
		rttr.addFlashAttribute("result", board.getNo());
		
		return "redirect:/freeboard/list";
	}
	
	//글조회 수정
	@GetMapping({"/get", "/modify"})
	public String get(@RequestParam("no") Long no, @ModelAttribute("cri") Criteria cri, Model model, FreeLikeCountVO likeCnt
			,@CookieValue(value="userId", required=false) String userId, @CookieValue("userNick") String userNick, HttpServletRequest request) {
		
		if( userId == null ) {
			model.addAttribute("msg","로그인 정보가 없습니다.");
			model.addAttribute("movePath","/common/login");
			return "common/message";
		}
		
		log.info("/get or /modify");
		log.info(no);
		likeCnt.setId(userId);
		likeCnt.setNo(no);
		model.addAttribute("userId",userId);
		model.addAttribute("board", service.getBoard(likeCnt));
		
		return request.getRequestURI().substring(1, request.getRequestURI().length());
	}
	
	//글수정
	@PostMapping("/modify")
	public String modify(FreeBoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr
			,@CookieValue("userId") String userId, @CookieValue("userNick") String userNick) {
		log.info("modify: "+ board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "seccess");
		}
		return "redirect:/freeboard/list" + cri.getListLink();
	}
	
	//글삭제
	@PostMapping("/remove")
	public String remove(@RequestParam("no") Long no, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr
			,@CookieValue("userId") String userId, @CookieValue("userNick") String userNick) {
		log.info("remove..." + no);
		if(service.remove(no)) {
			rttr.addFlashAttribute("result", "seccess");
		}
		return "redirect:/freeboard/list"+ cri.getListLink();
	}
	
	//좋아요 
	@ResponseBody
	@PostMapping(value="getLike", produces="application/json; charset-utf8")
	public String getLike(FreeLikeVO like){
		int resultNum = service.getLike(like);
		log.info(resultNum);
		return Integer.toString(resultNum);
	}
	@ResponseBody
	@PostMapping(value="addLike", produces="application/json; charset-utf8")
	public String addLike(FreeLikeVO like){
		int resultNum = service.addLike(like);
		log.info(resultNum);
		return Integer.toString(resultNum);
	}
	@ResponseBody
	@PostMapping(value="deleteLike", produces="application/json; charset-utf8")
	public String deleteLike(FreeLikeVO like){
		int resultNum = service.deleteLike(like);
		log.info(resultNum);
		return Integer.toString(resultNum);
	}
	
	   // 파일 업로드
	   @ResponseBody
	   @PostMapping(value="/uploadFile", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	   public String uploadFile(FreeFileVO freeFileVO, MultipartFile file, 
			   @CookieValue("userId") String id)throws IOException, InterruptedException {
		   
	      log.info("name : " + file.getOriginalFilename());
	      log.info("size : " + file.getSize());
	      log.info("contentType : " + file.getContentType());
	      String folderPath = "/home/parkingq/upload/freeboard";
	      
	      File destdir = new File(folderPath); 
	      
	      if(!destdir.exists()){
	         destdir.mkdirs();
	         }
	      
	      UUID uuid = UUID.randomUUID();
	      
	      String saveName = uuid.toString() + "_" + file.getOriginalFilename();
	      
	      @SuppressWarnings("deprecation")
	      String uploadPath = "/home/parkingq/upload/freeboard/";
	      log.info(uploadPath);
	      
	      File target = new File(uploadPath, saveName);
	      FileCopyUtils.copy(file.getBytes(), target);
	      Runtime.getRuntime().exec("chmod 644 "+uploadPath + saveName);
	      
	      return saveName;
	   }
	   
	   
	   //----------------------------------------------------------------------------------
	   
	   
	   //mobile 페이지
		@GetMapping("/mlist")
		public String mlist(Model model, Criteria cri, FreeLikeVO like, FreeFileVO file,
				@CookieValue(value="userId", required=false) String userId, @CookieValue("userNick") String userNick){
			
			if( userId == null ) {
				model.addAttribute("msg","로그인 정보가 없습니다.");
				model.addAttribute("movePath","/common/login");
				return "common/message";
			}
			
			log.info("connect list >>>>>>>>>>>>>");
			log.info("list :"+ cri);
			model.addAttribute("id", userId);
			model.addAttribute("nick", userNick);
			int total = service.getTotal(cri);
			model.addAttribute("list", service.getList(cri));
			model.addAttribute("pageMaker", new PagingDTO(cri, total));
			model.addAttribute("best", service.getBestList());
			
			return "/common/mFreeList";
		}
	   
		@GetMapping("/mGet")
		public String mGet(@RequestParam("no") Long no, @ModelAttribute("cri") Criteria cri, Model model, FreeLikeCountVO likeCnt
				,@CookieValue(value="userId", required=false) String userId, @CookieValue("userNick") String userNick) {
			
			if( userId == null ) {
				model.addAttribute("msg","로그인 정보가 없습니다.");
				model.addAttribute("movePath","/common/login");
				return "common/message";
			}
			
			log.info(no);
			likeCnt.setId(userId);
			likeCnt.setNo(no);
			model.addAttribute("userId",userId);
			model.addAttribute("board", service.getBoard(likeCnt));
			
			return "/common/mFreeGet";
		}
	   
}











