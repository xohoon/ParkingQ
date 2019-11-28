 package kr.parkingq.service.freeboard;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import kr.parkingq.domain.freeboard.Criteria;
import kr.parkingq.domain.freeboard.FreeBoardVO;
import kr.parkingq.domain.freeboard.FreeLikeCountVO;
import kr.parkingq.domain.freeboard.FreeLikeVO;
import kr.parkingq.mapper.FreeBoardMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class FreeBoardServiceImpl implements FreeBoardService{

	private FreeBoardMapper mapper;
	
	@Override
	public void register(FreeBoardVO board) {
		log.info("serviceimpl register() >>>>>>>>> �۵�� "+board);
		mapper.insertSelectKey(board);
	}
	@Override
	public FreeBoardVO getBoard(FreeLikeCountVO likeCnt) {
		log.info("serviceimpl get()  >>>>>>>>>>> �۹�ȣ "+likeCnt.getNo());
		int checkNum = mapper.updateReadCnt(likeCnt.getNo());
		log.info(checkNum +">>>>>>>>!>!>!>!>!>");
		
		return mapper.read(likeCnt);
	}
	
	@Override
	public boolean modify(FreeBoardVO board) {
		log.info("modify>>>>>>>>>>>>"+ board);
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long no) {
		log.info("remove>>>>>>>>>>>>"+ no);
		return mapper.delete(no) == 1;
	}

	@Override
	public List<FreeBoardVO> getList(Criteria cri) {
		
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public List<FreeBoardVO> getBestList() {
		return mapper.bestList();
	}
	
	public int getTotal(Criteria cri){
		log.info("serviceimpl getTotal()>>>>>>>>>>>");
		return mapper.getTotalCount(cri);
	}

	@Override
	public int getLike(FreeLikeVO like) {
		int resultNum = mapper.getLike(like);
		return resultNum;
	}

	@Override
	public int addLike(FreeLikeVO like) {
		int resultNum = mapper.addLike(like);
		return resultNum;
	}

	@Override
	public int deleteLike(FreeLikeVO like) {
		int resultNum = mapper.deleteLike(like);
		return resultNum;
	}
	
	@Override
	public void rewrite(FreeBoardVO board) {
		log.info("serviceimpl rewrite() >>>>>>>>>>>>>>>");
		log.info(board.getSeq()+">>>>>>>>>>>>>>>>>>>>>!!!!!!!>!!>!>!>!>!>!>!>>");
		log.info(board.getRef()+"<><><><><><><><><><><><><><><><><><><><");
		
		mapper.checkSeq(board);
		mapper.insertRewrite(board);
	}
	@Override
	public ArrayList<FreeBoardVO> getBestList5() {
		return mapper.getBestList5();
	}
	
	@Override
	public String selectDate() {
		return mapper.selectDate();
	}
	
	
	
}