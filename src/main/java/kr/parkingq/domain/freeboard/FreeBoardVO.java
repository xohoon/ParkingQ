package kr.parkingq.domain.freeboard;

import java.sql.Date;

import lombok.Data;

@Data
public class FreeBoardVO {

	private Long no;
	private String id;
	private String nick;
	private String title;
	private String content;
	private Long gno;
	private int ref;
	private int lev;
	private int seq;
	private Date fdate;
	private int freadCount;
	private int flike; 
	private String ffile; 
	private int replyCnt;
	private String likeId;
	private String profile;
	
	private String nowDate;
}
