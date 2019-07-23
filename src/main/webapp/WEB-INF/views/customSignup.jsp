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


<script type="text/javascript">
	$(document).ready(function() {
		
		var formObj = $("form[role='form']");
		
		$(".input_area_button").on("click", function(e) {
			e.preventDefault();
			var pw = $(".password").val();
			var pwConfirm = $(".password_confirm").val();
			if(pw != pwConfirm) {
				alert("값이 다르네요");
				return;
			} else {
				alert("같은 값이네요");
			}
			
			formObj.submit();
		})
	})

</script>

</head>
<body>

	<jsp:include page="inc/top.jsp" flush="true"></jsp:include>
	<div class="page_wrap">
	<div class="login background_wrap">
	</div>
	<div class="login_wrap">
		<h2><c:out value="${error}" /></h2>
		<h2><c:out value="${logout}"/></h2>	
		
		<span class="top_title">EVERY WALL</span>
		<span class="mid_title">IS A DOOR</span>
		<span class="bottom_title">모든 벽은 문	이다.</span>
		<div class="login_content">
			<form role="form" method="post" action="/customSignup">
				<div>
					<input class="input_area" type="text" name="username" placeholder="NAME">
				</div>
			
				<div>
					<input class="input_area" type="text" name="userid" placeholder="ID">
				</div>
				
				<div>
					<input class="input_area password" type="password" name="userpw" placeholder="PASSWORD">
				</div>
				
				<div>
					<input class="input_area password_confirm" type="password" placeholder="PASSWORD CONFIRM">
				</div>
				
				<div>
					<input class="input_area_button" type="submit" value="로그인">
				</div>
				
				<div class="input_check">
					<a><span>회원가입</span></a>
				</div>	
				
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				
			</form>
		</div>
	</div>
	
	<jsp:include page="inc/footer.jsp" flush="true"></jsp:include>
	</div>
</body>
</html>