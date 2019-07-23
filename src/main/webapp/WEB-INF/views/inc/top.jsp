<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script>
$(document).ready(function() {
	$(".login_area").mouseenter(function() {
		$(".member_dropmenu").css("display", "block");
	});
	
	$(".login_area").mouseleave(function() {
		$(".member_dropmenu").css("display", "none");
	})
	
})

</script>

<header id="header">
	<div class="header_inner">
		<!-- <h1><a href="/"><img alt="the Love Comunity"></a></h1> -->
		<a class="top_title" href="/">The Love Comunity</a>
		<nav>
			<ul>
				<!-- <li><a href="#">The Love Comunity</a></li> -->
				<li><a href="/notice/list">새소식</a></li>
				<li><a href="/photo/list">사진</a></li>
				<li><a href="/book/list">더사랑 이야기</a></li>
				<li class="login_area">				
					<sec:authorize access="isAuthenticated()">
						<div>
						<sec:authentication property="principal.member.userName"/>
						<img class="img-profile" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
						</div>
						<ul class="member_dropmenu">
							<li><i class="fa fa-user user_mark" aria-hidden="true"></i>내 정보 관리</li>
							<li><i class="fa fa-sign-out user_mark" aria-hidden="true"></i><a href="/customLogout">로그아웃</a></li>
						</ul>
					</sec:authorize>
					
					<sec:authorize access="isAnonymous()">
						<a href="/customLogin"><span alt="로그인">로그인</span></a>
					</sec:authorize>
				</li>
				
			</ul>

			</div>
		</nav>
	</div>
</header>

<aside id="btn_top">
	<span>TOP</span>
</aside>