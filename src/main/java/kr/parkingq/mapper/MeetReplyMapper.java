package kr.parkingq.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.parkingq.domain.meetboard.MeetCriteria;
import kr.parkingq.domain.meetboard.MeetReplyVO;

public interface MeetReplyMapper {
	
	public int insert(MeetReplyVO vo);
	
	public MeetReplyVO read(Long no);
	
	public int delete(Long no);
	
	public int update(MeetReplyVO reply);
	
	public List<MeetReplyVO> getListWithPaging(
			@Param("cri") MeetCriteria cri,
			@Param("no") Long no);
	
	public int getCountByNo(Long no);

}
