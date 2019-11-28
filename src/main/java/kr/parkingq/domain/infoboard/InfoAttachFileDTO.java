package kr.parkingq.domain.infoboard;

import lombok.Data;

@Data
public class InfoAttachFileDTO {
	
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;

}
