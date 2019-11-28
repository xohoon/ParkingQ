<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>:+:ParkingQ:+: - Login Page -</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<!-- Font -->
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<!-- FontAwesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous">
<!-- Login CSS-->
<link href="/css/login.css" rel="stylesheet" media="all">


<!-- Common JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script src="/js/jquery.cookie.js"></script>

<!-- Login JS-->
<!-- <script src="/js/index.js"></script>
 --></head>


<body>
	<c:choose>
		<%-- <c:when test="${sessionScope.userId ne null }"> --%>
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



	<div class="overlay"></div>
	<!-- <video playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop">
		<source src="/resources/video/main.mp4" type="video/mp4">
	</video> -->
	


	<div class="cont">

		<div class="demo">



			<!-- Login View Page -->
			<div class="login">
			<div class="login_logo">
				<img class="login_img" src="/images/login_logo3.png">
				<p class="login_idpwtext">ID : test  / PW : 1234</p>
			</div>
				<div class="login__form">
					<form method="post" action="/member/login">
						<div class="login__row">
							<svg class="login__icon name svg-icon" viewBox="0 0 20 20">
                                            <path d="M0,20 a10,8 0 0,1 20,0z M10,0 a4,4 0 0,1 0,8 a4,4 0 0,1 0,-8" />
                                        </svg>


							<input type="text" class="login__input name" placeholder="Username" id="id" />
						</div>
						<div class="login__row">
							<svg class="login__icon pass svg-icon" viewBox="0 0 20 20">
                                            <path d="M0,20 20,20 20,8 0,8z M10,13 10,16z M4,8 a6,8 0 0,1 12,0" />
                                        </svg>
							<input type="password" class="login__input pass" placeholder="Password" id="pass" />
						</div>
						<button type="button" class="login__submit">Sign in</button>
					</form>
					<p class="login__signup">
						설마 아직 회원이 아니세요 ? &nbsp;<a id="btn__signup">[회원가입]</a>
					</p>

				</div>
			</div>





			<!-- Login Messenger Page -->
			<div class="app" id="messenger">
				<div class="app__top">
					<div class="app__menu-btn">
						<span></span>
					</div>
					<i class="fas fa-home" id="icon-home"></i> <i class="fas fa-angle-double-up" id="icon-arrow"></i>
					<p class="app__hello"></p>
					<div class="app__user">
						<img src="" alt="" class="app__user-photo" /> <div class="app__user-notif" id="message_modal"></div>
						<div class="app__userId"></div>
					</div>


				</div>
				<div class="app__bot">
					<div class="app__meetings">
					
					
					</div>
				</div>
				<div class="app__logout">
					<svg class="app__logout-icon svg-icon" viewBox="0 0 20 20">
                                    <path d="M6,3 a8,8 0 1,0 8,0 M10,0 10,12" />
                                </svg>
				</div>
			</div>



			<!-- start join -->
			<div class="join">
				<div class="join__top">
					<div class="join__menu-btn">
						<span></span>
					</div>
					<svg class="join__icon search svg-icon" viewBox="0 0 20 20">
                                    <path d="M20,20 15.36,15.36 a9,9 0 0,1 -12.72,-12.72 a 9,9 0 0,1 12.72,12.72" />
                                </svg>
					<p class="join__hello">Sign Up</p>
					<div class="join__headerimg">
						<img src="/images/1.gif">
					</div>
					<div class="join__inputtext"></div>
				</div>


				<!--  Member Info Input -->
				<div class="join__bot">
					<div class="input-group">
						<input class="input--style-3" type="text" placeholder="input ID" data-oper='id' id="joinId" name="memberInfo">
					</div>

					<div class="input-group">
						<input class="input--style-3" type="password" placeholder="input Password" data-oper='pass' id="joinPass" name="memberInfo">
					</div>

					<div class="input-group">
						<input class="input--style-3" type="text" placeholder="inputNickName" data-oper='nick' id="joinNick" name="memberInfo">
					</div>

					<div class="input-group">
						<input class="input--style-3" type="text" placeholder="input Email" data-oper='email' id="joinEmail" name="memberInfo">
					</div>
				</div>


				<!-- Join Button -->
				<div class="join__logout">
					<svg class="join__logout-icon svg-icon" viewBox="0 0 20 20">
                    	<path d="M6,3 a8,8 0 1,0 8,0 M10,0 10,12" />
                    </svg>
				</div>
				
			</div>
			<!-- end join -->
			
			
			
			
			<!-- start choose -->
			<div class="choose">
				<div class="choose__top choose_top" style="height: 40rem;">
					<div class="choose__menu-btn">
						<span></span>
					</div>
					<svg class="choose__icon search svg-icon" viewBox="0 0 20 20">
                                    <path d="M20,20 15.36,15.36 a9,9 0 0,1 -12.72,-12.72 a 9,9 0 0,1 12.72,12.72" />
                                </svg>
					<p class="choose__hello">Choose Image</p>
					<div class="choose__headerimg">
						<div class="rounded-circle" id="profile_circle"></div>
						<i class="fas fa-sync fa-spin" id="choose_icon"></i>
						<img class="rounded-circle mt-5 ml-3" id="profile-default" src="/images/kakao/kakao-2.png" width>
					</div>
					<div class="choose__inputtext"></div>
				</div>
				
				<div class="choose__bot">
					<div class="input-group">
						<h5 class="font-weight-bold text-center text-white">프로필 기본사진을 선택 해 주세요 !</h5>
					</div>
				</div>



				<!-- Profile Choose Button -->
				<div class="choose__logout">
					<svg class="choose__logout-icon svg-icon" viewBox="0 0 20 20">
                                    <path d="M6,3 a8,8 0 1,0 8,0 M10,0 10,12" />
                                </svg>
				</div>
				
			</div>
			<!-- end choose -->
			
			
			
			
		</div>
	</div>



	 <!-- iframe을 이용한 쿠키처리 -->
	<form action="/member/deleteSession" method="post" target="zero" id="zeroForm">
		<button>LOGOUT</button>
	</form>
	<iframe name='zero' class='zero'> </iframe>


	<div id="mask"></div>


	<!-- Progess Bar -->
	<div class="progress" id="progressBar" style="display: none;">
		<div class="progress-bar progress-bar-striped bg-danger" style="width: 0%"></div>
		<div id="progress-val"></div>
	</div>
	<!-- Progess Text -->
	<div id="progress-text"></div>



	<!-- Modal Message -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Modal title</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
	<!-- MESSAGE & MEMBER INFO CHANGER ( CSS JS 파일로 추후 변경 )  -->
	
	
	
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
	width: 75%;
    height: 35px;
    border: 1px solid #d6d6d6;
    padding-left: 15px;
    font-size: 1.8rem;
    margin-top: 1%;
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
	font-size: 10px;
	
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
	left: 7%;
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
    left: 32%;
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
	padding-bottom: 4%;
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
input[type='password'] {
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
    font-size: 2rem;
    left: 43%;
    bottom: 3%;
}

