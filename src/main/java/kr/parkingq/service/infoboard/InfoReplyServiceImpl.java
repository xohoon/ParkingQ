package kr.parkingq.service.infoboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.parkingq.domain.infoboard.Criteria;
import kr.parkingq.domain.infoboard.InfoReplyVO;
import kr.parkingq.mapper.InfoReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class InfoReplyServiceImpl implements InfoReplyService{
	
	@Setter(onMethod_ = @Autowired)
	private InfoReplyMapper mapper;
	
	@Override
	public int register(InfoReplyVO vo) {
		log.info("register...."+vo);
		return mapper.insertSelectKey(vo);
	}

	@Override
	public InfoReplyVO get(int gno) {
		log.info("get......."+gno);
		return mapper.read(gno);
	}

	@Override
	public int modify(InfoReplyVO vo) {
		log.info("modify..........."+vo);
		return mapper.update(vo);
	}

	@Override
	public int remove(int gno) {
		log.info("remove....."+gno);
		return mapper.delete(gno);
	}

	@Override
	public List<InfoReplyVO> getList(Criteria cri, int no) {
		log.info("get Reply List of a Board" + no);
		return mapper.getListWithPaging(cri, no);
	}

}
