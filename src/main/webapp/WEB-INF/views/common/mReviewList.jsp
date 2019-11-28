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
                <span style="font-size: 1.4rem; position: absolute; margin-left: 5%;">이용후기</span>
            </div>


            <div class="layout-content">
                <div style=" height: auto;margin-top: 10%;">
                
                
                <table width="100%">
                <!-- 예제 -->
                	
					<tbody>
					
						<c:forEach items="${list}" var="reviewboard">
						<tr class="roof_tr">
							<td style="overflow:hidden;height:auto;margin-top:1%">
								<hr style="margin: 0px 0px 20px 0">
								<b style="margin-top:7%"><c:out value="${reviewboard.title}"/></b>&nbsp;&nbsp;<div style="font-size:60%;margin-bottom: 5%;">(<c:out value="${reviewboard.id}"/>)</div>
								<input type="hidden" class="boardno" value="<c:out value='${reviewboard.no }'/>">
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>

                </div>
                
                 <!--페이징 버튼 폼  -->
				<form id='actionForm' action="/reviewboard/mlist" method="get">
					<input type="hidden" name='pageNum' value="${pageMaker.pg.pageNum }">
					<input type="hidden" name='amount' value="${pageMaker.pg.amount }">
				</form>
                
                <!-- 페이징 START / 글 view 일 경우에는 페이징 요소 제거 -->
                <ul class="pagination" style="text-align: center;margin:10% auto 10% auto;;width: fit-content;">
                    <c:if test="${pageMaker.prev }">
                    	<li class="paginate_button previous">
                    	<a class="page-link" href="${pageMaker.startPage-1 }">이전</a></li>
                    </c:if>
                    
                    <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
                         <li class="page-item ${pageMaker.pg.pageNum==num?'active':'' }">
                         <a class="page-link" href="${num }">${num }</a></li>
                    </c:forEach>
                    
                    <c:if test="${pageMaker.next }">
                         <li class="paginate_button next">
                         <a class="page-link" href="${pageMaker.endPage+1 }">다음</a></li>
                    </c:if>
                </ul>
                <!-- 페이징 END -->
                
            </div>
        </div>
    </div>
    
    <script>
    	
    	var id = "<c:out value='${id}'/>";
    	
  	 	var actionForm=$("#actionForm");
  		$(".page-item a").on("click", function(e){
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();	
		});
  		$(".previous a").on("click", function(e){
  			e.preventDefault();
  			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
  			actionForm.submit();	
  			});
  		$(".next a").on("click", function(e){
  			e.preventDefault();
  			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
  			actionForm.submit();	
  			});
  		
  		//getPage 이동
  		$('.roof_tr').on('click',function(){
  			var no = $(this).find('.boardno').val();
  			var addNo = '<input type="hidden" name="no" value="'+no+'">';
  			var operForm = $('#actionForm');
  			operForm.append(addNo);
	  		operForm.attr("action", "/reviewboard/mReviewGet").submit();
  		});
  		
  		
    </script>
</body>
</html>