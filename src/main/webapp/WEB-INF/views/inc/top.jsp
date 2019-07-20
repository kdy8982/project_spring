<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

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
			</ul>
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal.member.userName"/>
				<img class="img-profile" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
			</sec:authorize>
			
			<sec:authorize access="isAnonymous()">
				<a class="login_area" href="/customLogin"><span alt="로그인">로그인</span></a>
			</sec:authorize>
		</nav>
	</div>
</header>

<aside id="btn_top">
	<span>TOP</span>
</aside>