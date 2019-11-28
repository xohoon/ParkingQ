package kr.parkingq.service.meetboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.parkingq.domain.meetboard.MeetCriteria;
import kr.parkingq.domain.meetboard.MeetReplyPageDTO;
import kr.parkingq.domain.meetboard.MeetReplyVO;
import kr.parkingq.mapper.MeetReplyMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class MeetReplyServiceImpl implements MeetReplyService{
	
	@Setter(onMethod_ = @Autowired)
	private MeetReplyMapper mapper;
	

	@Override
	public int register(MeetReplyVO vo) {
		
		log.info("reply register-------------"+vo);
		
		return mapper.insert(vo);
	}

	@Override
	public MeetReplyVO get(Long gno) {
		
		log.info("reply get--------------"+gno);
		
		return mapper.read(gno);
	}

	@Override
	public int modify(MeetReplyVO vo) {
		
		log.info("reply modify---------------"+vo);
		
		return mapper.update(vo);
	}

	
	@Override
	public int remove(Long gno) {
		
		log.info("reply remove-------------"+gno);
		
		return mapper.delete(gno);
	}

	@Override
	public List<MeetReplyVO> getList(MeetCriteria cri, Long no) {
		
		log.info("get Reply List of a Board : " + no);
		
		return mapper.getListWithPaging(cri, no);
	}

	@Override
	public MeetReplyPageDTO getListPage(MeetCriteria cri, Long no) {
		
		
		
		return new MeetReplyPageDTO(
				mapper.getCountByNo(no),
				mapper.getListWithPaging(cri, no));
	}
	
	 

}
