
package kr.parkingq.controller;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.parkingq.domain.admin.AlarmVO;
import kr.parkingq.domain.member.AuthVO;
import kr.parkingq.domain.member.ConnectLogVO;
import kr.parkingq.domain.member.FriendVO;
import kr.parkingq.domain.member.MemberVO;
import kr.parkingq.domain.member.ProfileVO;
import kr.parkingq.domain.member.QrVO;
import kr.parkingq.domain.member.VisitVO;
import kr.parkingq.service.member.MemberService;
import kr.parkingq.utils.MD5Encryption;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/member/*")
@Controller
@AllArgsConstructor
public class MemberController {

	private MemberService service;

	@GetMapping("")
	public void doAll() {
		log.info("blank member");
	}

	@GetMapping("test")
	public void test(@CookieValue("userId") String userId, @CookieValue("userNick") String userNick) {
		log.info("쿠키 아이디 : " + userId);
		log.info("쿠키 닉네임 : " + userNick);

		log.info(service);
	}

	@GetMapping("message")
	public void message() {
		log.info("move message page");
	}

	/*
	 * @RequestMapping(value="loginAction", produces =
	 * "application/json;charset=utf8")
	 */

	// ajax 로그인 처리
	@ResponseBody
	@PostMapping("login")
	public String loginAction(MemberVO member, VisitVO visit, HttpServletResponse response, HttpSession session) {
		String checkNum = service.login(member);
		if (checkNum == "1") {
			int checkVisitNum = service.registerVisit(visit);
			log.info("MemberController >>> loginAction >>> register visit info : " + checkVisitNum);

			// 닉네임 가져오기
			log.info("getNickName : " + service.getMemberNick(member.getId()));
			member.setNick(service.getMemberNick(member.getId()));

			// 세션 등록
			session.setAttribute("userId", member.getId());
			session.setAttribute("userNick", member.getNick());

			// 쿠키 등록
			Cookie loginCookie = new Cookie("userId", member.getId());
			int maxAge = 60 * 60 * 24;
			loginCookie.setMaxAge(maxAge);
			loginCookie.setPath("/");
			response.addCookie(loginCookie);

			Cookie nickCookie = new Cookie("userNick", member.getNick());
			nickCookie.setMaxAge(maxAge);
			nickCookie.setPath("/");
			response.addCookie(nickCookie);

			log.info("MemberController >>> loginAction >>> set userId Cookie");

			service.getConnectList();
		}
		return checkNum;
	}

	// ajax 회원가입 처리
	@ResponseBody
	@PostMapping("join")
	public String joinAction(MemberVO member, AuthVO auth, ConnectLogVO connectLog, ProfileVO profile, QrVO qr,
			HttpSession session) {
		log.info("id : " + member.getId() + ", pass : " + member.getPass() + ", nick : " + member.getNick()
				+ ", email : " + member.getEmail());
		int checkNum = 0;

		int checkJoinNum = service.join(member);
		log.info("MemberController >>> joinAction >>> checkJoinNum : " + checkJoinNum);

		int checkAuthNum = service.registerAuth(auth);
		log.info("MemberController >>> joinAction >>> checkAuthNum : " + checkAuthNum);

		int checkConnectLogNum = service.registerConnectLog(connectLog);
		log.info("MemberController >>> joinAction >>> checkConnectLogNum : " + checkAuthNum);
		
		qr.setKey(MD5Encryption.getMD5(member.getId()));
		int checkQrNum = service.registerQr(qr);
		log.info("MemberController >>> joinAction >>> checkQrNum : " + checkQrNum);
		
		int checkProfileNum = service.registerProfile(profile);
		log.info("MemberController >>> joinAction >>> checkProfileNum : " + checkProfileNum);
		
		// 회원가입 , 권한등록이 정상적으로 처리 된 경우 세션 등록
		if (checkJoinNum == 1 && checkAuthNum == 1 && checkConnectLogNum == 1 && checkProfileNum == 1) {
			checkNum = 1;
			session.setAttribute("userId", member.getId());
			session.setAttribute("userNick", member.getNick());
			session.setAttribute("userAuth", auth.getType());
			log.info("MemberController >>> joinAction >>> [ Join, Auth ] Result : true");
		} else {
			log.info("MemberController >>> joinAction >>> [ Join, Auth ] Result : false");
		}
		return Integer.toString(checkNum);
	}

	// ajax 아이디 확인
	@ResponseBody
	@PostMapping("checkid")
	public String checkId(@RequestParam("id") String id) {
		String checkNum = null;
		try {
			checkNum = service.checkId(id);
			log.info("MemberController >>> checkId >>> checkNum : " + checkNum);
		} catch (Exception e) {
		}
		return checkNum;
	}

	// ajax pass 임시통과 처리
	@ResponseBody
	@PostMapping("checkpass")
	public void checkPass() {
	}

	// ajax nick 중복 확인
	@ResponseBody
	@PostMapping("checknick")
	public String checkNick(@RequestParam("nick") String nick) {
		String checkNum = null;
		log.info("ajax controller >>>>>>>>>>> chekNick : " + nick);
		try {
			checkNum = service.checkId(nick);
		} catch (Exception e) {
		}
		return checkNum;
	}

	// ajax email 중복 확인
	@ResponseBody
	@PostMapping("checkemail")
	public String checkEmail(@RequestParam("email") String email) {
		String checkNum = null;
		log.info("ajax controller >>>>>>>>>>> chekEmail : " + email);
		try {
			checkNum = service.checkEmail(email);
		} catch (Exception e) {
		}
		return checkNum;
	}

	// ajax session 삭제
	@ResponseBody
	@RequestMapping(method = { RequestMethod.GET, RequestMethod.POST }, value = "deleteSession", produces = "text/html")
	public ResponseEntity<String> deleteSession(HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		// log.info("ajax controller >>>>>>>>>>> remove UserId Session ");
		session.invalidate();

		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				log.info(cookies[i].getName());
				if (cookies[i].getName().equals("userId") || cookies[i].getName().equals("userNick")) {
					cookies[i].setMaxAge(0);
					cookies[i].setPath("/");
					response.addCookie(cookies[i]);
				}
			}
		}
		log.info("ajax controller >>>>>>>>>>> remove UserId Cookies ");

		return new ResponseEntity<>("success", HttpStatus.OK);
	}
	
	
	@ResponseBody
	@PostMapping("checkPassword")
	public String checkPassword(MemberVO member) {
		String resultType = null;
		resultType = service.checkPassword(member);
		return resultType;
	}
	
	@ResponseBody
	@PostMapping("changePassword")
	public String changePassword(MemberVO member) {
		int resultType = service.changePassword(member);
		return Integer.toString(resultType);
	}
	

	// ajax 접속로그 갱신
	@ResponseBody
	@PostMapping("updateConnection")
	public String updateConnectLog(@RequestParam("userId") String userId) {
		int checkNum = service.updateConnectLog(userId);
		log.info("ajax controller >>>>>>>>>>> update User Connection log : " + checkNum);
		return Integer.toString(checkNum);
	}

	// ajax 접속로그 삭제
	@ResponseBody
	@PostMapping("LogoutConnectionLog")
	public String LogoutConnectionLog(@RequestParam("userId") String userId) {
		int checkNum = service.updateLogoutConnectLog(userId);
		log.info("ajax controller >>>>>>>>>>> delete User Connection log : " + checkNum);
		return Integer.toString(checkNum);
	}
	
	// ajax 접속로그 조회
	@ResponseBody
	@PostMapping("getConnectTime")
	public String getConnectTime(@RequestParam("userId") String userId ) {
		String getTime = service.getConnectTime(userId);
		return getTime;
	}
	

	// Member 정보 뷰
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping(value = "viewMemberInfo", produces = "application/json; charset=utf8")
	public String viewMemberInfo(@CookieValue("userId") String userId) {

		log.info("conn viewMemberInfo >>>>>> " + userId);
		MemberVO member = service.viewMemberInfo(userId);

		/* JSONObject obj = new JSONObject(); */
		JSONObject value = new JSONObject();
		JSONArray array = new JSONArray();
		
		value.put("id", member.getId());
		value.put("nick", member.getNick());
		value.put("file", member.getPFile());
		/* obj.put("result", value); */
		array.add(value);

		return array.toString();
	}
	
	// Member 정보 update
	@ResponseBody
	@PostMapping("updateMemberInfo")
	public String updateMemberInfo(MemberVO member, HttpServletResponse response) {
		log.info("updateMemberInfo");
		int checkNum = service.updateMemberInfo(member);
		
		if ( checkNum == 1 ) {
			
			// 쿠키 갱신
			Cookie loginCookie = new Cookie("userId", member.getId());
			int maxAge = 60 * 60 * 24;
			loginCookie.setMaxAge(maxAge);
			loginCookie.setPath("/");
			response.addCookie(loginCookie);

			Cookie nickCookie = new Cookie("userNick", member.getNick());
			nickCookie.setMaxAge(maxAge);
			nickCookie.setPath("/");
			response.addCookie(nickCookie);
			
		}
		return Integer.toString(checkNum);
	}


	// profile 파일 업로드
	@ResponseBody
	@PostMapping(value="uploadProfile", produces="text/plain;charset=utf-8")
	public String uploadProfile(MultipartFile file, HttpServletRequest request, @CookieValue("userId") String id) throws IOException, InterruptedException {
		log.info("name : " + file.getOriginalFilename());
		log.info("size : " + file.getSize());
		log.info("contentType : " + file.getContentType());
		
		String folderPath = "/home/parkingq/upload/profile";
		File destdir = new File(folderPath); 
		
		if(!destdir.exists()){
            destdir.mkdirs();
        }
		
		String folder_cmd = "chmod 755 " + folderPath;
		Runtime folder_rt = Runtime.getRuntime();
		Process folder_p = folder_rt.exec(folder_cmd);
		folder_p.waitFor();
		
		UUID uuid = UUID.randomUUID();
		String saveName = uuid.toString() + "_" +file.getOriginalFilename();
		
		@SuppressWarnings("deprecation")
		String uploadPath = "/home/parkingq/upload/profile/";
		//String uploadPath = "/home/parkingq/upload/profile";
		
		log.info(uploadPath);
		
		File target = new File(uploadPath, saveName);
		
		FileCopyUtils.copy(file.getBytes(), target);
		Runtime.getRuntime().exec("chmod 644 "+uploadPath + saveName);
		
		ProfileVO profile = new ProfileVO();
		profile.setId(id);
		profile.setPfile(saveName);
		service.updateProfile(profile);
		
		return saveName;
	}
	
	// profile 파일 정보 업데이트
	@ResponseBody
	@PostMapping(value="updateProfile", produces="text/plain;charset=utf-8")
	public String updateProfile(ProfileVO profile) {
		log.info("updateProfile >>> " + profile );
		int resultNum = service.updateProfile(profile);
		log.info("updateProfile >>> " + resultNum);
		return Integer.toString(resultNum);
	}
	
	@ResponseBody
	@PostMapping(value="getProfile", produces="text/plain;charset=utf-8")
	public String getProfile(@RequestParam("id") String id) {
		String profileName = service.getProfile(id);
		return profileName;
	}
	
	
	// QR 전체 목록 
		@SuppressWarnings("unchecked")
		@ResponseBody
		@GetMapping(value="getQr", produces="text/plain;charset=utf-8")
		public String getQr() {
			
			ArrayList<QrVO> qrList = service.getQr();
			
			for ( int i=0; i<qrList.size(); i++) {
				log.info(qrList.get(i).getKey());
			}
			
			JSONObject  obj = new JSONObject();
			JSONArray array = new JSONArray();
			for(int i=0; i<qrList.size(); i++) {
				JSONObject value = new JSONObject();
				value.put("no", qrList.get(i).getNo());
				value.put("id", qrList.get(i).getId());
				value.put("key", qrList.get(i).getKey());
				array.add(value);
			}
			obj.put("result", array);
			return obj.toString();
		}
		
		// QR 아이디 조회
		@SuppressWarnings("unchecked")
		@ResponseBody
		@PostMapping(value="getQrById", produces="text/plain;charset=utf-8")
		public String getQrById(@RequestParam("id") String id) {
			String getQr = service.getQrById(id);
			log.info("getQrById >>> " +  getQr);
			return  getQr;
		}
		
		// QR 키 변경
		@ResponseBody
		@PostMapping(value="changeQrById")
		public String changeQrById(QrVO qr) {
			// random 값 추가 
			UUID uuid = UUID.randomUUID();
			qr.setKey(MD5Encryption.getMD5( uuid + "_" + qr.getId() ));
			log.info("QR update Key >>>>" + qr.getKey());
			int resultNum=0;
			resultNum = service.changeQrById(qr);
			return Integer.toString(resultNum);
		}
		
		
		// 친구신청
		@ResponseBody
		@PostMapping("applyFriend")
		public String applyFriend(FriendVO friend) {
			int resultNum;
			log.info("applyFriend >>> " + friend);
			resultNum = service.applyFriend(friend);
			log.info("applyFriend >>> resultNum : " + resultNum);
			return Integer.toString(resultNum);
		}
		
		// 친구 승낙
		@ResponseBody
		@PostMapping("acceptFriend")
		public String acceptFriend(FriendVO friend) {
			int resultNum;
			log.info("acceptFriend >>> " + friend);
			resultNum = service.acceptFriend(friend);
			log.info("acceptFriend >>> resultNum : " + resultNum);
			return Integer.toString(resultNum);
		}
		
		// 친구거절
		@ResponseBody
		@PostMapping("refuseFriend")
		public String refuseFriend(FriendVO friend) {
			int resultNum;
			log.info("refuseFriend >>> " + friend);
			resultNum = service.refuseFriend(friend);
			log.info("refuseFriend >>> resultNum : " + resultNum);
			return Integer.toString(resultNum);
		}
		
		// 친구 신청 상태 정보
		@ResponseBody
		@PostMapping("checkFriendStatus")
		public String checkFriendStatus(FriendVO friend) {
			log.info("checkFriendStatus >>> " + friend);
			int statusNum = service.checkFriendStatus(friend);
			return Integer.toString(statusNum); 
		}
		
		// 친구 리스트
		@SuppressWarnings("unchecked")
		@ResponseBody
		@PostMapping("getFriendList")
		public String getFriendList(FriendVO friend) {
			ArrayList<FriendVO> friendList = service.getFriendList(friend);
			JSONObject object = new JSONObject();
			JSONArray array = new JSONArray();
			for ( int i=0; i<friendList.size(); i++ ) {
				JSONObject value = new JSONObject();
				value.put("fId", friendList.get(i).getFId());
				value.put("pFile", friendList.get(i).getPFile());
				value.put("check",friendList.get(i).isCheck());
				array.add(value);
			}
			object.put("result", array);
			
			log.info(object);
			
			return object.toString();
		}
		
		// 커뮤니티 활동 통계
		@SuppressWarnings("unchecked")
		@ResponseBody
		@PostMapping("communityInfo")
		public String communityInfo(@RequestParam("id") String id) {
			
			HashMap<String, Object> info = new HashMap<String, Object>();
			info = service.communityInfo(id);
			
			JSONObject infoJSON = new JSONObject();
			
			infoJSON.put("visit", info.get("visit"));
			infoJSON.put("board", info.get("board"));
			infoJSON.put("comment", info.get("comment"));
			
			log.info(infoJSON.toString());
			return infoJSON.toString();
		}
		
		@SuppressWarnings("unchecked")
		@ResponseBody
		@PostMapping(value="getFriendNews", produces="text/plain;charset=utf-8")
		public String getFriendNews(@CookieValue("userId") String id ) {
			
			ArrayList<AlarmVO> list = new ArrayList<AlarmVO>();
			list = service.getFriendNews(id);
			JSONObject result = new JSONObject();
			JSONArray array = new JSONArray();
			for ( int i=0; i<list.size(); i++ ) {
				JSONObject value = new JSONObject();
				value.put("no", list.get(i).getAno());
				value.put("id", list.get(i).getId());
				value.put("type", list.get(i).getType());
				
				if(list.get(i).getSubject().length() > 13 ) {
					list.get(i).setSubject(list.get(i).getSubject().substring(0, 13) + "...");
				}
				
				value.put("subject", list.get(i).getSubject());
				value.put("date", list.get(i).getADate());
				value.put("file", list.get(i).getAFile());
				array.add(value);
			}
			result.put("result", array);
			return result.toString();
		}
		
}