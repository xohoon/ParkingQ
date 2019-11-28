package kr.parkingq.domain.infoboard;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class InfoBoardVO {

	private int no;
	private String id;
	private String nick;
	private String title;
	private String content;
	private String spot;
	private int gno;
	private int ref;
	private int lev;
	
	private String ifile;
	private String lat;
	private String lng;
	private String userId;
	private Date idate;
	private List<InfoAttachVO> attachList;
}
