<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript" src="/resources/js/jquery.cookie.js"></script>


<script type="text/javascript">
	$(document).ready(function(){
		$('.topheader_subject_text').html('오시는거죠');
		var result='<c:out value="${result}"/>';
		
		checkModal(result);
		history.replaceState({}, null, null);
		
		function checkModal(result){
			if(result === '' || history.state){
				return;
			}
			if(parseInt(result)>0){
				$(".modal-body").html("New Group"+parseInt(result)+"num success");
			}
			$("#myModal").modal("show");
		}
		$("#regBtn").on("click", function(){
			self.location = "/meetboard/register";
		});
		
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
    					actionForm.attr("action", "/meetboard/get");
    					actionForm.submit();
   						console.lon("boardcount::::::"+no);
   		});
		
		/*  조건과 키워드 view */
		
		var searchForm = $("#searchForm");

			$("#searchForm button").on("click", function(e) {

						if (!searchForm.find("option:selected")
								.val()) {
							messageAlert("Error", "검색 종류를 선택하세요", "error", "확인");
							return false;
						}

						if (!searchForm.find(
								"input[name='keyword']").val()) {
							messageAlert("Error", "키워드를 입력하세요", "error", "확인");
							return false;
						}

						searchForm.find("input[name='pageNum']").val("1");
						e.preventDefault();

						searchForm.submit();

					});
            	
	});


</script> 
<!-- ----------------------------------------top part is script-------------------------------------------------------------- -->
<!-- style -->

<style>


    .listAll{
        width: 1260px;
        height: 218px;
        position: relative;
        background-color: #EEF5FA;
        border-radius: 10px;
        margin-top: 20px;
        
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
        margin: 8px;
        float: left;
    }
    .a02{
        width: 70px;
        height: 50px;
        position: absolute;
        left: 30px;
   		top: 30px;
   		background-color: #EEF5FA;
   		border-radius: 12px;
    }
    .bbb{
        width: 500px;
        float: left;
        margin-left: 15px;
    }
    .b01{
        margin-top:20px;
        background-color: #EEF5FA;
        font-weight:bold;
    }
    .b02{
        height: 50px;
        margin-top:10px;
        font-weight:bold;
    }
    .ccc{
        height: 100px;
        margin-top:27px;
    }
    .c01{
        float: left;
        font-weight:bold;
    }
    .c00{
        float: left;
        width: 410px;
        margin-top:5px;
        margin-left:18px;
        letter-spacing: 2px;
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

<!-- style -->



	<div class="col-lg-12" style="float:left;margin-top:10px;">
		<form id='searchForm' action="/meetboard/list" method='get'>
		<div style="float:left;">
			<select name='type' style="height:38px;border:1px solid #5a6268;" class="btn">
				<option class="dropdown-item" value=""
					<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>선택</option>
				<option class="dropdown-item" value="T"
					<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
				<option class="dropdown-item" value="C"
					<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
				<option class="dropdown-item" value="W"
					<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
				<%-- 
				<option value="TC"
					<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>
				<option value="TW"
					<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 or 작성자</option>
				<option value="TWC"
					<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목 or 내용 or 작성자</option>
				--%>
			</select> 
		</div>
		<div style="float:left;">
			<input class="form-control" type='text' placeholder="Keyword" name='keyword' style="float:left;margin-left:10px;border:1px solid #5a6268;border-radius:3px;"
			 value='<c:out value="${pageMaker.cri.keyword}"/>' />
			<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' />
			<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
		</div>
			<button class='btn btn-secondary' style="float:left;margin-left:20px;">Search</button>
		</form>
			<c:if test="${userId ne null}">
				<button id='regBtn' type="button" class="btn btn-warning" style="width:150px;margin-left:685px;float:left;">모임 생성</button>
			</c:if>
	</div>
	
	<br /><br />
	<c:forEach items="${list }" var="board">
		<div class="listAll" style="cursor:pointer;">
			<div class="move" href='<c:out value="${board.no}"/>'>
			    <div class="a01">
				        <img class="img01" src='/local_img/meetboard/<c:out value="${board.mfile }" />' style="width:310px;height:200px;">
			    </div>
			 
			    <div class="bbb">
					<div>
						<div class="b01"><h5><c:out value="${board.mdate }"/></h5></div>
						<div class="b02"><h4><c:out value="${board.title }" /></h4></div>
			        </div>
			        <div style="position:absolute;right:-417px;top:15px;float:right;width:150px;height:60px;">
						<img class="img02" src='/images/meetboard/s00.png' style="width:30px;height:30px;float:left;">
						<div style="margin-top:5px;margin-left:7px;float:left;font-weight:bold;">좋아요 <c:out value="${board.mlike }" />개</div>
			        </div>
			        <div style="position:absolute;right:-417px;top:66px;float:right;width:150px;height:60px;">
						<img class="img03" src='/images/meetboard/h00.png' style="width:30px;height:30px;float:left;">
						<div style="margin-top:2px;margin-left:7px;float:left;font-weight:bold;">참여중 <c:out value="${board.gmember }" />명</div>
			        </div>
			        <div style="position:absolute;right:-417px;top:117px;float:right;width:150px;height:60px;">
						<img class="img04" src='/images/meetboard/c00.png' style="width:30px;height:30px;float:left;">
						<div style="margin-top:2px;margin-left:7px;float:left;font-weight:bold;">댓글수 <c:out value="${board.greply }" />개</div>
			        </div>
			        <div style="position:absolute;right:-417px;top:168px;float:right;width:150px;height:60px;">
						<img class="img05" src='/images/meetboard/v00.png' style="width:30px;height:30px;float:left;">
						<div style="margin-top:2px;margin-left:7px;float:left;font-weight:bold;">조회수 <c:out value="${board.mview }" />회</div>
			        </div>
			        <div class="ccc">
			            <div class="c01"><img class="rounded-circle" src='/local_img/profile/<c:out value="${board.pfile }" />' style="width:60px;height:60px;"></div>
			            <div class="c00">
			                <div class="c02"><h5><c:out value="${board.mname }" /></h5></div>
			                <div class="c03"><c:out value="${board.nick }" /></div>
			            </div>
			        </div>
			        <input type='hidden' data-no='<c:out value="${board.no}"/>' name='no'>
			    </div>
			</div>
		</div>
	</c:forEach>
				
				
			 
<!-- jsp page 번호 출력 페이지 처리 -->
<div style="margin-top:60px;display:flex;justify-content:center;margin-leflt:400px;">
	<div class='pull-right'>
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
	</div>
	<!-- end Pagination -->
</div>
			
<!-- remove, update success modal  -->
 
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">확인</h4>
			</div>
			<div class="modal-body">정상적으로 처리되었습니다</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
		<!-- /. modal content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->


<form id='actionForm' action="/meetboard/list" method='get'>
	<input type="hidden" name='pageNum' value='${pageMaker.cri.pageNum }'>
	<input type="hidden" name='amount' value='${pageMaker.cri.amount }'>
	<!-- 검색후 페이지 바뀔떄도 검색정보 유지 -->
	<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }"/>'>
	<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }"/>'>
</form>



