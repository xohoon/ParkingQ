<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/resources/css/message/normalize.css">
<link rel="stylesheet" href="/resources/css/message/style.css">
<script src="/resources/js/index.js"></script>
<script src="/resources/js/jquery.cookie.js"></script>

<div id="cookie_id"></div>

<br>
<hr />


<style>
#message_container {
	width: 400px;
	height: 600px;
}

#message_body {
	height: 500px;
	overflow-y: scroll;
}

#message_footer {
	height: 60px;
}

#memberList_footer {
	height: 60px;
	padding: 0;
}

#message_input {
	width: 280px;
	height: 35px;
	border: 1px solid #d6d6d6;
	padding-left: 15px;
}

#meesage_btn {
	height: 40px;
	text-align: center;
}

#message_img {
	width: 40px;
	height: 40px
}

#message_time {
	font-size: 12px;
}

#message_list {
	height: 500px;
	width: 200px;
	overflow-y: scroll;
}

.message_listimage {
	width: 70px;
	height: 70px;
	cursor: pointer;
}

.message_profile {
	position: relative;
}

#message_state {
	width: 20px;
	height: 20px;
	border-radius: 20px;
	position: absolute;
	left: 1.5%;
    top: 30%;
}

.background_red {
background-color: red;
}
.background_green {
background-color: green;
}
.background_black {
background-color: black;
}

#message_readcount {
	width: 20px;
    height: 20px;
    border-radius: 20px;
    background-color: red;
    position: absolute;
    left: 36%;
    top: 78%;
}
#message_readtext {
	position: absolute;
    left: 30%;
    bottom: -6%;
    font-weight: bold;
    color: white;
}

.message_alarm {
	position: absolute;
	top: 18px;
	left: 48px;
	color: royalblue;
	font-weight: bold;
	font-size: 14px;
}

#message_line {
	border-bottom: 1px solid #dddddd;
	padding-bottom: 20px;
}

#message_id {
	visibility: hidden;
	width: 0;
	height: 0;
}

#message_listtitle {
	text-align: center;
}

#message_listtitle>i {
	float: right;
	margin-top: 5px;
	cursor: pointer;
}

input[type='text'] {
	padding: 5px 0px 5px 20px;
}

#successMessage, #warningMessage, #dangerMessage {
	z-index: 9999;
}

.fas{
float: right;
}
.fa-trash-alt{
    position: absolute;
	font-size: 1.6rem;
    left: 43%;
    bottom: 3%;
}

.fa-search{
	cursor: pointer;
}

div#message_rotate {
    position: absolute;
    width: 1.8rem;
    height: 1.8rem;
    left: 65%;
    top: 1.8%;
    background-color: #929189;
}
.alert{
z-index: 99999;
}

 

</style>



<button class="btn btn-primary" id="friend_apply">신청</button>
<button class="btn btn-primary" id="friend_accept">승낙</button>
<button class="btn btn-danger" id="friend_refuse">거절</button>



<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" style="background-color: transparent; border: 1px solid transparent">
			<div class="modal-body">


				<div id="message_container">
					<div style="width: 520px">
						<!-- 메세지 목록 부분 -->
						<div class="card mr-2 float-left" style="width: 125px;">
							<div class="card-header bg-dark text-white" id="message_listtitle">
								목록
								<div class="rounded-circle" id="message_rotate"></div>
								<i class="fas fa-sync fa-rotate fa-spin"></i>
							</div>
							<div class="card-body" id="message_list">

							</div>
							<div class="card-footer" id="memberList_footer" ondragover="return false;" ondragenter="return false;" ondrop="drop(this, event);">
								<i class="fas fa-trash-alt float-left"></i>
							</div>
						</div>


						<!-- 메세지함 부분 -->
						<div class="card">
							<div class="card-header bg-dark text-white" id="message_title">
							<span id="message_title_text">메세지함</span>
							<i class="fas fa-search"></i></div>
							<div class="card-body" id="message_body">

								<div class="row mb-3" id="message_line">
									<div class="col-12" style="text-align: center;">메세지를 보낼 대상을 선택 해 주세요 !</div>
								</div>



							</div>
							<div class="card-footer" id="message_footer">

								<input type="text float-left" id="message_input">
								<button class="btn btn-primary float-right" id="message_btn">전송</button>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content col-sm-8">
			<div class="modal-header">
				<h4 class="modal-title" id="modal" style="font-weight: bold;">아이디 검색</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>아이디</label> <input type="text" name="searchText" id="searchText" class="form-control" maxlength="15">
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" id="message_search" data-dismiss="modal" aria-label="Close">검색</button>
					<button class="btn btn-default" data-dismiss="modal" aria-label="Close">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>





