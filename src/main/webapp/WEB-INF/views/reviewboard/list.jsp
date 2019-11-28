
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="/resources/js/reviewBoard.js" charset="utf-8"></script>
<script type="text/javascript" src="/resources/js/reviewReply.js" charset="utf-8"></script>
<script type="text/javascript" src="/resources/js/reviewboard/list.js" charset="utf-8"></script>
<link href="/resources/css/reviewboard/list.css" type="text/css" rel="stylesheet">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js" charset="utf-8"></script > 


<!--댓글정보 모달  -->
<div class="modal fade" id="myModals" tabindex="-1" role="dialog" 
aria-labelledby="myModalLabel" aria-hidden="true">

	<div class="modal-dialog">
		
		<div class="modal-content">
		
			<div class="modal-header">
			
				<h4 class="modal-title" id="myModalLabel"><b>이용후기 작성</b></h4>
				<button type="button" class="close" data-dismiss="modal" 
				aria-hidden="true">&times;</button>
			</div>
				<!-- end modal-header  -->
				
			<div class="modal-body">
			
				<!--파일첨부  -->
				<b id="fileTitle" style="display: block;margin: 10px auto; width: fit-content;">사진을 넣어주세요</b>
				<img class="" id="reviewboard_File" style="width:300px; height:250px;display: block !important; margin:0px auto;"
				 src="/images/reviewboard/drag.PNG">
				
				
				
				<div class="form-group" id="appavgForm" style="margin-top: 50px; ">
					<label style="display: block; width: 100%;font-size: 170%;text-align: center; font-weight: bold;">1. 앱에 대한 평가</label>
					<p style="display: block;width: 100%;text-align: center;font-size:100%;font-weight:bold;">해당 앱에대해서 어떤 평가를 내리시겠어요?</p>
					<button class="app btn btn-primary" style="width:100%;margin-bottom:10px;" value="5">아주 좋아요!</button>
					<button class="app btn btn-info" style="width:100%;margin-bottom:10px;" value="4">조금 좋아요!</button>
					<button class="app btn btn-success" style="width:100%;margin-bottom:10px;" value="3">보통이에요!</button>
					<button class="app btn btn-warning" style="width:100%;margin-bottom:10px;" value="2">별로에요!</button>
					<button class="app btn btn-danger" style="width:100%;margin-bottom:10px;" value="1">개선이 필요해요!</button>
				</div>
				
				<div class="form-group" id="goodavgForm" style="margin-top: 50px; ">
					<label style="display: block; width: 100%;font-size: 170%;text-align: center; font-weight: bold;">2. 처리 시간</label>
					<p style="display: block;width: 100%;text-align: center;font-size:100%;font-weight:bold;">앱을 이용한 후 차량을 빼어 주는데 걸린 시간은 마음에 드셨나요?</p>
					<button class="goodavg btn btn-primary" style="width:100%;margin-bottom:10px;" value="5">아주 좋아요!</button>
					<button class="goodavg btn btn-info" style="width:100%;margin-bottom:10px;" value="4">조금 좋아요!</button>
					<button class="goodavg btn btn-success" style="width:100%;margin-bottom:10px;" value="3">보통이에요!</button>
					<button class="goodavg btn btn-warning" style="width:100%;margin-bottom:10px;" value="2">별로에요!</button>
					<button class="goodavg btn btn-danger" style="width:100%;margin-bottom:10px;" value="1">개선이 필요해요!</button>
				</div>
				
				<div class="form-group" id="reavgForm" style="margin-top: 50px; ">
					<label style="display: block; width: 100%;font-size: 170%;text-align: center; font-weight: bold;">3. 상대 이용자에 대한 평가</label>
					<p style="display: block;width: 100%;text-align: center;font-size:100%;font-weight:bold;">상대 이용자들의 태도나 반응, 적극적인 면은 마음에 드셨나요?</p>
					<button class="re btn btn-primary" style="width:100%;margin-bottom:10px;" value="5">아주 좋아요!</button>
					<button class="re btn btn-info" style="width:100%;margin-bottom:10px;" value="4">조금 좋아요!</button>
					<button class="re btn btn-success" style="width:100%;margin-bottom:10px;" value="3">보통이에요!</button>
					<button class="re btn btn-warning" style="width:100%;margin-bottom:10px;" value="2">별로에요!</button>
					<button class="re btn btn-danger" style="width:100%;margin-bottom:10px;" value="1">개선이 필요해요!</button>
					
				</div>
				
				
				
				<form id="modalForm" role="form" action="/reviewboard/register" method="post">

					<input type="hidden" class="form-control" name="appavg" value="">
					<input type="hidden" class="form-control" name="goodavg" value="">
					<input type="hidden" class="form-control" name="reavg" value="">
					
					<div class="form-group" id="title">
                		<label style="display: block; margin: 10px auto; width: fit-content; font-weight: bold;">제목</label>
                		<input class="form-control" id="titleArea" name="title" placeholder="제목을 작성해주세요" maxlength="25">
                		<span id="counterTitle">/25</span>
                	</div>	
                		
                	<div class="form-group" id="content">
                		<label style="display: block; margin: 10px auto; width: fit-content; font-weight: bold;">내용</label>
                		<textarea class="form-control" id="contentArea" rows="1" name="content" placeholder="상대 앱 이용자의 차량번호 거론을 삼가해주세요" maxlength="1000"></textarea>
                		<span id="counter">/1000</span>
                		<input id="reviewboard_filetext" type="hidden" name="rfile" readonly>
                	</div>
                		
                		<button id="modal_reset" type="reset" class="btn btn-primary">다시쓰기</button>
                		<button id="modal_submit" type="submit" class="btn btn-primary">등록</button>
				</form>
				
				
					<!-- end form-group  -->
				
			
					<!-- end form-group  -->
					
			</div>
				<!-- end modal-body  -->
				<input id="registerCheck" type="hidden" value="<c:out value='${registerCheck}'/>">
				<div class="modal-footer">
					<button id='modalModBtn' type="button" type="button" class="btn btn-warning">Modify</button>
					<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
					<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
					<button id='modalCloseBtn' type="button" class="btn btn-default">취소</button>
				</div>
					<!-- end modal-footer  -->
		</div>
			<!-- end modal-content  -->
	</div>
		<!-- end modal-dialog  -->
