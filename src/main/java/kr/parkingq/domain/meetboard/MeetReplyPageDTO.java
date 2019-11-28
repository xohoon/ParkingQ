package kr.parkingq.domain.meetboard;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class MeetReplyPageDTO {
	
	private int replyCnt;
	private List<MeetReplyVO> list;

}
