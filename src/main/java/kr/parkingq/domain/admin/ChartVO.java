package kr.parkingq.domain.admin;

import lombok.Data;

@Data
public class ChartVO {

	private int freeCount;
	private int meetCount;
	private int infoCount;
	private int reviewCount;
	
	private String tDate;
	private int visitCount;
	private int memberCount;
	private int messageCount;
	
}
