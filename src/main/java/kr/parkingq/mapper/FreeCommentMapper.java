package kr.parkingq.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.parkingq.domain.freeboard.Criteria;
import kr.parkingq.domain.freeboard.FreeCommentVO;

public interface FreeCommentMapper {
	
	
	public int insert(FreeCommentVO vo);
	
	public FreeCommentVO read(Long no);

	public int  delete(Long no);
	
	public int update(FreeCommentVO vo);
	
	public List<FreeCommentVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("no") Long no);
	
	public int getCountByNo(Long no);
}








