package kr.parkingq.service.reviewboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.parkingq.domain.reviewboard.PagingVO;
import kr.parkingq.domain.reviewboard.ReplyPageDTO;
import kr.parkingq.domain.reviewboard.ReviewCommentVO;
import kr.parkingq.mapper.ReviewReplyMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class CommentServiceImpl implements CommentService{
	@Setter(onMethod_ = @Autowired)
	private ReviewReplyMapper mapper;
	
	@Override
	public int register(ReviewCommentVO vo) {
		log.info("register.............");
		log.info("서비스에서의 vo 값 : " +vo);
		return mapper.insert(vo);
	}

	@Override
	public ReviewCommentVO get(Long no) {
		log.info("get.....................");
		return mapper.read(no);
	}

	@Override
	public int modify(ReviewCommentVO vo) {
		log.info("modify.....................");
		return mapper.update(vo);
	}

	@Override
	public int remove(Long no) {
		log.info("remove......................");
		return mapper.delete(no);
	}

	@Override
	public List<ReviewCommentVO> getList(PagingVO pvg, Long gno) {
		log.info("get comment list of a board" + gno);
		log.info("CommentService에서 pagingVO : " + pvg + "이고 gno는 :" + gno);
		return mapper.getListWithPaging(pvg, gno);
	}
	
	
	
	@Override
	public ReplyPageDTO getListPage(PagingVO pgv, Long gno) {
		
		log.info("serviceImpl의 getListPage 실행!" );
		log.info("serviceImpl의 pgv : " + pgv + ", gno : " + gno);
		return new ReplyPageDTO(mapper.getCountByGno(gno),
				mapper.getListWithPaging(pgv, gno));
	}

	@Override
	public int getCountByGno(Long gno) {
		return mapper.getCountByGno(gno);
	}
	
}
