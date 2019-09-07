<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<jsp:include page="../inc/headTop.jsp" flush="true"></jsp:include>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<script>

$(document).ready(function() {
	console.log($(".notice_content"));
	console.log($(".notice_content").get(0).innerText)
	
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
		openForm.attr("action", "/essay/list");
		openForm.submit();
	})
	
	$("button[data-oper='modify']").on("click",function(e) {
		e.preventDefault();
		openForm.attr("action", "/essay/modify").submit();
	})
	
})


</script>

<title>Insert title here</title>
</head>
<body>
<jsp:include page="../inc/top.jsp" flush="true"></jsp:include>
		
	<div class="page_wrap">
		<div class="title_wrap essay">
			<div class="main_title_wrap">
				<h2 class="wrap-inner main_title normal-font">더사랑 이야기</h2>
			</div>
			<div class="sub_title_wrap title-font">
				<span>
				"그래서 우리는 위로를 받았습니다.<br> 
				또한 우리가 받은 위로 위에 디도의 기쁨이 겹쳐서, 우리는 더욱 기뻐하게 되었습니다.<br>
				 그는 여러분 모두로부터 환대를 받고, 마음에 안정을 얻었던 것입니다."<br>
				고린도후서 7장 13절
				</span>
			</div>
		</div>
		<div class="container page_container">
			<div class="content">
				<div class="list_wrap notice_get_wrap">
					<div id="table">
					
						<div class="row notice_title">
							${essay.title }
						</div>
						
						<div class="row notice_info">
							<div class="row notice_writer">
								${essay.writer }
							</div>
							
							<div class="row notice_date">
								<fmt:formatDate pattern="yyyy-MM-dd" value="${essay.regdate}"/>
							</div>
						</div>
						
						<div class="row notice_content_box">
							<div class="notice_content">
								${essay.content }
							</div>
						</div>
						
						<div class="row bottom_wrap">
							<div class="notice_btn">
								<button class="btn normal_btn" data-oper="list">목록</button>
								<sec:authorize access="isAuthenticated()">
									<sec:authentication property="principal.member.userid" var="loginuserid"/>
									<c:if test="${essay.writer eq loginuserid }">
										<button class="btn normal_btn" data-oper="modify">수정</button>
									</c:if>
								</sec:authorize>
							</div>
						</div>
						
					<form id="openForm" action="/essay/modify" method="post">
						<input type="hidden" id="bno" name="bno" value='<c:out value="${essay.bno}"/>' />
						<input type="hidden" id="writer" name="writer" value='<c:out value="${essay.writer}"/>' />  
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