package kr.parkingq.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

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

import kr.parkingq.domain.member.ConnectLogVO;
import kr.parkingq.domain.message.LikeVO;
import kr.parkingq.domain.message.MessageVO;
import kr.parkingq.service.member.MemberService;
import kr.parkingq.service.message.MessageService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/message/*")
@Controller
@AllArgsConstructor
public class MessageController {

	
	private MessageService service;
	private MemberService MemberService;
	
	@GetMapping("test")
	public void test() {
	}
	
	
	@GetMapping("messageInForm")
	public void messageInForm(/*@RequestParam("toId") String toId,*/ Model model) {
		log.info("move messageInForm");
	}
	
	
	// 메세지 전송
	@ResponseBody
	@PostMapping("submit")
	public String MessageSubmit(@RequestParam("type") String type, @RequestParam("id") String id, @RequestParam("toId") String toId, @RequestParam("content") String content) throws IOException {
		String checkNum = null;
		int messageResultNum;
		
		if ( type == null || type.equals("") ||  id == null || id.equals("") || toId == null || toId.equals("") || content == null || content.equals("") ) {
			checkNum = "0";
		}
		else if ( id.equals(toId) ) {
			checkNum = "-1";
		}
		else {
			type = URLDecoder.decode(type, "UTF-8");
			id = URLDecoder.decode(id, "UTF-8");
			toId = URLDecoder.decode(toId, "UTF-8");
			content = URLDecoder.decode(content, "UTF-8");
			
			MessageVO message = new MessageVO();
			message.setType(type);
			message.setId(id);
			message.setToId(toId);
			message.setContent(content);
			
			messageResultNum = service.insertMessage(message);
			log.info("messageResultNum : " + messageResultNum);
			if ( messageResultNum == 1 ) {
				checkNum = "1";
			} else {
				checkNum = "-2";
			}
			log.info("MessageSubmit checkNum : " + checkNum);
		}
		return checkNum;
	}
	
	
	// 메세지 조회
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping(value="getMessage", produces = "application/json; charset=utf8")
	public String getMessage(MessageVO message) {
		ArrayList<MessageVO> messageList = new ArrayList<MessageVO>();
		messageList = service.getMessage(message);
		
		// 메세지 조회 한 내용 JSON 변환
		JSONObject obj = new JSONObject();
		JSONArray array = new JSONArray();
		for (int i=0; i<messageList.size(); i++) {
			JSONObject value = new JSONObject();
			value.put("no", messageList.get(i).getNo());
			value.put("id", messageList.get(i).getId());
			value.put("type", messageList.get(i).getType());
			value.put("idFile", messageList.get(i).getIdFile());
			value.put("content", messageList.get(i).getContent());
			value.put("mDate", messageList.get(i).getMDate());
			array.add(value);
		}
		obj.put("result", array);
		
		return obj.toString();
	}
	
	
	// 받은 메세지 사용자 리스트
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping(value="getMessageMemberList", produces = "application/json; charset=utf8")
	public String getMessageMemberList(@CookieValue("userId") String id) {
		
		ArrayList<MessageVO> memberList = new ArrayList<MessageVO>();
		memberList = service.getMessageMemberList(id);
		ArrayList<ConnectLogVO> connectList = new ArrayList<ConnectLogVO>();
		connectList = MemberService.getConnectList();
		
		JSONObject obj = new JSONObject();
		JSONArray array = new JSONArray();
		for(int i=0; i<memberList.size(); i++) {
			JSONObject value = new JSONObject();
			value.put("id", memberList.get(i).getId());
			value.put("roomid", memberList.get(i).getRoomId());
			value.put("type", memberList.get(i).getType());
			value.put("content", memberList.get(i).getContent());
			value.put("pfile", memberList.get(i).getPFile());
			value.put("read", memberList.get(i).getRead());
			value.put("mdate", memberList.get(i).getMDate());
			
			boolean checkPoint = false;

			// check Connect User
			for ( int j=0;  j<connectList.size(); j++ ) {
				if(connectList.get(j).getId().equals(memberList.get(i).getId())) {
					value.put("connect", "on");
					checkPoint = true;
					break;
				} 
			}
			//log.info(">>>>>>>> " + i + " >>>>> " + checkPoint);
			
			array.add(value);
		}
		obj.put("result", array);
		
		log.info(obj.toString());
		
		return obj.toString();
	}
	
	
	// 메세지 삭제
	@ResponseBody
	@PostMapping(value="deleteMessage", produces = "application/json; charset=utf8")
	public String deleteMessage(MessageVO message) {
		
		log.info("deleteMessage >>>  " + message);
		int resultNum = service.deleteMessage(message);
		
		return Integer.toString(resultNum);
	}
	
	
	// 읽지 않은 메세지 카운트
	@ResponseBody
	@PostMapping(value="getUnReadMessage", produces = "application/json; charset=utf8")
	public int getUnReadMessage(@CookieValue("userId") String id ) {
		
		int resultNum = service.getUnReadCount(id);
		log.info("getUnReadMessage >>>  " + resultNum);
		return resultNum;
	}
	
	
	// 초대 메세지 삭제
	@ResponseBody
	@PostMapping(value="deleteInviteMessage", produces = "application/json; charset=utf8")
	public String deleteInviteMessage(@RequestParam("no") long no) {
		log.info("deleteInviteMessage >>  no : " + no);
		int resultNum = service.deleteInviteMessage(no);
		log.info("deleteInviteMessage >> resultNum : " + resultNum );
		return Integer.toString(resultNum);
	}
	
	@ResponseBody
	@PostMapping(value="getLike")
	public String getLike(LikeVO like) {
		int resultNum = service.getLike(like);
		log.info(resultNum);
		return Integer.toString(resultNum);
	}
	
	@ResponseBody
	@PostMapping(value="addLike")
	public String addLike(LikeVO like) {
		int resultNum = service.addLike(like);
		log.info(resultNum);
		return Integer.toString(resultNum);
	}
	
	@ResponseBody
	@PostMapping(value="deleteLike")
	public String deleteLike(LikeVO like) {
		int resultNum = service.deleteLike(like);
		log.info(resultNum);
		return Integer.toString(resultNum);
	}
	
	@ResponseBody
	@PostMapping(value="unReadCountById")
	public String unReadCountById(@RequestParam("id") String id) {
		int unReadCount = service.unReadCountById(id);
		return Integer.toString(unReadCount);
	}
	
	
}