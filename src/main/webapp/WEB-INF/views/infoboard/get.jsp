<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
.container{border:1px solid blue;
}
#like{
	height:50px;}
#likeBtn{float:right;}
</style>
<h3>근처의 유용한 주차 공간을 찾아보세요.</h3>
<br>
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<div id="like">
			<button id="likeBtn" class="btn btn-primary">좋아요<div id="likeNum"></div></button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<div class="form-group">
					<label>글번호</label> <input class="form-control" name='no'
						value='<c:out value="${board.no}"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>닉네임</label> <input class="form-control" name='nick'
						value='<c:out value="${board.nick}"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>장소</label> <input class="form-control" name='spot'
						value='<c:out value="${board.spot}"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>제목</label> <input class="form-control" name='title'
						value='<c:out value="${board.title}"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" rows="15" name='content'
						readonly="readonly"><c:out value="${board.content}" /></textarea>
				</div>
				<div class="form-group">
					<label>위치</label>
					<div id="map" style="width:500px;height:400px;"></div>
						<!-- <p><em>지도를 클릭해주세요!</em></p>  -->
						
				</div>


				<button data-oper='modify' class="btn btn-default">
					<%-- <a href="/infoboard/modify?no=<c:out value="${board.no}"/>"> --%>
					Modify
				</button>
				<button data-oper="list" class="btn btn-info">
					<!-- <a href="/infoboard/list"> -->
					List
				</button>

				<form id='operForm' action="/board/modify" method="get">
					<input type='hidden' id='no' name='no'
						value='<c:out value="${board.no}"/>'> <input type='hidden'
						name='pageNum' value='<c:out value="${cri.pageNum}"/>'> <input
						type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
					<input type='hidden' name='keyword'
						value='<c:out value="${cri.keyword}"/>'>
					<%-- <input type='hidden' name='type' value='<c:out value="${cri.type}"/>'> --%>
				</form>


			</div>
			<!--  end panel-body -->
		</div>
	</div>
</div>

<!-- 첨부파일 창 -->
<div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>

<style>
.uploadResult {
  width:100%;
  background-color: gray;
}
.uploadResult ul{
  display:flex;
  flex-flow: row;
  justify-content: center;
  align-items: center;
}
.uploadResult ul li {
  list-style: none;
  padding: 10px;
  align-content: center;
  text-align: center;
}
.uploadResult ul li img{
  width: 100px;
}
.uploadResult ul li span {
  color:white;
}
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
  background:rgba(255,255,255,0.5);
}
.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}

.bigPicture img {
  width:600px;
}

</style>



<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">Files</div>
      <!-- /.panel-heading -->
      <div class="panel-body">
        
        <div class='uploadResult'> 
          <ul>
          </ul>
        </div>
      </div>
      <!--  end panel-body -->
    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->



<!-- 댓글 창 -->
<div class='row'>

  <div class="col-lg-12">

    <!-- /.panel -->
    <div class="panel panel-default">
<!--       <div class="panel-heading">
        <i class="fa fa-comments fa-fw"></i> Reply
      </div> -->
      <hr>
      <div class="panel-heading">
        <i class="fa fa-comments fa-fw"></i> Reply
        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
        <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
      <hr>
      </div>      
      
      
      <!-- /.panel-heading -->
      <div class="panel-body">        
      
        <ul class="chat">

        </ul>
        <!-- ./ end ul -->
      </div>
      <!-- /.panel .chat-panel -->

	<div class="panel-footer"></div>


		</div>
  </div>
  <!-- ./ end row -->
</div>


<!-- Modal -->
      <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">&times;</button>
              <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label>Reply</label> 
                <input class="form-control" name='reply' value='New Reply!!!!'>
              </div>      
             <!-- <div class="form-group">
                <label>Nick</label> 
                <input class="form-control" name='replyer' value='replyer'>
              </div>
              <div class="form-group">
                <label>Id</label> 
                <input class="form-control" name='id' value='replyer'>
              </div> -->
              
             <!--  <div class="form-group">
                <label>Reply Date</label> 
                <input class="form-control" name='idate' value='2018-01-01 13:13'>
              </div> -->
              
              <!-- <div class="form-group">
                <label>Gno</label> 
                <input class="form-control" name='gno' value='replyer'>
              </div> -->
           
              
      
            </div>
<div class="modal-footer">
        <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
        <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
        <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
        <button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
      </div>          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->





<!-- 댓글처리 -->
<script type="text/javascript" src="/resources/js/infoboard/InfoComment.js"></script>

<script>


