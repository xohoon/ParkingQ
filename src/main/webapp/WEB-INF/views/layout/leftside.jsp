<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>:+:ParkingQ:+: - Sub Page -</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:500,700"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Muli:400,400i,800,800i"
	rel="stylesheet">
<link href="/css/layout.css" rel="stylesheet">
<link href="/css/messenger/layout_messenger.css" rel="stylesheet">

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	crossorigin="anonymous">


<!-- Member CSS -->

<!-- FreeBoard CSS -->

<!-- MeetBoard CSS -->

<!-- InfoBoard CSS-->

<!-- ReviewBoard CSS -->

<!-- Admin CSS -->
<link rel="stylesheet" href="/css/admin.css">

<!-- Common JS -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<!-- Plugin JavaScript -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<!-- Custom scripts for this template -->
<script src="/resources/js/resume.min.js"></script>
<!-- SocketJS CDN -->
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<style>
.leftside_logo{
	cursor: pointer;
}
</style>
<script>
$(document).ready(function(){
$('.leftside_logo').on('click',function(){
	location.href='/common/main';
});
});
</script>

<!-- update connection Log -->
<c:choose>
	<%-- <c:when test="${sessionScope.userId ne null }"> --%>


	<c:when test="${cookie.userId eq null }">
		<script>
			alert('로그인정보가 없습니다.');
			location.href = '/common/login';
		</script>
	</c:when>

	<c:when test="${cookie.userId ne null }">
		<script>
			$(document).ready(function() {

				function updateConnect() {
					$.ajax({
						type : 'post',
						url : '/member/updateConnection',
						data : {
							userId : '${cookie.userId.value}'
						},
						async : false,
						success : function(data) {
							console.log('Update Connect Log : ' + data);
						}
					});
				}

				function setInfiniteConnectLog() {
					setInterval(function() {
						updateConnect();
					}, 55000);
				}
				updateConnect();
				setInfiniteConnectLog();
			});
		</script>
	</c:when>

</c:choose>

</head>



</head>

