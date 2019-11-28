package kr.parkingq.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.parkingq.domain.freeboard.Criteria;
import kr.parkingq.domain.freeboard.FreeBoardVO;
import kr.parkingq.domain.freeboard.FreeLikeCountVO;
import kr.parkingq.domain.freeboard.FreeLikeVO;

public interface FreeBoardMapper {

	//페이징&리스트
	public List<FreeBoardVO> getListWithPaging(Criteria cri);
	
	//글등록
	public void insertSelectKey(FreeBoardVO board);
	
	//글 조회
	public FreeBoardVO read(FreeLikeCountVO likeCnt);
	
	//조회수 구하기
	public int updateReadCnt(Long bno);
	
	//글삭제
	public int delete(Long bno);
	
	//글수정
	public int update(FreeBoardVO board);
	
	//전체글 개수구하기
	public int getTotalCount(Criteria cri);
	
	//댓글 개수 구하기
	public void updateReplyCnt(@Param("no")Long no, 
			@Param("amount")int amount);

	//추천
	public int getLike(FreeLikeVO like);
	public int addLike(FreeLikeVO like);
	public int deleteLike(FreeLikeVO like);

	//답글등록
	public void insertRewrite(FreeBoardVO board);

	//답글정렬
	public void checkSeq(FreeBoardVO board);

	//베스트게시글
	public List<FreeBoardVO> bestList();

	public ArrayList<FreeBoardVO> getBestList5();

	public String selectDate();
}
