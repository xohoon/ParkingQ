package kr.parkingq.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.parkingq.domain.infoboard.Criteria;
import kr.parkingq.domain.infoboard.InfoReplyVO;

public interface InfoReplyMapper {
	
	public int insertSelectKey(InfoReplyVO vo);
	
	public InfoReplyVO read(int no);
	
	public int delete(int no);
	
	public int update(InfoReplyVO reply);
	
	public List<InfoReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("no") int no);

}
