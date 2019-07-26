<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.zerock.domain.*"%>
<jsp:include page="inc/headTop.jsp" flush="true"></jsp:include>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	$(window).scroll(
			function() {
				var s_top = jQuery(".main_visual").innerHeight();
				//alert(s_top);
				var con_top = jQuery("#section01").innerHeight();
				if ($(this).scrollTop() < s_top
						&& !$('.slider').hasClass("fixed")) {
					$('.slider').addClass("fixed");
					//alert(con_top);
				} else if ($(this).scrollTop() > s_top
						&& $('.slider').hasClass("fixed")) {
					$('.slider').removeClass("fixed");
				}
			});

	$(window).scroll(function() {
		if ($(this).scrollTop() > 1) {
			$('.scroll_btn').fadeOut();
		} else {
			$('.scroll_btn').fadeIn();
		}
	});

	$(document)
			.ready(
					function() {
						$('.swipe_wrap').bxSlider({
							mode : 'horizontal',// 가로 방향 수평 슬라이드
							speed : 500, // 이동 속도를 설정
							pause : 2000, // 페이지 넘김 속도를 조절
							pager : true, // 현재 위치 페이징 표시 여부 설정
							moveSlides : 1, // 슬라이드 이동시 개수
							slideWidth : 300, // 슬라이드 너비
							minSlides : 4, // 최소 노출 개수
							maxSlides : 4, // 최대 노출 개수
							slideMargin : 10, // 슬라이드간의 간격
							auto : false, // 자동 실행 여부
							autoHover : true, // 마우스 호버시 정지 여부
							controls : true, // 이전 다음 버튼 노출 여부
							responsive : false,
							touchEnabled : (navigator.maxTouchPoints > 0)
						});

						var actionForm = $("#actionForm");
						$(".move")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											console.log($(this).attr('href'));
											actionForm
													.append("<input type='hidden' name='amount' value='"
															+ $(this).data(
																	'amount')
															+ "'>");
											actionForm
													.append("<input type='hidden' name='bno' value='"
															+ $(this).attr(
																	'href')
															+ "'>");
											actionForm
													.append("<input type='hidden' name='boardType' value='"
															+ $(this).data(
																	'type')
															+ "'>");
											actionForm.attr("action", $(this)
													.data("url"));
											actionForm.submit();

										})


					})
</script>

</head>

<body>
	<jsp:include page="inc/top.jsp" flush="true"></jsp:include>

	<div class="page_wrap">
		<div class="main_visual_wrap">

			<div class="main_visual">
				<div class="slider fixed">
					<div class="main_slg" alt="메인사진, 슬로건"></div>

					<div class="scroll_btn" style="display: block;">
						<span class="mouse"> <span> </span>
						</span>
						<p>scroll down</p>
					</div>

				</div>
			</div>
		</div>

		<div class="section_wrap main_section">

			<section class="main_row1" id="section01">
			<div class="container">
				<div class="title_wrap">
					<h2 class="main_tit">새소식</h2>
				</div>

				<div class="notice_wrap">
					<ul class="swipe_wrap">
						<c:forEach items="${noticeList}" var="notice">
							<li>
								<div class="notice_box">
									<a class="move" href='<c:out value="${notice.bno}"/>'
										data-type="notice" data-url="/notice/get" data-amount="10">
										<p class="main_notice">
											<c:out value="${notice.title}"></c:out>
										</p>
										<p class="sub_notice">
											<fmt:formatDate pattern="yyyy-MM-dd"
												value="${notice.regdate}" />
										</p>
									</a>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div class="viewmore_wrap">
					<a class="viewmore_btn" href="/notice/list">view more</a>
				</div>
			</div>
			</section>


			<section class="main_row2 even_row" id="section03">
			<div class="container">
				<div class="title_wrap">
					<h2 class="main_tit">사진</h2>
				</div>
				<ul class="gallery_li">
					<c:forEach var="photo" items="${photoList}" varStatus="status">
						<a class="move" href="${photo.bno}" data-type="photo"
							data-url="/photo/get" data-amount="12">
							<li class="yesupload bg1"><c:set var="attach"
									value="${photo.attachList[0].uploadPath}/s_${photo.attachList[0].uuid}_${photo.attachList[0].fileName}" />
								<%
									String url = (String) pageContext.getAttribute("attach");
										pageContext.setAttribute("filepath", URLEncoder.encode(url));
								%>
								<div class="thumb"
									style="background: url(/display?fileName=<c:url value='${filepath}'/>)no-repeat top center; background-size: cover; background-position: center;">
									<p class="photo-cntbox">
										<i class="fa fa-camera-retro" aria-hidden="true"></i>
										+${photoCount[status.index]}
									</p>
								</div>
								<div class="desc">
									<h3>${photo.title}</h3>
									<p>${photo.writer}</p>
								</div></li>
						</a>
					</c:forEach>
				</ul>

				<a class="viewmore_btn" href="/photo/list?amount=12">view more</a>
			</div>
			</section>


			<section class="main_row3 " id="section03">
			<div class="container">

				<div class="title_wrap">
					<h2 class="main_tit">더사랑 이야기</h2>
				</div>
				<ul class="book_li">

					<c:forEach var="essay" items="${essayList}">
						<li><a class="move" href="<c:out value='${essay.bno}'/>" data-amount="12" data-type="essay" data-url="/essay/get"> 
						<c:set var="attach"	value="${essay.attachList[0].uploadPath}/s_${essay.attachList[0].uuid}_${essay.attachList[0].fileName}" />
								<%
									String url = (String) pageContext.getAttribute("attach");
										pageContext.setAttribute("filepath", URLEncoder.encode(url));
								%>
								<div class="thumb"
									style="background: url(/display?fileName=<c:url value='${filepath}'/>)no-repeat top center; background-size: cover; background-position: center;">
								</div> <c:set var="subsContent" value="${essay.content}" /> <%
 	String subStr = (String) pageContext.getAttribute("subsContent");
 		if (subStr.length() > 150) {
 			subStr = subStr.substring(0, 150) + " ...";

 		}
 		pageContext.setAttribute("subsContent", subStr);
 %>
								<div class="desc">
									<span class="book_title">${essay.title}</span>
									<p>${subsContent}</p>
								</div>
						</a></li>

					</c:forEach>

				</ul>
				<div class="viewmore_wrap">
					<a class="viewmore_btn" href="/essay/list">view more</a>
				</div>
			</div>
			</section>


			<section class="main_row4 even_row" id="section04">
			<div class="container">

				<div class="title_wrap">
					<h2 class="main_tit">ABOUT US</h2>
				</div>
				<ul>
					<li>
						<div class="icon">
							<img src="#" alt="단체소개">
						</div>
						<h3>단체소개</h3> <a class="more_btn" href="#">more</a>
					</li>
					<li>
						<div class="icon">
							<img src="#" alt="연혁">
						</div>
						<h3>연혁</h3> <a class="more_btn" href="#">more</a>
					</li>
					<li>
						<div class="icon">
							<img src="#" alt="함께하는이들">
						</div>
						<h3>함께하는이들</h3> <a class="more_btn" href="#">more</a>
					</li>
				</ul>
			</div>
			</section>
		</div>
	<jsp:include page="./inc/footer.jsp" flush="true"></jsp:include>
	</div>

	<form id="actionForm" action="/notice/list" method="get">
		<input type="hidden" name="pageNum" value="1">
	</form>

</body>
</html>