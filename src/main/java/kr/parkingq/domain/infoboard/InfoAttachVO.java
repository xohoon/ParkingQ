package kr.parkingq.domain.infoboard;

import lombok.Data;

@Data
public class InfoAttachVO {
	
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean fileType;
	
	private int no;

}
