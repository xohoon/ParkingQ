package kr.parkingq.domain.member;

import java.util.Date;

import lombok.Data;

@Data
public class ConnectLogVO {

	private long no;
	private String id;
	private Date cdate;
	private String pFile;
	
}
