<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../inc/headTop.jsp" flush="true"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../inc/top.jsp" flush="true"></jsp:include>
	
	
	<div class="container">
		<section class="title">
			<h2 class="wrap-inner main_tit">공지사항</h2>
		</section>
		
		<section class="content">
			<div class="list-wrap">
				<ul>
				
					<c:forEach items="${noticeList}" var="notice">
						<li><c:out value="${notice.title}"></c:out></li>
						<li><c:out value="${notice.regdate}"></c:out></li>
					
					</c:forEach>
				

				</ul>
			</div>
		
		</section>
	</div>

<jsp:include page="../inc/footer.jsp" flush="true"></jsp:include>
</body>
</html>