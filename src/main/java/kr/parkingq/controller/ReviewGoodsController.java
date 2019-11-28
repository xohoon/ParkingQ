package kr.parkingq.controller;

import javax.xml.ws.Response;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.parkingq.domain.freeboard.FreeLikeVO;
import kr.parkingq.domain.reviewboard.ReviewLikeVO;
import kr.parkingq.service.reviewboard.ReviewGoodsService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController

@Log4j
@RequestMapping("/reviewBoardGoods/")
@AllArgsConstructor
public class ReviewGoodsController {

	private ReviewGoodsService service;
	
	/* 좋아요 */
	@ResponseBody
	@PostMapping(value="getGoods", produces="application/json; charset-utf8")
	public String getLike(ReviewLikeVO like){
		int resultNum = service.getGoods(like);
		log.info("getGoods에 따른 결과값 : " + resultNum);
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + resultNum);
		return Integer.toString(resultNum);
	}
	@ResponseBody
	@PostMapping(value="addGoods", produces="application/json; charset-utf8")
	public String addLike(ReviewLikeVO like){
		int resultNum = service.addGoods(like);
		log.info("addGoods에 따른 결과값 : " + resultNum);
		return Integer.toString(resultNum);
	}
	@ResponseBody
	@PostMapping(value="deleteGoods", produces="application/json; charset-utf8")
	public String deleteLike(ReviewLikeVO like){
		int resultNum = service.deleteGoods(like);
		log.info("deleteGoods에 따른 결과값 : " + resultNum);
		return Integer.toString(resultNum);
	}
	@ResponseBody
	@PostMapping(value="goodsCount", produces="application/json; charset-utf8")
	public String goodsCount(Long no) {
		int resultNum = service.goodsCount(no);
		log.info("goodsCount에 따른 결과값은 : " + resultNum);
		return Integer.toString(resultNum);
	}
}