<div class="modal fade" id="memberModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content col-sm-8" style="background-color: transparent; border: 1px solid transparent;">
			<div class="modal-body">

				<div class="card" style="width: 400px; border: 1px solid #dddddd;">
					<div class="card-header bg-dark text-white" id="message_title">정보 변경</div>
					<img class="card-img-top rounded-circle mt-lg-4" id="member_infoFile" alt="member image" style="width: 150px; height: 150px; margin-left: 32%">
					<div class="card-body">
						<p class="card-text">
						<div class="mb-3 mt-3">
							<span class="ml-4">아디</span> <input type="text" class="ml-4 disabled" id="member_infoId" maxlength="15" style="border-radius: 10px; background-color: #dddddd;" readonly>
						</div>

						<div class="mb-3">
							<span class="ml-4">비번</span> <input type="text" class="ml-4" id="member_infoPass" maxlength="15" style="border-radius: 10px">
						</div>

						<div class="mb-4">
							<span class="ml-4">닉넴</span> <input type="text" class="ml-4" id="member_infoNick" maxlength="15" style="border-radius: 10px">
						</div>
						<a href="#" class="btn btn-primary float-right" id="member_memberInfoBtn">변경</a>
					</div>
				</div>


			</div>
		</div>
	</div>
</div>





<!-- Alert Message -->
	<div class="alert alert-success" id="successMessage" style="display: none; z-index: 9999;">
	</div>
	<div class="alert alert-danger" id="dangerMessage" style="display: none;">
	</div>
	<div class="alert alert-warning" id="warningMessage" style="display: none;">
	</div>
	
	
	
	
	
	<script>
	
	var fId = 'test1';
    
    $('#friend_apply').on('click', function(){
       $.ajax({
           type : 'post',
           url : '/member/applyFriend',
           data : {
             id : $.cookie('userId'),
             fId : fId
           },
           async : false,
           success : function(data){
               console.log('applyFriend : '+data);
           }
       });
    });

    $('#friend_accept').on('click', function(){
       $.ajax({
           type : 'post',
           url : '/member/acceptFriend',
           data : {
             id : $.cookie('userId'),
             fId : fId
           },
           async : false,
           success : function(data){
               console.log('acceptFriend : ' + data);
           }
       });
    });
    
    $('#friend_refuse').on('click', function(){
        $.ajax({
           type : 'post',
           url : '/member/refuseFriend',
           data : {
             id : $.cookie('userId'),
             fId : fId
           },
           async : false,
           success : function(data){
               console.log('refuseFriend : ' + data);
           }
       });
    });
	
	</script>




