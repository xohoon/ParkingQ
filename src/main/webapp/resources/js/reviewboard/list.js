

var modalStart =(function(){
	function checkModalStart(resultValue){
		var result=resultValue;
		
		checkModal(result);
		
		history.replaceState({},null,null);
		
		//게시물 작성 완료 시 모달창 띄우기 체크
		function checkModal(result){
			if(result === ''||history.state){
				return ;
			}
			if(result=='success'){
				
				swal({
					  title: "게시물 등록완료",
					  text: "후기글을 등록하셨습니다",
					  icon: "success",
					  button: "확인",
					});
			}
			if(result=='remove success'){
				
				swal({
					  title: "게시물 삭제 완료",
					  text: "게시물을 삭제하셨습니다",
					  icon: "success",
					  button: "확인",
					});
			}
			if(result=='remove fail'){
				swal({
					  title: "게시물 삭제 실패",
					  text: "본인의 게시물이 아닌 게시물은 삭제할 수 없습니다!",
					  icon: "warning",
					  /*buttons: true,*/
					  dangerMode: true
					});
			}
			

		}
		
		
		}
	
	
	return {checkModalStart:checkModalStart};
})();

	$(document).ready(function(){
		//모달------------------------------------------------------------------
$("#reg_button").on("click",function(){
	
		});
	
	$(document).on('click','#modal_submit',function(e){
		e.preventDefault();
		var modalForm = $(this).parents('#modalForm');
		var modalTitle= modalForm.find("input[name='title']");
		var modalAppavg=modalForm.find("input[name='appavg']");
		var modalGoodavg = modalForm.find("input[name='goodavg']");
		var modalReavg= modalForm.find("input[name='reavg']");
		var modalContent = modalForm.find("textarea[name='content']");
		var modalRfile =modalForm.find("input[name='rfile']");
		
		if(modalTitle.val()==null || modalTitle.val()==''){
			swal({
				  title: "제목을 입력해주세요",
				  text: "",
				  icon: "warning",
				  /*buttons: true,*/
				  dangerMode: true
				});
			modalTitle.focus();
			return ;
		}
		if(modalContent.val()==null || modalContent.val()==''){
			swal({
				  title: "게시물 내용을 입력해주세요",
				  text: "",
				  icon: "warning",
				  /*buttons: true,*/
				  dangerMode: true
				});
			modalContent.focus();
			return ;
		}
		if(!(modalAppavg.val()=='1'||modalAppavg.val()=='2'||modalAppavg.val()=='3'||modalAppavg.val()=='4'||modalAppavg.val()=='5')){
			swal({
				  title: "질문 항목을 다시 체크해주세요",
				  text: "",
				  icon: "warning",
				  /*buttons: true,*/
				  dangerMode: true
				});
		
			return ;
		}
		if(!(modalGoodavg.val()=='1'||modalGoodavg.val()=='2'||modalGoodavg.val()=='3'||modalGoodavg.val()=='4'||modalGoodavg.val()=='5')){
			swal({
				  title: "질문 항목을 다시 체크해주세요",
				  text: "",
				  icon: "warning",
				  /*buttons: true,*/
				  dangerMode: true
				});
			
			return ;
		}
		if(!(modalReavg.val()=='1'||modalReavg.val()=='2'||modalReavg.val()=='3'||modalReavg.val()=='4'||modalReavg.val()=='5')){
			swal({
				  title: "질문 항목을 다시 체크해주세요",
				  text: "",
				  icon: "warning",
				  /*buttons: true,*/
				  dangerMode: true
				});
			
			return ;
		}
		modalForm.submit();
		
	});
	
	registerCheck();
	function registerCheck(){
	if($('#registerCheck').val()==null||$('#registerCheck').val()=='0'){
		return;
	}else if($('#registerCheck').val()=='1'){
		swal({
			  title: "게시물 등록 완료",
			  text: "게시물 등록이 완료되었습니다! 평가해주신 항목은 3개의 그림으로 나타납니다.",
			  icon: "success",
			  button: "확인",
			});
		$('#registerCheck').val('0');
	}
			
	}
	
	$()
		//end모달---------------------------------------------------------------
		
		var id = $.cookie("userId");
		var nick = $.cookie("userNick");
		
		
		//페이징 버튼 링크보내기
		var actionForm=$("#actionForm");
		var actionGoodsForm=$("#actionGoodsForm");
		var actionHighStarForm=$("#actionHighStarForm");
		var actionLowStarForm=$("#actionLowStarForm");
		var pagingHOW = $('.selected').attr('id');
		
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			//전체보기 폼
			if(pagingHOW=='d_id_all'){
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();	
			}
			//좋아요 순 폼
			if(pagingHOW=='d_id_goods'){
				actionGoodsForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionGoodsForm.submit();	
			}
			//별점높은 순 폼
			if(pagingHOW=='d_id_highStar'){
				actionHighStarForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionHighStarForm.submit();	
			}
			//별점낮은 순 폼
			if(pagingHOW=='d_id_lowStar'){
				actionLowStarForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionLowStarForm.submit();	
			}
		
		});
		
		//전체게시물 정렬 클릭
		$('#d_id_all').on("click", function(){
			
			location.href="http://파킹큐.kr/reviewboard/list/main";
			
		});
		
		//좋아요정렬 클릭
		$('#d_id_goods').on("click", function(){
			
			location.href="http://파킹큐.kr/reviewboard/list/goodsList";
			
		});
		
		//높은 별점순 클릭
		$('#d_id_highStar').on("click", function(){
			
			location.href="http://파킹큐.kr/reviewboard/list/highStar";
			
		});
		
		//낮은 별점 순
		$('#d_id_lowStar').on("click", function(){
			
			location.href="http://파킹큐.kr/reviewboard/list/lowStar";
			
		});
		
		
		 //info로 보낼 때 페이징정보값 같이 넘기기
		 $(".move").on("click", function(e){
			 
			 e.preventDefault();
			 
			 actionForm.append("<input type='hidden' name='no' value='"+$(this).attr("href")+"'>");
			 
			 actionForm.attr("action", "/reviewboard/info");
			 actionForm.submit();
		 });
		 
		 $(document).on('click','.delete_button',function(e){
			e.stopPropagation();
			var hidden_realId = $(this).parents('.reviewContent_body_close').find('.hidden_realId').val();
			if(hidden_realId==null)hidden_realId=$(this).parents('.reviewContent_body').find('.hidden_realId').val();
			
			swal({
				  title: "게시물을 삭제하시겠습니까?",
				  text: "게시물을 삭제하시면 영구히 삭제됩니다.",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				})
				.then((willDelete) => {
				  if (willDelete) {
					 
					  if(hidden_realId==id){
							 actionForm.append("<input type='hidden' name='no' value='"+$(this).val()+"'>");
							 actionForm.append("<input type='hidden' name='realId' value='"+hidden_realId+"'>");
							 actionForm.attr("method","post");
							 actionForm.attr("action", "/reviewboard/remove");
							 actionForm.submit();
							}else{
								swal({
									  title: "게시물 삭제 실패",
									  text: "본인의 게시물이 아닌 게시물은 삭제할 수 없습니다욜로!",
									  icon: "warning",
									  /*buttons: true,*/
									  dangerMode: true
									});
									
								return;
							}
				  } else {
				    return;
				  }
				});
			
			
			
		 });
		
		
		
		
		//좋아요버튼
		var review_right_goods = $(".review_right_goods_point");
		
		//좋아요 클릭 이벤트 발생
		review_right_goods.on("click", function(e){
			e.stopPropagation();

			var This = $(this);
			var no = $(this).parents('.reviewContent').find('.hidden_value').val();
			if(no==null){
				no = $(this).parents('.reviewContent_close').find('.hidden_value').val();
			}
			
			
			if($(this).attr("class") == "review_right_goods_point No_goods_color review_right_goods_close"){
				getGoods(This, no);
				addGoods(This, no);
				swal({
					  title: "좋아요가 추가되었습니다",
					  text: "이 게시물이 쪼아!",
					  icon: "success",
					  button: "확인",
					});
				goodsCount(This, no);
			}else if($(this).attr("class") == "review_right_goods_point No_goods_color review_right_goods"){
				getGoods(This, no);
				addGoods(This, no);
				swal({
					  title: "좋아요가 추가되었습니다",
					  text: "이 게시물이 쪼아!",
					  icon: "success",
					  button: "확인",
					});
				goodsCount(This, no);
			}else if($(this).attr("class") == "review_right_goods_point review_right_goods_close No_goods_color"){
				getGoods(This, no);
				addGoods(This, no);
				swal({
					  title: "좋아요가 추가되었습니다",
					  text: "이 게시물이 쪼아!",
					  icon: "success",
					  button: "확인",
					});
				goodsCount(This, no);
			}else if($(this).attr("class") == "review_right_goods_point review_right_goods No_goods_color"){
				getGoods(This, no);
				addGoods(This, no);
				swal({
					  title: "좋아요가 추가되었습니다",
					  text: "이 게시물이 쪼아!",
					  icon: "success",
					  button: "확인",
					});
				goodsCount(This, no);
			}

			else if($(this).attr("class") == "review_right_goods_point Yes_goods_color review_right_goods_close"){
				getGoods(This, no); 
				deleteGoods(This, no);
				
				goodsCount(This, no);
			}else if($(this).attr("class") == "review_right_goods_point Yes_goods_color review_right_goods"){
				getGoods(This, no); 
				deleteGoods(This, no);
				
				goodsCount(This, no);
			}else if($(this).attr("class") == "review_right_goods_point review_right_goods_close Yes_goods_color"){
				getGoods(This, no); 
				deleteGoods(This, no);
				
				goodsCount(This, no);
			}else if($(this).attr("class") == "review_right_goods_point review_right_goods Yes_goods_color"){
				getGoods(This, no); 
				deleteGoods(This, no);
				 
				goodsCount(This, no);
			}else{
				alert('로그인을 해주세요');
			}
		});
		
		//좋아요 수 출력
