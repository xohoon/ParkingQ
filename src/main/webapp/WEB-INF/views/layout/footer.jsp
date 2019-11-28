<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


			<!-- END CONTENT -->
        </div>
        <!-- END CONTAINER -->
    </div>
    
    <div style="height: 100px;"></div>
    
<script type="text/javascript" src="/resources/js/jquery.cookie.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    
<script>
	var userId='';
	var userNick='';
	var toId='';

	userId = $.cookie('userId');
	userNick = $.cookie('userNick');
	
	
	
	
 /************************* LeftSide Menu Process *************************/
    
    
 
 	var imageName = chageProfileImage(userId);
 	$('.leftside_welcome_image').attr('src','/local_img/profile/'+imageName);
 	function chageProfileImage(id){
	 var imageName;
	$.ajax({
		type : 'post',
		url : '/member/getProfile',
		async : false,
		data : {
			id : id
		},
		success : function(data){
			imageName = data;
		}
	});
	return imageName;
 }
 
    $('.leftside_welcome_userid').html(userNick);
    
    var connectTime = getConnectTime(userId);
    $('.leftside_welcome_time').html(connectTime);
    
    function getConnectTime(userId){
    	var connectTime;
    	$.ajax({
    		type : 'post',
    		url : '/member/getConnectTime',
    		async : false,
    		data : {
    			userId : userId
    		},
    		success : function(data){
    			connectTime = data;
    		}
    	});
    	return connectTime;
    }
    
    getCommunityInfo(userId);
    function getCommunityInfo(id){
		$.ajax({
			type : 'post',
			url : '/member/communityInfo',
			dataType : 'json',
			/* async : false, */
			data : {
				id : id
			},
			success : function(data){
				console.log(data);
				
				
				$.each( data, function(key,value) {
					if ( key == 'visit' ) {
						$('.leftside_community_visit').html(value);
					} else if ( key == 'board' ) {
						$('.leftside_community_board').html(value);
					} else if ( key == 'comment' ) {
						$('.leftside_community_comment').html(value);
					}
				});
				
				
			}
		});
	}
    
    
    
    
    
	
	
	getFriendList();
	function getFriendList(){
		
		$.ajax({
			type : 'post',
			url : '/member/getFriendList',
			dataType : 'json',
			async : false,
			data : {
				id : $.cookie('userId')
			},
			success : function(data){
				console.log(data);
				
				$.each(data.result, function(index, item) {
						addFriendList(item.fId, item.pFile, item.check);
				});
			}
		});
		
	}
	
	
	
		function addFriendList(fId, pFile, check){
			if ( check == true ) {
				$('#friend_List').append(
						'<div class="friendList">'
						+'<img class="friend_listimage rounded-circle" src="/local_img/profile/'+ pFile +'">'
						+'<p class="friend_listtext">'+ fId +'</p>'
						+'</div>'
					); 
			} else if ( check == false ) {
				/* $('#friend_List').append(
						'<div class="friendList">'
						+'<img class="friend_listimage rounded-circle" src="/local_profile/profile/'+ pFile +'">'
						+'<p class="friend_listtext">'+ fId + ' 친구추가 진행중...' + '</p>'
						+'</div>'
					);  */
			}
			
		}
			
	
	
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
	                messageAlert('정보변경', '프로필 사진이 변경 되었습니다.', 'success');
	                
	              /*   autoClosingAlert(
	                '#successMessage',
	                '프로필 사진이 변경 되었습니다.',
	                2000); */
	                
	            }
	         });
	}
	
	
	
	/************************* QR코드 관련 **************************/
	
	$('.leftside_qrcode').on('click', function() {
		var key = getQrCode();
		console.log('key >>>>>>> '+key);
		$('#qrModal').modal('show');
		$('#qr_image').attr('src','https://파킹큐.kr/qrcode/?key='+key);
	});
	
	$('#member_changQrBtn').on('click', function(){
		updateQrCode();
		var key = getQrCode();
		$('#qr_image').attr('src','https://파킹큐.kr/qrcode/?key='+key);
	});
	
	
	$('#member_printQrBtn').on('click', function(){
		printQr();
	});
	
	function printQr(){
		
		
		$('#qrModal').modal('hide');
		
		setTimeout(function(){ 
			printQrCode();
			}, 500);
		
		
	}
		
	function getQrCode(){
		var qr_code;
		$.ajax({
			url : '/member/getQrById',
			type : 'post',
			async : false,
			data : {
				id : $.cookie('userId')
			},
			success : function(data){
				qr_code = data;
			}
		});
		return qr_code;
	}
	
	
	function updateQrCode(){
		$.ajax({
			url : '/member/changeQrById',
			type : 'post',
			data : {
				id : $.cookie('userId')
			},
			success : function(data) {
				if ( data == 1 ) {
					
					messageAlert('QR코드', 'QR코드가 재생성 되었습니다.', 'success');
					/* autoClosingAlert(
			                '#successMessage',
			                'QR코드가 재생성 되었습니다.',
			                2000); */
				} else {
					messageAlert('QR코드', 'QR코드가 재생성에 실패했습니다.', 'error');
					/* autoClosingAlert(
			                '#dangerMessage',
			                'QR코드 재생성에 실패 했습니다.',
			                2000); */
				}
			}
		});
	}
	
	
	function printQrCode(){
		var orgin = $('.layout_container').html();
		var printContent = $('#qr_imagebox').html();
		$('.layout_container').html(printContent);
		console.log('click>>>>>>>');
		console.log(printContent);
		window.print();
		$('.layout_container').html(orgin);
	}
	

	/************************* 회원정보 관련 **************************/

	$('.leftside_member').on('click', function() {
		$('#memberModal').modal('show');
		getMemberInfo();
	});
	
	$('.leftside_logout').on('click', function(){
		
		
		swal({
			  title: "로그아웃",
			  text: "로그아웃 하시겠습니까?",
			  icon: "warning",
			  buttons: ["취소", "로그아웃"],
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
			    /* swal("정상적으로 로그아웃 되었습니다.", {
			      icon: "success",
			    }); */
			    logoutUser();
			  } else {
			    swal("로그아웃이 취소 되었습니다.", {
			    	icon: "error",
			    	button : "확인"
			    });
			  }
			});
		
		
		
		/* 
		var checkConfirm = confirm('로그아웃 하시겠습니까?');
		
		if ( checkConfirm ) {
		
		$.ajax({
			type : 'post',
			url : '/member/deleteSession',
			async : false ,
			success : function(data){
				console.log(data);
				location.href = '/common/login';
			}
		});
		
		} */
		
		
	});
	
	
	function logoutUser(){
		$.ajax({
			type : 'post',
			url : '/member/deleteSession',
			async : false ,
			success : function(data){
				console.log(data);
				location.href = '/';
			}
		});
	}
	
	
	$('#member_passwordBtn').on('click', function(){
		$('#passwordModal').modal('show');
	});
	
	$('#member_passwordChange').on('click', function(){
		
		var id = $.cookie('userId');
		var currPassword = $('#currPassword').val();
		var confirmPassword = $('#changePassword').val();
		var passwordMsg;
		
		if ( checkPassword(id, currPassword) == 1 ) {
			
			if ( currPassword == confirmPassword ) {
				messageAlert('비밀번호변경','현재비밀번호와 동일 합니다.','error');
				$('#currPassword').val('');
				$('#changePassword').val('');
			} else if ( changePassword(id,confirmPassword) == 1 ) {
				messageAlert('비밀번호변경','비밀번호가 변경 되었습니다.','success');
				$('#currPassword').val('');
				$('#changePassword').val('');
			}
		} else {
			messageAlert('비밀번호변경','비밀번호를 다시 확인 해 주세요.','error');
			$('#currPassword').val('');
			$('#changePassword').val('');
		}
		
		
		});
	
	function checkPassword(id, currPassword){
		var result;
		$.ajax({
			type : 'post',
			url : '/member/checkPassword',
			data : {
				id : id,
				pass : currPassword
			}, 
			async : false,
			success : function(data){
				result = data;
			}
		});
		console.log('checkPassword result >> ' + result);
		return result;
	}
	
	function changePassword(id,confirmPassword){
		var result;
		$.ajax({
			type : 'post',
			url : '/member/changePassword',
			data : {
				id : id,
				pass : confirmPassword
			},
			async : false,
			success : function(data){
				result = data;
			}
		});
		console.log('changePassword result >> ' + result);
		return result;
	}
	
	
	
	
	$('#member_memberInfoBtn').on('click', function(){
		var value_id = $('#member_infoId').val();
		var value_pass = $('#member_infoPass').val();
		var value_nick = $('#member_infoNick').val();
		var value_file = 'default.jpg';
		console.log(value_id + ' : ' + value_pass + ' : ' + value_nick + ' : ' + value_file);
		updateMemberInfo(value_id, value_pass, value_nick, value_file);
		$('#member_infoPass').val('');
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
					$('#memberModal').modal('hide');
					
					messageAlert('정보변경',  '사용자 정보가 변경 되었습니다.', 'success');
	                /* autoClosingAlert(
	                '#successMessage',
	                '사용자 정보가 변경 되었습니다.',
	                2000); */
				} else if ( data == -1 ) {
					messageAlert('정보변경',  '이미 사용중인 닉네임 입니다.', 'error');
					/* autoClosingAlert(
			        '#warningMessage',
			        '이미 사용중인 닉네임 입니다.',
			        2000); */
				} else if ( data == 0 ) {
					
					messageAlert('정보변경', '비밀번호를 다시 확인 해 주세요.', 'error');
					
					/* autoClosingAlert(
					'#dangerMessage',
					'비밀번호를 다시 확인 해 주세요.',
					2000); */
				}
			}
		});
	}

	/************************* 메세지 관련 **************************/

	
	var messageRepeat;
	var memberListRepeat;
	
	// 메세지 버튼 클릭시 modal 창 show
	$('.topheader_message').on('click', function() {
		$('#messageModal').modal('show');
		
		getMessageMemberList();
		memberListRepeat = setInterval( "getMessageMemberList()", 3000 );
		
		swing();
		profileBtn();
		
		
		});
	
	
	$('#messageModal').on('hide.bs.modal', function(e){
		console.log('close modal');
		clearInterval(messageRepeat);
		clearInterval(memberListRepeat);
		e.stopImmediatePropagation();
	});
	
	

	$('.fa-sync').on('click', function() {
		getMessageMemberList();
		console.log('메세지 멤버 목록 초기화');
		
		 autoClosingAlert(
	                '#successMessage',
	                '목록이 갱신 되었습니다.',
	                2000);
		
		
	});
	
	// 검색버튼(돋보기 아이콘) 클릭시 modal 창 show
	$('.fa-search').on('click', function() {
		$('#searchModal').modal('show');
	});
	
	$('.fa-user-plus').on('click', function() {
		$('#friendModal').modal('show');
	});

	// 검색 모달창 : 검색 버튼 클릭시 조회 결과
	$('#message_search').on('click',	function() {
		findUser();	
	});	
	
	$('#searchText').on('keydown', function(e) {
		if (e.which == 13) {
			findUser();	
			$('#searchModal').modal('hide');
		}
	});
	
	function findUser(){
		userId = $.cookie('userId');
		toId = $('#searchText').val();
		$('#searchText').val('');
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
			
			autoClosingAlert(
	                '#dangerMessage',
	                '본인과는 대화를 연결 할 수 없습니다.',
	                2000);

			// 상대방 아이디 조회에 성공한 경우
		} else if (checkNum == 1) {
			$('#message_title_text').html(toId + '와의 대화중...');
			getMessage();
			messageRepeat = setInterval( "getMessage()", 3000 );
			
			autoClosingAlert(
	                '#successMessage',
	                toId + ' 님에게 보낼 메세지를 입력해주세요.',
	                2000);

		} else {
			console.log('아이디 값 조회 실패 >>> 존재하지 않는 아이디 ');
			$('#message_title_text').html('아이디 검색 실패');
			$('#message_body').html('');
			$('#message_body')
					.append(
							'<div class="row mb-3" id="message_line">'
									+ '<div class="col-12" style="text-align: center;">아이디를 다시 확인 해 주세요 ! </div>'
									+ '</div>');
			
			autoClosingAlert(
	                '#warningMessage',
	                '입력 하신 아이디는 존재 하지 않습니다.',
	                2000);
		}
	}
	
	
	
	

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
			var type = 'normal';
			sendMessage(type, toId);
			$('#message_input').val('');
		}
	});

	// 메세지 버튼 을 클릭시 : 메세지 전송
	$('#message_btn').on('click', function() {
		var type = 'normal';
		sendMessage(type, toId);
		$('#message_input').val('');
	});

	// 메세지 전송 처리
	function sendMessage(type, toId) {
		var content;
		userId = $.cookie('userId');
		
		if ( type == 'normal'){
		content = $('#message_input').val();
		} else if ( type == 'friend' ) {
			content = userId + ' 님의 친구신청 !'
		}

		$.ajax({
			type : 'post',
			url : '/message/submit',
			data : {
				type : type,
				id : userId,
				toId : toId,
				content : content
			},
			async : false,
			success : function(data) {
				console.log('message submit check value : ' + data);
				
				if ( type == 'normal') {
					autoClosingAlert(
					'#successMessage',
					toId + ' 님에게 메세지를 전송 했습니다.',
					2000);
				} else if ( type == 'friend') {
					
					messageAlert('친구신청', toId + ' 님에게 친구 요청 메세지를 보냈습니다.', 'success');
					/* autoClosingAlert(
					'#successMessage',
					toId + ' 님에게 친구 요청 메세지를 보냈습니다.',
					3000); */
				}
			}
		});
	}

	// 메세지 호출 처리
	function getMessage() {
		
		userId = $.cookie('userId');
		
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
					addMessage(item.no, item.id, item.type,item.idFile, item.content, item.mDate);
					console.log(item.no + ' : ' + item.type + ' : '+ item.id + ' : ' + item.idFile + ' : ' + item.content + ' : ' + item.mDate);
				});
				btn_friendaccept();
				btn_friendrefuse();
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
	    
	    $('#memberList_footer').html('<i class="fas fa-trash-alt float-left"></i>');
	    
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
					
					messageAlert('메세지 삭제', toId + '와의 메세지가 삭제 되었습니다.', 'success');
					
					/* autoClosingAlert(
			                '#dangerMessage',
			                toId + '와의 메세지가 삭제 되었습니다.',
			                2000); */
					
					
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
	function addMessage(no, id, type, idFile, content, mDate) {

		
		if ( type === 'normal' ) {
			
		
		
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
							'<div class="row float-right font-weight-bold" style="margin-right:0.5%;">'
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
		
		// 친구신청 메세지 : 보낸사람 인 경우 , 신청 취소 폼
		} else if ( type === 'friend' && id == $.cookie('userId') ) {
				$('#message_body').append(
						'<div class="row mb-3" id="message_line">'
						+'<div class="col-11" style="text-align: center; margin-left:6%;">'
						+'<div id="frined_messageno"style="visibility: hidden; ">' + no + '</div>'
						+'<img src="/local_img/profile/' + idFile +'" id="friend_img" class="rounded-circle">'
						+'<p>'+ id + '님에게 친구 요청 중...' + '</p>'
						+'<button class="btn btn-danger friend_refuse">취소</button></div>'
						+'</div>'
					);
				
			// 친구신청 메세지 : 받는사람 인 경우 , 수락 취소 폼
			} else if ( type === 'friend' && id !== $.cookie('userId') ) {
			$('#message_body').append(
				'<div class="row mb-3" id="message_line">'
				+'<div class="col-11" style="text-align: center; margin-left:6%;">'
				+'<div id="frined_messageno"style="visibility: hidden; ">' + no + '</div>'
				+'<img src="/local_img/profile/' + idFile +'" id="friend_img" class="rounded-circle">'
				+'<p>'+ content + '</p>'
				+'<button class="btn btn-primary friend_accept" style="margin-right : 2%;">수락</button>'
				+'<button class="btn btn-danger friend_refuse">거절</button></div>'
				+'</div>'
			);
			
		}
		// 스크롤바 가장 아래로 처리
		$('#message_body').scrollTop($('#message_body')[0].scrollHeight);
	}
	
	
	
	var cookieId = $.cookie('userId');
	unReadCountById(cookieId);
	/* var unReadCountRepeat = setInterval( "unReadCountById(cookieId)", 3000 ); */
	
	function unReadCountById(id){
    	$.ajax({
    		type : 'post',
    		url : '/message/unReadCountById',
    		async : false,
    		data : {
    			id : id
    		},
    		success : function(data) {
    			console.log('읽지 않은 메세지 갯수 : ' + data);
    			$('.topheader_message_text').html(data);
    		}
    	});
    }
	
	
	function swing() {
		$('.message_alarm').animate({
			'top' : '29px'
		}, 1000).animate({
			'top' : '19px'
		}, 1000, swing);
	}
	
	
	
