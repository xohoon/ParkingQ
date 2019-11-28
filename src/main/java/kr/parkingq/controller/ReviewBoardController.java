package kr.parkingq.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.parkingq.domain.reviewboard.MPageDTO;
import kr.parkingq.domain.reviewboard.PageDTO;
import kr.parkingq.domain.reviewboard.PagingVO;
import kr.parkingq.domain.reviewboard.ReviewBoardVO;
import kr.parkingq.domain.reviewboard.ReviewFileVO;
import kr.parkingq.domain.reviewboard.ReviewScoreVO;
import kr.parkingq.service.reviewboard.ReviewBoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/reviewboard/*")
public class ReviewBoardController {
	
	private ReviewBoardService service;
	
	// add Cookie data Get
		@GetMapping("/test")
		public void test(@CookieValue(value="userId",required=false) String id, @CookieValue(value="userNick",required=false) String nick, Model model) {
			
			model.addAttribute("id",id);
			model.addAttribute("nick",nick);
		}
		
	@GetMapping("/list")
	public String list(@CookieValue(value="userId",required=false) String id,Model model) {
		if(id==null) {
			model.addAttribute("msg","로그인 정보가 없습니다"	);
			model.addAttribute("movePath","/common/login");
			return "common/message";
		}
		return "redirect:/reviewboard/list/main";
	}
	
	@GetMapping("/mlist")
	public String mlist(PagingVO pg, Model model,@CookieValue(value="userId",required=false) String id, 
			String result) {
		
		if(id==null) {
			model.addAttribute("msg","로그인 정보가 없습니다"	);
			model.addAttribute("movePath","/common/login");
			return "common/message";
		}
		
		int total=service.getTotal(pg);
		ReviewScoreVO getScore = service.getScore();
		List<ReviewBoardVO> getList = null;	
		getList = service.getMList(pg);

		model.addAttribute("id", id);
		model.addAttribute("chart", getScore);
		model.addAttribute("list", getList);
		model.addAttribute("pageMaker", new MPageDTO(pg, total));
		
		if(result!=null) {				
			model.addAttribute("result", result);
		}
		return "/common/mReviewList";
	}
	
	//listPage실행
	@GetMapping("/list/{align}")
	public String list(PagingVO pg, Model model,@CookieValue(value="userId",required=false) String id, 
			@CookieValue(value="userNick",required=false) String nick,@PathVariable("align") String align,
			String result) {

		if(id==null) {
			model.addAttribute("msg","로그인 정보가 없습니다"	);
			model.addAttribute("movePath","/common/login");
			return "common/message";
		}
		
		int total=0;
		pg.setId(id);
		ReviewScoreVO getScore = null;
		List<ReviewBoardVO> getList = null;
		
		//일반 게시판 정렬
		if(align.equals("main")) {
			
			getList = service.getList(pg);
			total=service.getTotal(pg);
			getScore = service.getScore();
			
			if(getList==null) {
				return "게시물이 없습니다";
			}
			model.addAttribute("list", getList);
			model.addAttribute("id", id);
			model.addAttribute("nick", nick);	
			model.addAttribute("chart", getScore);
			model.addAttribute("total", total);
			model.addAttribute("pageMaker", new PageDTO(pg, total));
			model.addAttribute("check",1);
			System.out.println("controller에서의 result값 : " + result);
			if(result!=null) {				
				model.addAttribute("result", result);
			}
		}
		
		//좋아요 정렬
		if(align.equals("goodsList")) {
			
			total=service.getTotal(pg);
			getScore = service.getScore();
			getList = service.getGoodsList(pg);
			
			if(getList==null	) {
				return "게시물이 없습니다";
			}
			model.addAttribute("list", getList);
			model.addAttribute("chart", getScore);
			model.addAttribute("id", id);
			model.addAttribute("nick", nick);
			model.addAttribute("total", total);
			model.addAttribute("pageMaker", new PageDTO(pg, total));
			model.addAttribute("check",0);
		}
		
		//별점 높은 순 정렬
		if(align.equals("highStar")) {
			
			total=service.getTotal(pg);
			getScore = service.getScore();
			getList = service.getHighStarList(pg);
			
			if(getList == null) {
				return "게시물이 없습니다";
			}
			model.addAttribute("list", getList);
			model.addAttribute("chart", getScore);
			model.addAttribute("id", id);
			model.addAttribute("nick", nick);
			model.addAttribute("total", total);
			model.addAttribute("pageMaker", new PageDTO(pg, total));
			model.addAttribute("check",-1);
		}
		
		//별점 낮은 순 정렬
		if(align.equals("lowStar")) {
			
			total=service.getTotal(pg);
			getScore = service.getScore();
			getList = service.getLowStarList(pg);
			
			if(getList == null) {
				return "게시물이 없습니다";
			}
			model.addAttribute("list", getList);
			model.addAttribute("chart", getScore);
			model.addAttribute("id", id);
			model.addAttribute("nick", nick);
			model.addAttribute("total", total);
			model.addAttribute("pageMaker", new PageDTO(pg, total));
			model.addAttribute("check",-2);
		}
		
		
		
		
		return "reviewboard/list";
	}
	
	
	//레지스터 화면이동
	/*@GetMapping("/register")
	public void register(Model model,@CookieValue("userId") String id) {
		model.addAttribute("id", id);
	}*/
	
	
	@PostMapping("/register")
	public String register(HttpServletRequest request, ReviewBoardVO board, Model model, RedirectAttributes rttr, @CookieValue("userId") String id,@CookieValue("userNick") String nick) {
		
		board.setId(id);
		board.setNick(nick);
		System.out.println("rfile : " + board.getRfile());
		if(board.getRfile()==null||board.getRfile().equals("")) {
			board.setRfile("noImg");
		}
		System.out.println("rfile : " + board.getRfile());
		service.register(board);
		rttr.addAttribute("registerCheck", 1);
		rttr.addAttribute("result","success");
		request.setAttribute("registerCheck", 1);
		return "redirect:/reviewboard/list/main";
		
	}

	@PostMapping("/getComment")
	@ResponseBody
	public String getComment(@RequestParam("no") int no,Model model) {
		System.out.println("no의 값은 : " + no);
		int commentCount = service.getComment(no);
		System.out.println("commentCount의 값은 : " + commentCount);
		model.addAttribute("result",commentCount);
		return Integer.toString(commentCount);
	}
	
	
	//===================================dropDown==================================================
	
	// Image upload
	   @ResponseBody
	   @PostMapping(value="/uploadFile", produces = "application/text; charset=utf8")
	   public String uploadFile(ReviewFileVO reviewfile, MultipartFile file) throws IOException, InterruptedException {
		  
/*	      String folderPath = "/home/parkingq/upload/reviewboard";*/
		  String folderPath = "/home/parkingq/upload/reviewboard";
	      File destdir = new File(folderPath); 
	      
	      if(!destdir.exists()){
	         destdir.mkdirs();
	      }
	      UUID uuid = UUID.randomUUID();
	      String origName;
	      origName=file.getOriginalFilename();

	      String saveName = uuid.toString() + "_" + origName;
	      
	      @SuppressWarnings("deprecation")
/*	      String uploadPath = "C:/upload/reviewboard/";*/
	      String uploadPath = "/home/parkingq/upload/reviewboard/";
	      
	      File target = new File(uploadPath, saveName);
	      
	      FileCopyUtils.copy(file.getBytes(), target);
	      System.out.println("chmod 644 "+uploadPath + saveName);
	      Runtime.getRuntime().exec("chmod 644 "+uploadPath + saveName);
	      
	      return saveName;
	   }
	//===============================================================================================
	
	@GetMapping({"/info","/modify"})
	public void get(@RequestParam("no") Long no, @ModelAttribute("pg") PagingVO pg, Model model) {
		
		model.addAttribute("reviewboard", service.get(no));
	}
	
	@GetMapping("/mReviewGet")
	public String mGet(@RequestParam("no") Long no, @ModelAttribute("pg") PagingVO pg, Model model) {
		
		model.addAttribute("reviewboard", service.get(no));
		return "common/mReviewGet";
	}
	
	@PostMapping("/modify")
	public String modify(ReviewBoardVO board,@ModelAttribute("pg") PagingVO pg, RedirectAttributes rttr) {
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", pg.getPageNum());
		rttr.addAttribute("amount", pg.getAmount());
		return "redirect:/reviewboard/list";
	}
	
	
	
	@PostMapping("/remove")
	public String remove(@RequestParam("realId") String realId, @RequestParam("no") Long no,
			@ModelAttribute("pg") PagingVO pg, RedirectAttributes rttr,@CookieValue("userId") String id) {
		if(realId.equals(id)) {
			service.removeComment(no);
			if(service.remove(no)) {
				rttr.addFlashAttribute("result","remove success");
			}
			rttr.addAttribute("pageNum", pg.getPageNum());
			rttr.addAttribute("amount", pg.getAmount());
		}else {
			rttr.addFlashAttribute("result","remove fail");
			rttr.addAttribute("pageNum", pg.getPageNum());
			rttr.addAttribute("amount", pg.getAmount());
		}
		
		return "redirect:/reviewboard/list/main";
	}
	//좋아요
	/*@PostMapping("/addGoods")
	public void addGoods(@RequestParam("no") Long no, @ModelAttribute("rlv") ReviewLikeVO rlv) {
		service.addGoods(no, rlv);
	}*/
	
	
}
