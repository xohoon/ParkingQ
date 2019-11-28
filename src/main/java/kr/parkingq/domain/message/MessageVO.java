package kr.parkingq.domain.message;


import lombok.Data;

@Data
public class MessageVO {

	private long no;
	private int roomId;
	private String type;
	private String id;
	private String toId;
	private String content;
	private String pFile;
	private String idFile;
	private String toIdFile;
	private int read;
	private int unReadCount;
	private String mDate;
}
