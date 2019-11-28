<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <style>
        .container {
            background-color: white;
            width: 100%;
            height: auto;
        }
        .fb_title{
    		display: inline-block;
    		width: 100%;}
    </style>

    <div class="container">

		<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top"
      	   style="z-index: 9999;">
        	 <a class="navbar-brand" href="/common/mmain">파킹큐</a>
         	<ul class="navbar-nav">
            	<li class="nav-item dropdown"><a
               	class="nav-link dropdown-toggle" href="#" id="navbardrop"
               	data-toggle="dropdown"> 게시판 </a>
               <div class="dropdown-menu">
                  <a class="dropdown-item" href="/freeboard/mlist">자유게시판</a> 
                  <a class="dropdown-item" href="/meetboard/mMeetList">오시는거죠</a> 
                  <a class="dropdown-item" href="/reviewboard/mlist">이용후기</a>
               </div></li>
         </ul>
        </nav>

        <div class="container-fluid" style="margin-top:70px; position: relative">

            <div class="layout-title" style="padding: 10px 10px 30px 10px;">
                <i class="far fa-comment-dots" style="font-size: 2rem;"></i>
                <span style="font-size: 1.4rem; position: absolute; margin-left: 5%;">자유게시판</span>
            </div>

            <div class="layout-content">
                <div style="height: auto;">
                
               <div>
                              
                
			<div class="fb_title">
			
                <label>No</label> <input class="form-control" name='no'
				value='<c:out value="${board.no }" />' readonly="readonly">
			
				<label>제목</label> <input class="form-control" name='title'
				value='<c:out value="${board.title }" />' readonly="readonly">
			
				<label>작성자</label> <input class="form-control" name='id'
				value='<c:out value="${board.id }" />' readonly="readonly">
            	 
           </div>
 
			<div class="form-group">

				<label>내용</label>
				<textarea class="form-control" rows="3" name='content' id="textarea"
					readonly="readonly">
           		<c:out value="${board.content }" />
        	    </textarea>

            </div>

                </div>
                
                
                <div id="get_btn">
	<div id="middel_btn" style="text-align: center;">
	
	<button data-oper='list' class="btn btn-success" onclick="history.back()">목록</button>
	
	</div>
</div>
                
            </div>
        </div>
    </div>
  </div>
</body>
</html>