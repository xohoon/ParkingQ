package kr.parkingq.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.parkingq.domain.reviewboard.PagingVO;
import kr.parkingq.domain.reviewboard.ReviewCommentVO;

public interface ReviewReplyMapper {
	//add comment
	public int insert(ReviewCommentVO vo);
	//read comment
	public ReviewCommentVO read(Long no);
	//delete comment
	public int delete(Long no);
	//update comment
	public int update(ReviewCommentVO vo);
	//comment paging
	public List<ReviewCommentVO> getListWithPaging(@Param("pgv") PagingVO pgv, @Param("gno") Long gno);
	//comment count
	public int getCountByGno(Long gno);
	
}
