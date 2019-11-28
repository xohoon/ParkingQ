<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	crossorigin="anonymous">

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>
table {
	width: 100%;
	border-top: 1px solid #444444;}
.tbl_center {
	text-align: center;}
.move {	cursor: pointer;}
.move td:first-child {	text-align: center;}
#search_div {
	padding-left: 150px;
	margin-bottom: 15px;}
#select {
	color: gray;
	padding: 8px;
	width: 250px;
	text-align: center;
	margin-right: 30px;
	border-radius: 10px;}
#search_box {
	width: 500px;
	margin-right: 30px;}
#search_btn {
	cursor: pointer;
	width: 42px;
	height: 42px;
	margin-right: 20px;}
#best_tbl_div {	margin-bottom: 10px;}
#best_img {
	padding: 0;
	margin-top: 10px;}
#best_tbl td {
	padding: 0px;
	text-align: center;
	border-bottom: none;}
#f_regBtn {
	color: white;
	width: 50px;
	height: 50px;
	cursor: pointer;}
#pagination_div {
	display: flex;
	justify-content: center;}
.pull-right {	display: block;}
#like_img {
	width: 20px;
	height: 20px;}
#comment_img {
	width: 35px;
	height: 35px;}
#porfile {
	width: 70px;
	height: 70px;}
#profile_td {
	width: 150px;}
#calendar {
	width: 40px;
	height: 40px;}
#reply_img {
	width: 25px;
	height: 25px;}
#best_tbl td:first-child {
	background-size: 25px, 20px;
	background-image: url("/local_img/freeboard/gold.png");
	background-repeat: no-repeat;
	background-position: 10% 2%;}
#best_tbl td:nth-child(2) {
	background-size: 25px, 20px;
	background-image: url("/local_img/freeboard/silver.png");
	background-repeat: no-repeat;
	background-position: 10% 2%;}
#best_tbl td:nth-child(3) {
	background-size: 25px, 20px;
	background-image: url("/local_img/freeboard/bronze.png");
	background-repeat: no-repeat;
	background-position: 10% 2%;}
#best_tbl span {
	font-size: 18px;
	margin: 30px;}
</style>

