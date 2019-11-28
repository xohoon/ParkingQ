package kr.parkingq.service.reviewboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.parkingq.domain.reviewboard.PagingVO;
import kr.parkingq.domain.reviewboard.ReviewBoardVO;
import kr.parkingq.domain.reviewboard.ReviewLikeVO;
import kr.parkingq.domain.reviewboard.ReviewScoreVO;
import kr.parkingq.mapper.ReviewBoardMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReviewBoardServiceImpl implements ReviewBoardService{
	
	@Setter(onMethod_ = @Autowired)
	private ReviewBoardMapper mapper;
	
	@Override
	public void register(ReviewBoardVO board) {
		log.info("register..................... : " + board);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>board.content : " + board.getContent());
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>board.title : " + board.getTitle());
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>board.appavg : " + board.getAppavg());
		mapper.insertSelectKey(board);
		
	}

	@Override
	public ReviewBoardVO get(Long no) {
		log.info("get................. : " + no);
		return mapper.read(no);
	}

	@Override
	public boolean modify(ReviewBoardVO board) {
		log.info("modify.............. : " + board);
		return mapper.update(board)==1;
	}

	@Override
	public boolean remove(Long no) {
		log.info("remove.............. : " + no);
		return mapper.delete(no)==1;
	}
	@Override
	public boolean removeComment(Long no) {
		
		return mapper.deleteComment(no)==1;
	}

	
	@Override
	public int getTotal(PagingVO pg) {
		log.info("getTotalList����............");
		return mapper.getTotalCount(pg);
	}

	@Override
	public void addGoods(Long no, ReviewLikeVO rlv) {
		log.info("addGoods....................");
		mapper.addGoods(no, rlv);
	}



	@Override
	public ReviewScoreVO getScore() {
		log.info("getScore start");
		return mapper.getScore();
	}
	
	@Override
	public List<ReviewBoardVO> getList(PagingVO pg) {
		log.info("get List with paging : " + pg);
		return mapper.getListWithPaging(pg);
	}
	
	@Override
	public List<ReviewBoardVO> getGoodsList(PagingVO pg) {
		log.info("get List with paging : " + pg);
		return mapper.getListWithGoodsPaging(pg);
	}

	@Override
	public List<ReviewBoardVO> getHighStarList(PagingVO pg) {
		
		return mapper.getListWithHighStarPaging(pg);
	}

	@Override
	public List<ReviewBoardVO> getLowStarList(PagingVO pg) {
		// 
		return mapper.getListWithLowStarPaging(pg);
	}

	@Override
	public int getComment(int no) {
		
		return mapper.getComment(no);
	}

	@Override
	public List<ReviewBoardVO> getMList(PagingVO pg) {
		
		return mapper.getMListWithGoodsPaging(pg);
	}

	
	



	/*@Override
	public List<ReviewBoardVO> getList() {
		log.info("getList............. : ");
		log.info("mapper.getList�� ����:"+mapper.getList());
		return mapper.getList();
	}*/
	
	
	
}
