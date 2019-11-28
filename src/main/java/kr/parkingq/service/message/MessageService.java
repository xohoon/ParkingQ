package kr.parkingq.service.message;

import java.util.ArrayList;

import kr.parkingq.domain.message.LikeVO;
import kr.parkingq.domain.message.MessageVO;

public interface MessageService {

	// 메세지 등록
	public int insertMessage(MessageVO message);
	
	// 메세지 내용 호출
	public ArrayList<MessageVO> getMessage(MessageVO message);
	
	// 자신과 메세지를 나눈 사용자 목록
	public ArrayList<MessageVO> getMessageMemberList(String id);

	// 메세지 삭제
	public int deleteMessage(MessageVO message);

	// 읽지 않은 메세지 갯수
	public int getUnReadCount(String id);

	// 번호에 해당하는 메세지 삭제
	public int deleteInviteMessage(long no);

	public int getLike(LikeVO like);

	public int addLike(LikeVO like);

	public int deleteLike(LikeVO like);

	// 읽지 않은 메세지 갯수 조회
	public int unReadCountById(String id);

}