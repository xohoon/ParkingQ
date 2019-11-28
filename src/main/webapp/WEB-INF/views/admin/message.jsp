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
      <a class="nav-link" href="<c:url value='/admin/board'/>">게시판정보</a>
    </li>
    <li class="nav-item">
      <a class="nav-link active" href="<c:url value='/admin/message'/>">메세지정보</a>
    </li>
</ul>


	<div class="admin_total">
		<span class="admin_total_text">최근 메세지 수 ( 7일 ) : </span>
		<span class="admin_total_value">${messageCount }</span>
	</div>
	<input class="form-control admin_search" id="admin_search" type="text" placeholder="검색...">


	<table id="datatable-scroller" class="table table-bordered" style="border-collapse: collapse; border-spacing: 0; width: 100%; text-align: center; vertical-align: middle;">
		<thead class="thead-dark">
			<tr>
				<th>순번</th>
				<th>방번호</th>
				<th>보내는사람</th>
				<th>받는사람</th>
				<th>내용</th>
				<th>확인여부</th>
				<th>일자</th>
				<th>기능</th>
			</tr>
		</thead>

		<tbody id="admin_tbody">

			<c:forEach items="${list}" var="list">
				<tr role="row" class="odd">
					<td class="admin_messageNo">${list.no }</td>
					<td class="admin_messageRoomId">${list.roomId }</td>
					<td class="admin_messageId">${list.id }</td>
					<td class="admin_messageToId">${list.toId }</td>
					<td class="admin_messageContent">${list.content }</td>
					
					<c:choose>
						<c:when test="${list.read == 0 }">
						<td class="admin_messageRead">읽지않음</td>
						</c:when>
						<c:otherwise>
						<td class="admin_messageRead">읽음</td>
						</c:otherwise>
					</c:choose>
					
					<td class="admin_messageMDate">${list.MDate }</td>
					<td>
						<button class="btn btn-danger admin_messagedelete">삭제</button>
					</td>
				</tr>
		</c:forEach>
		
		</tbody>

	</table>




<script>
$('.topheader_subject_text').html('관리페이지');

$("#admin_search").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#admin_tbody tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
  
  
  
  $('.admin_messagedelete').on('click',function(){
	  var no = $(this).parents('tr').children('.admin_messageNo').html();
	  
	  swal({
		  title: "메세지 삭제",
		  text: "해당 메세지를 삭제 하시겠습니까?",
		  icon: "warning",
		  buttons: ["취소", "삭제"],
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
		    swal("해당 메세지를 삭제 했습니다.", {
		      icon: "success",
		    });
		    deleteMessage(no);
		    $(this).parents('tr').remove();
		  } else {
		    swal("메세지 삭제가 취소 되었습니다.", {
		    	icon: "error",
		    	button : "확인"
		    });
		  }
		});
  });
  
  
  function deleteMessage(no){
	  $.ajax({
		  type : 'post',
		  url : '/admin/deleteMessage',
		  data : {
			  no : no
		  },
		  success : function(data){
			  if ( data == 1 ) {
				  
			  }
		  }
	  });
  }
  

</script>