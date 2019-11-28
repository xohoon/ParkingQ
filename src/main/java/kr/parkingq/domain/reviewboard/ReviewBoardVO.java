package kr.parkingq.domain.reviewboard;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewBoardVO {
	//�ı�Խ���
	long no;
	String realId;
	String id;
	String nick;
	String title;
	String content;
	String content_close;
	String reform;
	String rfile;
	Date rdate;
	Date up_date;
	String del_yn;
	int goods;
	int usergoods;
	int avg;
	int appavg;
	int goodavg;
	int reavg;  
	int readcount;
	int commentCount;
}
