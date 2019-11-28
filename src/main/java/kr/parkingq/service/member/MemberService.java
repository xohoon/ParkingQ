package kr.parkingq.service.member;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import kr.parkingq.domain.admin.AlarmVO;
import kr.parkingq.domain.member.AuthVO;
import kr.parkingq.domain.member.ConnectLogVO;
import kr.parkingq.domain.member.FriendVO;
import kr.parkingq.domain.member.MemberVO;
import kr.parkingq.domain.member.ProfileVO;
import kr.parkingq.domain.member.QrVO;
import kr.parkingq.domain.member.VisitVO;

public interface MemberService {

	// 로그인
	public String login(MemberVO member);
	
	// 닉네임 조회
	public String getMemberNick(String id);
	
	// 로그인시 방문자 등록
	public int registerVisit(VisitVO visit);
	
	// ajax 회원 정보 중복조회
	public String checkId(String id);
	public String checkNick(String nick);
	public String checkEmail(String email);
	
	// 비밀번호 확인
	public String checkPassword(MemberVO member);
	// 비밀번호 변경
	public int changePassword(MemberVO member);
	
	// ajax 회원 가입
	public int join(MemberVO member);
	// 회원가입시 AUTH 권한 등록
	public int registerAuth(AuthVO auth);
	// 회원가입시 접속로그 등록
	public int registerConnectLog(ConnectLogVO connectLog);
	// 회원가입시 프로필 등록
	public int registerProfile(ProfileVO profile);
	
	// 접속자 인원 출력
	public ArrayList<ConnectLogVO> getConnectList();
	// 접속자 로그 갱신
	public int updateConnectLog(String userId);
	public int updateLogoutConnectLog(String userId);
	// 접속 로그 조회
	public String getConnectTime(String userId);
	
	// 회원정보 조회
	public MemberVO viewMemberInfo(String userId);
	// 회원정보 변경
	public int updateMemberInfo(MemberVO member);
	// 회원 프로필 사진 변경
	public int updateProfile(ProfileVO profile);
	// 회원 프로필 사진 조회
	public String getProfile(String id);

	// QR 코드 등록
	public int registerQr(QrVO qr);
	// QR 코드 전체 리스트 조회
	public ArrayList<QrVO> getQr();
	// QR 코드 아이디 조회
	public String getQrById(String id);
	// QR코드 재생성
	public int changeQrById(QrVO qr);


	// 친구신청
	public int applyFriend(FriendVO friend);
	// 친구 승낙
	public int acceptFriend(FriendVO friend);
	// 친구 거절
	public int refuseFriend(FriendVO friend);
	// 친구 요청 상태 정보
	public int checkFriendStatus(FriendVO friend);

	// 친구 리스트 출력
	public ArrayList<FriendVO> getFriendList(FriendVO friend);

	// 커뮤니티 정보 출력
	public HashMap<String, Object> communityInfo(String id);

	// 친구 게시글 알람 출력
	public ArrayList<AlarmVO> getFriendNews(String id);

	// 메인 유저 목록
	public ArrayList<ConnectLogVO> getConntectUserImage();

	

	

	


}