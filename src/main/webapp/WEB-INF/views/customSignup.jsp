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
			validate();
			return;
			formObj.submit();
		})
		
		function validate() {
			var re = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
			var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		     // 이메일이 적합한지 검사할 정규식
			
		    var name = $("input[name='username']").val();
		    var email = $("input[name='useremail']").val();
			var id = $("input[name='userid']").val();
			var pw = $("input[name='userpw']").val();
			//var email = document.getElementById("email");
		     // ------------ 이메일 까지 -----------
		    
		     console.log(name + id + pw);
		     
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
				$(".password_confirm").val("");
				$(".password_confirm").focus();
				return;
			}
			
		     if(!check(re2,email,"적합하지 않은 이메일 형식입니다.")) {
		         return false;
		     }
		     
		     if(!check(re,name,"아이디는 4~12자의 영문 대소문자와 숫자로만 입력")) {
		         return false;
		     }
		     
		     if(!check(re,id,"아이디는 4~12자의 영문 대소문자와 숫자로만 입력")) {
		         return false;
		     }
		
		     if(!check(re,pw,"패스워드는 4~12자의 영문 대소문자와 숫자로만 입력")) {
		         return false;
		     }
		     // 관심분야, 자기소개 미입력시 하라는 메시지 출력
		     /* 
		     if(join.self.value=="") {
		         alert("자기소개를 적어주세요");
		         join.self.focus();
		         return false;
		     }
		      */
		     alert("회원가입이 완료되었습니다.");
		 }
		
		 function check(re, what, message) {
		     if(re.test(what)) {
		         return true;
		     }
		     alert(message);
		     what.value = "";
		     //return false;
		 }
		
	})

</script>

</head>
<body>

	<jsp:include page="inc/top.jsp" flush="true"></jsp:include>
	<div class="page_wrap login">
	<div class="layer">
		<div class="login_wrap title-font">
			<h2><c:out value="${error}" /></h2>
			<h2><c:out value="${logout}"/></h2>	
			
			<span class="top_title">EVERY WALL</span>
			<span class="mid_title">IS A DOOR</span>
			<span class="bottom_title">모든 벽은 문 이다</span>
			<div class="login_content">
				<form role="form" method="post" action="/customSignup">
					<div>
						<input class="login_div input_area" type="text" name="username" placeholder="NAME">
					</div>
				
					<div>
						<input class="login_div input_area" type="text" name="userid" placeholder="ID">
					</div>
					
					<div>
						<input class="login_div input_area" type="text" name="useremail" placeholder="EMAIL">
					</div>
					
					<div>
						<input class="login_div input_area password" type="password" name="userpw" placeholder="PASSWORD">
					</div>
					
					<div>
						<input class="login_div input_area password_confirm" type="password" placeholder="PASSWORD CONFIRM">
					</div>
					
					<div>
						<input class="input_area_button" type="submit" value="가입하기">
					</div>
					
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<!-- <input type="hidden" name="authList[0].auth" value="ROLE_USER" /> -->
				</form>
			</div>
		</div>
	</div>
	
	<jsp:include page="inc/footer.jsp" flush="true"></jsp:include>
	</div>
</body>
</html>