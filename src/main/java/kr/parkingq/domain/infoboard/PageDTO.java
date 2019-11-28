package kr.parkingq.domain.infoboard;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total; //전체 데이터 수
	private Criteria cri; // 페이지번호, 페이지당 로우 개수 저장
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(cri.getPageNum()/10.0)) * 10; // 페이지별 마지막 페이지
		this.startPage = this.endPage - 9; //페이지별 시작 페이지
		
		int realEnd = (int) (Math.ceil((total*1.0) / cri.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		this.prev = this.startPage > 1; //연산식 만족하면 true 아니면 false
		
		this.next = this.endPage < realEnd; 
	}

}
