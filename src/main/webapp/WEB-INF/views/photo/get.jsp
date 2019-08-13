<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<jsp:include page="../inc/headTop.jsp" flush="true"></jsp:include>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>

$(document).ready(function() {
	var actionForm = $("#actionForm"); 
	$(".page_num").on("click", function(e) {
		console.log("click page_num !!!");
		e.preventDefault();
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	})
	
	var openForm = $("#openForm");
	$("button[data-oper='list']").on("click", function(e) {
		e.preventDefault();
		openForm.find("#bno").remove();
		openForm.attr("action", "/photo/list");
		openForm.submit();
	})
	
	$("button[data-oper='modify']").on("click",function(e) {
		e.preventDefault();
		openForm.attr("action", "/photo/modify").submit();
	})
	
	
	var inputReply = $(".reply_write_box textarea");
	var replyer = null;
	var bnoValue = '<c:out value="${photo.bno}" />';
	
	<sec:authorize access="isAuthenticated()">
		replyer = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	})
	
	$(document).on("click", ".reply_close_btn", function(e) {
		var rno = $(this).data("rno");
		var replyer = $(this).data("replyer");
		replyService.remove(rno, replyer, function(result) {
			alert(result);
			showList(1);
		});
	})

	$(".reply_btn").on("click", function(e) { // 댓글 등록 버튼 클릭. 
		e.preventDefault();
		
		var reply = {
			reply : inputReply.val(),
			replyer : replyer,
			bno:bnoValue
		};
		
		replyService.add(reply , function(result) {
			alert(result);
			showList(1);
		});
	})
	
	/* 첨부파일 조회 AJAX */
	var bno = '<c:out value="${photo.bno}"/>';
	$.getJSON("/board/getAttachList" , {bno : bno}, function (arr) {
		console.log(arr);
		
		var str="";
		
		$(arr).each(function(i, attach) {
			//image type (썸네일)
				var fileCallPath = encodeURIComponent(attach.uploadPath+"/"+attach.uuid+ "_" + attach.fileName);
				
				str += "<li class='image_li' data-path='"+ attach.uploadPath +"' data-uuid='"+ attach.uuid +"' data-filename='"+ attach.fileName +"' data-type='"+ attach.fileType +"' >";
				str += "<div>";
				str += "<img src='/display?fileName="+ fileCallPath +"'>";
				str += "</div>"
				str += "</li>";
		});
		
		$(".image_box ul").html(str);
	}) 
	
	showList(1);
	
	function showList(page) {
		replyService.getList({bno:bnoValue, page:page||1}, function (data) {
			console.log(data);
			
			var replyCnt = data.replyCnt;
			
			if(page == -1) { // -1 --> crud작업이후 바로 일 경우,
				pageNum = Math.ceil(replyCnt/5.0);
				showList(pageNum);
				return;
			}
			
			$(".reply_ul").html("");
			
			var str= "";
			var loginuser = '<sec:authentication property="principal.username"/>';
			alert("loginuser is : " + loginuser)
			console.log(data);
			$(data.list).each(function(i, rep) {
				if(rep.thumbPhoto!="") {
		 			str += "<li class='reply_li'>";
					str += "<div class='reply_thumb_box'>";
					str += "<div class='thumb' style='background: url(/display?fileName=" + rep.thumbPhoto + ")no-repeat top center; background-size:cover; background-position: center'>";
					str += "</div>";
					str += "<span class='userid'>" + rep.replyer + "</span>";
					str += "</div> ";
					str += "<div class='reply_content_box'><span>" + rep.reply + "</span></div>";
					if(rep.replyer == loginuser) {
						str += '<button class="reply_close_btn" data-rno="' + rep.rno + '" data-replyer="' + rep.replyer + '"><i class="fa fa-times" aria-hidden="true"></i></button>';
					}
					str += "</li>";
				} else {
		 			str += "<li class='reply_li'>";
					str += "<div class='reply_thumb_box'>";
					str += "<div class='thumb'>";
					str += "<i class='fa fa-user-circle-o' aria-hidden='true'></i>";
					str += "</div>";
					str += "<span class='userid'>" + rep.replyer + "</span>";
					str += "</div> ";
					str += "<div class='reply_content_box'><span>" + rep.reply + "</span></div>";
					str += "</li>";
				}
			});         
			
			$(".reply_ul").prepend(str);
			
			showReplyPage(data.replyCnt); // 넘버링된 페이징 번호를 보여준다.
		}) // end function
	} // end showList()
		
	
	
	/* 댓글 페이징 처리 */
	var pageNum = 1;
	var replyPageFooter = $(".reply_paging_box");
	
	function showReplyPage(replyCnt) {
		
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;
		
		var prev = startNum != 1;
		var next = false;
		
		if(endNum*5 >= replyCnt) {
			endNum = Math.ceil(replyCnt/5.0);
		}
		
		if(endNum*5 < replyCnt) {
			next = true;
		}
		var str = "<ul class='pagination pull-right'>";
		
		if(prev) {
			str += "<li class='page-item'><a class='page-link' href='" + (startNum -1) + "'>Previous</a></li>";
		}
		for(var i = startNum; i <= endNum; i++) {
			var active = pageNum == i ? "active" : "";
			str += "<li class='page-item "+ active + "'><a class='page-link' href='"+ i + "'>" + i + "</a></li>";
		}
		
		if(next) {
			str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
			str += "</ul></div>";
			
			console.log(str);
		}
		replyPageFooter.html(str);
	}
		
	/* 댓글 페이지 번호 클릭 이벤트*/
	replyPageFooter.on("click", "li a", function(e) {
		e.preventDefault();
		var targetPageNum = $(this).attr("href");
		console.log("targetPageNum : " + targetPageNum);
		pageNum = targetPageNum;
		showList(targetPageNum);
	});	
})

