package kr.parkingq.domain.freeboard;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class CommentPageDTO {

	private int replyCnt;
	private List<FreeCommentVO> list;
	
}
