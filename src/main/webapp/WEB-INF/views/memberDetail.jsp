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

			/* input박스 null값 체크 */
			var inputArea = $(".input_area");
			for(var i=0; i < inputArea.length; i++) {
				console.log(inputArea[i].value);
				if(inputArea[i].value == "") {
					alert("입력하지 않은 정보가 있습니다.");
					return;
				}
			}
			
			/* 비밀번호 확인 체크 */
			var pw = $(".password").val();
			var pwConfirm = $(".password_confirm").val();
			if(pw != pwConfirm) {
				alert("비밀번호 확인 값을 다르게 입력하셨습니다.");
				return;
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
		
		<div class="profile_wrap">
			<div class="thumb" style="background: url(https://source.unsplash.com/QAB-WJcbgJk/60x60)no-repeat top center; background-size: cover; background-position: center;">
			</div>
		</div>
		<div class="login_content">
			<form role="form" method="post" action="/memberDetail">
				<div>
					<span>이름</span>
					<input class="input_area" type="text" name="username" value="<sec:authentication property="principal.member.username"/>" readonly="readonly">
				</div>
			
				<div>
					<span>아이디</span>
					<input class="input_area" type="text" name="userid" value="<sec:authentication property="principal.member.userid"/>" readonly="readonly">
				</div>
				
				<div>
					<input class="input_area_button" type="submit" value="확인">
				</div>
				
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</div>
	</div>
	
	<jsp:include page="inc/footer.jsp" flush="true"></jsp:include>
	</div>
</body>
</html>