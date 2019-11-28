package kr.parkingq.service.reviewboard;

import java.util.List;

import kr.parkingq.domain.reviewboard.PagingVO;
import kr.parkingq.domain.reviewboard.ReviewBoardVO;
import kr.parkingq.domain.reviewboard.ReviewLikeVO;
import kr.parkingq.domain.reviewboard.ReviewScoreVO;

public interface ReviewBoardService {
	public void register(ReviewBoardVO board);
	
	public ReviewBoardVO get(Long no);
	
	public boolean modify(ReviewBoardVO board);
	
	public boolean remove(Long no);
	
/*	public List<ReviewBoardVO> getList();*/
	
	
	//�Խù� �� ��
	public int getTotal(PagingVO pg);
	//add goods
	public void addGoods(Long no, ReviewLikeVO rlv);

	public ReviewScoreVO getScore();
	//전체리스트
	public List<ReviewBoardVO> getList(PagingVO pg);
	//좋아요 개수로 정렬
	public List<ReviewBoardVO> getGoodsList(PagingVO pg);
	//별점높은순 정렬
	public List<ReviewBoardVO> getHighStarList(PagingVO pg);
	//별점낮은순 정렬
	public List<ReviewBoardVO> getLowStarList(PagingVO pg);
	//댓글개수가져오기
	public int getComment(int no);

	public List<ReviewBoardVO> getMList(PagingVO pg);

	public boolean removeComment(Long no);
}
