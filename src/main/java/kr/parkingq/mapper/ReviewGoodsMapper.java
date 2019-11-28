package kr.parkingq.mapper;


import kr.parkingq.domain.reviewboard.ReviewLikeVO;

public interface ReviewGoodsMapper {
	//해당 아이디의 좋아요 여부 가져오기
	public int getGoods(ReviewLikeVO goods);
	//좋아요 추가
	public int addGoods(ReviewLikeVO goods);
	//좋아요 빼기
	public int deleteGoods(ReviewLikeVO goods);
	//좋아요 수 카운트
	public int goodsCount(Long no);
}