<div width="100%">
	<div id="best_tbl_div">
		<table class="table" id="best_tbl">
			<thead class="thead-light">
				<tr>
					<th colspan="6">best 게시글</th>
				</tr>
			</thead>
			<tr>
				<c:forEach items="${best}" var="best">
					<td style="line-height: 40px; padding: 10px;"><span><c:out
								value="${best.title}" /></span> <span><c:out value="${best.id}" /></span>
					<c:choose>
						<c:when test="${best.ffile != null}">
							<a class='go_img' href='<c:out value="${best.no }"/>'> <img
													id="best_img" src='/local_img/freeboard/<c:out value="${best.ffile }" />'
													width="380" height="123" style="text-align: left;">
							</a>
						</c:when>
						<c:otherwise>
							<a class='go_img' href='<c:out value="${best.no }"/>'> 
								<img id="best_img" src='/local_img/freeboard/noimg.png'
										width="380" height="123" style="text-align: left;">
							</a>
						</c:otherwise>
					</c:choose>
					</td>
				</c:forEach>
			</tr>
		</table>
	</div>
	<div class='row'>
		<div class="col-lg-12" id="search_div">

			<form id='searchForm' action="/freeboard/list" method='get'>
				<select name='type' id="select">
					<option value=""
						<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>검색조건</option>
					<option value="T"
						<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
					<option value="C"
						<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
					<option value="W"
						<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
					<option value="TC"
						<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목or
						내용</option>
					<option value="TW"
						<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목or
						작성자</option>
					<option value="TWC"
						<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목or
						내용 or 작성자</option>
				</select> <input type='text' id="search_box" name='keyword'
					value='<c:out value="${pageMaker.cri.keyword}"/>'
					placeholder="검색내용"> <input type='hidden' name='pageNum'
					value='<c:out value="${pageMaker.cri.pageNum}"/>' /> <input
					type='hidden' name='amount'
					value='<c:out value="${pageMaker.cri.amount}"/>' /> <img
					src="/local_img/freeboard/Search.png" id="search_btn""> <img
					src="/local_img/freeboard/writer.png" id="f_regBtn">
			</form>
		</div>
	</div>

	<table class="table table-hover">
		<tbody>
			<!-- 게시글 list 출력  -->

			<c:forEach items="${list}" var="fboard">
				<tr class='move' href='<c:out value="${fboard.no }"/>'>
					<c:choose>
						<c:when test="${fboard.lev == 0}">
							<td id="profile_td" style="text-align: center">
								<div id="profile_div">
									<img id="porfile" src="/local_img/profile/<c:out value="${fboard.profile}" />">
								</div>
							</td>
							<td style="text-align: left"><c:out value="${fboard.title}" />&nbsp; <img id="comment_img" src="/local_img/freeboard/comment_img.png">
							<c:out value="${fboard.replyCnt }" /> <br> <c:out value="${fboard.id }" /></td>
						</c:when>
						<c:otherwise>
							<td id="profile_td" style="text-align: center">
								<div id="profile_div">
									<img id="porfile" src="/local_img/profile/<c:out value="${fboard.profile}" />">
								</div>
							</td>
							<td style="text-align: left">
								<c:forEach items="${list}" var="lev" begin="1" end="${fboard.seq}">&nbsp;
								</c:forEach> <img id="reply_img" src="/local_img/freeboard/rereply.png"> 
								<c:out value="${fboard.title}" /> <img id="comment_img" src="/local_img/freeboard/comment_img.png"> 
								<c:out value="${fboard.replyCnt }" /> <br> 
								<c:out value="${fboard.id }" /></td>
						</c:otherwise>
					</c:choose>

					<td class="tbl_center" style="text-align: left">
						<i class="far fa-eye"></i> &nbsp; <c:out value="${fboard.freadCount}" />
					</td>
					<td class="tbl_center" style="text-align: left">
						<img src="/local_img/freeboard/thumbs.svg" id="like_img"> &nbsp; 
						<c:out value="${fboard.flike}" /></td>
					<td class="tbl_center">
						<img id="calendar" src="/local_img/freeboard/calendar.png"> 
						<fmt:formatDate	pattern="yyyy-MM-dd" value="${fboard.fdate}" />
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div id="pagination_div">
		<div class="pull-right">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class="page-item"><a class="page-link"
						href="${pageMaker.startPage -1}">Previous</a></li>
				</c:if>

				<c:forEach var="num" begin="${pageMaker.startPage}"
					end="${pageMaker.endPage}">
					<li class="page-item ${pageMaker.cri.pageNum == num ? "active":""} ">
						<a class="page-link" href="${num}">${num}</a>
					</li>
				</c:forEach>

				<c:if test="${pageMaker.next}">
					<li class="page-item"><a class="page-link"
						href="${pageMaker.endPage + 1 }">Next</a></li>
				</c:if>
			</ul>
		</div>
	</div>
	<!--<a>tag 제어부분-->

	<form id='actionForm' action="/freeboard/list" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
		<input type='hidden' name='type'
			value='<c:out value="${ pageMaker.cri.type }"/>'> <input
			type='hidden' name='keyword'
			value='<c:out value="${ pageMaker.cri.keyword }"/>'>
	</form>

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
					<button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
</div>

<!-- script -->
<script type="text/javascript">
	var result = '<c:out value="${result}"/>';

	checkModal(result);
	history.replaceState({}, null, null);
	
	$('.topheader_subject_text').html('자유게시판');

	function checkModal(result) {
		if (result === '' || history.state) {
			return;
		}
		if (parseInt(result) > 0) {
		 	$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			/* messageAlert("완료", "게시글이 등록되었습니다.", "success", "확인"); */
			}
			
	}

	$("#f_regBtn").on("click", function() {
		self.location = "/freeboard/register";
	});

	var actionForm = $("#actionForm");

	$(".page-item a").on("click", function(e) {
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});

	$(".move").on("click", function(e) {
				e.preventDefault();
				actionForm.append("<input type='hidden' name='no' value='"
						+ $(this).attr("href") + "'>");
				actionForm.attr("action", "/freeboard/get");
				actionForm.submit();
			});

	$(".go_img").on("click",function(e) {
				e.preventDefault();
				actionForm.append("<input type='hidden' name='no' value='"
						+ $(this).attr("href") + "'>");
				actionForm.attr("action", "/freeboard/get");
				actionForm.submit();
			});

	var searchForm = $("#searchForm");

	$("#search_btn").on("click", function(e) {
		if (!searchForm.find("option:selected").val()) {
			messageAlert("검색", "검색기준을 정하세요", "error", "확인");
			return false;
		}
		if (!searchForm.find("input[name='keyword']").val()) {
			messageAlert("검색", "키워드를 입력하세요", "error", "확인");
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();
	});
</script>