.fa-search{
	cursor: pointer;
	margin-top: 1%;
	margin-right: 2%;
}

.fa-user-plus {
	cursor: pointer;
    font-size: 1.9rem;
    margin-right: 4%;
    margin-top: 1%;
}


div#message_rotate {
    position: absolute;
    width: 2.3rem;
    height: 2.3rem;
    left: 74.5%;
    top: 2.4%;
    background-color: #929189;
}

#modal-size {
    font-size: 1.5rem;
    top: 13%;
}

#message_btn{
	padding: 0 23px;
}

#message_body{
    height: 500px;
    width: 104%;
    overflow-y: scroll;
    overflow-x: hidden;
    font-size: 1.8rem;
    padding-right: 8%;
}

.message_nick {
    font-size: 1.8rem;
}

input#searchText, input#friend_text {
    height: 36px;
    font-size: 2rem;
}

label#searchtext {
    font-size: 1.5rem;
}

button#message_search {
    position: absolute;
    left: 33%;
}

button#message_friend{
	position: absolute;
    left: 33%;
}

#modal-search{
    left: 5%;
    top: 20%;
}

#message_ltext{
    margin-top: 2%;
}

img#friend_img {
    width: 20%;
    margin-bottom: 4%;
}

#message_modal_layout, #memberModal, #qr_modal_layout{
	top: 12%;
}

