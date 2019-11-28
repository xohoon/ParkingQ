<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js" charset="utf-8"></script > 

	<div class="row">
    	<div class="col-lg-12">
    		<h1 class="page-header">Parking Q Board Register</h1>
        </div>
                <!-- /.col-lg-12 -->
	</div>
            <!-- /.row -->
    <div class="row">
    	<div class="col-lg-12">
    		<div class="panel panel-default">
				<div class="panel-heading">
                     Review Board Register
				</div>
                        <!-- /.panel-heading -->
				<div class="panel-body">
               
                	<!--파일첨부  -->
					<img class="" id="reviewboard_File" style="width:300px;height:250px;" src="고정이미지">
                	
                	<form role="form" action="/reviewboard/register" method="post">



					<input type="hidden" name="appavg" value="4">
					<input type="hidden" name="goodavg" value="1">
					<input type="hidden" name="reavg" value="5">
					
					<div class="form-group">
                			<label>Title</label>
                			<input class="form-control" name="title">
                		</div>	
                		
                		<div class="form-group">
                			<label>Test area</label>
                			<textarea class="form-control" rows="5" name="content"></textarea>
                			<input id="reviewboard_filetext" type="hidden" name="rfile" readonly>
                		</div>
                		
                		
                		<button type="submit" class="btn btn-default">Submit Button</button>
                		<button type="reset" class="btn btn-default">Reset Button</button>
                		          

   
<!-- Dropzone Image file upload -->
                	</form>
              	</div>
                        <!-- /.panel-body -->
           	</div>
                    <!-- /.panel -->
    	</div>
                <!-- /.col-lg-6 -->
	</div>
            <!-- /.row -->
  <!-- Dropzone Image file upload -->
<script>

   $(function () {
      var obj = $("#reviewboard_File");
      
    obj.on('dragenter', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $(this).css('border', '4px solid #5272A0');
    });
   
    obj.on('dragleave', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $(this).css('border', '1px solid transparent');
    });
   
    obj.on('dragover', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });
   
    obj.on('drop', function (e) {
         e.preventDefault();
         $(this).css('border', '1px solid transparent');
   
         var files = e.originalEvent.dataTransfer.files;
         var file = files[0];
         
    
         uploadReviewfile(file);
        
    });
   
   });

   // file upload
   
   function uploadReviewfile(file) {
      
      var formData = new FormData();
      formData.append("file", file);
            
            $.ajax({
               url: '/reviewboard/uploadFile',
               type: 'post',
               data: formData,
               dataType: 'text',
               processData: false,
               contentType: false,
               success: function(data) {

                   $('#reviewboard_File').attr('src',  '/local_img/reviewboard/'+data);
                   $('#reviewboard_filetext').val(data);
                   swal("사진등록 완료");
               }
            });
   }
   
   
   
   $(document).ready(function(){
      uploadReviewfile();
   });

   </script>