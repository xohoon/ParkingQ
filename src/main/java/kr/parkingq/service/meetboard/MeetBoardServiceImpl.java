package kr.parkingq.service.meetboard;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.parkingq.domain.meetboard.MeetBoardVO;
import kr.parkingq.domain.meetboard.MeetCriteria;
import kr.parkingq.domain.meetboard.MeetFileVO;
import kr.parkingq.domain.meetboard.MeetLikeCountVO;
import kr.parkingq.domain.meetboard.MeetLikeVO;
import kr.parkingq.domain.meetboard.MeetMemberVO;
import kr.parkingq.mapper.MeetBoardMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MeetBoardServiceImpl implements MeetBoardService{

	private MeetBoardMapper mapper;

	@Override
	public void register(MeetBoardVO board) {
		
		System.out.println("register---serviceImpl--board : "+board);
		mapper.insertSelectKey(board);
	}

	@Override
	public MeetBoardVO get(MeetLikeCountVO likeCount) {
		
		log.info("get-serviceImpl--"+likeCount);
		mapper.boardCount(likeCount.getNo());
		
		return mapper.read(likeCount);
	}

	
	@Override
	public List<MeetBoardVO> getList(MeetCriteria cri) {
		
		log.info("get List With Criteria :  serviceImpl--" + cri);
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(MeetCriteria cri) {
		
		log.info("get total count serviceImpl");
		
		return mapper.getTotalCount(cri);
	}

	@Override
	public boolean remove(Long no) {
		
		log.info("remove serviceImpl"+no);
		mapper.fileDelete(no);
		mapper.LocationDelete(no);
		
		return mapper.delete(no) == 1;
	}

	@Override
	public boolean modify(MeetBoardVO board) {
		
		log.info("modify serviceImpl"+board);
		log.info("tttttttttttttttttt"+board.getLat());
		
		if(board.getMfile() != "") {
			mapper.fileUpdate(board);			
		}
		if(board.getLat() != "") {
			mapper.mapUpdate(board);
		}
		
		return mapper.update(board) == 1;
	}

	
	@Override
	public int updateMeetfile(MeetFileVO meetfile) {
		
		int updateMeetfileCheckNum = mapper.updateMeetfile(meetfile);
		log.info("updateMeetfile------serviceImpl---------"+updateMeetfileCheckNum);
		
		return updateMeetfileCheckNum;
	}


	
	// Group Member resultNum get
	@Override
	public int getJoin(MeetMemberVO member) {
		int resultNum = mapper.getJoin(member);
		
		return resultNum;
	}
	
	// Group user insert
	@Override
	public int insertJoin(MeetMemberVO member) {
		int resultNum = mapper.insertJoin(member);
		
		return resultNum;
	}
	
	// Group user delete
	@Override
	public int deleteJoin(MeetMemberVO member) {
		int resultNum = mapper.deleteJoin(member);
		
		return resultNum;
	}

	// Group join count
	@Override
	public int countJoin(MeetMemberVO member) {
		
		int resultNum = mapper.countJoin(member);
		
		return resultNum;
	}

	// Board Like get
	@Override
	public int getLike(MeetLikeVO like) {
		
		int resultNum =  mapper.getLike(like);
		
		return resultNum;
	}

	// BoardLike insert
	@Override
	public int insertLike(MeetLikeVO like) {
		int resultNum = mapper.insertLike(like);
		
		return resultNum;
	}

	// Board Like delete
	@Override
	public int deleteLike(MeetLikeVO like) {
		int resultNum = mapper.deleteLike(like);
		
		return resultNum;
	}

	// Board like count
	@Override
	public int countLike(MeetLikeVO like) {
		int resultNum = mapper.countLike(like);
		
		return resultNum;
	}
	
	
	
	
	
	
	
	
	
	
}