/*		getGoods();*/
		
		//접속한 아이디로부터 해당 게시물의 좋아요 여부를 체크해서 class명 변경
		function getGoods(This, no){
	
		var goodsId = $('#goods'+no);
		
		
		$.ajax({
			type : 'post',
			url : '/reviewBoardGoods/getGoods',
			async : false,
			data : {
				no : no,
				id : id
				},
				success : function(data){
					
					if(data == 0){
						
						goodsId.removeClass('No_goods_color');
						goodsId.addClass('Yes_goods_color');	
					

					}else if(data > 0){
					
						goodsId.removeClass('Yes_goods_color');
						goodsId.addClass('No_goods_color');	
						
					}
				}
			});
		}
		
		//좋아요 총 개수 가져오기
		function goodsCount(This, no){
			
			var goodsId = $('#goods'+no);
			
			$.ajax({
				type: 'post',
				url : '/reviewBoardGoods/goodsCount',
				async : false,
				data : {
					no : no
				},
				success : function(data){
					goodsId.html('Goods:' + data);
				}
			});
		}
			
			
		//좋아요 추가
		function addGoods(This, no){
			
			$.ajax({
				type : 'post',
				url : '/reviewBoardGoods/addGoods',
				async : false,
				data : {
					no : no,
					id : id
				},
				success : function(data){
					
				}
			});
		}
		
		//좋아요 빼기
		function deleteGoods(This, no){
		
			$.ajax({
				type : 'post',
				url : '/reviewBoardGoods/deleteGoods',
				async : false,
				data : { 
					no : no,
					id : id
				},
				success : function(data){
				}
			});
		}
	
		
		 
			var gnoValue='';
			var replyUL = $(".chat");

			
			
		
		//게시물 한 개 클릭 & 펼치기
		 $(document).on("click",".purchur",function(e){
			 e.preventDefault();
			 var openClose = $(this).parents('.reviewContent_close').find('.hidden_openClose');
			 
			 //openClose가 0일 때 펼치기, 1일 때 닫기
			 if(openClose.val()==0){
			
			openClose.val('1');
			
			//td 클래스 변경
				$(this).parents('.reviewContent_close').removeClass('reviewContent_close').addClass('reviewContent');

			//클릭한 게시물의 td
				var This = $(this).parents('.reviewContent');
				
			

			$(this).parents('.table_body_tr').css('background-color','#ececec');
			//right 박스의 좋아요
			This.find('.review_right_goods_close').removeClass(
					'review_right_goods_close').addClass('review_right_goods'); 
			//right 박스의 아이디와 날짜
			This.find('.review_right_IdDate_close').removeClass(
					'review_right_IdDate_close').addClass('review_right_IdDate');
			//right 박스의 앱만족도
			This.find('.review_right_percent_close').removeClass(
					'review_right_percent_close').addClass('review_right_percent');
			// 평가그림 c
			This.find('.review_right_appraisal_c_close').removeClass(
					'review_right_appraisal_c_close').addClass('review_right_appraisal_c');
			// 평가그림 b
			This.find('.review_right_appraisal_b_close').removeClass(
					'review_right_appraisal_b_close').addClass('review_right_appraisal_b');
			// 평가그림 a
			This.find('.review_right_appraisal_a_close').removeClass(
					'review_right_appraisal_a_close').addClass('review_right_appraisal_a');
			//right 박스의 평가그림의 묶음
			This.find('.review_right_appraisal_close').removeClass(
					'review_right_appraisal_close').addClass('review_right_appraisal');
			//right 박스
			This.find('.review_right_close').removeClass(
					'review_right_close').addClass('review_right');
			//center 박스의 제목
			This.find('.review_center_title_close').removeClass(
					'review_center_title_close').addClass('review_center_title');
			//center 박스의 별점
			This.find('.review_center_star_close').removeClass(
					'review_center_star_close').addClass('review_center_star');
			//center 박스
			This.find('.review_center_close').removeClass(
					'review_center_close').addClass('review_center');
			//left 박스의 사진
			This.find('.picture_close').removeClass(
					'picture_close').addClass('picture');
			//left 박스의 사진
			This.find('.review_left_picture_close').removeClass(
					'review_left_picture_close').addClass('review_left_picture');
			//left 박스의 별점
			This.find('.review_left_star_close').removeClass(
					'review_left_star_close').addClass('review_left_star');
			//left 박스
			This.find('.review_left_close').removeClass(
					'review_left_close').addClass('review_left');
			//내용물 전체 클래스 변경
			This.find('.reviewContent_body_close').removeClass(
					'reviewContent_body_close').addClass('reviewContent_body');
			

		
			
			//게시물번호
			var gnoValue = $(this).parents('.reviewContent').find('.hidden_value').val(); // 사용
			
			//클릭한 게시물의 댓글이 들어가는 div
			var thisUL = This.find(".chat"); //사용
			
			//클릭한 게시물의 댓글 페이징이 들어가는 div
			var thisFooter = This.find(".panel-footer"); //사용
			
			
			 $(".replyContent").keyup(function (e){
		          var contentValue = $(this).val();
		          var counterComment = $(this).parents('.ohmygod').find('.counterComment');
		          counterComment.html(contentValue.length + '/500');
		          
			 });
			 $('.replyContent').keyup();
			
			//댓글리스트 뽑기 실행
			showList(thisFooter, thisUL, gnoValue, 1);
			
			 }
		 });
	

		 
		 
