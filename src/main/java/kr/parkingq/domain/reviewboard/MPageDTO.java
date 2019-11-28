package kr.parkingq.domain.reviewboard;

import lombok.Data;


@Data
public class MPageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private PagingVO pg;
	
	public MPageDTO(PagingVO pg, int total) {
		this.pg = pg; //paging ó������ pageNum�� amount�� ���� �⺻������ �޾ƿ;� �Ѵ�.
		this.total=total; //total�� �Ƹ��� ��Ʈ�ѷ����� ���� ������ �־�� �� ���̴�.
		
		this.endPage=(int)(Math.ceil(pg.getPageNum()/5.0))*5;

		this.startPage=this.endPage-4;
		
		int realEnd=(int)(Math.ceil((total*1.0)/pg.getAmount()));
		
		if(realEnd<this.endPage) {
			this.endPage=realEnd;
		}
		
		this.prev=this.startPage>1;
		this.next=this.endPage<realEnd;
	}
}