package kr.parkingq.domain.meetboard;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class MeetPageDTO {
	
	private int startPage;
	private int endPage;
	private int total;
	
	private boolean prev, next;
	
	private MeetCriteria cri;
	
// paging proccess
	
	
public MeetPageDTO(MeetCriteria cri, int total) {
	this.cri = cri;
	this.total = total;
	
	this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
	
	this.startPage = this.endPage -9;
	
	int realEnd = (int) (Math.ceil(total * 1.0) / cri.getAmount());
	
	if(realEnd <= this.endPage) {
		this.endPage = realEnd;
		}
	
	this.prev = this.startPage > 1;
	this.next = this.endPage < realEnd;
	
	}

}