/*밑에는 댓글 스크립트------------------------------------------------------------------------------------  */
			
			//댓글 리스트 함수
			function showList(thisFooter, thisUL, gnoValue, page){
				
				var This = thisFooter.parents('.reviewContent');
				
				//모듈화 된 CommentService의 getList. 댓글리스트뽑기
				CommentService.getList({gno:gnoValue, page:page||1},
						function(replyCnt, list){
						
					//showList() 함수는 파라미터로 전달되는 page 변수를 이용해서 원하는 댓글 페이지를 가져오게 된다. 이때 만일 page번호가 '-1'로
					//전달되면 마지막 페이지를 찾아서 다시 호출하게 된다. 사용자가 새로운 댓글을 추가하면 showList(-1)을 호출하여 우선 전체 댓글의
					//숫자를 파악하게 한다. 이 후에 다시 마지막 페이지를 호출해서 이동시키는 방식으로 동작시킨다.
					// 이러한 방식은 여러 번 서버를 호출해야 하는 단점이 있기는 하지만, 댓글의 등록 행위가 댓글 조회나 페이징에 비해서 적기 때문에
					//심각한 문제는 아니다.
						if(page == -1){
							//replyCnt : 댓글의 총 개수
							pageNum=Math.ceil(replyCnt/5.0);
							showList(thisFooter, thisUL, gnoValue,pageNum);
							return;
						}
						
						//추가하게될 html코드를 str에 담아준다.
						var str="";
					
						//댓글이 없는 경우 다시 리턴
						if(list==null || list.length==0){
							str+="댓글이 없습니다";
						}
						
						
						//댓글리스트
						for(var i =0, len=list.length || 0; i < len; i++){
							str +="<li class='left clearfix' data-no='"+list[i].no+"'>";
							if(id==list[i].realId){
								str +="<a href='#' 	class='comment_btn' style='float:right; font-size:90%; margin-right:20px;'>삭제</a>"}
							str +=" <div><div class='header'><strong class='primary-font'>"
								+ list[i].id + "</strong>";
							str +=" <small class='pull-right text-muted'>" 
							+ CommentService.displayTime(list[i].rdate)+"</small></div>";
							str +=" <p class='replyP'>" + list[i].content + "</p></div></li><hr>";
						}
						console.log('댓글리스트 실행 완료');
						// 댓글 창
						This.find('.review_final_comment_close').removeClass(
						'review_final_comment_close').addClass('review_final_comment');
						// 댓글 창 닫기버튼
						This.find('.cancle_Btn_close').removeClass(
						'cancle_Btn_close').addClass('cancle_Btn');
						
						//댓글이 들어갈 div에 추가해준다
						thisUL.html(str);
						
						//댓글 페이징 함수 호출
						showReplyPage(thisFooter, replyCnt);
						$('.comment_btn').on('click', function(e){
							e.preventDefault();
							var no = $(this).parents('.left').data("no");
							
							swal({
								  title: "해당 댓글을 삭제하시겠습니까?",
								  text: "해당 댓글을 삭제하시면 영구히 삭제됩니다.",
								  icon: "warning",
								  buttons: true,
								  dangerMode: true,
								})
								.then((willDelete) => {
								  if (willDelete) {
									  CommentService.remove(no, function(result){
										 swal("댓글이 삭제되었습니다.", {
										 icon: "success",
										 });
										 showList(thisFooter, thisUL, gnoValue, 1);
										});
								    
								  } else {
								    
								  }
								});
							
						});
					
				}); //end function
					
			}//end showList
			
			
