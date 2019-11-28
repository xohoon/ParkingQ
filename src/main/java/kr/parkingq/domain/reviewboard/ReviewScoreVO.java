package kr.parkingq.domain.reviewboard;

import lombok.Data;

@Data
public class ReviewScoreVO {
	//����
	int no;
	int avg;
	int appavgCount;
	int appavg1;
	int appavg2;
	int appavg3;
	int appavg4;
	int appavg5;
	int goodavgCount;
	int goodavg1;
	int goodavg2;
	int goodavg3;
	int goodavg4;
	int goodavg5;
	int reavgCount;
	int reavg1;
	int reavg2;
	int reavg3;
	int reavg4;
	int reavg5;
	
	int appavgscore1;
	int appavgscore2;
	int appavgscore3;
	int appavgscore4;
	int appavgscore5;
	int goodavgscore1;
	int goodavgscore2;
	int goodavgscore3;
	int goodavgscore4;
	int goodavgscore5;

	int reavgscore1;
	int reavgscore2;
	int reavgscore3;
	int reavgscore4;
	int reavgscore5;
	String rfile;
}
