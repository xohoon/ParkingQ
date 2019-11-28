package kr.parkingq.domain.admin;

import lombok.Data;

@Data
public class AdminMemberVO {

	// Member Infomation
	private long no;
	private String type;
	private String id;
	private String pass;
	private String nick;
	private String email;
	private String mDate;
	
	// QR CODE
	private String key;
	
	// Connect Log
	private String cDate;
	
	
}
