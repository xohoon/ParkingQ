$(document).ready(function(){
	

console.log("FreeComment Module..........");

var freecommentService = (function(){
	
//댓글 등록 처리
	function add(commentVO, callback, error){
		console.log("add reply.............");
		
		$.ajax({
		type : 'post',
		url : '/replies/new',
		data : JSON.stringify(commentVO),
		contentType : "application/json; charset=utf-8",
		success : function(result, status, xhr) {
			if(callback){
				callback(result);
			}
		},
		error : function(xhr, status, er){
			
			console.log("add reply>>>>>>>>>>>>>>>");
			 
			if(error){
				error(er);
			}
		}
	})
}
     	
	//댓글 목록 처리
	function getList(param, callback, error){
		var no = param.no;
		
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + no + "/"  + page + ".json",
				function(data){
					if(callback) {
						
						console.log()
						
						callback(data);
					}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}	

	//댓글 삭제
	function remove(gno, callback , error){
		$.ajax({
			
			type : 'delete',
			url : '/replies/' + gno,
			success : function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er){
				if (error) {
					error (er);
				}
			}
			
		});
	}
	
	//댓글 수정
	function update(commentVO, callback, error){
		console.log ("GNO :" + commentVO.gno );
		
		$.ajax({
			type : 'put',
			url : '/replies/' + commentVO.gno,
			data : JSON.stringify(commentVO),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if (error){
					error(er);
				}
			}
		});
	}
	
	//댓글 조회 
	function get(gno, callback, error){
		$.get("/replies/" + gno + ".json", function(result) {
			
			if(callback) {
				callback(result);
			}
			
		}).fail(function(xhr, status, err){
			if(error) {
				error();
			}
		});
	}
	
	return {
		add:add,
		getList : getList,
		remove : remove,
		update : update,
		get : get
	};
})();


});
