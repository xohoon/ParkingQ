package kr.parkingq.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import kr.parkingq.domain.admin.AlarmVO;
import kr.parkingq.domain.member.AuthVO;
import kr.parkingq.domain.member.ConnectLogVO;
import kr.parkingq.domain.member.FriendVO;
import kr.parkingq.domain.member.MemberVO;
import kr.parkingq.domain.member.ProfileVO;
import kr.parkingq.domain.member.QrVO;
import kr.parkingq.domain.member.VisitVO;

public interface MemberMapper {
	
	// ID 체크
		public String checkMemberId(String id);
		// ID에 해당하는 Password 확인
		public String getMemberPass(String id);
		// Password 체크
		public String checkMemberPass(String pass);
		// ID에 해당하는 Nick 확인
		public String getMemberNick(String id);
		// Nick 체크
		public String checkMemberNick(String nick);
		// Email 체크
		public String checkMemberEmail(String email);
		// 회원가입
		public int joinMember(MemberVO member);
		// 아이디 비번 체크
		public String checkIdPass(MemberVO member);
		// 비밀번호 확인
		public String checkPassword(MemberVO member);
		// 비밀번호변경
		public int changePassword(MemberVO member);
		
		
		
		// 권한설정 등록
		public int registerAuth(AuthVO vo);
		// 접속로그 등록
		public int registerConnectLog(ConnectLogVO connectLog);
		// 프로필 사진 등록
		public int registerProfile(ProfileVO profile);
		// 방문자 등록
		public int registerVisit(VisitVO visit);
		
		
		// 접속중인 로그 갱신
		public int updateConnectLog(String userId);
		public int updateLogoutConnectLog(String userId);
		// 실시간 접속자 정보 가져오기
		public ArrayList<ConnectLogVO> getConnectList();
		// 접속 로그 조회
		public String getConnectTime(String userId);
		
		// 유저 정보 가져오기
		public MemberVO getMemberInfo(String id);
		// 유저 정보 업데이트
		public int updateMemberInfo(MemberVO member);
		// 유저 프로필 사진 업데이트
		public int updateProfile(ProfileVO profile);
		// 유저 프로필 사진 조회
		public String getProfile(String id);
		
		// QR 코드 등록
		public int registerQr(QrVO qr);
		// QR 코드 전체 리스트 조회
		public ArrayList<QrVO> getQr();
		// QR 코드 아이디 조회
		public String getQrById(String id);
		// QR 코드 변경
		public int changeQrById(QrVO qr);
		
		// 친구 신청
		public int applyFriend(FriendVO friend);
		// 친구 승낙
		public int acceptFriend(FriendVO friend);
		// 친구 거절
		public int refuseFriend(FriendVO friend);
		// 친구 요청 상태 정보
		public int checkFriendStatus(FriendVO friend);
		// 친구 리스트 조회
		public ArrayList<FriendVO> getFriendList(FriendVO friend);
		// 친구 요청값 조회
		public String getFriendRequest(HashMap<String, String> map);
		
		// 커뮤니티 활동 통계 조회
		public int getVisitCount(String id);
		public int getFreeboardCount(String id);
		public int getMeetboardCount(String id);
		public int getInfoboardCount(String id);
		public int getReviewboardCount(String id);
		public int getFreecommentCount(String id);
		public int getMeetcommentCount(String id);
		public int getInfocommentCount(String id);
		public int getReviewcommentCount(String id);
		
		// 친구 게시글 알람
		public ArrayList<AlarmVO> getFriendNews(String id);
		
		// 메인 유저 리스트
		public ArrayList<ConnectLogVO> getConntectUserImage();
		
		
		
		
		
}

