<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
	
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>
#board{
	height: 700px;
}
#board_div{
	float:left;
	left:455px;
	width:770px;
	margin-left: 10px;
	padding :10px;}

#board_div .form-group{
height: 80px;
}

#fb_img{
	float:left;
	margin-top:15px;
	margin-left: 30px; 
	width: 450px;}
#fb_content{
	clear:left;
	width: 1200px;
	margin-top:25px;
	margin-left: 29px; }
#fb_img img{ border-radius: 10px;}
#rewrite_btn{
    display: inline;
    margin-left: 18px;
}
#textarea{height:250px;
width: 1222px;}
.btn {
	border: 0 solid;
	box-shadow: inset 0 0 20px rgba(255, 255, 255, 0);
	-webkit-transition: all 1.25s cubic-bezier(0.19, 1, 0.22, 1);
	transition: all 1.25s cubic-bezier(0.19, 1, 0.22, 1);
	}
.btn:hover {
	box-shadow: inset 0 0 20px rgba(255, 255, 255, 0.5), 0 0 20px rgba(255, 255, 255, 0.2);
	outline-offset: 15px;
	text-shadow: 1px 1px 2px #427388;}
#get_btn{
    text-align: right;
    margin-top: 50px;
    margin-bottom: 50px;
    justify-content: center;
    float: right;
    width: 100%;
	}
#get_btn button {
	margin-left: 16px;
}
#middel_btn{
	display: block;
    background-color: #e9ecef;
    padding: 10px;
    border-radius: 8px;
    width: 1222px;
    margin-left: 27px;
}

li {list-style: none;}

#re_form{
display: inline;
}
.panel-heading{
	clear:right;
	float: right;}
.panel-body{clear: right;}
#like{ cursor:pointer;}

.modal {
        text-align: center;
}
@media screen and (min-width: 768px) { 
        .modal:before {
                display: inline-block;
                vertical-align: middle;
                content: " ";
                height: 100%;
        }
}
.modal-dialog {
        display: inline-block;
        text-align: left;
        vertical-align: middle;
}
label {	font-size: 24px;}
#reply_div{
	clear: both;
}
#replyUpdate{
	display: block;
    float: right;
    margin-right: 15px;
}
</style>

<div id="wrap">

<div id="board">
	<div id="fb_img">
		<c:choose>
			<c:when test="${board.ffile != null}">			
				<img id="board_img" src="/local_img/freeboard/${board.ffile }" 
				style="width:450px;height:350px; margin-top:20px;">
			</c:when>
			<c:when test="${board.ffile == null}">
				<img id="board_img" src="http://www.rmei.info/images/joomlart/demo/default.jpg"
				 style="width:450px;height:350px;margin-top:20px;">
			</c:when>
		</c:choose>
	</div>

	<div id="board_div">
		
		<div class="form-group">
			<label>No</label> <input class="form-control" name='no'
				value='<c:out value="${board.no }" />' readonly="readonly">
		</div>
		<div class="form-group">
			<label>제목</label> <input class="form-control" name='title'
				value='<c:out value="${board.title }" />' readonly="readonly">
		</div>
		<div class="form-group">
			<label>작성자</label> <input class="form-control" name='id'
				value='<c:out value="${board.id }" />' readonly="readonly">
		</div>
		<div class="form-group">
			<label>작성일자</label> <input class="form-control" name='fdate'
				value='<c:out value="${board.fdate }" />' readonly="readonly">
		</div>
	<!-- 게시글 상단 div board_div -->
	</div>
	
	<div id="fb_content">
		<label>내용</label>
		<textarea class="form-control" rows="3" name='content' id="textarea" readonly="readonly">
           		<c:out value="${board.content }" />
            </textarea>
	</div>
	
</div>
<div style="text-align: center;margin-top: 30px;">
			<c:choose>
				<c:when test="${board.likeId eq userId}">
					<!-- <img src="/local_img/"> -->
					<button id="like" class="btn btn-default" style="visibility:visible;">추천</button>
					<button id="like" class="btn btn-danger" style="visibility:hidden;">추천</button>
				</c:when>
				<c:when test="${board.likeId ne userId}">
					<button id="like" class="btn btn-default" style="visibility:visible;">추천</button>
					<button id="like" class="btn btn-danger" style="visibility:hidden;">추천</button>
				</c:when>
			</c:choose>
