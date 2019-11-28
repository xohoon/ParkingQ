package kr.parkingq.mapper;

import java.util.List;

import kr.parkingq.domain.infoboard.Criteria;
import kr.parkingq.domain.infoboard.InfoBoardVO;
import kr.parkingq.domain.infoboard.infoLikeVO;

public interface InfoBoardMapper {

	//�Խù� ��� �� ������
	public List<InfoBoardVO> getList();
	
	//�۵��
	public void insert(InfoBoardVO board);
	
	//�Խñ۹�ȣ 1������ @SelectKey 
	public void insertSelectKey(InfoBoardVO board);
	
	//�� ����
	public InfoBoardVO read(int no);
	
	//�� ����
	public int delete(int no);
	
	//�� ����
	public int update(InfoBoardVO board);
	
	public List<InfoBoardVO> getListWithPaging(Criteria cri);

	public int getLike(infoLikeVO like);

	public int addLike(infoLikeVO like);

	public int deleteLike(infoLikeVO like);

	public int checkLike(infoLikeVO like);

	public void addMap(InfoBoardVO board);

	public InfoBoardVO getMap(int no);

	public int updateMap(InfoBoardVO board);
}
