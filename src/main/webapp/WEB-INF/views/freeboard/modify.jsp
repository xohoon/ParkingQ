<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>

#mod_button {
	text-align: center;
    margin-top: 30px;
}

</style>

<div class="container">

	<form role="form" action="/freeboard/modify" method="post">

		<div class="form-group">
			<label>No</label> <input class="form-control" name='no'
				value='<c:out value="${board.no }" />' readonly="readonly">
		</div>

		<div class="form-group">
			<label>제목</label> <input class="form-control" name='title'
				value='<c:out value="${board.title }" />'>
		</div>

		<div class="form-group">
			<label>내용</label>
			<textarea class="form-control" rows="3" name='content'>
           		<c:out value="${board.content }" />
            </textarea>
		</div>

		<div class="form-group">
			<label>작성자</label> <input class="form-control" name='id'
				value='<c:out value="${board.id }" />' readonly="readonly">
		</div>

		<div class="form-group">
			<label>작성일자</label> <input class="form-control" name='fdate'
				value='<c:out value="${board.fdate }" />' readonly="readonly">
		</div>

	<div id="mod_button">
		<button data-oper='modify' class="btn btn-primary">
			수정
		</button>
		<button data-oper='remove' class="btn btn-danger">
		 	삭제
		</button>
		<button data-oper='list' class="btn btn-success">
			목록
		</button>
	</div>
		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
  		<input type='hidden' name='pageSize' value='<c:out value="${cri.amount}"/>'>
 	    <input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'> 		
  		
	</form>

<script type="text/javascript">
		
	$(document).ready(function() {
		
		$('.topheader_subject_text').html('자유게시판');

			var formObj = $("form");

		$('button').on("click", function(e){
	    
	  		e.preventDefault(); 
	    
		    var operation = $(this).data("oper");
	    
	   		console.log(operation);
	    
	 		if(operation === 'remove'){
	   			formObj.attr("action", "/freeboard/remove");
	      
	    	}else if(operation === 'list'){
	    		
	    		formObj.attr("action", "/freeboard/list").attr("method","get");
	    		var pageNumTag = $("input[name='pageNum']").clone();
	    		var amountTag = $("input[name='amount']").clone();
	    		var keywordTag = $("input[name='keyword']").clone();
	    		var typeTag = $("input[name='type']").clone();
	    		
	    		formObj.empty();
	    		
	    		formObj.append(pageNumTag);
	    		formObj.append(amountTag);
	    		formObj.append(keywordTag);
	    		formObj.append(typeTag);
	    		
	   		}
	 		formObj.submit();
	 		
		});
		
	});
	    
</script>

</div>