</div>
	<!-- button -->

<div id="get_btn">
	<div id="middel_btn">
	
	<c:choose>
		<c:when test="${board.id eq userId}">	
			<button data-oper='modify' class="btn btn-danger">수정</button>
		</c:when>
	</c:choose>
	
	<form action="/freeboard/rewrite" method="get" id="re_form">
		<input type="submit" class="btn btn-primary" id="rewrite_btn" value="답글쓰기">
		<input type="hidden" name="seq" value='<c:out value="${board.seq}"/>' >	
		<input type="hidden" name="ref" value='<c:out value="${board.ref}"/>' >	
		<input type="hidden" name="lev" value='<c:out value="${board.lev}"/>' >		
	</form>
	
	<button data-oper='list' class="btn btn-success">목록</button>
	
	
	</div>
</div>

	<form id='operForm' action="freeboard/modify" method="get">
		<input type='hidden' id='no' name='no'
			value='<c:out value="${board.no}" />'> <input type='hidden'
			name='pageNum' value='<c:out value="${cri.pageNum}"/>'> <input
			type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>

		<input type='hidden' name='keyword'
			value='<c:out value="${cri.keyword}"/>'> <input type='hidden'
			name='type' value='<c:out value="${cri.type}"/>'>
	</form>

<!-- Reply Table View -->


<div id="reply_div">
	<button id='addReplyBtn' class="btn btn-warning" 
	style="width:100px;margin-top:20px;margin-left:1130px;margin-bottom:20px;">댓글 달기</button>

	<ul class="chat">
		<!-- start reply -->
		<li class="left clearfix" data-gno='12'>
			<div>
				<div class="header">
					<strong class="primary-font">user00</strong> <small
						class="pull-right text-muted">2018-01-01 13:13</small>
				</div>
				<p>Good Job!!!</p>
			</div>
		</li>
	</ul>
</div>

<div class="panel-footer" style="margin-left: 630px; margin-top: 20px;">

</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" style="width:650px">
			<div class="modal-header" style="width:650px; text-align: center;">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글달기</h4>
			</div>
			<div class="modal-body" style="width:650px">
				<div class="form-group">
					<label>댓글</label><input class="form-control" name='content' value="new reply!!!!">
				</div>

			</div>
			<div class="modal-footer" style="width:650px">
				<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
				<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
				<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
				<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
</div>


