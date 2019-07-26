<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<jsp:include page="inc/headTop.jsp" flush="true"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here1</title>
</head>
<body>
	<!-- <div class="login background_wrap"></div> -->
	<jsp:include page="inc/top.jsp" flush="true"></jsp:include>
	<div class="page_wrap">
		<div class="login_wrap">
			<h2><c:out value="${error}" /></h2>
			<h2><c:out value="${logout}"/></h2>	
			
			<span class="top_title">EVERY WALL</span>
			<span class="mid_title">IS A DOOR</span>
			<span class="bottom_title">모든 벽은 문 이다.</span>
			<div class="login_content">
				<form method="post" action="/login">
					<div>
						<input class="login_div input_area" type="text" name="username" value="admin90" placeholder="ID">
					</div>
					
					<div>
						<input class="login_div input_area" type="password" name="password" value="pw90" placeholder="PASSWORD">
					</div>
					
					<div class="input_check">
						<input  type="checkbox" name="remember-me"><span>Remember Me!</span>
					</div>
					
					<div>
						<input class="input_area_button" type="submit" value="로그인">
					</div>
					
					<div class="input_check">
						<a href="/customSignup"><span>회원가입</span></a>
					</div>
					
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					
				</form>
			</div>
		</div>
		<jsp:include page="inc/footer.jsp" flush="true"></jsp:include>
	</div>
	
</body>
</html>