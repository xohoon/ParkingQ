package kr.parkingq.mapper;

import java.util.List;

import kr.parkingq.domain.reviewboard.PagingVO;
import kr.parkingq.domain.reviewboard.ReviewBoardVO;
import kr.parkingq.domain.reviewboard.ReviewLikeVO;
import kr.parkingq.domain.reviewboard.ReviewScoreVO;
import lombok.AllArgsConstructor;

public interface ReviewBoardMapper {
	
	//reviewboard ����Ʈ ��������
	public List<ReviewBoardVO> getList();
	//reviewboard �Խù� �߰�
	public void insert(ReviewBoardVO reviewBoard);
	//reviewboard ����Ʈ Ű �߰�
	public void insertSelectKey(ReviewBoardVO reviewBoard);
	//reviewboard selectó��
	public ReviewBoardVO read(Long no);
	//reviewboard deleteó��
	public int delete(Long no);
	//reviewboard updateó��
	public int update(ReviewBoardVO board);
	
	//total �Խù�
	public int getTotalCount(PagingVO pg);
	//get goods
	public int getGoodsCount(Long no);
	//add goods
	public void addGoods(Long no, ReviewLikeVO rlv);
	//cancle goods
	public void cancleGoods(Long no, ReviewLikeVO rlv);
	//get score of chart
	public ReviewScoreVO getScore();
	//paging 전체
	public List<ReviewBoardVO> getListWithPaging(PagingVO pg);
	//좋아요 paging
	public List<ReviewBoardVO> getListWithGoodsPaging(PagingVO pg);
	//별점높은순 정렬
	public List<ReviewBoardVO> getListWithHighStarPaging(PagingVO pg);
	//별점낮은순 정렬
	public List<ReviewBoardVO> getListWithLowStarPaging(PagingVO pg);
	//알람추가
	public void insertAlarm(ReviewBoardVO board);
	//댓글 개수 가져오기
	public int getComment(int no);
	public List<ReviewBoardVO> getMListWithGoodsPaging(PagingVO pg);
	public int deleteComment(Long no);
}
