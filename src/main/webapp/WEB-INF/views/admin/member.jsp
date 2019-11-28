<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



	<!-- 
	<label class="switch"> <input type="checkbox" id="admin" checked> <span class="slider round"></span>
	</label>
	<button type="button" class="btn btn-facebook waves-effect waves-light m-t-20">
		<i class="fab fa-facebook m-r-5"></i> Facebook
	</button> -->



<ul class="nav nav-tabs nav-justified">
    <li class="nav-item">
      <a class="nav-link" href="<c:url value='/admin/main'/>">메인</a>
    </li>
    <li class="nav-item">
      <a class="nav-link active" href="<c:url value='/admin/member'/>">회원정보</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="<c:url value='/admin/board'/>">게시판정보</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="<c:url value='/admin/message'/>">메세지정보</a>
    </li>
</ul>


	<!-- <h4 class="header-title m-t-0 m-b-30">회원목록</h4> -->
	
	<div class="admin_total">
		<span class="admin_total_text">최근 가입한 사용자 수 ( 7일 ) : </span>
		<span class="admin_total_value">0</span>
	</div>
	<input class="form-control admin_search" id="admin_search" type="text" placeholder="검색...">

	<table id="datatable-scroller" class="table table-bordered" style="border-collapse: collapse; border-spacing: 0; width: 100%; text-align: center; vertical-align: middle;">
		<thead class="thead-dark">
			<tr>
				<th>순번</th>
				<th>권한</th>
				<th>아이디</th>
				<th>닉네임</th>
				<th>이메일</th>
				<th>QR코드</th>
				<th>기능</th>
				<th>관리자</th>
			</tr>
		</thead>

		<tbody id="admin_tbody">

			<c:forEach items="${memberList}" var="list">

				<tr role="row" class="odd test1" value="${list.no }">
					<td class="admin_memberNo">${list.no }</td>
					<td class="admin_memberType">${list.type }</td>
					<td class="admin_memberId">${list.id }</td>
					<td class="admin_memberNick">${list.nick }</td>
					<td class="admin_memberEmail">${list.email }</td>
					<td class="admin_memberKey">${list.key }</td>
					<td>
						<button class="btn btn-primary admin_memberModify">수정</button>
						<button class="btn btn-danger admin_delete">삭제</button> <!-- <i class="fas fa-times"></i><i class="fas fa-user-edit">
						</i> -->
					</td>
					<td><c:choose>
							<c:when test="${list.type eq 'normal' }">
								<label class="switch"> <input type="checkbox" class="admin"> <span class="slider round"></span></label>
							</c:when>
							<c:otherwise>
								<label class="switch"> <input type="checkbox" class="admin" checked> <span class="slider round"></span></label>
							</c:otherwise>
						</c:choose></td>
				</tr>

			</c:forEach>

		</tbody>

	</table>





