package kr.parkingq.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

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

import kr.parkingq.domain.meetboard.MeetBoardVO;
import kr.parkingq.domain.meetboard.MeetCriteria;
import kr.parkingq.domain.meetboard.MeetFileVO;
import kr.parkingq.domain.meetboard.MeetLikeCountVO;
import kr.parkingq.domain.meetboard.MeetLikeVO;
import kr.parkingq.domain.meetboard.MeetMemberVO;
import kr.parkingq.domain.meetboard.MeetPageDTO;
import kr.parkingq.service.meetboard.MeetBoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/meetboard/*")
@AllArgsConstructor
public class MeetBoardController {
	
	private MeetBoardService service;
	
	// add Cookie data Get
	@GetMapping("/test")
	public void test(@CookieValue("userId") String id, @CookieValue("userNick") String nick) {
		log.info("Cookie ID : " + id);
		log.info("Cookie Nick : " + nick);

	}
	
	@GetMapping("/list")
	public String list(MeetCriteria cri, Model model, @CookieValue(value="userId", required=false) String id, @CookieValue(value="userNick", required=false) String nick) {
		
		if(id == null) {
			model.addAttribute("msg", "로그인 정보가 없습니다.");
			model.addAttribute("movePath", "/");
			
			return "common/message";
		}
		
		log.info("list--------controller-------"+cri);
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		log.info("total------controller------>>>>>" + total);
		model.addAttribute("pageMaker", new MeetPageDTO(cri, total));
		
		log.info("Cookie ID : " + id);
		log.info("Cookie Nick : " + nick);
		
		return "meetboard/list";
	}
	
	@GetMapping("/register")
	public void register(@CookieValue("userId") String id, @CookieValue("userNick") String nick) {
		
		log.info("Cookie ID------- : " + id);
		log.info("Cookie Nick---------- : "+ nick);

		
	}
	
	// Board Info register (include File text name info, google map location info)
	@PostMapping("/register")
	public String register(MeetBoardVO board, Model model, RedirectAttributes rttr, @CookieValue(value="userId", required=false) String id, @CookieValue(value="userNick", required=false) String nick) {
		
		if(id == null) {
			model.addAttribute("msg", "로그인 정보가 없습니다.");
			model.addAttribute("movePath", "/");
			
			return "common/message";
		}
		
		String path = null;
		String resultText = null;
		
		log.info("register : " + board);
		board.setId(id);
		board.setNick(nick);
		System.out.println(">>>>>>>>>>>>controller>>>>>>>>>>>"+board.getId());
		
		if(board.getMfile() == "") {
			board.setMfile("uploadplease.gif");
		}
		service.register(board);
		System.out.println(">>>file test>>>>>-----controller------"+board);

		rttr.addFlashAttribute("result", board.getNo());
		
		path = "redirect:/meetboard/list";
		
		/*
		String str = board.getMdate();
		String dateA = str.substring(1, 10);
		System.out.println("dataaaaaaa>>>>>>>>>>>"+dateA);
		board.setMdate(dateA);
		*/
		
		return path;
	}
	
	
	
	
	// modify
	@PostMapping("/modify")
	public String modify(@RequestParam("no") Long no, MeetBoardVO board,@ModelAttribute("cri") MeetCriteria cri, RedirectAttributes rttr) {
		log.info("modify---------------------controller-------------"+board);
		log.info(board.getId()+board.getMfile()+",,,,,,,,,,,,,,,,,,,,,");
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/meetboard/list" + cri.getListLink();
	}

	
	// remove
	@PostMapping("/remove")
	public String remove(@RequestParam("no") Long no, MeetCriteria cri, RedirectAttributes rttr) {
		
		log.info("remove--------controller------"+no);
		
		if(service.remove(no)) {
			rttr.addFlashAttribute("result", "success");
		}
			
		return "redirect:/meetboard/list" + cri.getListLink();
	}
	
	
	// Image upload
	@ResponseBody
	@PostMapping(value="/uploadFile",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String uploadFile(MeetFileVO meetfile, MultipartFile file, @CookieValue("userId") String id) throws IOException, InterruptedException {
		log.info("name : " + file.getOriginalFilename());
		log.info("size : " + file.getSize());
		log.info("contentType : " + file.getContentType());
		
		String folderPath = "/home/parkingq/upload/meetboard/";
		
		File destdir = new File(folderPath); 
		
		if(!destdir.exists()){
			destdir.mkdirs();
		}
				
		UUID uuid = UUID.randomUUID();
		String saveName = uuid.toString() + "_" + file.getOriginalFilename();
		
		@SuppressWarnings("deprecation")
		String uploadPath = "/home/parkingq/upload/meetboard/";
		
		log.info(uploadPath);
		
		File target = new File(uploadPath, saveName);
		
		FileCopyUtils.copy(file.getBytes(), target);
		Runtime.getRuntime().exec("chmod 644 "+uploadPath + saveName);

		return saveName;
	}

	// Board List get
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("no") Long no, MeetLikeCountVO likeCount, @ModelAttribute("cri") MeetCriteria cri, Model model, @CookieValue("userId") String id, @CookieValue("userNick") String nick) {
		log.info("/get or modify");
		likeCount.setId(id);
		likeCount.setNo(no);
		model.addAttribute("board", service.get(likeCount));

		log.info("Cookie ID: " + id);
		log.info("Cookie Nick : "+ nick);
	}
	
	// Groupmember join user check
	@ResponseBody
	@PostMapping(
			value="getJoin",
			produces="application/json; charset=utf-8"
			)
	public String getJoin(MeetMemberVO member) {
		int resultNum = service.getJoin(member);
		log.info("getJoin testestestes>>controller>"+resultNum);
		
		return Integer.toString(resultNum);
	}
	
	// Group Join count
	@ResponseBody
	@PostMapping(
			value="/countJoin",
			produces="application/json; charset=utf-8"
			)
	public int countJoin(MeetMemberVO member) {
		int resultNum = service.countJoin(member);
		log.info("countJoincountJoincountJoincountJoin>>>>>>"+resultNum);
		
		return resultNum;
	}
	
	// Groupmember user join
	@ResponseBody
	@PostMapping(
			value="insertJoin",
			produces="application/json; charset=utf-8"
			)
	public String insertJoin(MeetMemberVO member) {
		int resultNum = service.insertJoin(member);
		log.info("insertJoin testestestes>>controller>"+resultNum);
		
		return Integer.toString(resultNum);
	}
	
	// Groupmember user out
	@ResponseBody
	@PostMapping(
			value="deleteJoin",
			produces="application/json; charset=utf-8"
			)
	public String deleteJoin(MeetMemberVO member) {
		int resultNum = service.deleteJoin(member);
		log.info("deleteJoin testestestes>>controller>"+resultNum);
		
		return Integer.toString(resultNum);
	}
	
	// Board Like get Num
	@ResponseBody
	@PostMapping(
			value="/getLike",
			produces="application/json; charset=utf-8"
			)
	public String getLike(MeetLikeVO like) {
		
		int resultNum = service.getLike(like);
		log.info("getLike resultNum>>>controller>>>>"+resultNum);
		
		return Integer.toString(resultNum);
	}
	
	// Board Like count
	@ResponseBody
	@PostMapping(
			value="/countLike",
			produces="application/json; charset=utf-8"
			)
	public int countLike(MeetLikeVO like) {
		int resultNum = service.countLike(like);
		log.info("count like count likecount likecount likecount like>>>>"+resultNum);
		
		return resultNum;
	}
	
	// Board like insert
	@ResponseBody
	@PostMapping(
			value="/insertLike",
			produces="application/json; charset=utf-8"
			)
	public String insertLike(MeetLikeVO like) {
		
		int resultNum = service.insertLike(like);
		log.info("insertLike resultNum>>>>controller>>>"+resultNum);
		
		return Integer.toString(resultNum);
	}
	
	// Board like delete
	@ResponseBody
	@PostMapping(
			value="/deleteLike",
			produces="application/json; charset=utf-8"
			)
	public String deleteLike(MeetLikeVO like) {
		
		int resultNum = service.deleteLike(like);
		log.info("deleteLike resultNum>>>>controller>>>"+resultNum);
		
		return Integer.toString(resultNum);
	}
	
	
	
	// Mobile mlist page
	@GetMapping("/mMeetList")
	public String mMeetList(MeetCriteria cri, Model model, @CookieValue(value="userId", required=false) String id, @CookieValue("userNick") String nick) {
		
		if(id == null) {
			model.addAttribute("msg", "로그인 정보가 없습니다.");
			model.addAttribute("movePath", "/common/login");
			
			return "common/message";
		}
		
		log.info("list--------controller-------"+cri);
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		log.info("total------controller------>>>>>" + total);
		model.addAttribute("pageMaker", new MeetPageDTO(cri, total));
		
		log.info("Cookie ID : " + id);
		log.info("Cookie Nick : " + nick);
		
		return "common/mMeetList";
	}
	
	
	
	// Mobile mget page
	@GetMapping("/mMeetGet")
	public String mMeetGet(@RequestParam("no") Long no, MeetLikeCountVO likeCount, @ModelAttribute("cri") MeetCriteria cri, Model model, @CookieValue(value="userId", required=false) String id, @CookieValue("userNick") String nick) {
		
		if(id == null) {
			model.addAttribute("msg", "로그인 정보가 없습니다.");
			model.addAttribute("movePath", "/common/login");
			
			return "common/message";
		}
		
		log.info("/mget");
		likeCount.setId(id);
		likeCount.setNo(no);
		model.addAttribute("board", service.get(likeCount));

		log.info("Cookie ID: " + id);
		log.info("Cookie Nick : "+ nick);
		
		return "common/mMeetGet";
	}
	
	
}
