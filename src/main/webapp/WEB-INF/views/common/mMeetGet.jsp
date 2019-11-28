<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">


<!-- reply service 확인을 위한 script -->
<script type="text/javascript" src="/resources/js/meetreply.js">
</script>

<script>

	$(document).ready(function(){
		
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


</head>
<body>
    <style>
        .container {
            background-color: white;
            width: 100%;
            height: auto;
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

    <div class="container">

<!-- 반응형에 맞춰질 수 있도록 % 로 너비 주고 em으로 글자크기 -->
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top"
         style="z-index: 9999;">
         <a class="navbar-brand" href="/common/mmain">파킹큐</a>
         <ul class="navbar-nav">
            <li class="nav-item dropdown"><a
               class="nav-link dropdown-toggle" href="#" id="navbardrop"
               data-toggle="dropdown"> 게시판 </a>
               <div class="dropdown-menu">
                  <a class="dropdown-item" href="/freeboard/mlist">자유게시판</a> <a
                     class="dropdown-item" href="/meetboard/mMeetList">오시는거죠</a> <a
                     class="dropdown-item" href="/reviewboard/mlist">이용후기</a>
               </div></li>
         </ul>
      </nav>

        <div class="container-fluid" style="margin-top:70px; position: relative">

            <div class="layout-title" style="padding: 10px 10px 30px 10px;">
                <i class="far fa-comment-dots" style="font-size: 2rem;"></i>
                <span style="font-size: 1.4rem; position: absolute; margin-left: 5%;">오시는거죠</span>
            </div>


            <div class="layout-content">
                <div style="height: auto;">


<div class="getPage" style="width:100%;">
	<div class="card">
		<!-- header -->
		<div class="card-body">
			<!-- Image View -->
			<div style="float:left;margin-right:25px;margin-bottom:20px;">
				<img class="img-thumbnail" src="/local_img/meetboard/${board.mfile }" style="width:253px;height:220px;">
			</div>
			<div>
				<div class="form-group">
					<label for="comment"><h5>모임 이름</h5></label>
					<input class="form-control" name='mname' value='<c:out value="${board.mname }"/>' readonly style="width:100%;background-color: #EEF5FA">
				</div>
				<div class="form-group">
					<label for="comment"><h5>모임 목적</h5></label>
					<input class="form-control" name='title' value='<c:out value="${board.title }" />' readonly style="width:100%;background-color: #EEF5FA">
				</div>
				<div class="form-group">
					<label for="comment"><h5>모임 장</h5></label>
					<input class="form-control" name='nick' value='<c:out value="${board.nick }"/>' readonly style="width:100%;background-color: #EEF5FA">
				</div>
			</div>
		</div>
		<!-- body -->
		<div class="card-header">
			<!-- Google map view part -->
			<div id="google_map" style="width:100%;height:300px;"></div>
		</div>
		<!-- footer -->
		<div class="card-body" style="height:520px;">
			<div class="form-group">
				<label for="comment"><h4>모임 상세내용</h4></label>
				<textarea class="form-control" rows="5" id="comment" name='content' readonly style="height:350px;background-color: #EEF5FA"><c:out value="${board.content }"/></textarea>
				<button data-oper='list' class="btn btn-info" style="position:absolute;margin-left:98px;margin-top:30px;color:white;"><a href="/meetboard/mMeetList">목록</a></button>
			</div>
		</div>
	</div>
</div>

<form id="operForm" action="/meetboard/modify" method="get">
	<input type='hidden' id='no' name='no' value='<c:out value="${board.no }"/>'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
</form>



                </div>
            </div>
        </div>
    </div>
    
    
    
    
    
    
    
    
    
    
    
    
    

<!-- Google map  -->

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>

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
				zoom : 16,
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


</body>
</html>