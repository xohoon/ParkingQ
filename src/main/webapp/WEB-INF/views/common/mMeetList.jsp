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

<script type="text/javascript" src="/resources/js/jquery.cookie.js"></script>


<script type="text/javascript">
	$(document).ready(function(){
		var actionForm = $("#actionForm");
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			console.log('click page');
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		/* board list event proccess add */
		
		/* move -> btn btn-info */
    	$(".move").on("click", function(e){
    		e.preventDefault();
    		actionForm.append("<input type='hidden' name='no' value='"+
    				$(this).attr("href")+"'>");
    					actionForm.attr("action", "/meetboard/mMeetGet");
    					actionForm.submit();
   						console.lon("boardcount::::::"+no);
   		});
		
	});


</script> 


</head>
<body>

<!-- 반응형에 맞춰질 수 있도록 % 로 너비 주고 em으로 글자크기 -->


<style>
	.container {
	background-color: white;
	width: 100%;
	height: auto;
	}

    .listAll{
        width: 100%;
        height: 71px;
        position: relative;
        background-color: #EEF5FA;
        border-radius: 10px;
        margin-bottom: 55px;
        
		-webkit-transform: scale(1);
		-moz-transform: scale(1);
		-ms-transform: scale(1);
		-o-transform: scale(1);
		transform: scale(1);
		-webkit-transition: all 0.3s ease-in-out;
		-moz-transition: all 0.3s ease-in-out;
		transition: all 0.3s ease-in-out;
    }
    .listAll:HOVER{
		-webkit-transform: scale(1.02);
		-moz-transform: scale(1.02);
		-ms-transform: scale(1.02);
		-o-transform: scale(1.02);
		transform: scale(1.02);
    }
    .a01{
        margin:5px;
        float: left;
    }
    .a02{
        position: absolute;
        left: 30px;
   		top: 30px;
   		background-color: #EEF5FA;
   		border-radius: 12px;
    }
    .bbb{
        float: left;
        margin-left: 2px;
    }
    .b01{
        margin-top:20px;
        background-color: #EEF5FA;
        font-weight:bold;
    }
    .b02{
        height: 27px;
        margin-top:3px;
        font-weight:bold;
        width:220px;
    }
    .c01{
        float: left;
        font-weight:bold;
    }
    .c00{
        float: left;
        margin-top:1px;
        margin-left:9px;
        letter-spacing: 1px;
        font-weight:bold;
    }
    .img01{
        border-radius: 15px;
    }
    .move{
    	position: absolute;
    }
    
    .asd{
    	border:1px solid red;
    }
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
                <!-- 반응형에 맞춰질 수 있도록 % 로 너비 주고 em으로 글자크기 -->
                
	<c:forEach items="${list }" var="board">
		<div class="listAll" style="cursor:pointer;">
			<div class="move" href='<c:out value="${board.no}"/>'>
			    <div class="a01">
				        <img class="img01" src='/local_img/meetboard/<c:out value="${board.mfile }" />' style="width:65px;height:60px;">
			    </div>
			 
			    <div class="bbb">
					<div>
						<div class="b02" style="font-size: 12px;"><c:out value="${board.title }" /></div>
			        </div>
			        <div class="ccc">
			            <div class="c01"><img class="rounded-circle" src='/local_img/profile/<c:out value="${board.pfile }" />' style="width:25px;height:25px;"></div>
			            <div class="c00">
			                <div class="c02" style="font-size: 11px;"><c:out value="${board.mname }" /></div>
			                <div class="c03" style="font-size: 10px;"><c:out value="${board.nick }" /></div>
			            </div>
			        </div>
			        <div style="position:absolute;bottom:-20px;left:12px;float:right;font-size:11px;width:50%;">
						<img class="img02" src='/images/meetboard/s00.png' style="width:15px;height:15px;float:left;">
						<div style="margin-left:4px;float:left;font-weight:bold;">좋아요 <c:out value="${board.mlike }" />개</div>
			        </div>
			        <div style="position:absolute;bottom:-22px;left:125px;float:right;font-size:11px;width:50%;">
						<img class="img03" src='/images/meetboard/h00.png' style="width:15px;height:15px;float:left;">
						<div style="margin-left:4px;float:left;font-weight:bold;">참여중 <c:out value="${board.gmember }" />명</div>
			        </div>
			        <div style="position:absolute;bottom:-40px;left:12px;float:right;font-size:11px;width:50%;">
						<img class="img04" src='/images/meetboard/c00.png' style="width:15px;height:15px;float:left;">
						<div style="margin-left:4px;float:left;font-weight:bold;">댓글수 <c:out value="${board.greply }" />개</div>
			        </div>
			        <div style="position:absolute;bottom:-42px;left:125px;float:right;font-size:11px;width:50%;">
						<img class="img05" src='/images/meetboard/v00.png' style="width:15px;height:15px;float:left;">
						<div style="margin-left:4px;float:left;font-weight:bold;">조회수 <c:out value="${board.mview }" />회</div>
			        </div>
			        <input type='hidden' data-no='<c:out value="${board.no}"/>' name='no'>
			    </div>
			</div>
		</div>
	</c:forEach>
                
                

                </div>
                
                <br><br>
                <!-- 페이징 START / 글 view 일 경우에는 페이징 요소 제거 -->
		<ul class="pagination">
			<c:if test="${pageMaker.prev }">
				<li class="paginate_button previous"><a class="page-link" href="${pageMaker.startPage -1}">Previous</a></li>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
				<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":"" } "><a class="page-link" href="${num }">${num }</a></li>
			</c:forEach>
			<c:if test="${pageMaker.next }">
				<li class="paginate_button next"><a class="page-link" href="${pageMaker.endPage +1 }">Next</a></li>
			</c:if>
		</ul>
                <!-- 페이징 END -->
                
            </div>
        </div>
    </div>
    
    
<form id='actionForm' action="/meetboard/mMeetList" method='get'>
	<input type="hidden" name='pageNum' value='${pageMaker.cri.pageNum }'>
	<input type="hidden" name='amount' value='${pageMaker.cri.amount }'>
</form>

    
    
    
</body>
</html>