$(document).ready(function () {
	
  var noValue = '<c:out value="${board.no}"/>';
  var replyUL = $(".chat");
  var gnoValue = '<c:out value="${board.gno}"/>';
  var idateValue = '<c:out value="${board.idate}"/>';
  console.log("idateValue>>>"+idateValue);
  /* var inValue = '<c:out value="${board.id}"/>';
  var gnoValue = '<c:out value="${board.gno}"/>';
  var idateValue = '<c:out value="${board.idate}"/>'; */
  
    showList(1);
    
function showList(page){
	
	  console.log("show list " + page);
    
    infocommentservice.getList({no:noValue,page: page|| 1 }, function(list) {
      
    /* console.log("replyCnt: "+ replyCnt );
    console.log("list: " + list);
    console.log(list);
    
    if(page == -1){
      pageNum = Math.ceil(replyCnt/10.0);
      showList(pageNum);
      return;
    } */
      
     var str="";
     	
     if(list == null || list.length == 0){
    	 replyUL.html("");
    	 return;
     }
     for (var i = 0, len = list.length || 0; i < len; i++) {
       str +="<li class='left clearfix' data-gno='"+list[i].gno+"'>";
       str +="  <div><div class='header'><strong class='primary-font'>"+list[i].nick+"</strong>"; 
       str +="    <p>"+list[i].content+"</p><p>"+list[i].idate+"</p></div></li>";
       console.log("idate>>>"+list[i].idate);
     }
     
     
     replyUL.html(str);
     
   });//end function
     
 }//end showList
 
var modal = $(".modal");
var modalInputReply = modal.find("input[name='reply']");
var modalInputReplyer = modal.find("input[name='replyer']");/* 
var modalInputReplyDate = modal.find("input[name='idate']"); */

var modalInputReplyId = modal.find("input[name='id']");
/* var modalInputReplyGno = modal.find("input[name='gno']");  */


var modalModBtn = $("#modalModBtn");
var modalRemoveBtn = $("#modalRemoveBtn");
var modalRegisterBtn = $("#modalRegisterBtn");


$("#modalCloseBtn").on("click", function(e){
	
	modal.modal('hide');
});

$("#addReplyBtn").on("click", function(e){
  modal.find("input").val("");
  $("#replyer").val($.cookie('userNick')); //???
 /*  modalInputReplyDate.closest("div").hide(); */
  modal.find("button[id !='modalCloseBtn']").hide();
  
  
  modalRegisterBtn.show();
  
  $(".modal").modal("show");
  
});

modalRegisterBtn.on("click",function(e){
  
    var reply = {
          content: modalInputReply.val(),
          nick:$.cookie('userNick'),
          no:noValue,/* 
          gno:modalInputReplyGno.val(), */
          id:$.cookie('userId'),
          gno:gnoValue,
          idate:idateValue
          /* ,
          id:idValue,
          gno:gnoValue,
          idate:idateValue */
          
        };
    infocommentservice.add(reply, function(result){
      
      alert(result);
      
      modal.find("input").val("");
      modal.modal("hide");
      
      showList(1);
    });    
  });



		$(".chat").on("click", "li", function(e){
			
			var gno = $(this).data("gno");
			
			infocommentservice.get(gno, function(reply){
				modalInputReply.val(reply.content);
				modalInputReplyer.val(reply.nick);
				modal.data("gno", reply.gno);

				modal.find("button[id !='modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
			console.log(gno);
		});
		
		modalModBtn.on("click", function(e){
			var reply = {gno:modal.data("gno"), content:modalInputReply.val()};
			
			infocommentservice.update(reply, function(result){
				alert(result);
				modal.modal("hide");
				showList(1);
			});
		});
		
		modalRemoveBtn.on("click", function(e){
			var gno = modal.data("gno");
			
			infocommentservice.remove(gno, function(result){
				alert(result);
				modal.modal("hide");
				showList(1);

			})
		});



});
</script>


<!-- <script>
console.log("========");
console.log("JS TEST");

var noValue = '<c:out value="${board.no}"/>';

infocommentservice.add(
		{reply:"JS Test", replyer:"tester", no:noValue}
		,
		function(result){
			alert("RESULT:"+result);
}
);

infocommentservice.getList({no:noValue, page:1}, function(list){
	
	for(var i=0, len=list.length||0; i<len; i++){
		console.log(list[i]);
	}
});

infocommentservice.remove(23, function(count){
	
	console.log(count);
	
	if(count === "success"){
		alert("REMOVED");
	}
}, function(err){
	alert('ERROR...');
	
});

infocommentservice.update({
	gno:22,
	no:noValue,
	reply:"Modified Reply..."
}, function(result){
	alert("수정 완료");
})

infocommentservice.get(10, function(data){
	console.log(data);
})

</script> -->


<script>
$(document).ready(function(){
  
  (function(){
  
    var no = '<c:out value="${board.no}"/>';
    
    $.getJSON("/infoboard/getAttachList", {no:no}, function(arr){
    
      console.log(arr);  
      
      var str = "";
      
      $(arr).each(function(i, attach){
      
        //image type
        if(attach.fileType){
          var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
          
          str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
          str += "<img src='/infoboard/display?fileName="+fileCallPath+"'>";
          str += "</div>";
          str +"</li>";
        }else{
            
          str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
          str += "<span> "+ attach.fileName+"</span><br/>";
          str += "<img src='/resources/images/infoattach.png'></a>";
          str += "</div>";
          str +"</li>";
        }
      });
      
      $(".uploadResult ul").html(str);
      
    }); //end getjson
  })();//end function
  
  $(".uploadResult").on("click","li", function(e){
      
	    console.log("view image");
	    
	    var liObj = $(this);
	    
	    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
	    
	    if(liObj.data("type")){
	      showImage(path.replace(new RegExp(/\\/g),"/"));
	    }else {
	      //download 
	      self.location ="/infoboard/download?fileName="+path
	    }
	    
	    
	  });
	  
	  function showImage(fileCallPath){
		    
	    alert(fileCallPath);
	    
	    $(".bigPictureWrapper").css("display","flex").show();
	    
	    $(".bigPicture")
	    .html("<img src='/infoboard/display?fileName="+fileCallPath+"' >")
	    .animate({width:'100%', height: '100%'}, 1000);
	    
	  }
	  
	  $(".bigPictureWrapper").on("click", function(e){
		    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		    setTimeout(function(){
		      $('.bigPictureWrapper').hide();
		    }, 1000);
		  });
});
</script>
<script>

var no='<c:out value="${board.no}"/>';
var id=$.cookie('userId');

console.log("no>>"+no);
console.log("id>>"+id);

$('#likeBtn').on('click', function(){
	console.log($(this).attr("class"));
	
	if($(this).attr("class")=="btn btn-primary"){
		addLikeGet();
		getLike();
		checkLike();
		console.log("$(this).attr('class')=='btn btn-primary'>>>>>"+$(this).attr('class')=='btn btn-primary');
	}else if($(this).attr("class")=="btn btn-danger"){
		deletLikeGet();
		getLike();
		checkLike();
		console.log("$(this).attr('class')=='btn btn-danger'>>>>>"+$(this).attr('class')=='btn btn-danger');
	}
});

function getLike(){
$.ajax({
	type:'POST',
	url:'/infoboard/get',
	async:false,
	data:{
		no:no,
		id:id
	},
	success:function(data){
		console.log("data>>>>"+data);
		if(data==0){
			$('#likeBtn').removeClass("btn btn-danger");
			$('#likeBtn').addClass("btn btn-primary");
		}else if(data > 0){
			$('#likeBtn').removeClass("btn btn-primary");
			$('#likeBtn').addClass("btn btn-danger");
		}

	}
});
}

function addLikeGet(){
	$.ajax({
		type:'POST',
		url:'/infoboard/addLike',
		async:false,
		data:{
			no:no,
			id:id
		},
		success:function(data){
			console.log("addLikeGet>>>>>");
			
			}

	});
	}

	function deletLikeGet(){
		$.ajax({
			type:'POST',
			url:'/infoboard/deletLike',
			async:false,
			data:{
				no:no,
				id:id
			},
			success:function(data){
				console.log("deleteLikeGet>>>>>");
				
				}

		});
		}
	
	function checkLike(){
		$.ajax({
			type:'POST',
			url:'/infoboard/checkLike',
			async:false,
			data:{
				no:no,
				id:id
			},
			success:function(data){
				console.log("checkLike>>>>>"+data);
				$('#likeNum').text(data);
				}

		});
		}


</script>

<script type="text/javascript">
	$(document).ready(function() {

		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {

			operForm.attr("action", "/infoboard/modify").submit();

		});

		$("button[data-oper='list']").on("click", function(e) {

			operForm.find("#no").remove();
			operForm.attr("action", "/infoboard/list")
			operForm.submit();

		});
	});
</script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=252fb6164fbfe7257f504bc8c64642b8"></script>
<script>

		var container = document.getElementById('map');
		var options = {
			center: new daum.maps.LatLng('<c:out value="${mapboard.lat}"/>','<c:out value="${mapboard.lng}"/>'),
			level: 3
		};
		//지도생성
		var map = new daum.maps.Map(container, options);
		
	

		// 마커가 표시될 위치
		var markerPosition  = new daum.maps.LatLng('<c:out value="${mapboard.lat}"/>', '<c:out value="${mapboard.lng}"/>'); 
		console.log("markerPosition>>>"+markerPosition);
		// 마커 생성
		var marker = new daum.maps.Marker({
    		position: markerPosition
			});
		// 마커가 지도 위에 표시되도록 설정
		marker.setMap(map);
		
	</script>