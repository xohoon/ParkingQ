package kr.parkingq.service.infoboard;

import java.util.List;

import kr.parkingq.domain.infoboard.Criteria;
import kr.parkingq.domain.infoboard.InfoReplyVO;

public interface InfoReplyService {
	
	public int register(InfoReplyVO vo);
	
	public InfoReplyVO get(int gno);
	
	public int modify(InfoReplyVO vo);
	
	public int remove(int gno);
	
	public List<InfoReplyVO> getList(Criteria cri, int no);

}