<!-- freecommentService  -->
<script type="text/javascript">
	$(document).ready(function() {
		
		$('.topheader_subject_text').html('자유게시판');

						console.log("FreeComment Module..........");

						var freecommentService = (function() {

							//댓글 등록 처리
							function add(comment, callback, error) {
								console.log("add reply.............");
								console.log(comment+">>>>><><><><><><><>");
								
								$.ajax({
											type : 'post',
											url : '/replies/new',
											data : JSON.stringify(comment),
											async: false,
											contentType : "application/json; charset=utf-8",
											success : function(result, status,
													xhr) {
												if (callback) {
													callback(result);
												}
											},error : function(xhr, status, er) {
												console.log("add reply>>>>>>>>>>>>>>>");
												if (error) {
													error(er);
												}
											}
										});
							}

							//댓글 목록 처리
							function getList(param, callback, error) {
								var no = param.no;
								var page = param.page || 1;

								$.getJSON("/replies/pages/" + no + "/" + page + ".json", 
										function(data) {
											if (callback) {

												//callback(data); 댓글 목록만 가져 오는 경우
												callback(data.replyCnt, data.list); // 댓글 숫자와 목록을 가져오는 경우 
												}
										}).fail(function(xhr, status, err) {
									if (error) {
										error();
									}
								});
							}

							//댓글 삭제
							function remove(gno, callback, error) {
								$.ajax({

									type : 'delete',
									url : '/replies/' + gno,
									async: false,
									success : function(deleteResult, status,
											xhr) {
										if (callback) {
											callback(deleteResult);
										}
									},
									error : function(xhr, status, er) {
										if (error) {
											error(er);
										}
									}
								});
							}

							//댓글 수정
							function update(commentVO, callback, error) {
								console.log("GNO :" + commentVO.gno);

								$.ajax({type : 'put',
											url : '/replies/' + commentVO.gno,
											data : JSON.stringify(commentVO),
											async: false,
											contentType : "application/json; charset=utf-8",
											success : function(result, status,
													xhr) {
												if (callback) {
													callback(result);
												}
											},
											error : function(xhr, status, er) {
												if (error) {
													error(er);
												}
											}
										});
							}
							//댓글 조회 
							function get(gno, callback, error) {
								$.get("/replies/" + gno + ".json",
										function(result) {
											if (callback) {
												callback(result);
											}
										}).fail(function(xhr, status, err) {
									if (error) {
										error();
									}
								});
							}
							//날짜 출력 처리
							function displayTime(timeValue) {
								var today = new Date();
								var gap = today.getTime() - timeValue;
								var dateObj = new Date(timeValue);
								var str = "";

								if (gap < (1000 * 60 * 60 * 24)) {
									var hh = dateObj.getHours();
									var mi = dateObj.getMinutes();
									var ss = dateObj.getSeconds();

									return [ (hh > 9 ? ' ' : '0') + hh, ':',
											(mi > 9 ? ' ' : '0') + mi, ':',
											(ss > 9 ? ' ' : '0') + ss ]
											.join(' ');
								} else {
									var yy = dateObj.getFullYear();
									var mm = dateObj.getMonth() + 1;
									var dd = dateObj.getDate();
									return [ yy, '/',
											(mm > 9 ? ' ' : '0') + mm, '/',
											(dd > 9 ? ' ' : '0') + dd ]
											.join(' ');
								}
							};
							return {
								add : add,
								get : get,
								getList : getList,
								remove : remove,
								update : update,
								displayTime : displayTime
							};
						})();
						
						/* end js */
		
						var noValue = '<c:out value="${board.no}"/>';
						var cookieId = $.cookie("userId");
						var replyUL = $(".chat");

						showList(1);
						
						function showList(page) {

							console.log("show list  "+ page);
							
							freecommentService.getList({no : noValue,page : page || 1},
						function(replyCtn,list) {

							console.log("replyCtn :" + replyCtn);
							console.log("list: "+ list);
							console.log(list);
												
							if(page == -1){
								pageNum = Math.ceil(replyCtn/10.0);
								showList(pageNum);
								return;
							}
												
							var str = "";
												
							if (list == null || list.length == 0) {
								return;
							}

							for (var i = 0, len = list.length || 0; i < len; i++) {
								str += "<li class='left clearfix' data-gno="+list[i].gno+">";
								str += "	 <div><div class='header'><strong class='primary-font'>" + list[i].id+ "</strong>";
								str += "	 <small class='pull-right text-muted'>"+ freecommentService.displayTime(list[i].fdate)+ "</small></div>";
						
							 	if(list[i].id == cookieId){
									str += "<div><button class='btn' id='replyUpdate' data-gno='"+list[i].gno+"'>나의 댓글 관리</button></div>";
								} 
								
								str += "</div><p>" + list[i].content + "</p></div></li><hr>"
							}
							replyUL.html(str);
							showReplyPage(replyCtn);
						});
		 			}
						var modal = $("#myModal");
						var modalInputContent = modal.find("input[name='content']");
						var modalModBtn = $("#modalModBtn");
						var modalRemoveBtn = $("#modalRemoveBtn");
						var modalRegisterBtn = $("#modalRegisterBtn");

						$("#modalCloseBtn").on("click", function(e){
						    	modal.modal('hide');
						  });
						
						$("#addReplyBtn").on("click", function(e) {
							modal.find("input").val("");
							modal.find("button[id != 'modalCloseBtn']").hide();
							modalRegisterBtn.show();

							$("#myModal").modal("show");
						});

						/* 새로운 댓글 추가 처리 */
						modalRegisterBtn.on("click", function(e) {
							
							var comment = {
								content : modalInputContent.val(),
								no : noValue
							};
							freecommentService.add(comment, function(result) {

								messageAlert("성공", "댓글이  등록되었습니다", "success", "확인");
								modal.find("input").val("");
								modal.modal("hide");

								showList(-1);
							});
						});
						
						/* 댓글 조회 클릭  */
						//인자값 "li" >>>>>>>> "button"
						$(document).on("click","#replyUpdate",function(e) {

							var gno = $(this).data("gno");

							freecommentService.get(gno,function(comment) {
								console.log('>>>>>'+ comment.content);
								modalInputContent.val(comment.content);
								modal.data("gno",comment.gno);
								modal.find("button[id != 'modalCloseBtn']").hide();
								modalModBtn.show();
								modalRemoveBtn.show();
						$("#myModal").modal("show");
						});
					});
						
					/* 댓글 수정버튼 클릭 */	
						modalModBtn.on("click", function(e){

							var comment = {gno : modal.data("gno"), content : modalInputContent.val()};
							
							freecommentService.update(comment, function(result){
								messageAlert("성공", "댓글이 수정되었습니다", "success", "확인");
								modal.modal("hide");
								showList(pageNum);
							});
						});
						
						modalRemoveBtn.on("click", function(e){

							var gno = modal.data("gno");
							
							freecommentService.remove(gno, function(result){
								
								messageAlert("성공", "댓글이 삭제되었습니다", "success", "확인");
								modal.modal("hide");
								showList(pageNum);
							});
						});

						var pageNum = 1;
						var replyPageFooter = $(".panel-footer");
						
						function showReplyPage(replyCtn){
							var endNum = Math.ceil(pageNum / 10.0) * 10;
							var startNum = endNum - 9;
							var prev =  startNum != 1;
							var next = false;
							
							if(endNum *10 >= replyCtn){
								endNum = Math.ceil(replyCtn/10.0);
							}
							if(endNum *10 < replyCtn){
								next = true;
							}
							
							var str = "<ul class='pageination pull-right' style='display:flex; justify-content:baseline;''>";
							
							if(prev){
								str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";	
							}					
							for(var i=startNum; i<=endNum; i++){
								var active = pageNum == i ? "active" : "";
								
								str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
							}
							if(next){
								str += "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
							}
							str += "</ul>";
							console.log(str);
							replyPageFooter.html(str);
						}
						
						replyPageFooter.on("click","li a", function(e){
							e.preventDefault();
							console.log("page click");
							
							var targetPageNum = $(this).attr("href");
							
							console.log("targetPageNum: " + targetPageNum);
							pageNum = targetPageNum;
							showList(pageNum);
						});
					});

	$(document).ready(function() {

		var no = ${board.no};
		var id = $.cookie("userId");
		var operForm = $("#operForm");
		
		//수정
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/freeboard/modify").submit();
		});
		//목록
		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#no").remove();
			operForm.attr("action", "/freeboard/list");
			operForm.submit();
		});
		
	//좋아요
	getLike();
 	$('#like').on("click", function(){
		console.log($(this).attr("class"));
		if($(this).attr("class") == "btn btn-default"){
			addLike();
			messageAlert("추천", no+"번 게시물을 추천합니다", "success", "확인");
			getLike();	
		}else if($(this).attr("class") == "btn btn-danger"){
			deleteLike();
			messageAlert("추천", no+"번 게시물의 추천을 취소", "success", "확인");
			getLike(); 
		}
	}); 
	