<body>



	<div class="layout_container">



		<!-- Alert Message -->
		<div class="alert alert-success" id="successMessage"
			style="display: none; z-index: 9999;"></div>
		<div class="alert alert-danger" id="dangerMessage"
			style="display: none; z-index: 9999;"></div>
		<div class="alert alert-warning" id="warningMessage"
			style="display: none; z-index: 9999;"></div>


		<div class="modal fade" id="messageModal" tabindex="-1" role="dialog"
			aria-labelledby="modal" aria-hidden="true">
			<div class="modal-dialog" id="message_modal_layout">
				<div class="modal-content"
					style="background-color: transparent; border: 1px solid transparent">
					<div class="modal-body">
						<div id="message_container">
							<div style="width: 520px">
								<!-- 메세지 목록 부분 -->
								<div class="card mr-2 float-left" style="width: 125px;">
									<div class="card-header bg-dark text-white"
										id="message_listtitle">
										목록
										<!-- 	<div class="rounded-circle" id="message_rotate"></div>
								<i class="fas fa-sync fa-rotate fa-spin"></i> -->
									</div>
									<div class="card-body" id="message_list"></div>
									<div class="card-footer" id="memberList_footer"
										ondragover="return false;" ondragenter="return false;"
										ondrop="drop(this, event);">
										<i class="fas fa-trash-alt float-left"></i>
									</div>
								</div>
								<!-- 메세지함 부분 -->
								<div class="card">
									<div class="card-header bg-dark text-white" id="message_title">
										<span id="message_title_text">메세지함</span> <i
											class="fas fa-search"></i> <i class="fas fa-user-plus"></i>
									</div>
									<div class="card-body" id="message_body">
										<div class="row mb-3" id="message_line">
											<div class="col-12" style="text-align: center;">메세지를 보낼
												대상을 선택 해 주세요 !</div>
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


		<div class="modal fade" id="searchModal" tabindex="-1" role="dialog"
			aria-labelledby="modal" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content col-sm-8">
					<div class="modal-header">
						<h4 class="modal-title" id="modal" style="font-weight: bold;">아이디
							검색</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>아이디</label> <input type="text" name="searchText"
								id="searchText" class="form-control" maxlength="15">
						</div>
						<div class="modal-footer">
							<button class="btn btn-danger" id="message_search"
								data-dismiss="modal" aria-label="Close">검색</button>
							<button class="btn btn-default" data-dismiss="modal"
								aria-label="Close">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>



		<div class="modal fade" id="memberModal" tabindex="-1" role="dialog"
			aria-labelledby="modal" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content col-sm-8"
					style="background-color: transparent; border: 1px solid transparent;">
					<div class="modal-body">

						<div class="card" style="width: 400px; border: 1px solid #dddddd;">
							<div class="card-header bg-dark text-white" id="message_title">정보
								변경</div>
							<img class="card-img-top rounded-circle mt-lg-4"
								id="member_infoFile" alt="member image"
								style="width: 150px; height: 150px; margin-left: 32%">
							<div class="card-body">
								<p class="card-text">
								<div class="mb-3 mt-3">
									<span class="ml-4">아디</span> <input type="text"
										class="ml-4 disabled" id="member_infoId" maxlength="15"
										style="border-radius: 10px; background-color: #dddddd;"
										readonly>
								</div>

								<div class="mb-3">
									<span class="ml-4">비번</span> <input type="password"
										class="ml-4" id="member_infoPass" maxlength="15"
										style="border-radius: 10px">
								</div>

								<div class="mb-4">
									<span class="ml-4">닉넴</span> <input type="text" class="ml-4"
										id="member_infoNick" maxlength="15"
										style="border-radius: 10px">
								</div>
								<a href="#" class="btn btn-primary float-right"
									id="member_memberInfoBtn">수정</a>
								<button class="btn btn-danger float-right mr-sm-2"
									id="member_passwordBtn">비밀번호변경</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>


		<div class="modal fade" id="passwordModal" tabindex="-1" role="dialog"
			aria-labelledby="modal" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content col-sm-8">
					<div class="modal-header">
						<h4 class="modal-title" id="modal" style="font-weight: bold;">비밀번호
							변경</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>현재비밀번호</label> <input type="password" name="currPassword"
								id="currPassword" class="form-control" maxlength="15">
						</div>
						<div class="form-group">
							<label>변경비밀번호</label> <input type="password"
								name="changePassword" id="changePassword" class="form-control"
								maxlength="15">
						</div>
						<div class="modal-footer">
							<button class="btn btn-danger" id="member_passwordChange"
								data-dismiss="modal" aria-label="Close">변경</button>
							<button class="btn btn-default" data-dismiss="modal"
								aria-label="Close">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>


		<div class="modal fade" id="qrModal" tabindex="-1" role="dialog"
			aria-labelledby="modal" aria-hidden="true">
			<div class="modal-dialog" id="qr_modal_layout">
				<div class="modal-content col-sm-8"
					style="background-color: transparent; border: 1px solid transparent;">
					<div class="modal-body">

						<div class="card" style="width: 400px; border: 1px solid #dddddd;">
							<div class="card-header bg-dark text-white" id="message_title">QR코드</div>
							<div id="qr_imagebox">
								<img class="card-img-top mt-lg-4" id="qr_image" alt="qr image"
									style="width: 250px; height: 250px; margin-left: 19%">
							</div>
							<div class="card-body">
								<p class="card-text">

									<!-- <div class="mb-4">
							<span class="ml-4">닉넴</span> <input type="text" class="ml-4" id="member_infoNick" maxlength="15" style="border-radius: 10px">
						</div> -->
									<a href="#" class="btn btn-danger" id="member_changQrBtn"
										style="margin-left: 30%">재생성</a> <a href="#"
										class="btn btn-primary" id="member_printQrBtn">인쇄</a>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>


		<div class="modal fade" id="friendModal" tabindex="-1" role="dialog"
			aria-labelledby="modal" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content col-sm-8">
					<div class="modal-header">
						<h4 class="modal-title" id="modal" style="font-weight: bold;">친구
							추가</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>아이디</label> <input type="text" name="searchText"
								id="friend_text" class="form-control" maxlength="15">
						</div>
						<div class="modal-footer">
							<button class="btn btn-danger friend_apply" id="message_friend"
								data-dismiss="modal" aria-label="Close">신청</button>
							<button class="btn btn-default" data-dismiss="modal"
								aria-label="Close">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>



		<div class="leftside_container">
			<img class="leftside_logo" src="/images/layout/leftlogo.png">

			<div class="leftside_welcome">
				<img class="rounded-circle leftside_welcome_image"
					src="/local_img/profile/index.png" style="width: 60px; height: 60px;">
				<p class="leftside_welcome_text">
					<span class="leftside_welcome_userid"></span>님 환영 합니다.
				</p>
				<p class="leftside_welcome_log">
					마지막 접속기록 : <span class="leftside_welcome_time"></span>
				</p>
				<button class="btn btn-danger leftside_logout">로그아웃</button>
				<button class="btn btn-success leftside_qrcode">QR코드</button>
				<button class="btn btn-primary leftside_member">정보변경</button>

			</div>

			<ul class="nav flex-column leftside_ul">
			
				<li class="nav-item"><a class="nav-link" href="/common/main">메인
						<i class="fas fa-angle-right"></i>
				</a></li>
			
				<li class="nav-item"><a class="nav-link" href="/freeboard/list">자유게시판
						<i class="fas fa-angle-right"></i>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="/meetboard/list">오시는거죠
						<i class="fas fa-angle-right"></i>
				</a></li>
				<!-- <li class="nav-item"><a class="nav-link" href="/infoboard/list">정보공유
						<i class="fas fa-angle-right"></i>
				</a></li> -->
				<li class="nav-item"><a class="nav-link"
					href="/reviewboard/list">이용후기 <i class="fas fa-angle-right"></i></a></li>
				<li class="nav-item"><a class="nav-link" href="/admin/main">관리
						<i class="fas fa-angle-right"></i>
				</a></li>
			</ul>

			<div class="leftside_community">
				<div class="leftside_community_text">커뮤니티 활동</div>
				<div>
					<div class="leftside_community_box leftside_margin_1">
						<p class="leftside_community_num leftside_community_visit">0</p>
						<p class="leftside_community_sub">방문한수</p>
					</div>

					<div class="leftside_community_box">
						<p class="leftside_community_num leftside_community_board">0</p>
						<p class="leftside_community_sub">글작성수</p>
					</div>

					<div class="leftside_community_box">
						<p class="leftside_community_num leftside_community_comment">0</p>
						<p class="leftside_community_sub">댓글단수</p>
					</div>
				</div>

				<!-- END LEFTSIDE_COMMUNITY -->
			</div>
			<!-- END LEFTSIDE NAV VAR -->
		</div>