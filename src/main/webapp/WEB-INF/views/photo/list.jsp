<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.zerock.domain.*"%>

<jsp:include page="../inc/headTop.jsp" flush="true"></jsp:include>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<script>

$(document).ready(function() {
	var actionForm = $("#actionForm"); 
	$(".page_num").on("click", function(e) {
		e.preventDefault();
		console.log("click page_num !!!");
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	})
	
	
	var actionForm = $("#actionForm");
	$(".move").on("click", function(e) {
		e.preventDefault();
		console.log($(this).attr('href'));
		actionForm.append("<input type='hidden' name='bno' value='"+ $(this).attr('href') +"'>");
		actionForm.attr("action", "/notice/get");
		actionForm.submit();
		
	})
})
</script>

<title>Insert title here</title>
</head>
<body>
<jsp:include page="../inc/top.jsp" flush="true"></jsp:include>
	
	
	<div class="container page_container">
		<div class="title_wrap">
			<h2 class="wrap-inner main_tit">사진</h2>
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
			<ul class="gallery_li">
				<c:forEach var="photo" items="${photoList}">
					<c:forEach var="attach" items="${photo.attachList}">
					
						<c:set target="${attach}" property="wholeFilePath" value="${attach.uploadPath}/s_${attach.uuid}_${attach.fileName}" />	
						<%
							BoardAttachVO vo = (BoardAttachVO)pageContext.getAttribute("attach");
							pageContext.setAttribute("imgPath", URLEncoder.encode(vo.getWholeFilePath()));
						%>					
						<li class="yesupload bg1">
							<div class="thumbnail"> 
								<img src="/display?fileName=<c:url value='${imgPath}'/>"> 
							</div> 
							<div class="desc">
								<h3>${photo.title}</h3>
								<p>${photo.writer}</p>
							</div>
						</li>		
									
					</c:forEach>
				</c:forEach>
			</ul>
		</div>
		
		<div class="bottom_wrap">
			<div class="page_box">
				<ul>
					<c:if test="${pageMaker.prev}">
						<li class="page-item">
							<a class="page-link" href="${pageMaker.startPage -1}" aria-label="Previous">
					        	<span aria-hidden="true">&laquo;</span>
								<span class="sr-only">Previous</span>
							</a>
						</li>
					</c:if>
				
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="page-item ${pageMaker.cri.pageNum == num ? "active":""} "><a class="page_num" href="${num}">${num}</a></li>
					</c:forEach>
					
					<c:if test="${pageMaker.next}">
						<li class="page-item next">
							<a class="page-link" href="${pageMaker.endPage + 1}" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
	   							<span class="sr-only">Next</span>
							</a>
						</li>
					</c:if>
				</ul>
			</div>
			<div class="notice_btn">
				<button onclick="location.href='/notice/register'">새 공지 쓰기</button>
			</div>
		</div>
	</div>
		
	<form id="actionForm" action="/notice/list" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name="type" value="${pageMaker.cri.type }">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
	</form>

<jsp:include page="../inc/footer.jsp" flush="true"></jsp:include>
</body>
</html>