/************************* Friend Process *************************/
	
	
	$('.friend_apply').on('click', function(){
		
		var friend_id = $.cookie('userId');
		var friend_fId = $('#friend_text').val();
		var type = 'friend';
		console.log(friend_id + " " + friend_fId);
		
		if ( checkUserId(friend_fId) == true ) {
			
			if ( friend_id === friend_fId ) {
				
				messageAlert('친구신청','본인에게는 친구신청을 할 수 없습니다.','error');
				
				/* autoClosingAlert(
	  	                '#dangerMessage',
	  	                '본인에게는 친구신청을 할 수 없습니다.',
	  	                2000); */
	  	                
				return;
			}
			
			
		} else {
			console.log('friend 검색 : 존재하지 않는 아이디');

			messageAlert('친구신청',friend_fId+'는 존재하지 않는 아이디 입니다.','error');
			
			/* autoClosingAlert(
  	                '#dangerMessage',
  	              friend_fId + ' 는 존재하지 않는 아이디 입니다.',
  	                2000); */
  	                
			return;
		}
		
		
		
			
		$.ajax({
			type : 'post',
			url : '/member/checkFriendStatus',
			async : false,
			data : {
				id : friend_id,
				fId : friend_fId
			},
			success : function(data){
				if ( data == 0 ) {
					inviteFriendMessage(friend_id, friend_fId);
					
					messageAlert('친구신청', friend_fId + ' 님에게 친구신청 되었습니다.','success');
					/* autoClosingAlert(
          	                '#successMessage',
          	              friend_fId + ' 님에게 친구신청 되었습니다.',
          	                2000); */
				} else if ( data == 1 ) {
					
					messageAlert('친구신청', friend_fId + ' 님과 이미 친구신청 진행중 입니다.' ,'error');
					/* autoClosingAlert(
          	                '#warningMessage',
          	              friend_fId + ' 님과 이미 친구신청 진행중 입니다.',
          	                2000); */
				} else if ( data == 2 ) {
					
					messageAlert('친구신청', friend_fId + ' 님과 이미 등록 된 친구 입니다.' ,'error');
					
					/* autoClosingAlert(
          	                '#dangerMessage',
          	              friend_fId + ' 님과 이미 등록 된 친구 입니다.',
          	                2000); */
				}
			}
		});
	   
	});
	
	function checkUserId(check_id){
		var checkPoint = false;
		$.ajax({
			type : 'post',
			url : '/member/checkid',
			data : {
				id : check_id
			},
			async : false,
			success : function(data){
				if ( data == '1' ) {
				checkPoint = true;
				}
			}
		});
		return checkPoint;
	}
	
	function inviteFriendMessage(friend_id, friend_fId){
		
		var type = 'friend';
		   $.ajax({
		       type : 'post',
		       url : '/member/applyFriend',
		       data : {
		         id : friend_id,
		         fId : friend_fId
		       },
		       async : false,
		       success : function(data){
		           console.log('applyFriend : '+data);
		           if ( data > 0 ) { 
		           sendMessage(type, friend_fId);
		           }
		       }
		   });
		}
	
	
	
	
    /* 
    $('#friend_apply').on('click', function(){
    	
    	var friend_idtext = $('#friend_id').val();
    	var friend_fidtext = $('#friend_fid').val();
    	console.log(friend_idtext + " " + friend_fidtext);
    	
       $.ajax({
           type : 'post',
           url : '/member/applyFriend',
           data : {
             id : friend_idtext,
             fId : friend_fidtext
           },
           async : false,
           success : function(data){
               console.log('applyFriend : '+data);
               if ( data > 0 ) { 
               sendMessage(type, fId);
               }
           }
       });
    }); 
     */
    
    
    function btn_friendaccept(){
    	
    	$('.friend_accept').on('click', function(){
        	
        	console.log($.cookie('userId') + ' : ' + toId);
        	console.log($(this).closest('div').find('#frined_messageno').html());
        	
        	var friend_messageNo = $(this).closest('div').find('#frined_messageno').html();
        	deleteInviteMessage(friend_messageNo);
        	
           $.ajax({
               type : 'post',
               url : '/member/acceptFriend',
               data : {
                 id : $.cookie('userId'),
                 fId : toId
               },
               async : false,
               success : function(data){
                   console.log('acceptFriend : ' + data);
                   getMessage();
                   
                  messageAlert('친구상태','친구신청을 수락 하였습니다.','success');
                   
                   /* autoClosingAlert(
          	                '#successMessage',
          	                '친구신청을 수락 하였습니다.',
          	                2000); */
               }
           });
        });
    }

    
    function btn_friendrefuse(){
    	
    	
    $('.friend_refuse').on('click', function(){
    	
    	console.log($.cookie('userId') + ' : ' + toId);
    	console.log($(this).closest('div').find('#frined_messageno').html());
    	
    	var friend_messageNo = $(this).closest('div').find('#frined_messageno').html();
    	deleteInviteMessage(friend_messageNo);
    	
    	
        $.ajax({
           type : 'post',
           url : '/member/refuseFriend',
           data : {
             id : $.cookie('userId'),
             fId : toId
           },
           async : false,
           success : function(data){
               console.log('refuseFriend : ' + data);
               getMessage();
               
               messageAlert('친구상태','친구신청이 취소 되었습니다.','error');
               
               
               /* autoClosingAlert(
    	                '#dangerMessage',
    	                '친구신청이 취소 되었습니다.',
    	                2000); */
           }
       });
    });
  }
    
    function deleteInviteMessage(no){
    	$.ajax({
    		type : 'post',
    		url : '/message/deleteInviteMessage',
    		data : {
    			no : no
    		},
    		async : false,
    		success : function(data) {
    		console.log('deleteInviteMessage : ' + data);	
    		}
    	});
    }
    
    
    function messageAlert(title, content, type){
    	swal({
    		  title: title,
    		  text: content,
    		  icon: type,
    		  button: "확인",
    		});
    }
    
</script>
    
    
    
    


</body>

</html>