<!-- 
<script>
	// 받는사람
	var toId = '';
	//패 본인 : 쿠키값 확인
	var userId = $.cookie('userId');

	$('#cookie_id').html(userId + ' 님 접속중');
	
	
	/************************* Alert Message *************************/
	
	function autoClosingAlert(selector, message ,delay) {
        var alert = $(selector).alert();
        $(selector).html('<strong>'+message+'</strong>');
        alert.show();
        window.setTimeout(function () {
            alert.hide()
        }, delay);
    }
	
	
	
	/************************* drag & drop *************************/
	
	$(function () {
     var obj = $("#member_infoFile");

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
          
          console.log(file);

          uploadProfile(file);
     });

});
	
	
	// 파일 업로드
	function uploadProfile(file) {
		
		var formData = new FormData();
		formData.append("file", file);
	         
	         $.ajax({
	            url: '/member/uploadProfile',
	            type: 'post',
	            data: formData,
	            dataType: 'text',
	            processData: false,
	            contentType: false,
	            success: function(data) {
	                console.log('이미지 변경 >>> ' + data);
	                $('#member_infoFile').attr('src',  '/local_img/profile/'+data);
	                
	                // 프로필 사진 변경 알림창 출력
	                autoClosingAlert(
	                '#successMessage',
	                '프로필 사진이 변경 되었습니다.',
	                2000);
	                
	            }
	         });
	}
	
	
	

	

	/************************* 회원정보 관련 **************************/

	$('#member_modal').on('click', function() {
		$('#memberModal').modal('show');
		getMemberInfo();
	});
	
	$('#member_memberInfoBtn').on('click', function(){
		var value_id = $('#member_infoId').val();
		var value_pass = $('#member_infoPass').val();
		var value_nick = $('#member_infoNick').val();
		var value_file = 'default.jpg';
		console.log(value_id + ' : ' + value_pass + ' : ' + value_nick + ' : ' + value_file);
		updateMemberInfo(value_id, value_pass, value_nick, value_file);
	});

	function getMemberInfo() {

		var info_id='';
		var info_nick='';
		var info_file='';

		$.ajax({
			type : 'post',
			dataType : 'json',
			url : '/member/viewMemberInfo',
			async : false,
			success : function(data) {
				$.each(data, function(index, item) {
					info_id = item.id;
					info_nick = item.nick;
					info_file = item.file;
				});
				console.log('아이디 : ' + info_id + ' / 닉네임 : ' + info_nick + ' / 파일 : ' + info_file);
				setTextMemberInfo(info_id, info_nick, info_file);
				
				console.log('info_file >>>>>> ' + info_file);
			}

		});
	}

	function setTextMemberInfo(id, nick, file) {
		$('#member_infoId').val(id);
		$('#member_infoNick').val(nick);
		$('#member_infoFile').attr('src', '/local_img/profile/'+file
				/* function(){
			console.log($(this).attr('src') + file );
			return $(this).attr('src')+file;
		} */
		);
	}
	
	
	
	function updateMemberInfo(value_id, value_pass, value_nick, value_file) {
		$.ajax({
			type : 'post',
			url : '/member/updateMemberInfo',
			data : {
				id : value_id,
				pass : value_pass,
				nick : value_nick,
				file : value_file
			},
			async : false,
			success : function(data){
				console.log('updateMemberInfo 결과값 >>> ' + data);
				
				 // 회원정보 업데이트 변경 알림창 출력
				if ( data == 1 ) {
	                autoClosingAlert(
	                '#successMessage',
	                '사용자 정보가 변경 되었습니다.',
	                2000);
				} else if ( data == -1 ) {
					autoClosingAlert(
			        '#warningMessage',
			        '이미 사용중인 닉네임 입니다.',
			        2000);
				} else if ( data == 0 ) {
					autoClosingAlert(
					'#dangerMessage',
					'비밀번호를 다시 확인 해 주세요.',
					2000);
				}
			}
		});
	}

	/************************* 메세지 관련 **************************/

	
	var messageRepeat;
	var memberListRepeat;
	
	// 메세지 버튼 클릭시 modal 창 show
	$('#message_modal').on('click', function() {
		$('#messageModal').modal('show');
		
		getMessageMemberList();
		//memberListRepeat = setInterval( "getMessageMemberList()", 3000 );
		
		swing();
		profileBtn();
		
		});
	
	
	$('#messageModal').on('hide.bs.modal', function(e){
		console.log('close modal');
		clearInterval(messageRepeat);
		e.stopImmediatePropagation();
	});
	
	

	$('.fa-sync').on('click', function() {
		getMessageMemberList();
		console.log('메세지 멤버 목록 초기화');
	});
	
	// 검색버튼(돋보기 아이콘) 클릭시 modal 창 show
	$('.fa-search').on('click', function() {
		$('#searchModal').modal('show');
	});

	// 검색 모달창 : 검색 버튼 클릭시 조회 결과
	$('#message_search')
			.on(
					'click',
					function() {
						toId = $('#searchText').val();
						console.log(toId);
						console.log('아이디 조회 결과 >>> ' + checkNum);
						var checkNum = checkmemberId(toId);
						clearInterval(messageRepeat);

						// 본인 아이디를 검색 한 경우
						if (userId === toId) {
							console.log('아이디 값 조회 실패 >>> 본인 아이디 ');
							$('#message_title_text').html('아이디 검색 실패');
							$('#message_body').html('');
							$('#message_body')
									.append(
											'<div class="row mb-3" id="message_line">'
													+ '<div class="col-12" style="text-align: center;">본인은 검색 할 수 없습니다 ! </div>'
													+ '</div>');

							// 상대방 아이디 조회에 성공한 경우
						} else if (checkNum == 1) {
							$('#message_title_text').html(toId + '와의 대화중...');
							getMessage();
							messageRepeat = setInterval( "getMessage()", 3000 );

						} else {
							console.log('아이디 값 조회 실패 >>> 존재하지 않는 아이디 ');
							$('#message_title_text').html('아이디 검색 실패');
							$('#message_body').html('');
							$('#message_body')
									.append(
											'<div class="row mb-3" id="message_line">'
													+ '<div class="col-12" style="text-align: center;">아이디를 다시 확인 해 주세요 ! </div>'
													+ '</div>');
						}
					});
	
	
	
	

	// 목록에서 이미지 클릭시 메세지 호출
	function profileBtn(){
	$('.message_profile').on("click", function(e) {
		toId = $(this).find('#message_id').html();
		console.log('profile click...');
		console.log(toId);
		$('message_title_text').html('');
		$('#message_title_text').html(toId + '와의 대화중...');
		
		getMessage();
		clearInterval(messageRepeat);
		messageRepeat = setInterval( "getMessage()", 3000 );
		
		console.log('click>>>>>>>>>>>>>' + e.target.id);
	});
	}
	
	
	

	// 메세지 input 칸에서 ENTER 를 누를 경우 : 메세지 전송
	$('#message_input').on('keydown', function(e) {
		if (e.which == 13) {
			sendMessage();
			$('#message_input').val('');
		}
	});

	// 메세지 버튼 을 클릭시 : 메세지 전송
	$('#message_btn').on('click', function() {
		sendMessage();
		$('#message_input').val('');
	});

	// 메세지 전송 처리
	function sendMessage() {
		var content = $('#message_input').val();

		$.ajax({
			type : 'post',
			url : '/message/submit',
			data : {
				id : userId,
				toId : toId,
				content : content
			},
			async : false,
			success : function(data) {
				console.log('message submit check value : ' + data);
			}

		});
	}

	// 메세지 호출 처리
	function getMessage() {
		
		
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : '/message/getMessage',
			async : false,
			data : {
				id : userId,
				toId : toId
			},
			success : function(data) {
				$('#message_body').html('');
				$.each(data.result, function(index, item) {
					addMessage(item.id, item.idFile, item.content, item.mDate);
					console.log(item.idFile + ' : ' + item.toIdFile);
				});
			}
		});
	}

	// 사용자 아이디 조회 처리
	function checkmemberId(toId) {
		var checkNum;
		$.ajax({
			type : 'post',
			url : '/member/checkid',
			async : false,
			data : {
				id : toId
			},
			success : function(data) {
				console.log('아이디 조회 확인 값 : ' + data);
				if (data === '1') {
					checkNum = 1;
				} else {
					checkNum = 0;
				}
			}
		});
		return checkNum;
	}
	
	
	function getMessageMemberList(){
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : '/message/getMessageMemberList',
			async : false,
			success : function(data) {
				$('#message_list').html('');
				
				$.each(data.result, function(index, item) {
					console.log(item.roomid + ' : ' + item.id + ' : ' + item.content + ' : ' + item.read + ' : ' + item.mdate + ' : ' + item.pfile + ' : ' + item.connect );
					
					if ( item.connect == 'on' ) {
						
						if ( item.read > 9) {
							$('#message_list').append(
									  '<div class="ml-2 mb-3 message_profile">'
									+'<div id="message_id">'+ item.id +'</div>'
									+'<div class="message_nick" style="margin: 0; width: 70px; height: 30px; overflow: hidden; text-align: center">'+ item.id +'</div>'
									+'<img class="rounded-circle message_listimage" id="'+ item.id +'" src="/local_img/profile/'+ item.pfile +'"  draggable="true" ondragstart="drag(this, event)">'
									+'<div class="background_green" id="message_state"></div>'
									+'<div id="message_readcount"><span id="message_readtext">'+ '!?' +'</span></div>'
									+'<div class="message_alarm">'
									+'<span class="badge badge-danger">New</span>'
									+'</div>'
									+'</div>'
									);
						} else if ( item.read > 0 ) {
							$('#message_list').append(
									  '<div class="ml-2 mb-3 message_profile">'
									+'<div id="message_id">'+ item.id +'</div>'
									+'<div class="message_nick" style="margin: 0; width: 70px; height: 30px; overflow: hidden; text-align: center">'+ item.id +'</div>'
									+'<img class="rounded-circle message_listimage" id="'+ item.id +'" src="/local_img/profile/'+ item.pfile +'"  draggable="true" ondragstart="drag(this, event)">'
									+'<div class="background_green" id="message_state"></div>'
									+'<div id="message_readcount"><span id="message_readtext">'+ item.read +'</span></div>'
									+'<div class="message_alarm">'
									+'<span class="badge badge-danger">New</span>'
									+'</div>'
									+'</div>'
									);
						} else if ( item.read == 0 ){
							$('#message_list').append(
									  '<div class="ml-2 mb-3 message_profile">'
									+'<div id="message_id">'+ item.id +'</div>'
									+'<div class="message_nick" style="margin: 0; width: 70px; height: 30px; overflow: hidden; text-align: center">'+ item.id +'</div>'
									+'<img class="rounded-circle message_listimage" id="'+ item.id +'" src="/local_img/profile/'+ item.pfile +'"  draggable="true" ondragstart="drag(this, event)">'
									+'<div class="background_green" id="message_state"></div>'
									+'<div id="message_readcount"><span id="message_readtext">'+ item.read +'</span></div>'
									+'</div>'
									);
						}
						
					} else {
						
						if ( item.read > 9) {
							$('#message_list').append(
									  '<div class="ml-2 mb-3 message_profile">'
									+'<div id="message_id">'+ item.id +'</div>'
									+'<div class="message_nick" style="margin: 0; width: 70px; height: 30px; overflow: hidden; text-align: center">'+ item.id +'</div>'
									+'<img class="rounded-circle message_listimage" id="'+ item.id +'" src="/local_img/profile/'+ item.pfile +'"  draggable="true" ondragstart="drag(this, event)">'
									+'<div class="background_red" id="message_state"></div>'
									+'<div id="message_readcount"><span id="message_readtext">'+ '!?' +'</span></div>'
									+'<div class="message_alarm">'
									+'<span class="badge badge-danger">New</span>'
									+'</div>'
									+'</div>'
									);
						} else if ( item.read > 0 ) {
							$('#message_list').append(
									  '<div class="ml-2 mb-3 message_profile">'
									+'<div id="message_id">'+ item.id +'</div>'
									+'<div class="message_nick" style="margin: 0; width: 70px; height: 30px; overflow: hidden; text-align: center">'+ item.id +'</div>'
									+'<img class="rounded-circle message_listimage" id="'+ item.id +'" src="/local_img/profile/'+ item.pfile +'"  draggable="true" ondragstart="drag(this, event)">'
									+'<div class="background_red" id="message_state"></div>'
									+'<div id="message_readcount"><span id="message_readtext">'+ item.read +'</span></div>'
									+'<div class="message_alarm">'
									+'<span class="badge badge-danger">New</span>'
									+'</div>'
									+'</div>'
									);
						} else if ( item.read == 0 ){
							$('#message_list').append(
									  '<div class="ml-2 mb-3 message_profile">'
									+'<div id="message_id">'+ item.id +'</div>'
									+'<div class="message_nick" style="margin: 0; width: 70px; height: 30px; overflow: hidden; text-align: center">'+ item.id +'</div>'
									+'<img class="rounded-circle message_listimage" id="'+ item.id +'" src="/local_img/profile/'+ item.pfile +'"  draggable="true" ondragstart="drag(this, event)">'
									+'<div class="background_red" id="message_state"></div>'
									+'<div id="message_readcount"><span id="message_readtext">'+ item.read +'</span></div>'
									+'</div>'
									);
						}
					}
					
					
					
					
				});
				// end $.each
				
				swing();
				profileBtn();
				
			}
		});
	}
	
	//드래그 시작시 호출 할 함수
	function drag(target, profile) {       
		profile.dataTransfer.setData('memberList', target.id);
	};
	 //드롭시 호출 할 함수
	function drop(target, profile) {      
		var toId = '';
	    var id = profile.dataTransfer.getData('memberList');
	    target.appendChild(document.getElementById(id));
	    profile.preventDefault();  
	    toId = $('#memberList_footer').find('.message_listimage').attr('id');
	    deleteMessage(toId);
	};
	
	function deleteMessage(toId) {
		$.ajax({
			type : 'post',
			url : '/message/deleteMessage',
			data : {
				id : $.cookie('userId'),
				toId : toId
			},
			async : false,
			success : function(data) {
				console.log('삭제 된 메세지 수 : ' + data);
				if ( data > 0 ) {
					getMessageMemberList();
					$('#memberList_footer').html('');
					$('#memberList_footer').html('<i class="fas fa-trash-alt float-left"></i>');
					$('#message_title_text').html('메세지함');
					$('#message_body').html('');
					$('#message_body').append(
						'<div class="row mb-3" id="message_line">'
						+'<div class="col-12" style="text-align: center;">메세지를 보낼 대상을 선택 해 주세요 !</div>'
						+'</div>'	
						);
					clearInterval(messageRepeat);
					
					
				} else {
					console.log('삭제 실패');
				}
			}
		});
	}
	
	$(function () {
	     var obj = $("#memberList_footer");
	     
	     
	     obj.on('dragenter', function (e) {
	          e.stopPropagation();
	          e.preventDefault();
	          $(this).css('border', '3px solid #5272A0');
	     });
	     
	     obj.on('dragleave', function (e) {
	          e.stopPropagation();
	          e.preventDefault();
	          $(this).css('border', '1px solid #dddddd');
	     });

	     obj.on('dragover', function (e) {
	          e.stopPropagation();
	          e.preventDefault();
	     });
	     
	     obj.on('drop', function (e) {
	          e.preventDefault();
	          $(this).css('border', '1px solid #dddddd');
	     });
	     
	});
	
	
	
	// 메세지 리스트에 값 출력
	function addMessage(id, idFile, content, mDate) {

		// 메세지 리스트가 본인 인 경우 출력 템플릿
		if (id === $.cookie('userId')) {
			$('#message_body')
					.append(
							"<div class='row ml-1 font-weight-bold'>"
									+ $.cookie('userId')
									+ "</div>"
									+ '<div class="row mb-3" id="message_line">'
									+ '<div class="col-2">'
									+ '<img class="rounded-circle" id="message_img" src="/local_img/profile/'+ idFile +'">'
									+ '</div>' + '<div class="col-7">'
									+ content + '</div>'
									+ '<div class="col-3" id="message_time">'
									+ mDate + '</div>' + '</div>');

			// 메세지 리스트가 상대 인 경우 출력 템플릿
		} else {
			$('#message_body')
					.append(
							'<div class="row float-right font-weight-bold">'
									+ id
									+ '</div>'
									+ '<br/>'
									+ '<div class="row mb-3" id="message_line">'
									+ '<div class="col-3" id="message_time">'
									+ mDate
									+ '</div>'
									+ '<div class="col-7" style="text-align: right;">'
									+ content
									+ '</div>'
									+ '<div class="col-2 style="margin-right:10px;">'
									+ '<img class="rounded-circle" id="message_img" src="/local_img/profile/'+ idFile +'">'
									+ '</div>' 
									+ '</div>');
		}

		// 스크롤바 가장 아래로 처리
		$('#message_body').scrollTop($('#message_body')[0].scrollHeight);
	}
	
	function swing() {
		$('.message_alarm').animate({
			'top' : '29px'
		}, 1000).animate({
			'top' : '19px'
		}, 1000, swing);
	}

</script> -->




