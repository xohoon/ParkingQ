package kr.parkingq.domain.member;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	
	private long no;
	private String type;
	private String id;
	private String pass;
	private String nick;
	private String email;
	private String pFile;
	private Date date;
	
}
