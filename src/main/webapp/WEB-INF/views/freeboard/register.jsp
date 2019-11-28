<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
	body{
	}
	.freeboard_warp{
		padding: 3% 5% 0 5%;
		border: 1px solid #ccc9c9;
    	width: 1100px;
    	height: 840px;
    	margin-left: 70px;
    	border-radius: 15px;
    	/* background-color: #fafafa; */
	}
	.freeboard_file{
		width: 300px;
  	 	height: 250px;
   		margin-left: 35%;
    	margin-top: 19%;
	}
	.freeboard_filewarp{
		float: left;
	}
	.freeboard_rightinputwarp{
		float: left;
	}
	.clear-fix{
		clear: both;
	}
	.freeboard_rightspan{
		font-size: 1.2rem;
		margin: 6% 0 0 70%;
		display: block;
	}
	.freeboard_rightinputwarp input{
		margin: 1% 0 1% 70%;
   		font-weight: bold;
  		width: 340px;
  		padding: 3% 3% 3% 10%;
	}
	.freeboard_contentwarp{
	margin-top: 5%;
	}
	.freeboard_contentwarp span{
		font-size: 1.2rem;
		margin-right: 3.5%;
	}
	.freeboard_contentwarp input{
		padding: 1% 1% 1% 2%;
		width: 855px;
	}
	.freeboard_contentwarp textarea{
		border-radius: 10px;
	}
	.freeeboard_textarea{
		margin-top: 1%;
		position: relative;
	}
	.freeeboard_textarea textarea{
		position: absolute;
  	  	left: 7%;
	}
	.freeeboard_textarea span{
		position: absolute;
	}
	.freeboard_btn{
		margin-top: 31%;
    	text-align: right;
    	margin-right: 4%;
	}
</style>


<div class="freeboard_warp">

<form role="form" action="/freeboard/register" method="post">
	<div class="freeboard_filewarp">
	
		<img id="free_file" class="freeboard_file" src="/local_img/freeboard/defaultimg.png" style="width:300px;height:250px;">
	
	</div>
	
	<div class="freeboard_rightinputwarp">
		<span class="freeboard_rightspan">구분</span><input type="text" value="자유게시판 > 새글쓰기" readonly="readonly"><br>
		<span class="freeboard_rightspan">작성자</span><input type="text" value='<c:out value="${userId}"/>' readonly="readonly"><br>
		<span class="freeboard_rightspan">작성일</span><input type="text" value='<c:out value="${date}"/>' readonly="readonly">
	</div>
	
	<div class="clear-fix"></div>

	<div class="freeboard_contentwarp">
		<div>
			<span>제목</span><input type="text" name='title'><br>
		</div>
		<div class="freeeboard_textarea">
			<span>내용</span><textarea rows="10" cols="104" name="content"></textarea>
		</div>
	</div>
	<div class="freeboard_btn">
		<input id="free_filetext" type="hidden" name="ffile" readonly>
		<button type="submit" class="btn btn-primary">등록</button>
		<button type="reset" id="reset" class="btn btn-danger">취소</button>
	</div>
</form>

</div>

<script>

$(document).ready(function(){
	//페이지 이름
	$('.topheader_subject_text').html('자유게시판');
	
	//드랍존 파일
	 $(function () {
	      var obj = $("#free_file");
	   
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
	         
	         console.log(file);
	         console.log(file.name);
	         uploadFreeFile(file);
	    });
	   
	   });
	
});
		
	 //파일 업로드
	 function uploadFreeFile(file) {
	      
	     var formData = new FormData();
	     formData.append("file", file);
	           
	           $.ajax({
	              url: '/freeboard/uploadFile',
	              type: 'post',
	              data: formData,
	              dataType: 'text',
	              processData: false,
	              contentType: false,
	              success: function(data) {
	                  console.log('이미지 변경 >>>>>>>> ' + data);
	                  $('#free_file').attr('src',  '/local_img/freeboard/'+data);
	                  $('#free_filetext').val(data);
	              }
	           });
	   }
	  
	   $("#reset").on("click", function(){
		   history.back();
	   });

	   $(document).ready(function(){
		   uploadFreeFile();
	   });
	   
</script>
