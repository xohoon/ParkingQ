package kr.parkingq.service.meetboard;

import java.util.List;

import kr.parkingq.domain.meetboard.MeetCriteria;
import kr.parkingq.domain.meetboard.MeetReplyPageDTO;
import kr.parkingq.domain.meetboard.MeetReplyVO;

public interface MeetReplyService {

	public int register(MeetReplyVO vo);
	
	public MeetReplyVO get(Long gno);
	
	public int modify(MeetReplyVO vo);
	
	public int remove(Long gno);
	
	public List<MeetReplyVO> getList(MeetCriteria cri, Long no);
	
	public MeetReplyPageDTO getListPage(MeetCriteria cri, Long no);
}
