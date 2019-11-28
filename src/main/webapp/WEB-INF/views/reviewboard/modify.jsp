<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		var formObj = $("form");
		
		$('button').on("click",function(e){
			
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if(operation ==='remove'){
				formObj.attr("action", "/reviewboard/remove");
			}else if(operation ==='list'){
				//move to list
				formObj.attr("action", "/reviewboard/list").attr("method","get");
				var pageNumTag=$("input[name='pageNum']").clone();
				var amountTag=$("input[name='amount']").clone();
				
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
			}
			formObj.submit();
			
		});
	});
</script>
	<div class="row">
    	<div class="col-lg-12">
    		<h1 class="page-header">Parking Q Board Modify</h1>
        </div>
                <!-- /.col-lg-12 -->
	</div>
            <!-- /.row -->
    <div class="row">
    	<div class="col-lg-12">
    		<div class="panel panel-default">
				<div class="panel-heading">
                     Review Board Modify
				</div>
                        <!-- /.panel-heading -->
				<div class="panel-body">
				
                	<form role="form" action="/reviewboard/modify" method="post">
                	
                	<input type="hidden" name="pageNum" value='<c:out value="${pg.pageNum }"/>'>
                	<input type="hidden" name="amount" value='<c:out value="${pg.amount }"/>'>
                	
                	<div class="form-group">
                		<label>No</label><input class="form-control" name="no"
                		value='<c:out value="${reviewboard.no}"/>' readonly="readonly"> 
                	</div>
                	
                	<div class="form-group">
                		<label>Title</label><input class="form-control" name="title"
                		value='<c:out value="${reviewboard.title}"/>'> 
                	</div>
                	
                	<div class="form-group">
                		<label>Id</label><input class="form-control" name="id"
                		value='<c:out value="${reviewboard.id}"/>' readonly="readonly"> 
                	</div>
                	
                	<div class="form-group">
                		<label>Nick</label><input class="form-control" name="nick"
                		value='<c:out value="${reviewboard.nick}"/>' readonly="readonly"> 
                	</div>
                	
                	<div class="form-group">
                		<label>Textarea</label>
                		<textarea class="form-control" rows="3" name="content">
                		<c:out value="${reviewboard.content}"/></textarea> 
                	</div>
                	
                	<div class="form-group">
                		<label>Rdate</label><input class="form-control"
                		value='<fmt:formatDate pattern="yyyy/MM/dd" 
                		value="${reviewboard.rdate}"/>' readonly="readonly"> 
                	</div>
                	
                	<div class="form-group">
                		<label>Up_date</label><input class="form-control"
                		value='<fmt:formatDate pattern="yyyy/MM/dd" 
                		value="${reviewboard.up_date}"/>' readonly="readonly"> 
                	</div>
                	
                	<button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
                	<button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>
                	<button type="submit" data-oper='list' class="btn btn-info">List</button>
              	</form>
              	</div>
                        <!-- /.panel-body -->
           	</div>
                    <!-- /.panel -->
    	</div>
                <!-- /.col-lg-6 -->
	</div>
            <!-- /.row -->