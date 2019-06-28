<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
		<div class="title">
			<h2 class="wrap-inner main_tit">NOTICE</h2>
		</div>
		
		<div class="content">
			<div class="list_wrap notice_wrap">
				<table class ="notice_table">
					<colgroup>
						<col width="60%">
						<col width="40%">
					</colgroup>
					<thead>
						<tr>
							<th class="title">소식</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${noticeList}" var="notice" varStatus="status" >
							<c:if test="${status.count % 2 == 1}">
								<tr>
									<td class="even"><c:out value="${notice.title}"></c:out></td>
									<td class="even"><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}" /></td>
								</tr>
							</c:if>
													
							<c:if test="${status.count % 2 == 0}">
								<tr>
									<td><c:out value="${notice.title}"></c:out></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}" /></td>
								</tr>
							</c:if>

						</c:forEach>
					</tbody>
				</table>
			</div>
		
		</div>
	</div>

<jsp:include page="../inc/footer.jsp" flush="true"></jsp:include>
</body>
</html>