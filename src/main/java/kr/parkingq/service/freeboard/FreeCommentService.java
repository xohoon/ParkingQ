package kr.parkingq.service.freeboard;

import java.util.List;

import kr.parkingq.domain.freeboard.CommentPageDTO;
import kr.parkingq.domain.freeboard.Criteria;
import kr.parkingq.domain.freeboard.FreeCommentVO;

public interface FreeCommentService {

	public int register(FreeCommentVO vo);
	
	public FreeCommentVO get(Long gno);
	
	public int modify(FreeCommentVO vo);
	
	public int remove(Long gno);
	
	public List<FreeCommentVO> getList(Criteria cri, Long no);
	
	public CommentPageDTO getListPage(Criteria cri, Long no);
	 
	
}