</script>

<title>Insert title here</title>
</head>
<body>
<jsp:include page="../inc/top.jsp" flush="true"></jsp:include>
	
<div class="page_wrap">
	<div class="container page_container">
		<div class="title_wrap">
			<h2 class="wrap-inner main_tit title-font">사진</h2>
		</div>
		
		<div class="sub_title title-font">
		<h3>
			"그래서 우리는 위로를 받았습니다.<br> 
			또한 우리가 받은 위로 위에 디도의 기쁨이 겹쳐서, 우리는 더욱 기뻐하게 되었습니다.<br>
			 그는 여러분 모두로부터 환대를 받고, 마음에 안정을 얻었던 것입니다."<br>
			고린도후서 7장 13절.
		 </h3>
		</div>
		
		<div class="content">
			<div class="list_wrap notice_get_wrap">
				<div id="table">
				
					<div class="row notice_title">
						${photo.title }
					</div>
					
					<div class="row notice_info">
						<div class="row notice_writer">
							${photo.writer }
						</div>
						
						<div class="row notice_date">
							<fmt:formatDate pattern="yyyy-MM-dd" value="${photo.regdate}"/>
						</div>
					</div>
					
					<div class="row notice_content_box">
						<div class="notice_content">
							${photo.content }
						</div>
						
						<div class="image_box">
							<ul>
							</ul>
						</div>
					</div>
					
					<div class="row bottom_wrap">
						<ul class="reply_ul">
						</ul>
						<div class="reply_paging_box">
						</div>
						<div class="reply_write_li">
							<sec:authorize access="isAuthenticated()">
								<div class="reply_thumb_box">
									<div class="thumb" style="background: url(/display?fileName=<sec:authentication property="principal.member.thumbPhoto"/>)no-repeat top center; background-size:cover; background-position: center">
									</div>
								</div>
								<div class="reply_write_box">
									<textarea placeholder="새로운 댓글을 작성해보세요!"></textarea>
									<div class="reply_btn_box">
										<button class="btn small_btn reply_btn">댓글 올리기</button>
									</div>
								</div>
							</sec:authorize>
								
							<sec:authorize access="isAnonymous()">
								<div class="reply_write_box">
									<textarea placeholder="댓글을 작성하시려면, 로그인 하셔야 합니다." readonly="readonly"></textarea>
								</div>
							</sec:authorize>
						</div>

					
						<div class="notice_btn">
							<ul>
							</ul>
							<button class="btn normal_btn" data-oper="list">목록</button>
							<sec:authorize access="isAuthenticated()">
								<sec:authentication property="principal.member.userid" var="loginuserid"/>
								<c:if test="${photo.writer eq loginuserid }">
									<button class="btn normal_btn" data-oper="modify">수정</button>
								</c:if>
							</sec:authorize>
						</div>
					</div>
					
				<form id="openForm" action="/photo/modify" method="post">
					<input type="hidden" id="bno" name="bno" value='<c:out value="${photo.bno}"/>' /> 
					<input type="hidden" id="writer" name="writer" value='<c:out value="${photo.writer}"/>' /> 
					<input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum}"/>'> 
					<input type="hidden" id="amount" name="amount" value='<c:out value="${cri.amount}"/>'> 
					<input type="hidden" id="keyword" name="keyword" value='<c:out value="${cri.keyword}"/>'> 
					<input type="hidden" id="type" name="type" value='<c:out value="${cri.type}"/>' />
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
				</div>
			</div>
		</div>
	</div>	
	<jsp:include page="../inc/footer.jsp" flush="true"></jsp:include>
</div>
</body>
</html>