<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<ul class="nav nav-tabs nav-justified">
    <li class="nav-item">
      <a class="nav-link" href="<c:url value='/admin/main'/>">메인</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="<c:url value='/admin/member'/>">회원정보</a>
    </li>
    <li class="nav-item">
      <a class="nav-link active" href="<c:url value='/admin/board'/>">게시판정보</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="<c:url value='/admin/message'/>">메세지정보</a>
    </li>
</ul>



	<div class="admin_total">
		<span class="admin_total_text">최근 게시글 수 ( 7일 ) : </span>
		<span class="admin_total_value">${boardCount }</span>
	</div>
	<input class="form-control admin_search" id="admin_search" type="text" placeholder="검색...">


	<table id="datatable-scroller" class="table table-bordered" style="border-collapse: collapse; border-spacing: 0; width: 100%; text-align: center; vertical-align: middle;">
		<thead class="thead-dark">
			<tr>
				<th>순번</th>
				<th>글번호</th>
				<th>분류</th>
				<th>아이디</th>
				<th>제목</th>
				<th>일자</th>
				<th>기능</th>
			</tr>
		</thead>

		<tbody id="admin_tbody">

				<c:forEach items="${list}" var="list">
				<tr role="row" class="odd">
					<td class="admin_boardNo">${list.no }</td>
					<td class="admin_boardANo">${list.ano }</td>
					<td class="admin_boardType">${list.type }</td>
					<td class="admin_boardId">${list.id }</td>
					<td class="admin_boardSubject">${list.subject }</td>
					<td class="admin_boardSubject">${list.ADate }</td>
					<td>
						<button class="btn btn-primary admin_boarmodify">수정</button>
						<button class="btn btn-danger admin_boarddelete">삭제</button>
					</td>
				</tr>
		</c:forEach>


		</tbody>

	</table>
	
	
	
	<div class="modal fade" id="admin_boardModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content col-sm-8" style="background-color: transparent; border: 1px solid transparent;">
					<div class="modal-body">

						<div class="card" style="width: 455px; border: 1px solid #dddddd;">
							<div class="card-header bg-dark text-white" id="message_title">게시판정보변경</div>
							<div class="card-body">
								<div class="mb-3 mt-3">
									<span class="ml-4 modal_boardtext">글번호</span> <input type="text" class="ml-4 disabled modal_boardinput" id="admin_boardANo" maxlength="15" readonly>
								</div>

								<div class="mb-3">
									<span class="ml-4 modal_boardtext">아이디</span> <input type="text" class="ml-4 modal_boardinput" id="admin_boardId" maxlength="15" readonly>
								</div>
								<div class="mb-4">
									<span class="ml-4 modal_boardtext">게시판 명</span> <input type="text" class="ml-4 modal_boardinput" id="admin_boardType" maxlength="15" readonly>
								</div>
								<div class="mb-3">
									<span class="ml-4 modal_boardtext">등록일자</span> <input type="text" class="ml-4 modal_boardinput" id="admin_boardADate" readonly>
								</div>
								<div class="mb-3">
									<span class="ml-4 modal_boardtext">제목</span> <input type="text" class="ml-4 modal_boardinput" id="admin_boardSubject" >
								</div>
								<div class="mb-3">
									<span class="ml-4 modal_boardtext">내용</span> <textarea class="ml-4 modal_boardinput" id="admin_boardContent"></textarea>
								</div>
								<a href="#" class="btn btn-primary ml-sm-4" id="admin_updateBoardInfo">수정</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>


<script>
$('.topheader_subject_text').html('관리페이지');


$('.admin_boarmodify').on('click', function(){
	var ano = $(this).parents('tr').children('.admin_boardANo').text();
	var type = $(this).parents('tr').children('.admin_boardType').text();
	$('#admin_boardModal').modal('show');
	getAdminBoard(ano, type);
});

$('.admin_boarddelete').on('click', function(){
	var ano = $(this).parents('tr').children('.admin_boardANo').text();
	var type = $(this).parents('tr').children('.admin_boardType').text();
	
	swal({
		  title: "게시글 삭제",
		  text: "해당 게시글을 삭제 하시겠습니까?",
		  icon: "warning",
		  buttons: ["취소", "삭제"],
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
		    swal("해당 게시글을 삭제 했습니다.", {
		      icon: "success",
		    });
		    deleteBoard(ano, type);
		    $(this).parents('tr').remove();
		  } else {
		    swal("게시글 삭제가 취소 되었습니다.", {
		    	icon: "error",
		    	button : "확인"
		    });
		  }
		});
	
	
});



$('#admin_updateBoardInfo').on('click', function(){
	
	var no = $('#admin_boardANo').val();
	var id = $('#admin_boardId').val();
	var type = $('#admin_boardType').val();
	var aDate = $('#admin_boardADate').val();
	var subject = $('#admin_boardSubject').val();
	var content = $('#admin_boardContent').val();
	
	console.log('no : ' + no + ', id : ' + id + ', type : ' + type + ', aDate : ' + aDate + ' , subject : ' + subject + ' , content : ' + content );
	
	updateAdminBoard(no, id, type, aDate, subject, content);
	$('#admin_boardModal').modal('hide');
});


	function getAdminBoard(ano, type){
	$.ajax({
		type : 'post',
		url : '/admin/getBoard',
		dataType : 'json',
		data : {
			ano : ano,
			type : type
		},
		success : function(data){
			console.log(data);
			$.each(data , function(key, value){
				
				console.log(key);
				if ( key == 'aNo' ){
					$('#admin_boardANo').val(value);
				} else if ( key == 'id') {
					$('#admin_boardId').val(value);
				} else if ( key == 'type') {
					$('#admin_boardType').val(value);
				} else if ( key == 'aDate') {
					$('#admin_boardADate').val(value);
				} else if ( key == 'subject') {
					$('#admin_boardSubject').val(value);
				} else if ( key == 'content') {
					$('#admin_boardContent').val(value);
				}
			});
		}
	});
}

function updateAdminBoard(no, id, type, aDate, subject, content){
	$.ajax({
		type : 'post',
		url : '/admin/updateBoard',
		data : {
			no : no,
			type : type,
			subject : subject,
			content : content
		},
		success : function(data){
			if ( data == 1 ) {
				messageAlert('게시판정보변경', type+' 게시글 '+ no +'번의 정보를 수정했습니다.', 'success');
			} else {
				messageAlert('게시판정보변경', '게시글 정보 수정을 실패 했습니다.', 'error');
			}
		}
	});
}


function deleteBoard(ano, type){
	$.ajax({
		type : 'post',
		url : '/admin/deleteBoard',
		data : {
			ano : ano,
			type : type
		},
		success : function(data){
			
		}
	});
}





$("#admin_search").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#admin_tbody tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });

</script>