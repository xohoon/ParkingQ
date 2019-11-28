package kr.parkingq.domain.member;

import lombok.Data;

@Data
public class FriendVO {

	private long no;
	private String id;
	private String fId;
	private String pFile;
	private int request;
	private boolean check;
	
}
