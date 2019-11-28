package kr.parkingq.service.reviewboard;

import java.util.List;

import kr.parkingq.domain.reviewboard.PagingVO;
import kr.parkingq.domain.reviewboard.ReplyPageDTO;
import kr.parkingq.domain.reviewboard.ReviewCommentVO;

public interface CommentService {
	public int register(ReviewCommentVO vo);
	public ReviewCommentVO get(Long no);
	public int modify(ReviewCommentVO vo);
	public int remove(Long no);
	public List<ReviewCommentVO> getList(PagingVO pvg, Long gno);
	public ReplyPageDTO getListPage(PagingVO pgv, Long gno);
	public int getCountByGno(Long gno);
}
