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
</head>
<body>
    <style>
        .container {
            background-color: white;
            width: 100%;
            height: auto;
        }
    </style>

    <div class="container">


        <nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top" style="z-index: 9999;">
            <a class="navbar-brand" href="#">파킹큐</a>
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                        게시판
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="/freeboard/mlist">자유게시판</a>
                        <a class="dropdown-item" href="/meetboard/mlist">오시는거죠</a>
                        <a class="dropdown-item" href="/infoboard/mlist">정보공유</a>
                        <a class="dropdown-item" href="/reviewboard/mlist">이용후기</a>
                    </div>
                </li>
            </ul>
        </nav>

        <div class="container-fluid" style="margin-top:70px; position: relative">

            <div class="layout-title" style="padding: 10px 10px 30px 10px;">
                <i class="far fa-comment-dots" style="font-size: 2rem;"></i>
                <span style="font-size: 1.4rem; position: absolute; margin-left: 5%;">자유게시판</span>
            </div>


            <div class="layout-content">
                <div style="border: 1px solid blue; height: auto;">
                
                
                
<div class="getPage">
	<div class="card-body" style="width:100%;height:100%;position:repeat;">
		<div class="like" style="float:left;margin-bottom:5px;margin-left:166px;">
					<img src="/images/meetboard/s01.png" class="btn_like_u" style="visibility:visible;width:18px;height:18px;position:absolute;">
					<img src="/images/meetboard/s02.png" class="btn_like_d" style="visibility:hidden;width:18px;height:18px;position:absolute;">
		</div>
		<div style="float:left;font-size:11px;margin-left:22px;margin-top:2px;"><b>좋아요</b></div>
		<div id="countLike" style="float:left;font-weight:bold;font-size:11px;margin-top:2px;">1개</div>
	</div>
	<div class="card" style="width:100%">
		<!-- header -->
		<div class="card-body">
			<!-- Image View -->
			<div>
				<img class="img-thumbnail" src="/local_img/meetboard/${board.mfile }" style="width:256px;height:181px;">
			</div>
			<div>
				<div class="form-group" style="margin-top:15px;">
					<label for="comment">모임 이름</label>
					<input class="form-control" name='mname' value='<c:out value="${board.mname }"/>' readonly style="background-color: #EEF5FA">
				</div>
				<div class="form-group">
					<label for="comment">모임 목적</label>
					<input class="form-control" name='title' value='<c:out value="${board.title }" />' readonly style="background-color: #EEF5FA">
				</div>
				<div class="form-group">
					<label for="comment">모임 장</label>
					<input class="form-control" name='nick' value='<c:out value="${board.nick }"/>' readonly style="background-color: #EEF5FA">
				</div>
			</div>
		</div>
		<!-- body -->
		<div class="card-header" style="width:256px;height:150px;">
			<!-- Google map view part -->
			<div id="google_map"></div>
		</div>
		<!-- footer -->
		<div class="card-body">
			<div class="form-group">
				<label for="comment">모임 상세내용</label>
				<textarea class="form-control" rows="5" id="comment" name='content' readonly style="background-color: #EEF5FA"><c:out value="${board.content }"/></textarea>
			</div>
			<br />
			<c:if test="${userId ne board.id }">
				<button id="joinClick" class="btn btn-primary" style="float:left;margin-left:85px;"><div id="joinText">참여하기</div></button>
			</c:if>
			<div>
				<div id="countJoin" style="position:absolute;float:left;;font-weight:bold;"></div>
				<div style="position:absolute;float:left;;font-weight:bold;left:222px;bottom:50px;"> 참여중</div>
			</div>
		</div>
		</div>
		<div class="card">
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



                </div>
                
            </div>
        </div>
    </div>
</body>
</html>