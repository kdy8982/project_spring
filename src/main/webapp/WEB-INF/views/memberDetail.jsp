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
			console.log("pw : " + pw);
			console.log("pw confirm : " + pwConfirm);
			if(pw != pwConfirm) {
				alert("비밀번호 확인 값을 다르게 입력하셨습니다.");
				return;
			}
			
			formObj.submit();
		})
		
		var result = '<c:out value="${result}"/>';
		checkModal(result);

		function checkModal(result) {
			if (result === "") {
				return;
			}
			if (parseInt(result) > 0) {

			} else {
				wrapWindowByMask();
			}
		}

		function wrapWindowByMask() {
			//화면의 높이와 너비를 구한다.
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();

			//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
			$('#mask').css({
				'width' : maskWidth,
				'height' : maskHeight
			});

			$('#mask').fadeTo("slow", 0.8);
			
			
			$('.modal_body').html(result);
			//모달 같은 거 띄운다.
			$('.modal').css("display", "block");
			//$(".modal").show();
		}

		$(".normal_btn.close").on("click", function() {
			$(".modal").css("display", "none");
			$("#mask").css("display", "none");
		})
		
	})
	
	function showPasswordChange() {
		$(".hidden_div").css("display", "block");
		$(".show_div").css("display", "none");
	} 


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
			<form role="form" method="post" action="/memberModify">
				<div class="login_div">
					<span>이름</span>
					<input class="input_area" type="text" name="username" value="<sec:authentication property="principal.member.username"/>" readonly="readonly">
				</div>
			
				<div class="login_div">
					<span>아이디</span>
					<input class="input_area" type="text" name="userid" value="<sec:authentication property="principal.member.userid"/>" readonly="readonly">
				</div>
				
				<div class="login_div hidden_div" style="display: none">
					<span>현재 비밀번호</span>
					<input class="input_area" type="password" name="userpw" value="">
				</div>
				
				<div class="login_div hidden_div" style="display: none">
					<span>새로운 비밀번호</span>
					<input class="input_area password" type="password" name="newpw" value="">
				</div>
				
				<div class="login_div hidden_div" style="display: none">
					<span>새로운 비밀번호 확인</span>
					<input class="input_area password_confirm" type="password" value="">
				</div>
				
				<div class="login_div input_check show_div">
					<span onclick="showPasswordChange()">비밀번호 변경</span>
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
	
	<div class="modal">
			<div class="modal_header row">
				<div class="modal_title">알림</div>
				<!-- <button class="close_btn"><i class="fa fa-times" aria-hidden="true"></i></button> -->
			</div>

			<div class="modal_body row">정상적으로 처리 되었습니다.</div>

			<div class="modal_footer row">
				<button class="btn normal_btn close">확인</button>
			</div>
		</div>
	<div id="mask"></div>
</body>
</html>