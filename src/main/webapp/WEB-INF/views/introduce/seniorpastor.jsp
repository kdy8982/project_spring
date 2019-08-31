<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@page import="java.net.URLEncoder"%>
<%@page import="org.zerock.domain.*"%>

<jsp:include page="../inc/headTop.jsp" flush="true"></jsp:include>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<script type="text/javascript" src="/resources/js/board.js"></script>
<script>
</script>

<title>Insert title here</title>
</head>
<body>
<jsp:include page="../inc/top.jsp" flush="true"></jsp:include>
	
<div class="page_wrap">
	<div class="container page_container">
		<div class="title_wrap">
			<h2 class="wrap-inner main_tit title-font">더사랑 교회</h2>
		</div>
		
		<div class="church_introduce_menubar">
			<div class="church_introduce_menu" style="text-decoration: underline; text-underline-position: under;">교회 소개</div>
			<div class="church_introduce_menu">담임목사</div>
			<div class="church_introduce_menu">사역</div>
			<div class="church_introduce_menu">예배 안내</div>
		</div>
		
		<div class="content church">
			<p>
			사랑의교회(옥한흠 목사)는 2001년 7월 22일 정기당회에서 옥한흠 목사가 "65세까지 담임 목사로 시무한 후 은퇴하겠다"는 발표 후 당회의 동의를 얻어 후임자 선정을 위한 준비 작업에 들어갔다. 이어 2002년 8월 25일 열린 정기당회에서는 오정현 목사 청빙 문제를 안건으로 남녀 순장을 대상으로 투표를 실시키로 결의했다.<br>
그러나 여러 가지 사정으로 투표를 실시하지 못하고, 옥한흠 목사가 남녀 순장 1,700명에게 오정현 목사 청빙에 대한 취지를 설명하는 편지를 발송하고 순장반에서 재차 설명함으로써 순장들의 동의를 구했다. 이후 오정현 목사 청빙을 위한 준비 작업이 순조롭게 진행되는 가운데 2003년 3월 16일 열린 정기당회에서는 오정현 목사를 사랑의교회 위임목사로 청빙키로 가결하고, 청빙위원을 선출하는 한편 장로들의 연명으로 청빙서를 작성키로 결의했다. 이날 당회에서 선출된 청빙위원은 이민희, 김병채, 김광석, 김진석, 홍종진, 백운동 장로 등 6명으로 이들은 6월 13일부터 16일까지 남가주사랑의교회를 방문했다</p>
			<p class="imgp"><img src="/resources/images/index/index2.jpg"></img></p>
		</div>
	</div>
	<jsp:include page="../inc/footer.jsp" flush="true"></jsp:include>
</div>
	
	<div id="mask"></div>
		
	<form id="actionForm" action="/photo/list" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name="type" value="${pageMaker.cri.type }">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
	</form>
	


</body>
</html>