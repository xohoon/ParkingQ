package kr.parkingq.service.message;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.parkingq.domain.message.LikeVO;
import kr.parkingq.domain.message.MessageVO;
import kr.parkingq.mapper.MessageMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MessageServiceImpl implements MessageService {

	@Setter(onMethod_ = @Autowired)
	private MessageMapper mapper;

	@Override
	public int insertMessage(MessageVO message) {

		// user 간의 roomid checking
		String checkRoomId = mapper.checkRoomId(message);

				// 얘기를 나누지 않은 경우 새로운 roomid 발급
		if (checkRoomId == null) {
			message.setRoomId(mapper.getRoomId());
			log.info("insertMessage >>> new connect message : getRoomId >>> " + message.getRoomId());
		} else {
			message.setRoomId(Integer.parseInt(checkRoomId));
			log.info("insertMessage >>> connect message : checkRoomId >>> " + message.getRoomId());
		}

		int checkNum = mapper.insertMessage(message);
		log.info("insertMessage >>> insert checkNum : " + checkNum);

		return checkNum;
	}

	@Override
	public ArrayList<MessageVO> getMessage(MessageVO message) {
		// update read message
		mapper.readMessage(message);
		ArrayList<MessageVO> messageList = mapper.getMessage(message);
		log.info(">>> getMessage");
		return messageList;
	}

	@Override
	public ArrayList<MessageVO> getMessageMemberList(String id) {
		ArrayList<MessageVO> memberList = mapper.getMessageMemberList(id);
		
		for ( int i=0; i<memberList.size(); i++ ) {
			if ( memberList.get(i).getId().equals(id) ) {
				memberList.get(i).setId(memberList.get(i).getToId());
				memberList.get(i).setToId("");
				memberList.get(i).setPFile(mapper.getProfile(memberList.get(i).getId()));
			} else {
				memberList.get(i).setId(memberList.get(i).getId());
				memberList.get(i).setToId("");
				memberList.get(i).setPFile(mapper.getProfile(memberList.get(i).getId()));
			}
		}
		return memberList;
	}

	@Override
	public int deleteMessage(MessageVO message) {
		int deleteMessageNum = mapper.deleteMessage(message);
		log.info("deleteMessage >>> " + deleteMessageNum);
		return deleteMessageNum;
	}

	@Override
	public int getUnReadCount(String id) {
		int unReadCount = mapper.getUnReadCount(id);
		log.info("getUnReadCount >>> " + id + " : " + unReadCount);
		return unReadCount;
	}

	@Override
	public int deleteInviteMessage(long no) {
		int resultNum = mapper.deleteInviteMessage(no);
		log.info("deleteInviteMessage >> " + resultNum);
		return resultNum;
	}

	@Override
	public int getLike(LikeVO like) {
		int resultNum = mapper.getLike(like);
		return resultNum;
	}

	@Override
	public int addLike(LikeVO like) {
		int resultNum = mapper.addLike(like);
		return resultNum;
	}

	@Override
	public int deleteLike(LikeVO like) {
		int resultNum = mapper.deleteLike(like);
		return resultNum;
	}
	

	@Override
	public int unReadCountById(String id) {
		int unReadCount = mapper.unReadCountById(id);
		return unReadCount;
	}
	
	

}