<div class="modal fade" id="admin_memberModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content col-sm-8" style="background-color: transparent; border: 1px solid transparent;">
					<div class="modal-body">

						<div class="card" style="width: 455px; border: 1px solid #dddddd;">
							<div class="card-header bg-dark text-white" id="message_title">회원정보변경</div>
							<div class="card-body">
								<div class="mb-3 mt-3">
									<span class="ml-4 modal_membertext">아이디</span> <input type="text" class="ml-4 disabled modal_memberinput" id="admin_memberId" maxlength="15" readonly>
								</div>

								<div class="mb-3">
									<span class="ml-4 modal_membertext">비밀번호</span> <input type="password" class="ml-4 modal_memberinput" id="admin_memberPass" maxlength="15" >
								</div>

								<div class="mb-4">
									<span class="ml-4 modal_membertext">닉네임</span> <input type="text" class="ml-4 modal_memberinput" id="admin_memberNick" maxlength="15">
								</div>
								
								<div class="mb-3">
									<span class="ml-4 modal_membertext">이메일</span> <input type="mail" class="ml-4 modal_memberinput" id="admin_memberEmail" >
								</div>
								
								<div class="mb-3">
									<span class="ml-4 modal_membertext">QR코드</span> <input type="text" class="ml-4 modal_memberinput" id="admin_memberQr" readonly>
								</div>
								<div class="mb-3">
									<span class="ml-4 modal_membertext">가입일자</span> <input type="text" class="ml-4 modal_memberinput" id="admin_memberMDate" readonly>
								</div>
								<a href="#" class="btn btn-danger" id="admin_changeQrBtn">QR코드 재생성</a>
								<a href="#" class="btn btn-primary ml-sm-1" id="admin_updateMemberInfo">수정</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>





	<script>

	$('.topheader_subject_text').html('관리페이지');
	$('input:checkbox[class="admin"]').on('click', function(){
		
		var admin_memberId = $(this).parents('tr').children('.admin_memberId').text();
		var admin_memberType = $(this).parents('tr').children('.admin_memberType').text();
		
		if ( admin_memberType == 'normal' ) {
			admin_memberType = 'admin';
		} else {
			admin_memberType = 'normal';
		}
		
		var changeType = updateAuth(admin_memberId, admin_memberType);
		$(this).parents('tr').children('.admin_memberType').text(changeType);
		
	});
	
	// 최근 7일 가입자 수 확인
	getWeekCountMember();
	function getWeekCountMember(){
		$.ajax({
			type : 'post',
			url : '/admin/getWeekCountMember',
			async : false,
			success : function(data){
				$('.admin_total_value').html(data);
			}
		});
	}
	
	
	function updateAuth(id,type){
		var result = type;
		$.ajax({
			type : 'post',
			url : '/admin/updateAuth',
			data : {
				id : id,
				type : type
			},
			async : false,
			success : function(data){
				
				// 시간설정
				setTimeout(function(){
					
					if ( data == 1 ) {
						if ( type == 'admin'){
							result = 'admin';
							
							
							messageAlert('권한변경',id + '님이 관리자로 설정 되었습니다.','success');
							
						} else {
							result = 'normal';
							messageAlert('권한변경',id + '님의 관리자 권한이 해제 되었습니다.','error');
							
						}
					} else {
						
						if ( type == 'admin' ) {
							result = 'normal';
						} else {
							result = 'admin';
						}
						
						messageAlert('권한변경', id + '님의 권한 설정에 실패 했습니다.','success');
						
					}
				}
						, 300);
				
			}
		});
		
		return result;
	}
	
	function getAuth(id) {
		var result;
		$.ajax({
			type : 'post',
			url : '/admin/getAuth',
			data : {
				id : id
			},
			async : false,
			success : function(data){
				result = data;
			}
		});
		return result;
	}
	
	
	$('.admin_memberModify').on('click',function(){
		console.log (  $(this).parents('tr').children('.admin_memberId').text()   );
		var id = $(this).parents('tr').children('.admin_memberId').text();
		getAdminMember(id);
		$('#admin_memberModal').modal('show');
	});
	
	function getAdminMember(id){
		$.ajax({
			type : 'post',
			url : '/admin/getMemberInfo',
			dataType : 'json',
			async : false,
			data : {
				id : id
			},
			success : function(data){
				console.log(data);
				$.each(data,function(key,value){
					if(key == 'id'){
						$('#admin_memberId').val(value);
					} else if ( key == 'pass' ){
						$('#admin_memberPass').val(value);
					} else if ( key == 'nick' ) {
						$('#admin_memberNick').val(value);
					} else if ( key == 'email' ) {
						$('#admin_memberEmail').val(value);
					} else if ( key == 'mDate' ) {
						$('#admin_memberMDate').val(value);
					} else if ( key == 'key' ) {
						$('#admin_memberQr').val(value);
					}
				});
			}
		});
	}
	
	
	
	$('#admin_changeQrBtn').on('click',function(){
		updateQrCode();
		var key = getQrCode();
		$('#admin_memberQr').val(key);
	});
	
	
	$('#admin_updateMemberInfo').on('click', function(){
		var id = $('#admin_memberId').val();
		var pass = $('#admin_memberPass').val();
		var nick = $('#admin_memberNick').val();
		var email = $('#admin_memberEmail').val();
		var result = updateAdminMember(id, pass, nick, email);
		
		if ( result == 1 ) {
			$('#admin_memberModal').modal('hide');
		}
	});
	
	function updateAdminMember(id, pass, nick, email){
		var result;
		$.ajax({
			type : 'post',
			url : '/admin/updateMember',
			async : false,
			data : {
				id : id,
				pass : pass,
				nick : nick,
				email : email
			},
			success : function(data){
				result = data;
				if ( data == 1 ) {
					messageAlert('회원정보변경', id+'님의 회원정보를 변경 했습니다.', 'success');
				} else {
					messageAlert('회원정보변경', id+'님의 회원정보를 변경 실패 했습니다..', 'error');
				}
			}
		});
		return result;
	}
	
	
	$('.admin_delete').on('click',function(){
		
		var admin_memberId = $(this).parents('tr').children('.admin_memberId').text();
		
		swal({
			  title: "사용자 삭제",
			  text: "해당 사용자를 삭제 하시겠습니까?",
			  icon: "warning",
			  buttons: ["취소", "삭제"],
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
			    swal("해당 사용자를 삭제 했습니다.", {
			      icon: "success",
			    });
			    deleteUser(admin_memberId);
			    $(this).parents('tr').remove();
			  } else {
			    swal("사용자 삭제가 취소 되었습니다.", {
			    	icon: "error",
			    	button : "확인"
			    });
			  }
			});
		
	});
	
	
	
	function deleteUser(id){
		$.ajax({
			type : 'post',
			url : '/admin/deleteUser',
			data : {
				id : id
			},
			async : false,
			success : function(data){
				console.log(data);
			}
		});
	}

		$("#admin_search").on("keyup", function() {
		    var value = $(this).val().toLowerCase();
		    $("#admin_tbody tr").filter(function() {
		      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
		    });
		  });
		
		
	</script>

