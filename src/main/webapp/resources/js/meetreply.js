console.log("Reply Module................meetreply.jsjsjsjsjs");

var replyService = (function(){
	
	function add(reply, callback, error){
		console.log("add reply............");
		
		$.ajax({
			type : 'post',
			url : '/meetreplies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				console.log("add reply............111");
				if(callback){
					callback(result);
				}
				console.log("add reply>>>>>>>>>>>>>>>>>>>"+result);
			},
			error : function(xhr, status, er){
				console.log("add reply............222");
				if(error){
					error(er);
				}
			}
		});
		
	}
	
	// Ajax call part and jQuery's getJSON() use
	function getList(param, callback, error){
		console.log("add reply............333");
		var no = param.no;
		var page = param.page || 1;
		console.log("add reply............333");
		$.getJSON("/meetreplies/pages/"+no+"/"+page+".json",
			function(data){
			console.log("add reply............444");
				if(callback){
					// callback(data); -> reply only List
					callback(data.replyCnt, data.list); // -> reply num and list all get
				}
				console.log("add reply............555");
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	// reply remove
	function remove(gno, callback, error){
		$.ajax({
			type : 'delete',
			url : '/meetreplies/' + gno,
			success : function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	
	
	// reply update
	function update(reply, callback, error){
		console.log("GNO:" + reply.gno);
		
		$.ajax({
			type : 'put',
			url : '/meetreplies/' + reply.gno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	
	// reply GET type view
	function get(gno, callback, error){
		$.get("/meetreplies/" + gno + ".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
		
	}
	
	// reply list data desc
	function displayTime(timeValue){
		var today = new Date();
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		var str = "";
		
		if(gap < (1000 * 60 * 60 * 24)){
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return[ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss ].join('');
		}else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			// getMonth() is zero-based
			var dd = dateObj.getDate();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd ].join('');
		}
	}
	;
	
	return {
		add:add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
		};
})();



