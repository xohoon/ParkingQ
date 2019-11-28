package kr.parkingq.service.meetboard;

import java.util.List;

import kr.parkingq.domain.meetboard.MeetLikeVO;
import kr.parkingq.domain.meetboard.MeetBoardVO;
import kr.parkingq.domain.meetboard.MeetCriteria;
import kr.parkingq.domain.meetboard.MeetFileVO;
import kr.parkingq.domain.meetboard.MeetLikeCountVO;
import kr.parkingq.domain.meetboard.MeetMemberVO;

public interface MeetBoardService {
	
	// VO
	public void register(MeetBoardVO board);
	
	// no
	public MeetBoardVO get(MeetLikeCountVO likeCount);
	
	public List<MeetBoardVO> getList(MeetCriteria cri);
	
	public int getTotal(MeetCriteria cri);
	
	// remove
	public boolean remove(Long no);
	
	// modify
	public boolean modify(MeetBoardVO board);
	
	// file update
	public int updateMeetfile(MeetFileVO meetfile);
	
	// Group Member resultNum get
	public int getJoin(MeetMemberVO member);

	// Group user insert
	public int insertJoin(MeetMemberVO member);

	// Group user delete
	public int deleteJoin(MeetMemberVO member);

	// Group Join count
	public int countJoin(MeetMemberVO member);
	
	// Board Like get Num
	public int getLike(MeetLikeVO like);

	// Board Like insert
	public int insertLike(MeetLikeVO like);

	// Board Like delete
	public int deleteLike(MeetLikeVO like);

	// Board like count
	public int countLike(MeetLikeVO like);


	


	

}
