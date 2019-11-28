package kr.parkingq.service.reviewboard;

import kr.parkingq.domain.reviewboard.ReviewLikeVO;

public interface ReviewGoodsService {
	
	public int addGoods(ReviewLikeVO goods);
	
	public int deleteGoods(ReviewLikeVO goods);
	//해당 아이디의 좋아요 여부
	public int getGoods(ReviewLikeVO goods);
	//해당 게시물의  개수
	public int goodsCount(Long no);
}
