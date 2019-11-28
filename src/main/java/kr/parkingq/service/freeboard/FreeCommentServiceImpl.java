package kr.parkingq.service.freeboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.parkingq.domain.freeboard.CommentPageDTO;
import kr.parkingq.domain.freeboard.Criteria;
import kr.parkingq.domain.freeboard.FreeCommentVO;
import kr.parkingq.mapper.FreeBoardMapper;
import kr.parkingq.mapper.FreeCommentMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class FreeCommentServiceImpl implements FreeCommentService{

	@Setter(onMethod_=@Autowired)
	private FreeCommentMapper mapper;
	@Setter(onMethod_=@Autowired)
	private FreeBoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(FreeCommentVO vo) {

		log.info("register()>>>>>>>>>>>" + vo);
		
		boardMapper.updateReplyCnt(vo.getNo(), 1);
		return mapper.insert(vo);
	}

	@Override
	public FreeCommentVO get(Long gno) {

		log.info("get()>>>>>>>>>>>" + gno);
		
		return mapper.read(gno);
	}

	@Override
	public int modify(FreeCommentVO vo) {

		log.info("modify()>>>>>>>>>>>" + vo);
		
		return mapper.update(vo);
	}
	
	@Transactional
	@Override
	public int remove(Long gno) {

		log.info("remove()>>>>>>>>>>>" + gno);
		
		FreeCommentVO vo = mapper.read(gno);
		
		boardMapper.updateReplyCnt(vo.getNo(), -1);
		return mapper.delete(gno);
	}

	@Override
	public List<FreeCommentVO> getList(Criteria cri, Long no) {

		log.info("comment list>>>>>>>>>>>" + no);
		
		return mapper.getListWithPaging(cri, no);
	}

	@Override
	public CommentPageDTO getListPage(Criteria cri, Long no) {

		return new CommentPageDTO(
				mapper.getCountByNo(no), 
				mapper.getListWithPaging(cri, no));
	}

	
	
}





