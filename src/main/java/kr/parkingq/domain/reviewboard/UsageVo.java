package kr.parkingq.domain.reviewboard;

import java.sql.Date;

import lombok.Data;

@Data
public class UsageVo {
	//어플사용빈도
	int no;
	String id;
	Date udate;
}
