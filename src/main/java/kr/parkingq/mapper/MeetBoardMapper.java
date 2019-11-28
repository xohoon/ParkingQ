package kr.parkingq.mapper;

import java.util.List;

import kr.parkingq.domain.meetboard.MeetBoardVO;
import kr.parkingq.domain.meetboard.MeetCriteria;
import kr.parkingq.domain.meetboard.MeetFileVO;
import kr.parkingq.domain.meetboard.MeetLikeCountVO;
import kr.parkingq.domain.meetboard.MeetLikeVO;
import kr.parkingq.domain.meetboard.MeetMapVO;
import kr.parkingq.domain.meetboard.MeetMemberVO;

public interface MeetBoardMapper {
	
	public List<MeetBoardVO> getList();
	
	public List<MeetBoardVO> getListWithPaging(MeetCriteria cri);

	public MeetBoardVO read(MeetLikeCountVO likeCount);
	
	public int getTotalCount(MeetCriteria cri);
	
	public void insert(MeetBoardVO board);
	
	public Integer insertSelectKey(MeetBoardVO board);
	
	// Group info delete
	public int delete(Long no);
	
	// file info delete
	public void fileDelete(Long no);
	
	// Location info delete
	public void LocationDelete(Long no);
	
	// Group update
	public int update(MeetBoardVO board);
	
	// File Update
	public void fileUpdate(MeetBoardVO board);

	// Map update
	public void mapUpdate(MeetBoardVO board);
	
	// Image file update
	public int updateMeetfile(MeetFileVO meetfile);

	// Group Member resultNum get
	public int getJoin(MeetMemberVO member);

	// Group user insert
	public int insertJoin(MeetMemberVO member);
	
	// Group user delete
	public int deleteJoin(MeetMemberVO member);

	// Group Join count
	public int countJoin(MeetMemberVO member);

	// Board Like resultNum get
	public int getLike(MeetLikeVO like);
	
	// Board Like insert
	public int insertLike(MeetLikeVO like);

	// Board Like delete
	public int deleteLike(MeetLikeVO like);

	// Board like count
	public int countLike(MeetLikeVO like);

	// Board view count
	public int boardCount(Long no);

	
	



}
