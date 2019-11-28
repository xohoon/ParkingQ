package kr.parkingq.domain.freeboard;

import java.sql.Date;

import lombok.Data;

@Data
public class FreeCommentVO {

	private Long no;
	private Long gno;
	
	private String id;
	private String nick;
	private String content;
	private Date fdate;
	
}
