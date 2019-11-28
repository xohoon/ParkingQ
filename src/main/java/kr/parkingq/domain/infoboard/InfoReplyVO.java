package kr.parkingq.domain.infoboard;

import java.sql.Date;

import lombok.Data;

@Data
public class InfoReplyVO {

	private int no;
	private int gno;
	
	private String id;
	private String content;
	private Date idate;
	private String nick;

}
