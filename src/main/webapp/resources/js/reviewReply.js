

var CommentService=(function(){
	function add(reply, callback, error){
		
		
		//등록
		$.ajax({
			type:'post',
			url:'/comment/new',
			data:JSON.stringify(reply),
			contentType:"application/json; charset=utf-8",
			success:function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er)
					console.log("모듈의 error : " +er);
				}
			}
		});
	}
	
		//위까지 등록
		//리스트뽑기
		function getList(param, callback, error){
			var gno=param.gno;
			var page=param.page ||1;
			
			$.getJSON("/comment/pages/" + gno + "/" + page + ".json",
					function(data){
				if(callback){
					//callback(data); 전체 댓글 목록을 가져오는 경우
					callback(data.replyCnt, data.list);//댓글 숫자와 목록을 가져오는 경우
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
		}
		
		function getGoodList(param, callback, error){
			var gno=param.gno;
			var page=param.page ||1;
			
			$.getJSON("/comment/pages/" + gno + "/" + page + ".json",
					function(data){
				if(callback){
					//callback(data); 전체 댓글 목록을 가져오는 경우
					callback(data.replyCnt, data.list);//댓글 숫자와 목록을 가져오는 경우
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
		}
		
		
		//getList()는 param이라는 객체를 통해서 필요한 파라미터를 전달받아 json목록을 호출합니다 json형태가 필요하므로 url호출 시 확장자를
		//'.json'으로 요구합니다.
		//여기까지 list뽑기
		
		//삭제
		function remove(no, callback, error){
			$.ajax({
				type:'delete',
				url: '/comment/' + no,
				success : function(deleteResult, status, xhr){
					if(callback){
						callback(deleteResult);
					}
				},
				error:function(xhr, status, er){
					if(error){
						error(er);
					}
				}
			});
		}
		//위까지 삭제
		//remove는 delete 방식으로 데이터를 전달하므로, $.ajax()를 이용해서 구체적으로 type속성으로 'delete'를 지정한다. 
		//reviewboard/info.jsp 에서는 반드시 실제 데이터베이스에 있는 댓글 번호를 이용해서 정상적으로 댓글이 삭제되는지를 확인한다
		
		
		//수정
		function update(comment, callback, error){

			$.ajax({
				type:'put',
				url:'/comment/' + comment.no,
				data:JSON.stringify(comment),
				contentType:"application/json; charset=utf-8",
				success:function(result, status, xhr){
					if(callback){
						callback(result);
					}
				},
				error:function(xhr, status, er){
					if(error){
						error(er);
					}
				}
			});
		}
		//댓글 수정은 수정하는 내용과 함께 댓글의 번호를 전송한다. 댓글의 내용은 json형태로 전송하기 때문에 댓글 등록과 유사한 부분이 많다.
		
		//댓글 조회 처리
		function get(no, callback, error){
			$.get("/comment/" + no + ".json", function(result){
				if(callback){
					callback(result);
				}
			}).fail(function(xhr,status,err){
				if(error){
					error();
				}
			});
		}
		
		//417p 시간
		function displayTime(timeValue){
			var today=new Date();
			
			var gap=today.getTime() - timeValue;
			
			var dateObj=new Date(timeValue);
			var str = "";
			
			if(gap < (1000 * 60 * 60 * 24)){
	
				var hh = dateObj.getHours();
				var mi = dateObj.getMinutes();
				var ss = dateObj.getSeconds();
				
				return [(hh > 9 ? '' : '0') + hh, ':', (mi>9 ? '':'0') + mi,
					':', (ss>9? '':'0')+ss].join('');
			}else{
				var yy= dateObj.getFullYear();
				var mm = dateObj.getMonth() + 1; //getMonth() is zero-based
				var dd = dateObj.getDate();
				
				return [yy, '/',(mm>9? '':'0')+mm, '/',
					(dd>9?'':'0')+dd].join('');
			}
		};
	return {
		add:add,
		get:get,
		getList:getList,
		remove: remove,
		update:update,
		displayTime:displayTime
	};
})();
