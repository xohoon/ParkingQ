package kr.parkingq.service.reviewboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.parkingq.domain.freeboard.FreeLikeVO;
import kr.parkingq.domain.reviewboard.ReviewLikeVO;
import kr.parkingq.mapper.ReviewGoodsMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReviewGoodsServiceImpl implements ReviewGoodsService{
	@Setter(onMethod_=@Autowired)
	private ReviewGoodsMapper mapper;

	@Override
	public int getGoods(ReviewLikeVO goods) {
		int resultNum = mapper.getGoods(goods);
		return resultNum;
	}

	@Override
	public int addGoods(ReviewLikeVO goods) {
		int resultNum = mapper.addGoods(goods);
		return resultNum;
	}

	@Override
	public int deleteGoods(ReviewLikeVO goods) {
		int resultNum = mapper.deleteGoods(goods);
		return resultNum;
	}

	@Override
	public int goodsCount(Long no) {
		int resultNum = mapper.goodsCount(no);
		return resultNum;
	}
	
	
	
	
}