/* 	 $('.far fa-thumbs-up').on('click', function(){
		addLike();
		messageAlert("추천 ", "이글을 추천합니다", "success", "확인");
		getLike();
	});
	$('.fas fa-thumbs-up').on('click', function(){
		deleteLike();
		messageAlert("추천취소", "추천을 취소합니다", "success", "확인");
		getLike();
	});  */
		
		function getLike(){
		$.ajax({
			type : 'post',
			url : '/freeboard/getLike',
			async : false,
			data : {
				no : no,
				id : id
			},
			success : function(data){
				console.log(data);
				if(data == 0){
					$('#like').removeClass("btn-danger");
					$('#like').addClass("btn-default");
				}else if(data > 0){
					$('#like').removeClass("btn-default");
					$('#like').addClass("btn-danger");					
				}
			}
		});
	}
	function addLike(){
		$.ajax({
			type : 'post',
			url : '/freeboard/addLike',
			async : false,
			data : {
				no : no,
				id : id
			},
			success : function(data){
				console.log(data);
			}
		});
	}
	function deleteLike(){
		$.ajax({
			type : 'post',
			url : '/freeboard/deleteLike',
			async : false,
			data : {
				no : no,
				id : id
			},
			success : function(data){
				console.log(data);
			}
		});
	}
	});
</script>
