package kr.parkingq.service.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.parkingq.domain.admin.AlarmVO;
import kr.parkingq.domain.member.AuthVO;
import kr.parkingq.domain.member.ConnectLogVO;
import kr.parkingq.domain.member.FriendVO;
import kr.parkingq.domain.member.MemberVO;
import kr.parkingq.domain.member.ProfileVO;
import kr.parkingq.domain.member.QrVO;
import kr.parkingq.domain.member.VisitVO;
import kr.parkingq.mapper.MemberMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;

	@Override
	public String login(MemberVO member) {
		log.info("loginAction connect");
		log.info(">>>>>>>>>>>>>>>>" + mapper);

		// 로그인 체크옵션 ( 1:로그인 , 0:아이디 불일치, -1:비밀번호불일치 )
		String checkNum = null;

		// 사용자 아이디, 비밀번호 정보
		Map<String, String> params = new HashMap<String, String>();
		params.put("member_id", member.getId());
		params.put("member_pass", member.getPass());

		log.info("MemberServiceImple >>> login >>> member_id : " + params.get("member_id") + " , member_pass : "
				+ params.get("member_pass"));

		if (mapper.checkMemberId(params.get("member_id")) != null) {
			log.info("login result : 아이디 통과");
			if (mapper.getMemberPass(params.get("member_id")).equals(params.get("member_pass"))) {
				log.info("login result : 로그인 성공");
				checkNum = "1";
				int checkConnectNum = mapper.updateConnectLog(member.getId());
				log.info("MemberServiceImple >>> login >>> Connect CheckNum : " + checkConnectNum);
			} else {
				log.info("login result : 비밀번호 틀림");
				checkNum = "0";
			}
		} else {
			log.info("login result : 존재하지 않는 아이디");
			checkNum = "-1";
		}
		log.info("MemberServiceImpl >>> checkNum : " + checkNum);
		return checkNum;
	}

	@Override
	public String getMemberNick(String id) {
		String nick = null;
		if (mapper.getMemberNick(id) != null) {
			nick = mapper.getMemberNick(id);
			log.info("MemberServiceImpl >>> getMemberNick >>> result : " + nick);
		}
		return nick;
	}

	@Override
	public String checkId(String id) {
		String checkNum = null;
		if (mapper.checkMemberId(id) != null) {
			checkNum = "1";
		} else {
			checkNum = "0";
		}
		log.info("MemberServiceImpl >>> checkMemberId >>> result : " + checkNum);
		return checkNum;
	}

	@Override
	public String checkNick(String nick) {
		String checkNum = null;
		if (mapper.checkMemberNick(nick) != null) {
			checkNum = "1";
		} else {
			checkNum = "0";
		}
		log.info("MemberServiceImpl >>> checkMemberNick >>> result : " + checkNum);
		return checkNum;
	}

	@Override
	public String checkEmail(String email) {
		String checkNum = null;
		if (mapper.checkMemberEmail(email) != null) {
			checkNum = "1";
		} else {
			checkNum = "0";
		}
		log.info("MemberServiceImpl >>> checkMemberEmail >>> result : " + checkNum);
		return checkNum;
	}
	
	@Override
	public String checkPassword(MemberVO member) {
		String resultType = mapper.checkPassword(member);
		if ( resultType != null ) {
			resultType = "1";
		} else {
			resultType = "0";
		}
		return resultType;
	}

	@Override
	public int changePassword(MemberVO member) {
		int resultType = mapper.changePassword(member);
		return resultType;
	}
	
	@Override
	public int join(MemberVO member) {
		int checkNum = mapper.joinMember(member);
		log.info("MemberServiceImpl >>>> join >>>> joinMember result : " + checkNum);
		log.info("MemberServiceImpl >>>> join >>>> joinProfile result : " + checkNum);
		return checkNum;
	}

	@Override
	public int registerAuth(AuthVO auth) {
		int checkNum = mapper.registerAuth(auth);
		log.info("MemberServiceImpl >>>> join >>>> registerAuth result : " + checkNum);
		return checkNum;
	}

	@Override
	public int registerConnectLog(ConnectLogVO connectLog) {
		int checkNum = mapper.registerConnectLog(connectLog);
		log.info("MemberServiceImpl >>>> join >>>> registerConnectLog result : " + checkNum);
		return checkNum;
	}

	@Override
	public int registerProfile(ProfileVO profile) {
		int checkNum = mapper.registerProfile(profile);
		log.info("MemberServiceImpl >>>> join >>>> registerProfile result : " + checkNum);
		return checkNum;
	}

	@Override
	public int registerVisit(VisitVO visit) {
		int checkNum = mapper.registerVisit(visit);
		log.info("MemberServiceImpl >>>> join >>>> registerVisit result : " + checkNum);
		return checkNum;
	}

	@Override
	public ArrayList<ConnectLogVO> getConnectList() {
		ArrayList<ConnectLogVO> connectMemberList = new ArrayList<>();

		connectMemberList = mapper.getConnectList();

		/*for (int i = 0; i < connectMemberList.size(); i++) {
			log.info("접속중인 인원 " + (i + 1) + "명 : " + connectMemberList.get(i).getId());
		}*/
		
		return connectMemberList;
	}

	@Override
	public int updateConnectLog(String userId) {
		int checkConnectLogNum = mapper.updateConnectLog(userId);
		log.info("MemberServiceImpl >>>> updateConnectLog >>>> updateConnectLog result : " + checkConnectLogNum + " : " + userId);
		return checkConnectLogNum;
	}

	@Override
	public int updateLogoutConnectLog(String userId) {
		int checkLogoutConnectLogNum = mapper.updateLogoutConnectLog(userId);
		log.info("MemberServiceImpl >>>> updateLogoutConnectLog >>>> checkLogoutConnectLogNum result : "
				+ checkLogoutConnectLogNum);
		return checkLogoutConnectLogNum;
	}

	@Override
	public MemberVO viewMemberInfo(String id) {
		log.info("viewMemberInfo >>>>>> " + id);
		MemberVO member = mapper.getMemberInfo(id);
		return member;
	}

	@Override
	public int updateMemberInfo(MemberVO member) {
		int checkUpdateNum;
		log.info(">>>>>>>>>>>>>>>updateMemberInfo접근");

		log.info(member.getId() + " : " + member.getNick() + " : " + member.getPass());

		if (mapper.checkIdPass(member) != null) {
			String nick = member.getNick();
			if (mapper.checkMemberNick(nick) == null) {
				checkUpdateNum = mapper.updateMemberInfo(member);
				log.info("updateMemberInfo >>>> 정보변경 성공");
				checkUpdateNum = 1;
			} else {
				log.info("updateMemberInfo >>>> 닉네임 중복");
				checkUpdateNum = -1;
			}
		} else {
			log.info("updateMemberInfo >>>> 비밀번호 틀림");
			checkUpdateNum = 0;
		}
		return checkUpdateNum;
	}

	@Override
	public int updateProfile(ProfileVO profile) {
		int updateProfileCheckNum = mapper.updateProfile(profile);
		log.info("updateProfile >>> " + updateProfileCheckNum);
		return updateProfileCheckNum;
	}

	@Override
	public int registerQr(QrVO qr) {
		int registerQrCheckNum = mapper.registerQr(qr);
		log.info("registerQr >>> " + registerQrCheckNum);
		return registerQrCheckNum;
	}

	@Override
	public ArrayList<QrVO> getQr() {
		ArrayList<QrVO> qrList = mapper.getQr();
		return qrList;
	}
	
	@Override
	public String getQrById(String id) {
		String getQr = mapper.getQrById(id);
		return getQr;
	}

	@Override
	public int applyFriend(FriendVO friend) {
		int applyFriendNum = mapper.applyFriend(friend);
		log.info("applyFriend >>> applyFriendNum : " + applyFriendNum);
		
		return applyFriendNum;
	}

	@Override
	public int acceptFriend(FriendVO friend) {
		int acceptFriendNum = mapper.acceptFriend(friend);
		log.info("acceptFriend >>> acceptFriendNum : " + acceptFriendNum);
		return acceptFriendNum;
	}

	@Override
	public int refuseFriend(FriendVO friend) {
		int refuseFriendNum = mapper.refuseFriend(friend);
		log.info("refuseFriend >>> refuseFriendNum : " + refuseFriendNum);
		return refuseFriendNum;
	}

	@Override
	public int checkFriendStatus(FriendVO friend) {
		int statusNum = mapper.checkFriendStatus(friend);
		log.info("checkFriendStatus >>> " + statusNum);
		return statusNum;
	}

	@Override
	public ArrayList<FriendVO> getFriendList(FriendVO friend) {
		
		ArrayList<FriendVO> friendList = mapper.getFriendList(friend);
		
		for ( int i=0; i<friendList.size(); i++ ) {
			
			if ( friendList.get(i).getRequest() == 1 ) {
				String id = friendList.get(i).getId();
				String fId = friendList.get(i).getFId();
				
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("id", id);
				map.put("fId", fId);
				if ( mapper.getFriendRequest(map) != null ) {
					friendList.get(i).setCheck(true);
				} else {
					friendList.get(i).setCheck(false);
				}
			}
		}
		return friendList;
	}

	@Override
	public int changeQrById(QrVO qr) {
		int resultNum = mapper.changeQrById(qr);
		return resultNum;
	}

	@Override
	public String getConnectTime(String userId) {
		String getTime = mapper.getConnectTime(userId);
		log.info(getTime);
		return getTime;
	}

	@Override
	public HashMap<String, Object> communityInfo(String id) {
		
		HashMap<String, Object> info = new HashMap<String, Object>();
		
		int visitCount = mapper.getVisitCount(id);
		
		int freeboardCount = mapper.getFreeboardCount(id);
		int meetboardCount = mapper.getMeetboardCount(id);
		int infoboardCount = mapper.getInfoboardCount(id);
		int reviewboardCount = mapper.getReviewboardCount(id);
		int resultBoard = freeboardCount + meetboardCount + infoboardCount + reviewboardCount;
		
		int freecommentCount = mapper.getFreecommentCount(id);
		int meetcommentCount = mapper.getMeetcommentCount(id);
		int infocommentCount = mapper.getInfocommentCount(id); 
		int reviewcommentCount = mapper.getReviewcommentCount(id);
		int resultComment = freecommentCount + meetcommentCount + infocommentCount + reviewcommentCount;
		
		info.put("visit", visitCount);
		info.put("board", resultBoard);
		info.put("comment", resultComment);
		
		return info;
	}

	@Override
	public String getProfile(String id) {
		return mapper.getProfile(id);
	}

	@Override
	public ArrayList<AlarmVO> getFriendNews(String id) {
		ArrayList<AlarmVO> list = mapper.getFriendNews(id);
		return list;
	}

	@Override
	public ArrayList<ConnectLogVO> getConntectUserImage() {
		return mapper.getConntectUserImage();
	}

	
	
	
	

	
	
	
	

	
	
	
}