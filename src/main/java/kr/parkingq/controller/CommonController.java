package kr.parkingq.controller;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.parkingq.domain.admin.AdminMemberVO;
import kr.parkingq.domain.admin.AlarmVO;
import kr.parkingq.domain.freeboard.FreeBoardVO;
import kr.parkingq.domain.freeboard.FreeCommentVO;
import kr.parkingq.domain.member.ConnectLogVO;
import kr.parkingq.domain.message.MessageVO;
import kr.parkingq.domain.reviewboard.PagingVO;
import kr.parkingq.domain.reviewboard.ReviewScoreVO;
import kr.parkingq.service.admin.AdminService;
import kr.parkingq.service.freeboard.FreeBoardService;
import kr.parkingq.service.freeboard.FreeCommentService;
import kr.parkingq.service.member.MemberService;
import kr.parkingq.service.message.MessageService;
import kr.parkingq.service.reviewboard.ReviewBoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class CommonController {

	private MessageService service;
	private ReviewBoardService reviewService;
	private AdminService adminService;
	private FreeBoardService freeService;
	private MemberService memberService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String login() {
		log.info("move login page");
		return "common/login";
	}

	@GetMapping("/common/test1")
	public void test1() {
		log.info("move test1");
	}

	@GetMapping("/common/test2")
	public void test2() {
		log.info("move test2");
	}

	/* @GetMapping("/common/main") */
	public String main(HttpSession session, Model model, @CookieValue(value = "userId", required = false) String id) {

		if (id == null) {
			model.addAttribute("msg", "로그인 정보가 없습니다");
			model.addAttribute("movePath", "/common/login");
			return "common/message";
		}

		// 평가 그래프..................................
		PagingVO pg = new PagingVO(1, 10);
		int total = reviewService.getTotal(pg);
		ReviewScoreVO getScore = reviewService.getScore();
		model.addAttribute("chart", getScore);
		model.addAttribute("total", total);
		// .........................................

		// 최근 가입자..................................
		ArrayList<AdminMemberVO> member = adminService.getLimitMember();
		model.addAttribute("member", member);
		// .........................................

		// 최근 게시물..................................
		ArrayList<AlarmVO> alarm = adminService.getMainLimitAlarm();
		model.addAttribute("alarm", alarm);
		// .........................................

		// 평가 그래프..................................
		ArrayList<MessageVO> message = adminService.getLimitMessage();
		model.addAttribute("message", message);
		// .........................................

		// 베스트 게시글..................................
		ArrayList<FreeBoardVO> bestFree = freeService.getBestList5();
		model.addAttribute("best", bestFree);
		// .........................................

		model.addAttribute("id", id);
		session.getAttribute("");
		log.info("move main page");

		return "/common/main";
	}

	@GetMapping("/common/mmain")
	public String mmain(Model model, @RequestParam(value = "android", required = false) String android,
			HttpServletResponse response) {
		
		if ( android == null ) {
			android = "false";
		} else if (android.equals("true")) {
			Cookie androidCookie = new Cookie("android", android);
			int maxAge = 60 * 60 * 24;
			androidCookie.setMaxAge(maxAge);
			androidCookie.setPath("/");
			response.addCookie(androidCookie);
		}

		model.addAttribute("android", android);
		log.info("move mmain page");
		return "common/mmain";
	}

	@GetMapping("/common/mmessage")
	public void mmessage() {
		log.info("move mmessage page");
	}

	@GetMapping("/common/message")
	public void message() {
		log.info("move message page");
	}

	@GetMapping("/common/testlike")
	public void testlike() {
		log.info("move testlike page");
	}

	@GetMapping("/common/exmaple")
	public String example() {
		log.info("move example page");
		return "common/mobile-example";
	}
	
	
	@GetMapping("/push/*")
	public String push(HttpServletRequest request) throws IOException {
		log.info("move push page");
		
		String uri = request.getRequestURI();
		int conPath = uri.lastIndexOf("/") + 1;
		String command = uri.substring(conPath);
		System.out.println(command);
		
		if ( !command.equals("") ) {
			makeFile("1");
		}
		return "common/mmessage";
	}
	
	@GetMapping("/clean")
	public void clean(HttpServletRequest request) throws IOException {
		log.info("move clean page");
		makeFile("0");
	}
	
	public void makeFile(String message) throws IOException {
		File file = new File("/home/parkingq/upload/file/push.txt");
		FileWriter writer = null;
		try {
			writer = new FileWriter(file, false);
			writer.write(message);
			writer.flush();
			System.out.println("DONE");
		} catch ( Exception e ) {
			e.printStackTrace();
		} finally {
			try {
				Runtime.getRuntime().exec("chmod 644 "+"/home/parkingq/upload/file/push.txt");
				if ( writer != null ) writer.close();
			} catch ( IOException e ) {
				e.printStackTrace();
			}
		}
	}

	@GetMapping("/common/main")
	public String main(Model model, @CookieValue(value = "userId", required = false) String id) {
		log.info("move main page");

		if (id == null) {
			model.addAttribute("msg", "로그인 정보가 없습니다");
			model.addAttribute("movePath", "/common/login");
			return "common/message";
		}

		ArrayList<ConnectLogVO> list = memberService.getConntectUserImage();
		log.info("메인 유저 목록 리스트 : " + list);

		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getId().length() > 6) {
				list.get(i).setId(list.get(i).getId().substring(0, 6) + "...");
			}
		}

		model.addAttribute("userList", list);

		return "common/index";
	}

	@GetMapping("/freeboard/example")
	public String freeexample() {
		log.info("move exmple");
		return "freeboard/example";
	}
	
	@GetMapping("/common/messagecar")
	public void messagecar() {
		log.info("move messagecar");
	}

}