</div>
	<!-- end myModal  -->




	<!-- main page frame  -->
	
	<div class="row">
    	<!-- <div class="col-lg-12">
    		<h2 class="page-header">Parking</h2><img class="page_header_img" src="/local_img/reviewboard/parking_q.png">
    		<div id="page_h"><img class="page_header_img" src="/images/reviewboard/parking_q_logo.png"></div>
        </div> -->
                <!-- /.col-lg-12 -->
	</div>
            <!-- /.row -->
    <div class="row">
    	<div class="col-lg-12">
    		<div class="panel panel-default">
				<div class="panel-heading">
                     
				</div>
                        <!-- /.panel-heading -->
				<div class="panel-body">
				
				
<!--통계가 들어가는 frame  -->
<div id="chart">
	<h3>앱 만족</h3>
	<!-- 별점이 들어가는 div  -->
	<div id="main_star_frame">
		<div id="main_star">
			<img class="star_image" src="/images/reviewboard/star_result.png">
			<div id="star_image_progress" class="progress-bar star_image_progress" role="progressbar"
				aria-valuenow="70" aria-valuemin="0" aria-valuemax="100"
				style="width:<c:out value='${chart.avg}'/>%"></div>
		</div>
	</div>
		<!-- end main_star_frame  -->
	<span><c:out value='${chart.avg}'/>%(<c:out value="${total }"/>명)</span>
	<br>
	<br>
	
	<table class="chart_table">
		<thead><tr><th>앱 만족도(개)</th><td><c:out value='${chart.appavgCount}'/></td></tr></thead>
		<tr><td><div class="progress">
		  <div class="progress-bar" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.appavgscore5}'/>%">
		    <c:out value='${chart.appavg5}'/>
		  </div>
		</div></td><td class="chart_text">아주 좋아요</td></tr>
		<tr><td><div class="progress">
		  <div class="progress-bar bg-info" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.appavgscore4}'/>%">
		    <c:out value='${chart.appavg4}'/>
		  </div>
		</div></td><td class="chart_text">조금 좋아요</td></tr>
		<tr><td><div class="progress">
		  <div class="progress-bar bg-success" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.appavgscore3}'/>%">
		    <c:out value='${chart.appavg3}'/>
		  </div>
		</div></td><td class="chart_text">보통이에요</td></tr>
		<tr><td><div class="progress">
		  <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.appavgscore2}'/>%">
		    <c:out value='${chart.appavg2}'/>
		  </div>
		</div></td><td class="chart_text">별로에요</td></tr>
		<tr><td><div class="progress">
		  <div class="progress-bar bg-danger" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.appavgscore1}'/>%">
		    <c:out value='${chart.appavg1}'/>
		  </div>
		</div></td><td class="chart_text">개선이 필요해요</td></tr>	
	</table>
	
	<table class="chart_table">
		<thead><tr><th>처리속도(개)</th><td><c:out value='${chart.appavgCount}'/></td></tr></thead>
		<tr><td><div class="progress">
		  <div class="progress-bar" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.goodavgscore5}'/>%">
		    <c:out value='${chart.goodavg5}'/>
		  </div>
		</div></td><td class="chart_text">아주 좋아요</td></tr>
		<tr><td><div class="progress">
		  <div class="progress-bar bg-info" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.goodavgscore4}'/>%">
		    <c:out value='${chart.goodavg4}'/>
		  </div>
		</div></td><td class="chart_text">조금 좋아요</td></tr>
		<tr><td><div class="progress">
		  <div class="progress-bar bg-success" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.goodavgscore3}'/>%">
		    <c:out value='${chart.goodavg3}'/>
		  </div>
		</div></td><td class="chart_text">보통이에요</td></tr>
		<tr><td><div class="progress">
		  <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.goodavgscore2}'/>%">
		    <c:out value='${chart.goodavg2}'/>
		  </div>
		</div></td><td class="chart_text">별로에요</td></tr>
		<tr><td><div class="progress">
		  <div class="progress-bar bg-danger" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.goodavgscore1}'/>%">
		    <c:out value='${chart.goodavg1}'/>
		  </div>
		</div></td><td class="chart_text">개선이 필요해요</td></tr>	
	</table>	
	
	<table class="chart_table">
		<thead><tr><th>상대 이용자 만족도(개)</th><td><c:out value='${chart.appavgCount}'/></td></tr></thead>
		<tr><td><div class="progress">
		  <div class="progress-bar" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.reavgscore5}'/>%">
		    <c:out value='${chart.reavg5}'/>
		  </div>
		</div></td><td class="chart_text">아주 좋아요</td></tr>
		<tr><td><div class="progress">
		  <div class="progress-bar bg-info" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.reavgscore4}'/>%">
		    <c:out value='${chart.reavg4}'/>
		  </div>
		</div></td><td class="chart_text">조금 좋아요</td></tr>
		<tr><td><div class="progress">
		  <div class="progress-bar bg-success" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.reavgscore3}'/>%">
		    <c:out value='${chart.reavg3}'/>
		  </div>
		</div></td><td class="chart_text">보통이에요</td></tr>
		<tr><td><div class="progress">
		  <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.reavgscore2}'/>%">
		    <c:out value='${chart.reavg2}'/>
		  </div>
		</div></td><td class="chart_text">별로에요</td></tr>
		<tr><td><div class="progress">
		  <div class="progress-bar bg-danger" role="progressbar" aria-valuenow="70"
		  aria-valuemin="0" aria-valuemax="100" style="width:<c:out value='${chart.reavgscore1}'/>%">
		    <c:out value='${chart.reavg1}'/>
		  </div>
		</div></td><td class="chart_text">개선이 필요해요</td></tr>	
	</table>
	