//440p 댓글 페이지번호 출력 로직
			
			var pageNum=1;
			
			function showReplyPage(thisFooter, replyCnt){
				
				var endNum=Math.ceil(pageNum / 10.0) * 10;
				var startNum = endNum - 9;
				
				var prev = startNum != 1;
				var next = false;
				
				if(endNum * 5 >= replyCnt){
					endNum = Math.ceil(replyCnt / 5.0);
				}
				
				if(endNum * 5 < replyCnt){
					next = true;
				}
				
				var str = "<ul class='pagination pull-right'>";
				
				if(prev){
					str += "<li class='page-item'><a class='page-link' href='"
					+ (startNum -1) +"'>Previous</a></li>";
				}
				
				for(var i = startNum ; i <= endNum ; i++){
					
					var active = pageNum == i ? "active" : "";
					
					str += "<li class='page-item " + active 
					+ " '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
				}
				
				if(next){
					str += "<li class='page-item' <a class='page-link' href='"
					+ (endNum + 1) + "'>Next</a></li>";
				}
				
				str += "</ul>";
				
				thisFooter.html(str);
				
			}


			
			//페이지 번호 클릭 시 새로운 댓글 출력 로직 441p
			$(".panel-footer").on("click","li a", function(e){
				
				e.preventDefault();
				
				var targetPageNum = $(this).attr("href");
				
				pageNum = targetPageNum;
				
				var thisFooter = $(this).parents('.reviewContent').find('.panel-footer');
				
				var thisUL = $(this).parents('.reviewContent').find(".chat");
				
				var gnoValue= $(this).parents('.reviewContent').find('.hidden_value').val();
						
				showList(thisFooter, thisUL, gnoValue, pageNum);
			});
			
			
			//423p 새로운 댓글 쓰기
			$(".commentwrite").on("click", function(){
				
				//댓글의 내용
				var replyContent = $(this).parents('.ohmygod').find('.form-control').val();
				
				if(replyContent==null || replyContent==''){
					swal({
						  title: "댓글 등록 실패",
						  text: "댓글을 작성해 주세요",
						  icon: "warning",
						  buttons: true
						});
					return;
				}
				var This = $(this);
				//댓글달 게시물 번호
				var reviewContent=$(this).parents('.reviewContent');
				
				var thisFooter = $(this).parents('.reviewContent').find('.panel-footer');
				
				var thisUL = $(this).parents('.reviewContent').find(".chat");
				
				var gnoValue= $(this).parents('.reviewContent').find('.hidden_value').val();
				
				var replyId= $(this).parents('.reviewContent').find('.hidden_id').val();
				
				var replyNick= $(this).parents('.reviewContent').find('.hidden_nick').val();
				
				var reply={
						
						content : replyContent,
						id : replyId,
						gno : gnoValue,
						nick : replyNick
				};
				//start ajax
				CommentService.add(reply, function(result){
					
					//comment count
						
					swal({
						  title: "댓글등록완료",
						  text: "댓글을 등록하셨습니다",
						  icon: "success",
						  button: "확인",
						});
					//텍스트박스 값 초기화
					This.parents('.ohmygod').find('.form-control').val('');
					
					//-1값을 던지면서 게시물을 초기화시킨다
					
					var commentCount;
					getComment(gnoValue);
					function getComment(gnoValue){
						$.ajax({
							type : 'post',
							url : '/reviewboard/getComment',
							async:false,
							data : {
								no : gnoValue
								},
							success : function(data){
								commentCount=data;
							},
							error:function(request,status,error){
			                    console.log('getComment error');
			                }
						});
					}
					
					reviewContent.find('.commentCount').html(commentCount);
					showList(thisFooter, thisUL, gnoValue, -1);
					
					//showList는 앞서 내가 정의한 함수이다. 1의 의미는 page 파라미터 값이고
					//gno의 값은 내장되어 있다.
				});
			});
			
			//댓글창 닫기버튼 클릭
			$('.cancle_Btn_close').on('click',function(e){
				e.stopPropagation();
				
				//클릭한 게시물의 td
				var This = $(this).parents('.reviewContent');
				var openClose= This.find('.hidden_openClose');
				openClose.val('0');
				$(this).parents('.table_body_tr').css('background-color','#ffffff');
				//td 클래스 변경
				This.removeClass('reviewContent').addClass('reviewContent_close');
				//right 박스의 좋아요
				This.find('.review_right_goods').removeClass(
						'review_right_goods').addClass('review_right_goods_close'); 
				//right 박스의 아이디와 날짜
				This.find('.review_right_IdDate').removeClass(
						'review_right_IdDate').addClass('review_right_IdDate_close');
				//right 박스의 앱만족도
				This.find('.review_right_percent').removeClass(
						'review_right_percent').addClass('review_right_percent_close');
				// 평가그림 c
				This.find('.review_right_appraisal_c').removeClass(
						'review_right_appraisal_c').addClass('review_right_appraisal_c_close');
				// 평가그림 b
				This.find('.review_right_appraisal_b').removeClass(
						'review_right_appraisal_b').addClass('review_right_appraisal_b_close');
				// 평가그림 a
				This.find('.review_right_appraisal_a').removeClass(
						'review_right_appraisal_a').addClass('review_right_appraisal_a_close');
				//right 박스의 평가그림의 묶음
				This.find('.review_right_appraisal').removeClass(
						'review_right_appraisal').addClass('review_right_appraisal_close');
				//right 박스
				This.find('.review_right').removeClass(
						'review_right').addClass('review_right_close');
				//center 박스의 제목
				This.find('.review_center_title').removeClass(
						'review_center_title').addClass('review_center_title_close');
				//center 박스의 별점
				This.find('.review_center_star').removeClass(
						'review_center_star').addClass('review_center_star_close');
				//center 박스
				This.find('.review_center').removeClass(
						'review_center').addClass('review_center_close');
				//left 박스의 사진
				This.find('.picture').removeClass(
						'picture').addClass('picture_close');
				//left 박스의 사진
				This.find('.review_left_picture').removeClass(
						'review_left_picture').addClass('review_left_picture_close');
				//left 박스의 별점
				This.find('.review_left_star').removeClass(
						'review_left_star').addClass('review_left_star_close');
				//left 박스
				This.find('.review_left').removeClass(
						'review_left').addClass('review_left_close');
				//내용물 전체 클래스 변경
				This.find('.reviewContent_body').removeClass(
						'reviewContent_body').addClass('reviewContent_body_close');
				
				// 댓글 창
				This.find('.review_final_comment').removeClass(
				'review_final_comment').addClass('review_final_comment_close');
				// 댓글 창 닫기버튼
				This.find('.cancle_Btn').removeClass(
				'cancle_Btn').addClass('cancle_Btn_close');
			

				
			});
			
			
			
			var appavgForm = $('#appavgForm');
			var goodavgForm = $('#goodavgForm ');
			var reavgForm = $('#reavgForm');
			var content = $('#content');
			var reviewboard_File = $('#reviewboard_File');
			var title = $('#title');
			var fileTitle=$('#fileTitle');
			var content_label = $('#content_label');
			var title_lavel=$('#title_lavel');
			//422p modal 
			var modal=$("#myModals");
			var modalInputReply=modal.find("input[name='reply']");
			var modalInputId=modal.find("input[name='id']");
			var modalInputRdate=modal.find("input[name='rdate']");
			
			var modalModBtn=$("#modalModBtn");
			var modalRemoveBtn=$("#modalRemoveBtn");
			var modalRegisterBtn = $("#modalRegisterBtn");
			var modalCloseBtn = $("#modalCloseBtn");
			var modal_submit = $('#modal_submit');
			var modal_reset = $('#modal_reset');
			var modalForm = $('#modalForm');
			
			$('#reg_button').on('click',function(){
				modal.modal("show");
				reavgForm.css('display','none');
				content.css('display','none');
				modalInputReply.css('display','none');
				modalInputId.css('display','none');
				modalInputRdate.css('display','none');
				modalModBtn.css('display','none');
				modalRemoveBtn.css('display','none');
				goodavgForm.css('display','none');
				reviewboard_File.css('display', 'none');
				title.css('display', 'none');
				fileTitle.css('display','none');
				modalRegisterBtn.css('display','none');
				modalCloseBtn.css('display','none');
				modal_submit.css('display','none');
				modal_reset.css('display','none');	
				content_label.css('display','none');
				title_lavel.css('display','none');
				modalForm.css('display','none');
				appavgForm.fadeIn();
				
			});
			
			//앱만족도
			appavgForm.find('.app').on('click',function(){
				appavgForm.css('display','none');
				goodavgForm.fadeIn();
				$(this).parents('.modal-body').find("input[name='appavg']").val($(this).val());
			});
			//처리속도
			goodavgForm.find('.goodavg').on('click',function(){
				goodavgForm.css('display','none');
				reavgForm.fadeIn();
				$(this).parents('.modal-body').find("input[name='goodavg']").val($(this).val());
			});
			//상대이용자 만족도
			reavgForm.find('.re').on('click',function(){
				reavgForm.css('display','none');
				
				fileTitle.fadeIn();
				reviewboard_File.fadeIn();
				fileTitle.css('display','block');
				reviewboard_File.css('display','block');
				content.fadeIn();
				title.fadeIn();
				modalCloseBtn.fadeIn();
				modal_submit.fadeIn();
				modal_reset.fadeIn();	
				title_lavel.fadeIn();
				content_label.fadeIn();
				modalForm.fadeIn();
				
				$(this).parents('.modal-body').find("input[name='reavg']").val($(this).val());
				swal({
					  title: "평가가 완료되었어요!",
					  text: "사진란에 올리실 사진이 있으시다면 드래그로 끌어다가 놓으시면 됩니다. 자유롭게 이용후기를 작성해 주세요 ^ ^",
					  icon: "success",
					  button: "확인",
					});
				 $("textarea[name='content']").keyup(function (e){
			          var contentValue = $(this).val();
			          
			          $('#counter').html(contentValue.length + '/1000');
			          $(this).height('186px');
				 });
				 
				 $("input[name='title']").keyup(function (e){
			          var contentValue = $(this).val();
			          $('#counterTitle').html(contentValue.length + '/25');
			          
				 });
				 
				
				  $('#titleArea').keyup();
			      $('#contentArea').keyup();
			});
			
			// modal cancle button
			modalCloseBtn.on("click", function(e){
				modal.modal("hide");
			});
			
			
			//427p update comment
			modalModBtn.on("click", function(e){
				var reply = {no:modal.data("no"), content:modalInputReply.val()};
				
				CommentService.update(reply, function(result){
					alert(result);
					modal.modal("hide");
					showList(pageNum);
				});
			});
			
			//427p delete comment
			modalRemoveBtn.on("click", function(e){
				var no = modal.data('no');
				
				CommentService.remove(no, function(result){
					alert(result);
					modal.modal("hide");
					showList(pageNum);
				});
			});
			
			var operForm = $("#operForm");
			
			$("button[data-oper='modify']").on("click", function(e){
				operForm.attr("action", "/reviewboard/modify").submit();
			});
			
			$("button[data-oper='list']").on("click", function(e){
				operForm.attr("action","/reviewboard/list")
				operForm.submit();
			});
		
	
	
	});
