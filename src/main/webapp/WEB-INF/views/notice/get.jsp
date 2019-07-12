<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../inc/headTop.jsp" flush="true"></jsp:include>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<script>

$(document).ready(function() {
	
	var openForm = $("#openForm");
	$("button[data-oper='list']").on("click", function(e) {
		e.preventDefault();
		openForm.find("#bno").remove();
		openForm.attr("action", "/notice/list");
		openForm.submit();
	})
	
	$("button[data-oper='modify']").on("click",function(e) {
		e.preventDefault();
		openForm.append("<input type='hidden' id='boardType' name='boardType' value='notice'>")
		openForm.attr("action", "/notice/modify").submit();
	})
	
	
	/* 첨부파일 조회 AJAX */
	
	var bno = '<c:out value="${notice.bno}"/>';
	$.getJSON("/board/getAttachList" , {bno : bno}, function (arr) {
		console.log(arr);
		
		var str="";
		
		$(arr).each(function(i, attach) {
			//image type (썸네일)
			if(attach.fileType) {
				var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+ "_" + attach.fileName);
				
				str += "<li class='image_li' data-path='"+ attach.uploadPath +"' data-uuid='"+ attach.uuid +"' data-filename='"+ attach.fileName +"' data-type='"+ attach.fileType +"' >";
				str += "<div>";
				str += "<img src='/display?fileName="+ fileCallPath +"'>";
				str += "</div>"
				str += "</li>";
			} else {
				str += "<li data-path ='"+ attach.uploadPath +"' data-uuid='"+ attach.uuid +"' data-filename='"+ attach.fileName +"' data-type ='"+ attach.fileType + "'>";
				str += "<div>"
				str += "<img src='/resources/img/attach.png'>"
				str += "</div>"
				str += "</li>"
			}
		});
		
		$(".uploadResult ul").html(str);
	})
})


</script>

<title>Insert title here</title>
</head>
<body>
<jsp:include page="../inc/top.jsp" flush="true"></jsp:include>
	
	
	<div class="container page_container">
		<div class="title_wrap">
			<h2 class="wrap-inner main_tit">새소식</h2>
		</div>
		
		<div class="sub_title">
		<h3>
			"그래서 우리는 위로를 받았습니다.<br> 
			또한 우리가 받은 위로 위에 디도의 기쁨이 겹쳐서, 우리는 더욱 기뻐하게 되었습니다.<br>
			 그는 여러분 모두로부터 환대를 받고, 마음에 안정을 얻었던 것입니다."<br>
			고린도후서 7장 13절
		 </h3>
		</div>
		
		<div class="content">
			<div class="list_wrap notice_get_wrap">
				<div id="table">
				
					<div class="row notice_title">
						${notice.title }
					</div>
					
					<div class="row notice_date">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}"/>
					</div>
					
					<div class="row notice_content_box">
						<div class="notice_content">
							${notice.content }
						</div>
						
					<div class="uploadResult">
						<ul>
						</ul>
					</div>
					</div>
					
					<div class="row bottom_wrap">
						<div class="notice_btn">
							<button data-oper="list">목록</button>
							<button data-oper="modify">수정</button>
							<button onclick="location.href='/notice/delete?bno=' + ${notice.bno}">삭제</button>
						</div>
					</div>
					
				<form id="openForm" action="/notice/modify" method="get">
					<input type="hidden" id="bno" name="bno" value='<c:out value="${notice.bno}"/>' /> 
					<input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum}"/>'> 
					<input type="hidden" id="amount" name="amount" value='<c:out value="${cri.amount}"/>'> 
					<input type="hidden" id="keyword" name="keyword" value='<c:out value="${cri.keyword}"/>'> 
					<input type="hidden" id="type" name="type" value='<c:out value="${cri.type}"/>' />
				</form>
					
				</div>
			</div>
		</div>
	</div>
		
<jsp:include page="../inc/footer.jsp" flush="true"></jsp:include>
</body>
</html>