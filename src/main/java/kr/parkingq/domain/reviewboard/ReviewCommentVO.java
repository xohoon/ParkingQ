package kr.parkingq.domain.reviewboard;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewCommentVO {
	Long no; //primary key
	Long gno; //foreign key
	String id; //replayer
	String realId;
	String nick; //add myself
	String content; //reply
	Date rdate; //replyDate
	Date up_date; //updatedate
	String del_yn;
}
