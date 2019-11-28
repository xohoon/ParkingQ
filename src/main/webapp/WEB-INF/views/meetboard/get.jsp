<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript" src="/resources/js/jquery.cookie.js"></script>

<!-- Reply Register modal part -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글</h4>
			</div>
			
			<div class="modal-body">
			
				<div class="form-group">
					<label>Reply</label>
					<input class="form-control" name="reply" value="New Reply!!!!!!!">
				</div>
				
				<div class="form-group">
					<label>Replyer</label>
					<input class="form-control" name='replyer' value="${nick }" id="replyer" readonly="readonly">
				</div>
				
				<div class="form-group">
					<label>Reply Date</label>
					<input class="form-control" name='idate' value="">
				</div>
				
			</div>
			<div class="modal-footer">
				<button id='modalModBtn' type='button' class='btn btn-warning'>Modify</button>
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

<!-- reply service 확인을 위한 script -->
<script type="text/javascript" src="/resources/js/meetreply.js">
</script>

<script>

	$(document).ready(function(){
		$('.topheader_subject_text').html('오시는거죠');
		var noValue = '<c:out value="${board.no }"/>';
		var replyUL = $(".chat");
		var replyerCookie = $.cookie('userNick');
		
		showList(1);
		
		/* list show add li, reply, replyer etc.. */
		function showList(page){
			console.log("show list : "+page);
			replyService.getList({
			no : noValue,
			page : page || 1
		},
			function(replyCnt, list){
				console.log("replyCnt : "+replyCnt);
				console.log("lsit : "+list);
				console.log(list);
				
				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				var str="";

				if(list == null || list.length == 0){
					/* replyUL.html(""); */
					
					return;
				}
				for(var i = 0, len = list.length || 0; i < len; i++){
					console.log(list[i].gno + ' : ' +  	list[i].replyer + ' : ' + replyerCookie);
					str += "<li class='left clearfix' data-gno='"+list[i].gno+"'>";
					str += "	<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
					str += "	<small class='pull-right text-muted'>"+replyService.displayTime(list[i].idate)+"</small>";
					if(list[i].replyer == replyerCookie){
						str += "	<button class='btn' id='replyUpdate' style='margin-left:935px;' data-gno='"+list[i].gno+"'>댓글수정</button>";			
					}
					str += "	</div><p>"+list[i].reply+"</p></div></li>";
				}
				replyUL.html(str);
				showReplyPage(replyCnt);
				/* 	
				$(document).on('click', '#replyUpdate', function(e){
					var gno = $(this).data("gno");
					replyService.get(gno, function(reply){
						modalInputReply.val(reply.reply);
						modalInputReplyer.val(reply.replyer);
						modalInputIdate.val(replyService.displayTime(reply.idate)).show()
						.attr("readonly", "readonly");
						modal.data("gno", reply.gno);
						
						modal.find("button[id != 'modalCloseBtn']").hide();
						modalInputReplyer.closest("div").show();
						modalRegisterBtn.hide();
						modalModBtn.show();
						modalRemoveBtn.show();
						
						$("#myModal").modal("show");
					});
					console.log(gno);
				});
				*/
			}); // end function
		}// end showList
		 
		
		// reply pageNum sysout losic ReplyPage()
		var pageNum = 1;
	    var replyPageFooter = $(".panel-footer");
	    
	    function showReplyPage(replyCnt){
	      
	      var endNum = Math.ceil(pageNum / 10.0) * 10;  
	      var startNum = endNum - 9; 
	      
	      var prev = startNum != 1;
	      var next = false;
	      
	      if(endNum * 10 >= replyCnt){
	        endNum = Math.ceil(replyCnt/10.0);
	      }
	      
	      if(endNum * 10 < replyCnt){
	        next = true;
	      }
	      
	      var str = "<ul class='pagination pull-right'>";
	      
	      if(prev){
	        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	      }
	      
	      for(var i = startNum ; i <= endNum; i++){
	        
	        var active = pageNum == i? "active":"";
	        
	        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	      }
	      
	      if(next){
	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	      }
	      
	      str += "</ul></div>";
	      
	      console.log(str);
	      
	      replyPageFooter.html(str);
	    }
	    
	    replyPageFooter.on("click", "li a", function(e){
	    	e.preventDefault();
	    	console.log("page click");
	    	var targetPageNum = $(this).attr("href");
	    	console.log("targetPageNum : " + targetPageNum);
	    	pageNum = targetPageNum;
	    	showList(pageNum);
	    });
		
		// reply add start button event
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputIdate = modal.find("input[name='idate']");

		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		/* Reply register button click event */
		$('#addReplyBtn').on("click", function(e){
		$(modalInputReplyer).val('ddddddddd');
			
			$("#replyer").val($.cookie('userNick'));
			modal.find("input").val("");
			modalInputReplyer.closest("div").hide().attr("readonly", "readonly");
			modal.find("button[id != 'modalClosebtn']").hide();
			modalInputIdate.closest("div").hide();
			
			modalRegisterBtn.show();
			
			$("#myModal").modal("show");
			
		});
		
		modalRegisterBtn.on("click", function(e){
			
			var reply = {
					reply : modalInputReply.val(),
					replyer : modalInputReplyer.val(),
					no : noValue
			};
			replyService.add(reply,  function(result){
				
				messageAlert("완료", "댓글이 정상적으로 등록되었습니다", "success", "확인");
				
				modal.find("input").val("");
				modal.modal("hide");
				
				// showList(1);
				showList(-1);
			});
			
		});
		
		/* reply click modify/ remove ,,, modal */
		
		/*
		$("body").delegate('.qwe','click', "li", function(e){
		$(".chat").on("click", "li", function(e){
		*/
		$(document).on('click', '#replyUpdate', function(e){
			var gno = $(this).data("gno");
			replyService.get(gno, function(reply){
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputIdate.val(replyService.displayTime(reply.idate)).show()
				.attr("readonly", "readonly");
				modal.data("gno", reply.gno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalInputReplyer.closest("div").show();
				modalRegisterBtn.hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$("#myModal").modal("show");
			});
			console.log(gno);
		});
		
		// reply update---------
		modalModBtn.on("click", function(e){
			var reply = {gno:modal.data("gno"), reply:modalInputReply.val()};
			
			replyService.update(reply, function(result){
				messageAlert("완료", "댓글이 정상적으로 수정되었습니다", "success", "확인");
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		// reply delete----------
		modalRemoveBtn.on("click", function(e){
			var gno = modal.data("gno");
			
			replyService.remove(gno, function(result){
				messageAlert("삭제", "댓글이 정상적으로 삭제되었습니다", "success", "확인");
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		
		

	
});
	
	
</script>

<!-- reply service 확인을 위한 script -->

<script type="text/javascript">
	
	$(document).ready(function(){
		var operForm=$("#operForm");
		$("button[data-oper='modify']").on("click", function(e){
			operForm.attr("action", "/meetboard/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.find('#no').remove();
			operForm.attr("action", "/meetboard/list");
			operForm.submit();
		});
	});
</script>

<!-- --------------------------------------- top part is script---------------------------------------------------------------------------------------- -->
<!-- style -->
<style>
.getPage{
	width:100%;
}
.like{
	position: relative;
}
.btn_like_u{
	position: absolute;
	width:35px;
	height:35px;
}
.btn_like_d{
	position: absolute;
	width:35px;
	height:35px;
}
.a:link{
	text-decoration: none;
	color: #FFFFFF;
}
a:visited {
	text-decoration: none;
	color: #FFFFFF;
}
</style>
<!-- style -->

<div class="getPage">
	<div class="card-body" style="height:80px;margin-top:40px;">
		<div class="like" style="float:left;margin-left:1090px;margin-top:10px;">
			<c:choose>
				<c:when test="${board.likeID eq userId}">
					<img src="/images/meetboard/s01.png" class="btn_like_u" style="visibility:visible;">
					<img src="/images/meetboard/s02.png" class="btn_like_d" style="visibility:hidden;">
				</c:when>
				<c:when test="${board.likeID ne userId}">
					<img src="/images/meetboard/s01.png" class="btn_like_u" style="visibility:hidden;">		
					<img src="/images/meetboard/s02.png" class="btn_like_d" style="visibility:visible;">
				</c:when>
			</c:choose>
		</div>
			<div style="float:left;margin-top:17px;margin-left:45px;"><b>좋아요</b></div>
			<div id="countLike" style="float:left; margin-top:17px;margin-left:5px;font-weight:bold;"></div>
	</div>
	<div class="card">
		<!-- header -->
		<div class="card-body">
			<!-- Image View -->
			<div style="float:left;margin-right:25px;">
				<img class="img-thumbnail" src="/local_img/meetboard/${board.mfile }" style="width:400px;height:310px;">
			</div>
			<div>
				<div class="form-group" style="margin-top:15px;">
					<label for="comment"><h5>모임 이름</h5></label>
					<input class="form-control" name='mname' value='<c:out value="${board.mname }"/>' readonly style="width:780px;background-color: #EEF5FA">
				</div>
				<div class="form-group">
					<label for="comment"><h5>모임 태그</h5></label>
					<input class="form-control" name='title' value='<c:out value="${board.title }" />' readonly style="width:780px;background-color: #EEF5FA">
				</div>
				<div class="form-group">
					<label for="comment"><h5>모임 장</h5></label>
					<input class="form-control" name='nick' value='<c:out value="${board.nick }"/>' readonly style="width:780px;background-color: #EEF5FA">
				</div>
			</div>
		</div>
		<!-- body -->
		<div class="card-header">
			<!-- Google map view part -->
			<div id="google_map" style="width:1190px;height:450px;margin:15px;"></div>
		</div>
		<!-- footer -->
		<div class="card-body" style="height:520px;">
			<div class="form-group">
				<label for="comment"><h4>모임 상세내용</h4></label>
				<textarea class="form-control" rows="5" id="comment" name='content' readonly style="height:350px;background-color: #EEF5FA"><c:out value="${board.content }"/></textarea>
			</div>
			<br />
			<c:if test="${userId ne board.id }">
				<button id="joinClick" class="btn btn-primary" style="margin-left:567px;float:left;"><div id="joinText">참여하기</div></button>
			</c:if>
			<div>
				<div id="countJoin" style="position:absolute;float:left;margin-left:1135px;margin-top:8px;font-weight:bold;"></div>
				<div style="position:absolute;float:left;margin-left:1166px;margin-top:8px;font-weight:bold;"> 참여중</div>
			</div>
		</div>
		<div class="card-footer" style="height:62px;">
			<div style="margin-left:1085px;">
				<c:if test="${userId eq board.id }">
					<button data-oper='modify' class="btn btn-secondary" style="position:absolute;">
					<a style="text-decoration:none;color: #FFFFFF;" href='/meetboard/modify?no=<c:out value="${board.no }"/>'>수정</a></button>
				</c:if>
				<button data-oper='list' class="btn btn-info" style="position:absolute;margin-left:68px;"><a href="/meetboard/list">목록</a></button>
			</div>
		</div>
		
		<div class="card">
			<div class="joinReply" style="margin-left:480px;margin-top:35px;">그룹에 참여하시면 댓글을 작성하실 수 있습니다.</div>
			<button id='addReplyBtn' class="btn btn-warning" style="width:100px;margin-top:20px;margin-left:1130px;margin-bottom:20px;">댓글 달기</button>
			<ul class="chat">
				<!-- start reply -->
				<li class="left clearfix" data-gno='12'>
					<div>
						<div class="header">
							<strong class="primary-font">Nothing Reply</strong>
							<small class="pull-right text-muted"><!-- 년월일 --></small>
						</div>
							<!-- <p>Reply</p> -->
					</div>
				</li>
				<!-- end reply -->
			</ul>
			<!-- ./ end ul -->
		</div>
		
	</div>
</div>

<form id="operForm" action="/meetboard/modify" method="get">
	<input type='hidden' id='no' name='no' value='<c:out value="${board.no }"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
	<!-- 조회 페이지에서 type과 keyword 처리 -->
	<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
	<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
</form>


<!-- --------------------------------------- bottom part is script---------------------------------------------------------------------------------------- -->

<!-- Google map  -->

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyByjX-fIiEVgNTofLuWWpxgGqQADaoNSWk&libraries=places&callback=initAutocomplete"></script>

<script>
	jQuery(document).ready(function(){
		google.maps.event.addDomListener(window, 'load', initialize);
	});
	var map_lat = "${board.lat}";
	var map_lng = "${board.lng}";
	console.log(">>>>>>>>>>>>>"+"${board.lat}"+"${board.lng}");
	
	function initialize(){
		var mapLocation = new google.maps.LatLng("${board.lat}","${board.lng}");
		var markLocation = new google.maps.LatLng("${board.lat}","${board.lng}");
		
		var mapOptions = {
				center : mapLocation,
				zoom : 17,
				mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById("google_map"), mapOptions);
		
		var size_x = 60;
		var size_y = 60;
		
		var image = new google.maps.MarkerImage('http://www.larva.re.kr/home/img/boximage3.png',
				new google.maps.Size(size_x, size_y),
				'',
				'',
				new google.maps.Size(size_x, size_y));
		
		var marker;
		
		marker = new google.maps.Marker({
			position : markLocation,
			map : map,
			icon : image,
			info : 'Welcome ^___^',
			title : 'Right now Here'
		});

	}
</script>

<!-- Group Join and Like getNum // insert// delete -->

<script>

	var joinId = $.cookie('userId');
	var joinNo = '${board.no}';
	
	var likeId = $.cookie('userId');
	var likeNo = '${board.no}';
	
	console.log(joinId+"testestestest"+joinNo)
	console.log(likeId+"testestestest"+likeNo)
	
	getJoin();

	/* group join user insert and delete button change */
	$('#joinClick').on('click', function(){
		
		console.log($(this).attr('class'));
		
		if($(this).attr('class') == 'btn btn-primary'){
			swal({
				title : "모임 참여",
				text : "모임에 참여 하시겠습니까?",
				icon : "warning",
				buttons : ["취소", "확인"],
				dangerMode: false,
			}).then((willDelete) =>{
				if(willDelete){
					swal("참여 되었습니다", {
						icon: "success",
					});
					insertJoin();
					countJoin();
					getJoin();
				}else {
					swal("참여가 취소 되었습니다", {
						icon : "error",
						button : "확인"
					});
				}
			});
			
		}else if($(this).attr('class') == 'btn btn-danger'){
			swal({
				title : "모임 탈퇴",
				text : "모임에서 탈퇴 하시겠습니까?",
				icon : "warning",
				buttons : ["취소", "확인"],
				dangerMode: true,
			}).then((willDelete) =>{
				if(willDelete){
					swal("탈퇴 되었습니다", {
						icon: "success",
					});
					deleteJoin();
					countJoin();
					getJoin();
				}else {
					swal("탈퇴가 취소 되었습니다", {
						icon : "error",
						button : "확인"
					});
				}
			});
			
		}
		
	});

	/* Group Join Check Num */
	function getJoin(){
		$.ajax({
			type : 'post',
			url : '/meetboard/getJoin',
			async : false,
			data : {
				id : joinId,
				no : joinNo
			},
			success : function(data){
				console.log("join get data >>>>>>>>>>>>>>"+data);
				if(data == 0 ){
					$('#joinText').html("참여하기");
					$('#joinClick').removeClass('btn-danger');
					$('#joinClick').addClass('btn-primary');
					$('#addReplyBtn').css('visibility', 'hidden');
					$('.joinReply').css('visibility', 'visible');
				}else if(data > 0){ 
					$('#joinText').html("탈퇴하기");
					$('#joinClick').removeClass('btn-primary');
					$('#joinClick').addClass('btn-danger');
					$('#addReplyBtn').css('visibility', 'visible');
					$('.joinReply').css('visibility', 'hidden');
				}
			}
		});
	}
	
	countJoin();
	/* Group count join */
	function countJoin(){
		
		$.ajax({
			type : 'post',
			url : '/meetboard/countJoin',
			data : {
				no : likeNo
			},
			success : function(data){
				console.log("like count>>>>>>>>>>>>>"+data);
				$('#countJoin').text(data+"명");
			}
		});
	}

	/* group join user insert */
	function insertJoin(){
		$.ajax({
			type : 'post',
			url : '/meetboard/insertJoin',
			async : false,
			data : {
				id : joinId,
				no : joinNo
			},
			success : function(data){
				console.log("insertJoininininin>>>>"+data);
				if(data == 1){
					$('#addReplyBtn').css('visibility', 'visible');
					$('.joinReply').css('visibility', 'hidden');					
				}
			}
		});
	}

	/* group join user delete */
	function deleteJoin(){	
		$.ajax({
			type : 'post',
			url : '/meetboard/deleteJoin',
			async : false,
			data : {
				id : joinId,
				no : joinNo
			},
			success : function(data){
				console.log("deletejoininininininin>>>>"+data);
				if(data == 1){
					$('#addReplyBtn').css('visibility', 'hidden');
					$('.joinReply').css('visibility', 'visible');
				}
			}
		});
	}
	
	/* board like get */
	countLike();
	
	$('.btn_like_d').on('click', function(){
		messageAlert("좋아요 + 1", "관심이 추가 되었습니다", "success", "확인");
		insertLike();
		getLike();
	});
	$('.btn_like_u').on('click', function(){
		messageAlert("좋아요  - 1", "관심이 사라졌습니다", "success", "확인");
		deleteLike();
		getLike();
	});

	/* Group Like get */
	function getLike(){
	
		$.ajax({
			type : 'post',
			url : '/meetboard/getLike',
			async : false,
			data : {
				id : likeId,
				no : likeNo
			},
			success : function(data){
			
				console.log("Like get Num >>>><>><><><><>"+data);
				if(data == 1){
					$('.btn_like_u').css('visibility', 'visible');
					$('.btn_like_d').css('visibility', 'hidden');
				}else if(data == 0){
					$('.btn_like_u').css('visibility', 'hidden');
					$('.btn_like_d').css('visibility', 'visible');
				}
			}
		});
	}
	
	/* Group Like count */
	function countLike(){
		
		$.ajax({
			type : 'post',
			url : '/meetboard/countLike',
			data : {
				no : likeNo
			},
			success : function(data){
				console.log("like count>>>>>>>>>>>>>"+data);
				$('#countLike').text(data+"개");
			}
		});
	}
	
	/* Board Like isnert */
	function insertLike(){
		
		$.ajax({
			type : 'post',
			url : '/meetboard/insertLike',
			async : false,
			data : {
				id : likeId,
				no : likeNo
			},
			success : function(data){
				countLike();
			}
		});
	}
	/* Board Like delete */
	function deleteLike(){
		
		$.ajax({
			type : 'post',
			url : '/meetboard/deleteLike',
			async : false,
			data : {
				id : likeId,
				no : likeNo
			},
			success : function(data){
				countLike();
			}
		});
	}
	
</script>

















