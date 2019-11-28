package kr.parkingq.service.infoboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.parkingq.domain.infoboard.Criteria;
import kr.parkingq.domain.infoboard.InfoAttachVO;
import kr.parkingq.domain.infoboard.InfoBoardVO;
import kr.parkingq.domain.infoboard.infoLikeVO;
import kr.parkingq.mapper.InfoAttachMapper;
import kr.parkingq.mapper.InfoBoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class InfoBoardServiceImpl implements InfoBoardService{

	@Setter(onMethod_ = @Autowired)
	private InfoBoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private InfoAttachMapper attachMapper;
	
	
	@Transactional
	@Override
	public void register(InfoBoardVO board) {
		log.info("serviceimpl register() >>>>>>>>> �۵�� "+board);
		mapper.insertSelectKey(board);
		if(board.getAttachList()==null || board.getAttachList().size() <= 0) {
			return;
		}
		board.getAttachList().forEach(attach ->{
			attach.setNo(board.getNo());
			attachMapper.insert(attach);
		});
	}

	@Transactional
	@Override
	public boolean modify(InfoBoardVO board) {

		log.info("modify......" + board);
		System.out.println("board>>>>"+board);

		attachMapper.deleteAll(board.getNo());

		boolean modifyResult = mapper.update(board) == 1;
		System.out.println("modifyResult>>>>>1"+modifyResult);
		System.out.println("board.getAttachList().size()>>"+board.getAttachList());
		
		if(board.getAttachList()!=null) {
			if(board.getAttachList().size() > 0 && modifyResult){
				System.out.println("modifyResult>>>>>2"+modifyResult);

				board.getAttachList().forEach(attach -> {

				attach.setNo(board.getNo());
				attachMapper.insert(attach);
			});
			}
		
		}return modifyResult;
	}


	@Override
	public boolean remove(int no) {
		log.info("remove....");
		attachMapper.deleteAll(no);
		return mapper.delete(no) ==1;
	}

	@Override
	public List<InfoBoardVO> getList(Criteria cri) {
		log.info("getList with criteria...."+cri);
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public InfoBoardVO get(int no) {
		log.info("get..."+no);
		return mapper.read(no);
	}
	@Override
	public InfoBoardVO getBoard(Long bno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<InfoAttachVO> getAttachList(int no) {
		log.info("get attach list by no >>>"+no);
		
		return attachMapper.findByNo(no);
	}

	@Override
	public int getLike(infoLikeVO like) {
		int resultNum = mapper.getLike(like);
		log.info("resultNum>>>"+resultNum);

		return resultNum;
	}

	@Override
	public int addLike(infoLikeVO like) {
		int resultNum = mapper.addLike(like);
		log.info("resultNum>>>"+resultNum);

		return resultNum;
	}

	@Override
	public int deleteLike(infoLikeVO like) {
		int resultNum = mapper.deleteLike(like);
		log.info("resultNum>>>"+resultNum);

		return resultNum;
	}

	@Override
	public int checkLike(infoLikeVO like) {
		int resultNum = mapper.checkLike(like);
		log.info("checkLike resultNum>>>>>"+resultNum);
		return resultNum;
	}

	@Override
	public void addMap(InfoBoardVO board) {
		mapper.addMap(board);
	}

	@Override
	public InfoBoardVO getMap(int no) {
		return mapper.getMap(no);
	}

	@Override
	public int updateMap(InfoBoardVO board) {
		return mapper.updateMap(board);
	}
	
}
