package kr.parkingq.domain.reviewboard;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagingVO {
	private int pageNum;
	private int amount;
	private String id;
	
	public PagingVO() {
		this(1,10);
	}
	
	public PagingVO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public PagingVO(int pageNum, int amount, String id) {
		this.pageNum= pageNum;
		this.amount = amount;
		this.id = id;
	}

	
}