</div>
	<!--end chart  -->
				
				
					<button id="reg_button" class="btn btn-default float-lg-right"><img class="write_img" src="/images/reviewboard/write.PNG"/><b style="color:#777;">글쓰기</b></button>
					<div class="job"><h4>이용 후기</h4></div>
					<hr id="hr1">
					
					
					<!-- table-striped  -->
					<!--전체테이블 -->
					<table width="100%" class="table table-bordered" id="dataTables-example">
						<thead>
						<tr><th><div id="table_head">

									<c:choose>
										  <c:when test="${check eq '1'}">
										 		<div id ="d_id_lowStar" class="goods">별점낮은 순</div>
												<div id ="d_id_highStar" class="goods">별점높은 순</div>
										        <div id ="d_id_goods" class="goods">좋아요 순</div>
												<div id ="d_id_all" class="selected">전체</div>
										  </c:when>
										  <c:when test="${check eq '0'}">
										  		<div id ="d_id_lowStar" class="goods">별점낮은 순</div>
												<div id ="d_id_highStar" class="goods">별점높은 순</div>
										        <div id ="d_id_goods" class="selected">좋아요 순</div>
												<div id ="d_id_all" class="goods">전체</div>
										  </c:when>
										  <c:when test="${check eq '-1'}">
										        <div id ="d_id_lowStar" class="goods">별점낮은 순</div>
												<div id ="d_id_highStar" class="selected">별점높은 순</div>
										        <div id ="d_id_goods" class="goods">좋아요 순</div>
												<div id ="d_id_all" class="goods">전체</div>
										  </c:when>
										  <c:when test="${check eq '-2'}">
										        <div id ="d_id_lowStar" class="selected">별점낮은 순</div>
												<div id ="d_id_highStar" class="goods">별점높은 순</div>
										        <div id ="d_id_goods" class="goods">좋아요 순</div>
												<div id ="d_id_all" class="goods">전체</div>
										  </c:when>
										</c:choose>
								
								</div></th></tr>
						</thead>
						<tbody>
						
						
						<!--게시물 삽입  -->
					<c:forEach items="${list}" var="reviewboard">
						<tr class="table_body_tr">
							<!--펼치기 전 상태  -->
							<td class="reviewContent_close">
								<!--댓글 속 내용이 table의 td속에 존재하기 때문에 속 내용물들을 묶은 div이다  -->
								<div class="reviewContent_body_close">
									<button class="cancle_Btn_close btn btn-danger">닫기</button>	
								
									<!--hidden게시물번호  -->
									<input type="hidden" class="hidden_value" value="<c:out value="${reviewboard.no}" />"/>
									<input type="hidden" class="hidden_id" value="<c:out value="${id}"/>"/>
									<input type="hidden" class="hidden_nick" value="<c:out value="${nick}"/>"/>
									<input type="hidden" class="hidden_openClose" value="0">
									<input type="hidden" class="hidden_realId" value="<c:out value='${reviewboard.realId }'/>">
									<!--별점과 사진이 들어갈 div  -->
									<div class="review_left_close">
										<!--별점  -->
										<div class="review_left_star_close">	
											<!-- <div class="main_star"> -->
												<img class="star_image"
													src="/images/reviewboard/star_result.png">
												<div class="progress-bar star_image_board"
													role="progressbar" aria-valuenow="70" aria-valuemin="0"
													aria-valuemax="100" style="width:<c:out value="${reviewboard.avg}"/>%"></div>
											<!-- </div> -->	
										</div>
										<!--사진  -->
										<div class="review_left_picture_close"><img class="picture_close" src="
										<c:choose>
											<c:when test="${reviewboard.rfile != 'noImg'}">										
												/local_img/reviewboard/<c:out value='${reviewboard.rfile}'/>											
											</c:when>
											<c:when test="${reviewboard.rfile == 'noImg'}">
												/images/reviewboard/noimg.png
											</c:when>
										</c:choose>
										"></div>
									</div>
										<!-- end review_left  -->
										
									<!--제목과 내용이 들어갈 div  -->
									<div class="review_center_close">
										<!--별점이 들어가는 div. 게시물을 클릭 했을 시에만 나타난다  -->
										<div class="review_center_star_close">
											<!-- <div class="main_star"> -->
												<img class="star_image"
													src="/images/reviewboard/star_gray.png">
												<div class="progress-bar star_image_board"
													role="progressbar" aria-valuenow="70" aria-valuemin="0"
													aria-valuemax="100" style="width:<c:out value="${reviewboard.avg}"/>%"></div>
											<!-- </div> -->	</div>
										
										<!--제목  -->
										<div class="review_center_title_close"><c:out value="${reviewboard.title}" />
										<!-- 이미지 여부  -->
										&nbsp;&nbsp;<c:choose>
											<c:when test="${reviewboard.rfile.length() > 5}">
												<span style="font-size:70%;font-weight:normal;">
												<img src="/images/reviewboard/file.PNG" style="width:18px;vertical-align: unset;"></span>
											</c:when>
										</c:choose>
										<!--댓글 수  -->
										<img src="/images/reviewboard/comment.PNG" style="width:21px;vertical-align:top;">
										<span class="commentCount" style="vertical-align:top;position:absolute;line-height:initial;display:inline-block;font-weight: normal; font-size:80%">
										<c:out value="${reviewboard.commentCount}"/></span>
										</div>
										
										<!--게시물 내용  -->
										<div class="review_center_content_close"><c:out value="${reviewboard.content_close}"/>
										&nbsp;&nbsp;<a href="#" class="purchur">자세히 보기</a></div>
										<div class="review_center_content"><c:out value="${reviewboard.content}"/></div>	
									</div>
										<!-- end review_center  -->
									
									
									<c:choose>
										<c:when test="${reviewboard.realId eq id }">
											<button value="<c:out value='${reviewboard.no }'/>" class="btn btn-default delete_button">
											<b style="color:#777;">삭제</b></button>
										</c:when>
										
									</c:choose>
									<!--평가점수와 id, 작성일, 평균만족도, 좋아요가 들어갈 div  -->
									<div class="review_right_close">
										<!--후기 항목에대한 평가 그림3개  -->
										<div class="review_right_appraisal_close">
											<div class="review_right_appraisal_a_close">
											<img class="score_img"
													src="/images/reviewboard/<c:out value="${reviewboard.appavg }"/>.PNG"></div>
											
											<div class="review_right_appraisal_b_close">
											<img class="score_img"
													src="/images/reviewboard/<c:out value="${reviewboard.goodavg }"/>.PNG"></div>
											
											<div class="review_right_appraisal_c_close">
											<img class="score_img"
													src="/images/reviewboard/<c:out value="${reviewboard.reavg }"/>.PNG"></div>
										</div>
										
										<!--아이디와 작성날짜  -->
										<div class="review_right_IdDate_close">
											<!--작성자 아이디  -->
											<c:out value="${reviewboard.id}" />&nbsp; &nbsp;
											<!--작성날짜  -->
											<fmt:formatDate pattern="yyyy-MM-dd hh:mm.ss" value="${reviewboard.rdate}" />
										</div>
										
										<!-- 좋아요  -->
										<div id="goods<c:out value='${reviewboard.no}'></c:out>" 
										class=<c:choose>
										  <c:when test="${reviewboard.usergoods eq '0'}">
										        "review_right_goods_point No_goods_color review_right_goods_close"
										  </c:when>
										  <c:when test="${reviewboard.usergoods eq '1'}">
										        "review_right_goods_point Yes_goods_color review_right_goods_close"
										  </c:when>
										</c:choose>
										>
										Goods:<c:out value="${reviewboard.goods }"></c:out></div>
									</div>
										<!--end review_right  -->
	
									<!--start comment frame  -->
									<div class="review_final_comment_close">
											
										<!--댓글  -->
										<div class="panel panel-default">               		
							                <div class="panel-heading ohmygod">
							                
							                	<!--클릭하기전까지 diplay none 상태  -->
												<img class="parking_q_img" src="/images/reviewboard/parking_q.png"/> <b class="parking_q_id">${id }</b>
												<Textarea maxlength="500" class='form-control replyContent' rows='3' name='content' 
													placeholder='저작권 등 다른 사람의 권리를 침해하거나 명예를 회손하는 게시물은 이용약관 및 관련 법률에 의해 제재를 받을 수 있습니다. 건전한 토론문화와 양질의 댓글 문화를 위해, 타인에게 불쾌감을 주는 욕설 또는 특정 계층/민족, 종교 등을 비하하는 단어들은 자제해 주시기 바랍니다.'></Textarea>
	        									<span class="counterComment">###</span>
	        									<button id='addReplyBtn1' class='btn btn-primary commentwrite'>등록</button>
	        									
							               	</div>
								                <!-- /.panel-heading  -->
								           	<div class="panel-body">
								            	<ul class="chat">
								            		<!--start reply  -->    
								            				
								            		<!--end reply  -->
								            	</ul>
								            </div>
								            	<!-- /.panel-body  -->
								            			
								            <!-- chat-panel 추가  -->
								            <div class="panel-footer">
								            		
								            </div>	
								            	<!-- end panel-footer  -->
								            
								            
								         </div>
								            <!-- /.panel-default  -->
					                </div>
					                	<!--end review_final_comment  -->
					                			
									
								</div>
									<!--reviewContent_body  -->
							</td>
								<!--end reviewContent_close  -->



						</tr>
						</c:forEach>
						</tbody>

					</table>
		
		
		

								<!-- 게시물 페이징 start  -->
								<div style="margin-top:60px;display:flex;justify-content:center;">
                                <div class='pull-right'>
                                	<ul class="pagination">
                                		
                                		<c:if test="${pageMaker.prev }">
                                			<li class="paginate_button previous">
                                			<a class="page-link" href="${pageMaker.startPage-1 }">Previous</a></li>
                                		</c:if>
                                		
                                		<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
                                		<li class="paginate_button ${pageMaker.pg.pageNum==num?'active':'' }">
                                		<a class="page-link" href="${num }">${num }</a></li>
                                		</c:forEach>
                                		
                                		<c:if test="${pageMaker.next }">
                                			<li class="paginate_button next">
                                			<a class="page-link" href="${pageMaker.endPage+1 }">Next</a></li>
                                		</c:if>
                                		
                                	</ul>
                                <!-- End pagination  -->
                                </div>
                                </div>
                                 <!-- <div class='row'></div> -->
                                 
                            <!--페이징 버튼 폼  -->
							<form id='actionForm' action="/reviewboard/list/main" method="get">
								<input type="hidden" name='pageNum' value="${pageMaker.pg.pageNum }">
								<input type="hidden" name='amount' value="${pageMaker.pg.amount }">
							</form>
							<!-- End 게시물 페이징  -->
							
							<!--페이징 버튼 폼  -->
							<form id='actionGoodsForm' action="/reviewboard/list/goodsList" method="get">
								<input type="hidden" name='pageNum' value="${pageMaker.pg.pageNum }">
								<input type="hidden" name='amount' value="${pageMaker.pg.amount }">
							</form>
							<!-- End 게시물 페이징  -->
							
							<!--페이징 버튼 폼  -->
							<form id='actionHighStarForm' action="/reviewboard/list/highStar" method="get">
								<input type="hidden" name='pageNum' value="${pageMaker.pg.pageNum }">
								<input type="hidden" name='amount' value="${pageMaker.pg.amount }">
							</form>
							<!-- End 게시물 페이징  -->
							
							<!--페이징 버튼 폼  -->
							<form id='actionLowStarForm' action="/reviewboard/list/lowStar" method="get">
								<input type="hidden" name='pageNum' value="${pageMaker.pg.pageNum }">
								<input type="hidden" name='amount' value="${pageMaker.pg.amount }">
							</form>
							<!-- End 게시물 페이징  -->
							
							
							
							
							
							
                      <!-- 게시물 쓰기 결과값에 다른 Modal  -->
                      <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                      aria-labelledby="myModalLabel" aria-hidden="true">
                      	<div class="modal-dialog">
                      		<div class="modal-content">
                      				
                      			<div class="modal-header">
                      				<h4 class="modal-title float-lg-left" id="myModalLabel">Modal title</h4>
                      				<button type="button" class="close" data-dismiss="modal"
                      				aria-hidden="true">&times;</button>
                      			</div>
                      			<!--end modal-header  -->
                      			
                      			<div class="modal-body">처리가 완료되었습니다</div>
                      			
                      			<div class="modal-footer">
                      				<button type="button" class="btn btn-default"
                      				data-dismiss="modal">Close</button>
                      				<button type="button" class="btn btn-primary">Save changes</button>
                      				</div>
                      				<!--end modal-footer  -->
                      		</div>
                      		<!--end modal-content  -->
                      	</div>
                      	<!--modal-dialog  -->
                      </div>
                      <!--end modal fade  -->         
              	</div>
                        <!-- /.panel-body -->
           	</div>
                    <!-- /.panel -->
    	</div>
                <!-- /.col-lg-6 -->
	</div>
            <!-- /.row -->
