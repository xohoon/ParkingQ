package kr.parkingq.mapper;

import java.util.List;

import kr.parkingq.domain.infoboard.InfoAttachVO;

public interface InfoAttachMapper {
	
	public void insert(InfoAttachVO vo);
	
	public void delete(String uuid);
	
	public List<InfoAttachVO> findByNo(int no);
	
	public void deleteAll(int no);
	
	

}
