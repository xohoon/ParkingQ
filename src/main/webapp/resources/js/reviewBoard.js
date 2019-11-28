
var GoodsService=(function(){
	
	//등록
	function add(goods, callback, error){
		console.log("goods.....................");
		
		$.ajax({
			type:'post',
			url:'/goods/new',
			data:JSON.stringify(goods),
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
	
	//게시물 컨텐츠 값 전체 가져오기
	function getContent(content, callback, error){
		console.log("getContent.................");
		
		$.ajax({
			type:'get',
			url:'info',
			data:JSON.stringify(content),
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
	
	return {
		add:add,
		getContent : getContent
	};
})();