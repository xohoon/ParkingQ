package kr.parkingq.mapper;

import java.util.ArrayList;

import kr.parkingq.domain.message.LikeVO;
import kr.parkingq.domain.message.MessageVO;

public interface MessageMapper {

	// 메세지 등록
		public int insertMessage(MessageVO message);
		// 메세지 호출
		public ArrayList<MessageVO> getMessage(MessageVO message);
		// 회원간의 메세지 그룹 번호 확인
		public String checkRoomId(MessageVO message);
		// 메세지 그룹 번호 발급
		public int getRoomId();
		// 메세지를 나눈 회원 목록
		public ArrayList<MessageVO> getMessageMemberList(String id);
		// 해당 회원 프로필 사진
		public String getProfile(String id);
		// 메세지 읽은 표시
		public void readMessage(MessageVO message);
		// 메세지 삭제
		public int deleteMessage(MessageVO message);
		// 읽지 않은 메세지 갯수
		public int getUnReadCount(String id);
		// 번호에 해당하는 메세지 삭제
		public int deleteInviteMessage(long no);
		
		public int getLike(LikeVO like);
		public int addLike(LikeVO like);
		public int deleteLike(LikeVO like);
		
		// 읽지 않은 메세지 갯수
		public int unReadCountById(String id);
}
