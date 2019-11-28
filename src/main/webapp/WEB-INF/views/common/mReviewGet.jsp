<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            padding-left:0px;
            padding-right:0px;
        }
        .logo{
			top:10px;
			left:5%;
			width:152px;
			height:26px;
			line-height:26px;
			pyomering:0px;
			text-indent:-9999em;
			outline:none;
			overflow:hidden;
			z-index:3;
			opacity:1;
			background:url('/resources/images/main/leftlogo.png') no-repeat;
			display: inline-block;
		    padding-top: .3125rem;
		    padding-bottom: .3125rem;
		    margin-right: 1rem;
		    line-height: inherit;
		    white-space: nowrap;
		    cursor:pointer;
		}
		
		.roof_tr:active {
			background-color:#eee;
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

            <div class="layout-title" style="padding: 10xp 10px 30px 10px;">
                <i class="far fa-comment-dots" style="font-size: 2rem;"></i>
                <span style="font-size: 1.4rem; position: absolute; margin-left: 5%;"></span>
            </div>


            <div class="layout-content">
                <div style=" height: auto;margin-top: 10%;">
                
                <div class="row">
    	<div class="col-lg-12">
    		<div class="panel panel-default">
                        <!-- /.panel-heading -->
				<div class="panel-body">
                	

                	
                	<div class="form-group">
                		<label>작성자</label><input class="form-control" name='no'
                		value='<c:out value="${reviewboard.id}"/>' readonly="readonly"> 
                	</div>
                	
                	<div class="form-group">
                		<label>제목</label><input class="form-control" name='title'
                		value='<c:out value="${reviewboard.title}"/>' readonly="readonly"> 
                	</div>
                	
                	<div class="form-group">
                		<label>내용</label>
                		<Textarea class="form-control" rows="3" name='content'
                		 readonly="readonly"> <c:out value="${reviewboard.content}"/>
                		 </Textarea> 
                	</div>
       
                	<button data-oper='list' class="btn btn-info">뒤로가기</button>
                	
                	<form id="operForm" action="/reviewboard/modify" method="get">
                		<input type="hidden" id="no" name="no" value='<c:out value="${reviewboard.no }"/> '>
                		<input type="hidden" name="pageNum" value='<c:out value="${pg.pageNum }"/>'>
                		<input type="hidden" name="amount" value='<c:out value="${pg.amount }"/>'>
                	</form>
                	
                	<div class="panel panel-default">
                		
                		<div class="panel-heading">
                			<i class="fa fa-comments fa-fw"></i> 댓글
                			
                		</div>
                			<!-- /.panel-heading  -->
            		<div class="panel-body">
            			<ul class="chat">
            				<!--start reply  -->
            				
            				<!--end reply  -->
            			</ul>
            		</div>
            			<!-- /.panel-body  -->
            			
            		<!-- chat-panel 추가  -->
            		<div class="panel-footer">
            		
            		</div>	
            			<!-- end panel-footer  -->
                	</div>
                		<!-- /.panel-default  -->
              	</div>
                        <!-- /.panel-body -->
           	</div>
                    <!-- /.panel -->
    	</div>
                <!-- /.col-lg-6 -->
	</div>
            <!-- /.row -->
               

                </div>
                
                
                
               
                
            </div>
        </div>
    </div>
    
    <script type="text/javascript" src="/resources/js/reviewReply.js"></script> 
    <script type="text/javascript">
		$(document).ready(function(){
			
			//415p comment list
			var gnoValue='<c:out value="${reviewboard.no}"/>';
			var replyUL = $(".chat");
			
			console.log(gnoValue);
			
			showList(1);
			
			function showList(page){

				console.log("show list " + page);
				
				CommentService.getList({gno:gnoValue, page:page||1},
						function(replyCnt, list){
						
						console.log("replyCnt : " + replyCnt);
						console.log("list : " + list);
						console.log(list);
						
						if(page == -1){
							pageNum=Math.ceil(replyCnt/10.0);
							showList(pageNum);
							return;
						}
						
					var str="";
					if(list==null || list.length==0){
						return;
					}
					
					for(var i =0, len=list.length || 0; i < len; i++){
						str +="<li class='left clearfix' data-no='"+list[i].no+"'>";
						str +=" <div><div class='header'><strong class='primary-font'>["
							+ list[i].no+ "] "+ list[i].id + "</strong>";
						str +=" <small class='pull-right text-muted'>" 
						+ CommentService.displayTime(list[i].rdate)+"</small></div>";
						str +=" <p>" + list[i].content + "</p></div></li>";
					}
					for(var i =0, len = list.length || 0; i <len ; i++){
						
					}
					replyUL.html(str);
					
					showReplyPage(replyCnt);
					
					
				}); //end function
					
			}//end showList
			//showList() 함수는 파라미터로 전달되는 page 변수를 이용해서 원하는 댓글 페이지를 가져오게 된다. 이때 만일 page번호가 '-1'로
			//전달되면 마지막 페이지를 차장서 다시 호출하게 된다. 사용자가 새로운 댓글을 추가하면 showList(-1)을 호출하여 우선 전체 댓글의
			//숫자를 파악하게 한다. 이 후에 다시 마지막 페이지를 호출해서 이동시키는 방식으로 동작시킨다.
			// 이러한 방식은 여러 번 서버를 호출해야 하는 단점이 있기는 하지만, 댓글의 등록 행위가 댓글 조회나 페이징에 비해서 적기 때문에
			//심각한 문제는 아니다.
			
			
			
			//422p modal 
			var modal=$("#myModals");
			var modalInputReply=modal.find("input[name='reply']");
			var modalInputId=modal.find("input[name='id']");
			var modalInputRdate=modal.find("input[name='rdate']");
			
			var modalModBtn=$("#modalModBtn");
			var modalRemoveBtn=$("#modalRemoveBtn");
			var modalRegisterBtn = $("#modalRegisterBtn");
			var modalCloseBtn = $("#modalCloseBtn");
			
			$("#addReplyBtn").on("click",function(e){
				
				modal.find("input").val("");
				modalInputRdate.closest("div").hide();
				modal.find("button[id !='modalCloseBtn']").hide();
				
				modalRegisterBtn.show();
				$("#myModals").modal("show");
			});
		
			//423p add new comment 
			modalRegisterBtn.on("click", function(e){
				
				var reply={
					
						content : modalInputReply.val(),
						id : modalInputId.val(),
						gno : gnoValue,
						nick : "임시닉네임"
				};
				
				
				CommentService.add(reply, function(result){
					
					alert(result);
					
					modal.find("input").val("");
					modal.modal("hide");
					
					showList(-1);
					
					//showList는 앞서 내가 정의한 함수이다. 1의 의미는 page 파라미터 값이고
					//gno의 값은 내장되어 있다.
				});
			});
			
			// modal cancle button
			modalCloseBtn.on("click", function(e){
				modal.modal("hide");
				showList(pageNum);
			});
			
			//425p comment click event 
			$(".chat").on("click", "li", function(e){
				var no= $(this).data("no");
				
				console.log(no);
				//댓글을 클릭하면 콘솔창에 로그가 찍힌다.
			});
			
			//425p comment read event
			$('.chat').on("click", "li", function(e){
				
				var no= $(this).data("no");
				
				CommentService.get(no, function(reply){
					modalInputReply.val(reply.content);
					modalInputId.val(reply.id);
					modalInputRdate.val(CommentService.displayTime(reply.rdate)).attr("readonly", "readonly");
					modal.data("no", reply.no);
					
					modal.find("button[id != 'modalCloseBtn']").hide();
					modalModBtn.show();
					modalRemoveBtn.show();
					
					$("#myModals").modal("show");
				});
				
			});
			
			//427p update comment
			modalModBtn.on("click", function(e){
				var reply = {no:modal.data("no"), content:modalInputReply.val()};
				
				CommentService.update(reply, function(result){
					alert(result);
					modal.modal("hide");
					showList(pageNum);
				});
			});
			
			//427p delete comment
			modalRemoveBtn.on("click", function(e){
				var no = modal.data('no');
				
				CommentService.remove(no, function(result){
					alert(result);
					modal.modal("hide");
					showList(pageNum);
				});
			});
			
			//440p 댓글 페이지번호 출력 로직
			
			var pageNum=1;
			var replyPageFooter=$(".panel-footer");
			
			function showReplyPage(replyCnt){
				
				var endNum=Math.ceil(pageNum / 10.0) * 10;
				var startNum = endNum - 9;
				
				var prev = startNum != 1;
				var next = false;
				
				if(endNum * 10 >= replyCnt){
					endNum = Math.ceil(replyCnt / 10.0);
				}
				
				if(endNum * 10 < replyCnt){
					next = true;
				}
				
				var str = "<ul class='pagination pull-right'>";
				
				if(prev){
					str += "<li class='page-item'><a class='page-link' href='"
					+ (startNum -1) +"'>Previous</a></li>";
				}
				
				for(var i = startNum ; i <= endNum ; i++){
					
					var active = pageNum == i ? "active" : "";
					
					str += "<li class='page-item " + active 
					+ " '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
				}
				
				if(next){
					str += "<li class='page-item' <a class='page-link' href='"
					+ (endNum + 1) + "'>Next</a></li>";
				}
				
				str += "</ul></div>";
				
				console.log(str);
				
				replyPageFooter.html(str);
			}
			
			
			//페이지 번호 클릭 시 새로운 댓글 출력 로직 441p
			replyPageFooter.on("click","li a", function(e){
				
				e.preventDefault();
				console.log("page click");
				
				var targetPageNum = $(this).attr("href");
				
				console.log("targetPageNum : " + targetPageNum);
				
				pageNum = targetPageNum;
				
				showList(pageNum);
			});
			
		/* console.log("=================");
		console.log("JS TEST");
		
		var gnoValue='<c:out value="${reviewboard.no }"/>'; */
		
		//댓글 등록
		/* CommentService.add(
				{content:"JS TEST", id:"tester", gno:gnoValue, nick:"sss"}
				,
				function(result){
					alert("RESULT: "  + result);
				}); */
		//댓글 조회	
		/* CommentService.getList({gno:gnoValue, page:1}, function(list){
			for(var i=0, len = list.length || 0; i<len; i++ ){
				console.log(list[i]);
			}
		}); */
		
		//댓글 삭제
		/* CommentService.remove(7, function(count){
			console.log(count);
			
			if(count==="success"){
				alert("removed");
			}
		},function(err){
			alert("error...");
		});	 */
		
		
		//댓글 수정
		/* CommentService.update({
			no:6,
			gno:gnoValue,
			content:"update dongjune's comment content..."
		}, function(result){
			alert("수정 완료....");
		}); */
		
		//댓글 번호 전달
		/* CommentService.get(10, function(data){
			console.log(data);
		}); */
			var operForm = $("#operForm");
			
			$("button[data-oper='modify']").on("click", function(e){
				operForm.attr("action", "/reviewboard/modify").submit();
			});
			
			$("button[data-oper='list']").on("click", function(e){
				operForm.attr("action","/reviewboard/mlist")
				operForm.submit();
			});
		});
</script>
</body>
</html>