<script>
	//게시글 등록에 관한 모달창
	$(document).ready(function(){
		$('.topheader_subject_text').html('이용후기');
		modalStart.checkModalStart("<c:out value='${result}'/>");
	});
	
   $(function () {
      var obj = $("#reviewboard_File");
      
    obj.on('dragenter', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $(this).css('border', '4px solid #5272A0');
    });
   
    obj.on('dragleave', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $(this).css('border', '1px solid transparent');
    });
   
    obj.on('dragover', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });
   
    obj.on('drop', function (e) {
         e.preventDefault();
         $(this).css('border', '1px solid transparent');
         var files = e.originalEvent.dataTransfer.files;
         var file = files[0];
        
    
         uploadReviewfile(file);
        
    });
   
   });

   // file upload
   
   function uploadReviewfile(file) {
      
      var formData = new FormData();
      formData.append("file", file);
      
            $.ajax({
               url: '/reviewboard/uploadFile',
               type: 'post',
               data:formData,
               dataType: 'text',
               processData: false,
               contentType: false,
               success: function(data) {

                   $('#reviewboard_File').attr('src',  '/local_img/reviewboard/'+data);
                   $('#reviewboard_filetext').val(data);
                   swal("사진등록 완료");
               }
            });
   }
   
   
   
   $(document).ready(function(){
      uploadReviewfile();
   });

   </script>