package kr.parkingq.domain.meetboard;

import java.util.Date;

import lombok.Data;

@Data
public class MeetBoardVO {
	
	private Long no;
	
	private Long mlike;
	private Long gmember;
	private Long greply;
	private Long mview;
	
	private String likeID;
	private String id;
	private String nick;
	private String mname;
	private String title;
	private String content;
	
	private String pfile;
	private String mfile;
	private String mdate;
	
	private String lat;
	private String lng;
	
}
