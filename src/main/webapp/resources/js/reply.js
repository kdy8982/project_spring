console.log("Reply Module..................");

var replyService = (function() {

	function add(reply, callback, error) {
		console.log("reply............");

		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}

		})
	}
	
/*	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;

		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
				function(data) {
					if (callback) {
						callback(data.replyCnt, data.list)
					}
				}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}
*/

	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;

		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
				function(data) {
					if (callback) {
						callback(data)
					}
				}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}

	function remove(rno, replyer, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			data : JSON.stringify({rno:rno, replyer:replyer}),
			contentType : "application/json; charset=utf-8",
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}
	
	function get (rno, callback, error) {
		
		$.get("/replies/" + rno + ".json", function (result) {
			
			if(callback) {
				callback(result);
			}
			
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
	}
	
	function update (reply, callback) {
		$.ajax({
			type : "PUT",
			url : "/replies/" + reply.rno, 
			data:JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			}
		})
	}

	
	
	function displayTime(timeValue)  {
		var today = new Date(); // 오늘시간 
		var gap = today.getTime() - timeValue; // 오늘시간과 주어진 시간의 차이
		
		var dateObj = new Date(timeValue); // 주어진 시간 객체
		var str = "";
		
		if(gap < (1000 * 60 * 60 * 24)) { // 현재 시간과 작성일이의 차이가 하루가 넘는가?
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [(hh>9 ? '': '0') + hh, ':', (mi>0 ? '':'0') + mi, ':', (ss>9?'':'0') + ss].join('');
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();
			
			return [yy, '/', (mm>9 ? '':'0') + mm, '/', (dd>9? '':'0') + dd].join(''); 
		}
	}; 
	
	return {
		add : add,
		getList : getList,
		remove : remove,
		get : get,
		update : update, 
		displayTime : displayTime
	};
	
})();