<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
.pull-right{border:1px solid red;
			}
.pull-right>ul{border:1px solid blue;
				width:280px;
				margin:0 auto;}
.pull-right>ul>li{border:1px solid green;
				margin:0 3px;}

</style>

<h3>근처의 유용한 주차 공간을 찾아보세요.&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<button class='btn btn-default' id="registerBtn" type="button">글쓰기</button></h3>
<br>
<form id='searchForm' action="/infoboard/list" method="get">
	<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>' placeholder="지역명 또는 지하철역을 입력하세요" size=40/>
	<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
	<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>
	<button class='btn btn-default'>검색</button>
	

</form>            

<div class="container">

	<table class="table table-hover">
		<thead>
			<tr>
				<th>글번호</th>
				<th>지역명</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
			</tr>
		</thead>
		<tbody>
			<!-- 게시글 list 뽑는 부분 -->

			<c:forEach items="${list}" var="board">
				<tr>
					<td><c:out value="${board.no}" /></td>
					<td><c:out value="${board.spot}"/></td>
					<td><a class='move' href='<c:out value="${board.no}"/>'> 
						<c:out value="${board.title}" /></a></td>
					<td><c:out value="${board.nick}" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${board.idate}" /></td>
				</tr>
			</c:forEach>

		</tbody>
	</table>
	
				<%-- <form id='searchForm' action="/infoboard/list" method="get">
				 <select name='type'>
				  <option value=""
				  <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
				  <option value="T"
				  <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
				  <option value="C"
				  <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
				  <option value="W"
				  <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
				  <option value="TC"
				  <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>
				  <option value="TW"
				  <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 or 작성자</option>
				  <option value="TWC"
				  <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목or내용or작성자</option>
				 </select>
				 <input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'/>
				 <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
				 <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>
				 <button class='btn btn-default'>Search</button>
				</form> --%>
	
	<div class='pull-right'>
		<ul class="pagination">

			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous"><a
					href="${pageMaker.startPage -1}">Previous</a></li>
			</c:if>

			<c:forEach var="num" begin="${pageMaker.startPage}"
				end="${pageMaker.endPage}">
				<li class="paginate_button ${pageMaker.cri.pageNum==num? "active":""} ">
					<a href="${num}">${num}</a>
				</li>
			</c:forEach>

			<c:if test="${pageMaker.next}">
				<li class="paginate_button next"><a
					href="${pageMaker.endPage +1 }">Next</a></li>
			</c:if>
		</ul>
	</div>

	<form id='actionForm' action="/infoboard/list" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
		<%-- <input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'>  --%>
		<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>

	</form>	
</div>
<!-- Modal  추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
			</div>
			<div class="modal-body">처리가 완료되었습니다.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script type="text/javascript">
$(document).ready(function() {
	var result = '<c:out value="${result}"/>';
	checkModal(result); //??
	history.replaceState({}, null, null); //뒤로가기해서 list.jsp 왔을때 모달창 뜨지 않게 함.
	function checkModal(result) {
	if (result === '' || history.state) {return;}
	if (parseInt(result) > 0) {
		$(".modal-body").html("게시글 " + parseInt(result)+ "번이 등록되었습니다.");
	}
	$("#myModal").modal("show");
	}

	$('#registerBtn').on("click", function() {
		self.location = "/infoboard/register";
	});

	 var actionForm = $("#actionForm");

	$(".paginate_button a").on(
			"click",
			function(e) {

				e.preventDefault();

				console.log('click');

				actionForm.find("input[name='pageNum']")
						.val($(this).attr("href"));
				actionForm.submit();
			}); 
	
	  $(".move").on("click",function(e) {
		e.preventDefault();
		actionForm.append("<input type='hidden' name='no' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action","/infoboard/get");
		actionForm.submit();
		});
	  
	  var searchForm = $("#searchForm");

		$("#searchForm button").on("click",function(e) {

					/* if (!searchForm.find("option:selected").val()) {
						alert("검색종류를 선택하세요");
						return false;
					} */

					if (!searchForm.find("input[name='keyword']").val()) {
						alert("키워드를 입력하세요");
						return false;
					}
					searchForm.find("input[name='pageNum']").val("1");
					
					e.preventDefault();
					searchForm.submit();
				});

	}); 
</script>
