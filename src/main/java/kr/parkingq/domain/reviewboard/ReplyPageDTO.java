package kr.parkingq.domain.reviewboard;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {
	private int replyCnt;
	private List<ReviewCommentVO> list;
	//List<ReplyVO>와 댓글의 수를 전달받음
	//객체 생성 시에 편리하도록 @AllArgsConstructor를 이용해서 replyCnt와 list를 생성자의 파라미터로 처리한다
	
}
