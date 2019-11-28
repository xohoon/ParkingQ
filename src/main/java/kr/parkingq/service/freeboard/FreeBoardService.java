package kr.parkingq.service.freeboard;

import java.util.ArrayList;
import java.util.List;

import org.springframework.ui.Model;

import kr.parkingq.domain.freeboard.Criteria;
import kr.parkingq.domain.freeboard.FreeBoardVO;
import kr.parkingq.domain.freeboard.FreeLikeCountVO;
import kr.parkingq.domain.freeboard.FreeLikeVO;

public interface FreeBoardService {

	//글등록
	public void register(FreeBoardVO board);
	
	//글조회
	public FreeBoardVO getBoard(FreeLikeCountVO likeCnt);
	
	//글수정
	public boolean modify(FreeBoardVO board);
	
	//글삭제
	public boolean remove(Long no);
	
	//글 목록
	public List<FreeBoardVO> getList(Criteria cri);
	
	//전체 게시글 개수
	public int getTotal(Criteria cri);
	
	//좋아요 	
	public int getLike(FreeLikeVO like);
	public int addLike(FreeLikeVO like);
	public int deleteLike(FreeLikeVO like);

	//답글 쓰기
	public void rewrite(FreeBoardVO board);

	public List<FreeBoardVO> getBestList();

	public ArrayList<FreeBoardVO> getBestList5();

	public String selectDate();

}
