package kr.parkingq.service.infoboard;

import java.util.List;

import kr.parkingq.domain.infoboard.Criteria;
import kr.parkingq.domain.infoboard.InfoAttachVO;
import kr.parkingq.domain.infoboard.InfoBoardVO;
import kr.parkingq.domain.infoboard.infoLikeVO;

public interface InfoBoardService {
	
	//�۵�� 
	public void register(InfoBoardVO board);
	
	//�� ����
	public InfoBoardVO getBoard(Long bno);
	
	//�ۼ���
	public boolean modify(InfoBoardVO board);
	
	//�� ����
	public boolean remove(int no);
	
	//�۸�� ��������
	public List<InfoBoardVO> getList(Criteria cri);
	
	public InfoBoardVO get(int no);
	
	public List<InfoAttachVO> getAttachList(int no);

	public int getLike(infoLikeVO like);

	public int addLike(infoLikeVO like);

	public int deleteLike(infoLikeVO like);

	public int checkLike(infoLikeVO like);

	public void addMap(InfoBoardVO board);

	public InfoBoardVO getMap(int no);

	public int updateMap(InfoBoardVO board);

}