div#message_title, div#message_listtitle {
    height: 5rem;
}


.fa-search, #message_listtitle, #message_title {
	font-size: 1.5rem;
}

.fa-user-plus{
	font-size: 1.7rem;
}

#message_listtitle, #message_title{
	padding-top: 14px;
}

#message_readtext{
	font-size: 15px;
}

#searchModal, #friendModal{
    top: 25%;
    left: 11%;
}

span#message_title_text {
    margin-left: 5%;
}


</style>





<!-- <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog" id="modal-size">
		<div class="modal-content" style="background-color: transparent; border: 1px solid transparent">
			<div class="modal-body">


				<div id="message_container">
					<div style="width: 520px">
						메세지 목록 부분
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


						메세지함 부분
						<div class="card">
							<div class="card-header bg-dark text-white" id="message_title">
							<span id="message_title_text">메세지함</span>
							<i class="fas fa-search"></i></div>
							<div class="card-body" id="message_body">

								<div class="row mb-3" id="message_line">
									<div class="col-12" id="message_ltext" style="text-align: center;">메세지를 보낼 대상을 선택 해 주세요 !</div>
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
	<div class="modal-dialog" id="modal-search">
		<div class="modal-content col-sm-8">
			<div class="modal-header">
				<h4 class="modal-title" id="modal" style="font-weight: bold;">아이디 검색</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label id="searchtext">아이디</label> <input type="text" name="searchText" id="searchText" class="form-control" maxlength="15">
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" id="message_search" data-dismiss="modal" aria-label="Close">검색</button>
					<button class="btn btn-default" data-dismiss="modal" aria-label="Close">취소</button>
				</div>
			</div>
		</div>
	</div>
</div> -->






<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog" id="message_modal_layout">
		<div class="modal-content" style="background-color: transparent; border: 1px solid transparent">
			<div class="modal-body">


				<div id="message_container">
					<div style="width: 520px">
						<!-- 메세지 목록 부분 -->
						<div class="card mr-2 float-left" style="width: 125px;">
							<div class="card-header bg-dark text-white" id="message_listtitle">
								목록
								<!-- <div class="rounded-circle" id="message_rotate"></div>
								<i class="fas fa-sync fa-rotate fa-spin"></i> -->
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
								<i class="fas fa-search"></i>	<i class="fas fa-user-plus"></i>
							</div>
							<div class="card-body" id="message_body">

								<div class="row mb-3" id="message_line">
									<div class="col-12 message_defaultment" style="text-align: center; margin-top: 2%;">메세지를 보낼 대상을 선택 해 주세요 !</div>
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
					<span aria-hidden="true" style="font-size: 2rem;">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label style="font-size:1.5rem;">아이디</label> <input type="text" name="searchText" id="searchText" class="form-control" maxlength="15">
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" id="message_search" data-dismiss="modal" aria-label="Close">검색</button>
					<button class="btn btn-default" data-dismiss="modal" aria-label="Close">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="friendModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content col-sm-8">
			<div class="modal-header">
				<h4 class="modal-title" id="modal" style="font-weight: bold;">친구 추가</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true" style="font-size: 2rem;">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label style="font-size:1.5rem;">아이디</label> <input type="text" name="searchText" id="friend_text" class="form-control" maxlength="15">
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger friend_apply" id="message_friend" data-dismiss="modal" aria-label="Close">신청</button>
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
							<span class="ml-4">비번</span> <input type="password" class="ml-4" id="member_infoPass" maxlength="15" style="border-radius: 10px">
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
	<div class="alert alert-danger" id="dangerMessage" style="display: none; z-index: 9999;">
	</div>
	<div class="alert alert-warning" id="warningMessage" style="display: none; z-index: 9999;">
	</div>




<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="/js/index.js"></script>
<script src="/js/message.js"></script>



</body>
</html>