package kr.parkingq.domain.meetboard;


import lombok.Data;

@Data
public class MeetMapVO {
	
	private Long no;
	private String lat;
	private String lng;
	private String address;
	private String bounds;

}
