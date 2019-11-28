package kr.parkingq.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.parkingq.domain.admin.AdminBoardVO;
import kr.parkingq.domain.admin.AdminMemberVO;
import kr.parkingq.domain.admin.AlarmVO;
import kr.parkingq.domain.admin.ChartVO;
import kr.parkingq.domain.message.MessageVO;
import kr.parkingq.service.admin.AdminService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/*")
@Controller
@AllArgsConstructor
public class AdminController {

	private AdminService service;

	@GetMapping("main")
	public String main(Model model, @CookieValue(value="userId", required=false) String userId) {
		log.info("move admin-main");
		if( userId == null ) {
			model.addAttribute("msg","로그인 정보가 없습니다.");
			model.addAttribute("movePath","/common/login");
			return "common/message";
		} else if ( service.getCheckAdmin(userId).equals("normal") ) {
			model.addAttribute("msg","관리자만 접근 가능 합니다.");
			model.addAttribute("movePath","/common/main");
			return "common/message";
		}
		int memberCount = service.getWeekCountMember();
		int boardCount = service.getBoardCount();
		int messageTotalCount = service.getMessageTotalCount();
		ArrayList<AdminMemberVO> member = service.getLimitMember();
		ArrayList<MessageVO> message = service.getLimitMessage();
		ArrayList<AlarmVO> alarm = service.getLimitAlarm();
		model.addAttribute("memberCount",memberCount);
		model.addAttribute("boardCount",boardCount);
		model.addAttribute("messageCount",messageTotalCount);
		model.addAttribute("member", member);
		model.addAttribute("alarm", alarm);
		model.addAttribute("message", message);
		return "admin/main";
	}

	@GetMapping("board")
	public String board(Model model, @CookieValue(value="userId", required=false) String userId) {
		log.info("move admin-board");
		if( userId == null ) {
			model.addAttribute("msg","로그인 정보가 없습니다.");
			model.addAttribute("movePath","/common/login");
			return "common/message";
		} else if ( service.getCheckAdmin(userId).equals("normal") ) {
			model.addAttribute("msg","관리자만 접근 가능 합니다.");
			model.addAttribute("movePath","/common/main");
			return "common/message";
		}
		ArrayList<AlarmVO> list = service.getAllBoard();
		int boardCount = service.getBoardCount();
		model.addAttribute("list",list);
		model.addAttribute("boardCount",boardCount);
		return "admin/board";
	}

	@GetMapping("message")
	public String message(Model model, @CookieValue(value="userId", required=false) String userId) {
		log.info("move admin-message");
		if( userId == null ) {
			model.addAttribute("msg","로그인 정보가 없습니다.");
			model.addAttribute("movePath","/common/login");
			return "common/message";
		} else if ( service.getCheckAdmin(userId).equals("normal") ) {
			model.addAttribute("msg","관리자만 접근 가능 합니다.");
			model.addAttribute("movePath","/common/main");
			return "common/message";
		}
		ArrayList<MessageVO> message = service.getAllMessage();
		int messageTotalCount = service.getMessageTotalCount();
		model.addAttribute("list",message);
		model.addAttribute("messageCount",messageTotalCount);
		return "admin/message";
	}

	@GetMapping("member")
	public String admin(Model model, @CookieValue(value="userId", required=false) String userId) {
		log.info("move admin-memer");
		if( userId == null ) {
			model.addAttribute("msg","로그인 정보가 없습니다.");
			model.addAttribute("movePath","/common/login");
			return "common/message";
		} else if ( service.getCheckAdmin(userId).equals("normal") ) {
			model.addAttribute("msg","관리자만 접근 가능 합니다.");
			model.addAttribute("movePath","/common/main");
			
			return "common/message";
		}
		ArrayList<AdminMemberVO> list = new ArrayList<AdminMemberVO>();
		list = service.getMember();
		model.addAttribute("memberList", list);
		return "admin/member";
	}

	@ResponseBody
	@PostMapping("updateAuth")
	public String updateAuth(AdminMemberVO member) {
		int resultNum = service.updateAuth(member);
		return Integer.toString(resultNum);
	}

	@ResponseBody
	@PostMapping("getAuth")
	public String getAuth(@RequestParam("id") String id) {
		String resultType = service.getAuth(id);
		return resultType;
	}

	@ResponseBody
	@PostMapping("deleteUser")
	public String deleteUser(@RequestParam("id") String id) {
		int resultNum = service.deleteUser(id);
		return Integer.toString(resultNum);
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping(value="getMemberInfo", produces = "application/json; charset=utf8")
	public String getMemberInfo(@RequestParam("id") String id ) {
		AdminMemberVO adminMember = service.getMemberInfo(id);
		JSONObject member = new JSONObject();
		member.put("id", adminMember.getId());
		member.put("pass", adminMember.getPass());
		member.put("nick", adminMember.getNick());
		member.put("email", adminMember.getEmail());
		member.put("mDate", adminMember.getMDate());
		member.put("key", adminMember.getKey());
		return member.toString();
	}

	@ResponseBody
	@PostMapping("updateMember")
	public String updateMember(AdminMemberVO adminMember) {
		int resultNum = service.updateMember(adminMember);
		return Integer.toString(resultNum);
	}

	@ResponseBody
	@PostMapping("getWeekCountMember")
	public String getWeekCountMember() {
		return Integer.toString(service.getWeekCountMember());
	}
	
	@ResponseBody
	@PostMapping("deleteMessage")
	public String deleteMessage(@RequestParam("no") long no) {
		return Integer.toString(service.deleteMessage(no));
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("getBoard")
	public String getBoard(AlarmVO alarm) {
		AlarmVO content = new AlarmVO();
		content = service.getBoard(alarm);
		
		JSONObject result = new JSONObject();
		result.put("aNo", content.getAno());
		result.put("id", content.getId());
		result.put("type", content.getType());
		result.put("subject", content.getSubject());
		result.put("content", content.getContent());
		result.put("aDate", content.getADate());
		return result.toString();
	}
	
	@ResponseBody
	@PostMapping(value="updateBoard", produces = "application/json; charset=utf8")
	public String updateBoard(AlarmVO alarm) {
		return Integer.toString(service.updateBoard(alarm));
	}
	
	@ResponseBody
	@PostMapping("deleteBoard")
	public String deleteBoard(AlarmVO alarm) {
		return Integer.toString(service.deleteBoard(alarm));
	}
	
	
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping(value="getMemberChart", produces = "application/json; charset=utf8")
	public String getMemberChart() {
		ArrayList<ChartVO> list = service.getMemberChart();
		log.info(list);
		
		JSONObject result = new JSONObject();
		JSONArray array = new JSONArray();
		
		for ( int i=0; i<list.size(); i++ ) {
			JSONObject value = new JSONObject();
			value.put("tDate", list.get(i).getTDate());
			value.put("visitCount", list.get(i).getVisitCount());
			value.put("memberCount", list.get(i).getMemberCount());
			value.put("messageCount", list.get(i).getMessageCount());
			array.add(value);
		}
		result.put("result", array);
		
		log.info(result.toString());
		
		
		return result.toString();
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping(value="getBoardChart", produces = "application/json; charset=utf8")
	public String getBoardChart() {
		ChartVO chart = service.getBoardChart();
		log.info(chart);
		JSONObject result = new JSONObject();
		result.put("freeCount", chart.getFreeCount());
		result.put("meetCount", chart.getMeetCount());
		result.put("infoCount", chart.getInfoCount());
		result.put("reviewCount", chart.getReviewCount());
		
		return result.toString();
	}
	
	@ResponseBody
	@PostMapping(value="testValue")
	public String testValue(@RequestParam HashMap<String, Object> map) {
		log.info("test1 : " + map.get("test1"));
		log.info("test2 : " + map.get("test2"));
		log.info("test3 : " + map.get("test3"));
		return"";
	}
	
	
	
}
