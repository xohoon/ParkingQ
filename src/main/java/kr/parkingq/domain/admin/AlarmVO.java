package kr.parkingq.domain.admin;

import lombok.Data;

@Data
public class AlarmVO {

	private long no;
	private long ano;
	private String id;
	private String nick;
	private String type;
	private String subject;
	private String content;
	private String aFile;
	private String aDate;
	
}