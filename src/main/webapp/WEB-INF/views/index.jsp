<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.zerock.domain.*"%>
<jsp:include page="inc/headTop.jsp" flush="true"></jsp:include>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<script type="text/javascript">
		    $(window).scroll(function() {
				  var s_top = jQuery(".main_visual").innerHeight();
				  //alert(s_top);
				  var con_top = jQuery("#section01").innerHeight();
					if ( $(this).scrollTop() < s_top && !$('.slider').hasClass("fixed")){
						$('.slider').addClass("fixed");
				  //alert(con_top);
				}else if ( $(this).scrollTop() > s_top && $('.slider').hasClass("fixed")){
					$('.slider').removeClass("fixed");
				}
			});
		    
		    $(window).scroll(function() {
		      	if ($(this).scrollTop() > 1){
		      		$('.scroll_btn').fadeOut();
		      	}else{
		      		$('.scroll_btn').fadeIn();
		      	}
		      });
		    
		    
			$(document).ready(function() {
				 $('.swipe_wrap').bxSlider({
					mode: 'horizontal',// 가로 방향 수평 슬라이드
					speed: 500,        // 이동 속도를 설정
					pause: 2000,        // 페이지 넘김 속도를 조절
					pager: true,      // 현재 위치 페이징 표시 여부 설정
					moveSlides: 1,     // 슬라이드 이동시 개수
					slideWidth: 300,   // 슬라이드 너비
					minSlides: 4,      // 최소 노출 개수
					maxSlides: 4,      // 최대 노출 개수
					slideMargin: 10,    // 슬라이드간의 간격
					auto: false,        // 자동 실행 여부
					autoHover: true,   // 마우스 호버시 정지 여부
					controls: true,    // 이전 다음 버튼 노출 여부
					responsive: false,
					touchEnabled : (navigator.maxTouchPoints > 0)
				});
				 
				var actionForm = $("#actionForm");
				$(".move").on("click", function(e) {
					e.preventDefault();
					console.log($(this).attr('href'));
					actionForm.append("<input type='hidden' name='bno' value='"+ $(this).attr('href') +"'>");
					actionForm.attr("action", "/notice/get");
					actionForm.submit();
					
				})
				 
			})
			
		</script>
	
	</head>

	<body>
		<jsp:include page="inc/top.jsp" flush="true"></jsp:include>
	
		<div class="wrap">
			<div class="main_visual_wrap">
	
				<div class="main_visual">
					<div class="slider fixed">
						<div class="main_slg" alt="메인사진, 슬로건">
						</div>
						
						<div class="scroll_btn" style="display: block;">
					        <span class="mouse">
						        <span>
						        </span>
					        </span>
					        <p>scroll down</p>
				     	 </div>
						
					</div>
				</div>
			</div>
	
			<div class="section_wrap main_section">
		
				<section class="main_row1" id="section01">
					<div class="container">
						<h2 class="main_tit">NOTICE</h2>
						<a href="/notice/list">view more</a>
						<div class="notice_wrap">
							<ul class="swipe_wrap">
								<c:forEach items="${noticeList}" var="notice">
									<li>
										<div class="notice_box">
											<a class="move" href='<c:out value="${notice.bno}"/>'>
												<p class="main_notice"><c:out value="${notice.title}"></c:out></p>
												<p class="sub_notice"><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}" /></p>
											</a>
										</div>
									</li>
								</c:forEach> 
							</ul>
						</div>
					</div>
					
					<form id="actionForm" action="/notice/list" method="get">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
						<input type="hidden" name="type" value="${pageMaker.cri.type }">
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
					</form>
				</section>
				
				
				<section class="main_row2 even_row" id="section02">
					<div class="container">
						<h2 class="main_tit">Book</h2>
						<a class="view_btn" href="#">view more</a>
						<ul class="book_li">
							<li>
								<a>
									<div class="thumb">
										<img src="/resources/images/index/bookcoversample.png">
									</div>
									
									<div class="desc">
										<h3><span class="book_title">책제목</span></h3>
										<p class="book_author">저자</p>
									</div>
								</a>
							</li>
							
							<li>
								<a>
									<div class="thumb">
										<img src="/resources/images/index/bookcoversample.png">
									</div>
									
									<div class="desc">
										<h3><span class="book_title">책제목</span></h3>
										<p class="book_author">저자</p>
									</div>
								</a>
							</li>
							
							<li>
								<a>
									<div class="thumb">
										<img src="/resources/images/index/bookcoversample.png">
									</div>
									
									<div class="desc">
										<h3><span class="book_title">책제목</span></h3>
										<p class="book_author">저자</p>
									</div>
								</a>
							</li>						
						</ul>
	
					</div>
				</section>
				
				
				<section class="main_row3" id="section03">
					<div class="container">
						<h2 class="main_tit">Photo</h2>
						<a class="view_btn" href="#">view more</a>
						<ul class="gallery_li">
							
							<c:forEach items="${galleryList}" var="gallery" varStatus="galleryStatus">
								<c:forEach items="${gallery.attachList}" var="attach" varStatus="attachStatus">
										
									<c:if test="${attach.previewImg eq 1}"> <!-- 대표이미지가 설정된 경우 -->
										<li class="yesupload bg1"><!-- 업로드 완료 리스트 -->
											<a onclick="javascript:open_pop(this)">
									
												<c:set target="${attach}" property="wholeFilePath" value="${attach.uploadPath}/s_${attach.uuid}_${attach.fileName}" />
												<%
													GalleryAttachVO vo = (GalleryAttachVO)pageContext.getAttribute("attach");
													pageContext.setAttribute("imgPath", URLEncoder.encode(vo.getWholeFilePath()));
												%>
												<div class="thumb">
													<img src="/display?fileName=<c:url value='${imgPath}'/>">
												</div>
												
												<div class="desc">
													<h3><c:out value="${gallery.koreaName}"/></h3>
													<p><c:out value="${gallery.engName}"/></p>
													
												</div>
											</a>
										</li>
									</c:if>
									
									<c:if test="${attach.previewImg eq 0}"> <!-- 대표이미지가 설정되어 있지 않은 경우 -->
										<li class="noupload"><!-- 업로드 전 리스트 -->
											<a onclick="javascript:open_pop()">
									
												<div class="thumb">
													<i class="fa fa-question question" aria-hidden="true"></i>
												</div>
												
												<div class="desc">
													<h3><c:out value="${gallery.koreaName}"/></h3>
													<p><c:out value="${gallery.engName}"/></p>
												</div>
											</a>	
										</li>
									</c:if>									
									
									
								</c:forEach>
							</c:forEach> 
							
							
						</ul>
					</div>
				</section>


				<section class="main_row4 even_row" id="section04">
					<div class="container">
						<h2 class="main_tit">ABOUT US</h2>
						<ul>
							<li>
								<div class="icon">
									<img src="#" alt="단체소개">
								</div>
								<h3>단체소개</h3>
								<a class="more_btn" href="#">more</a>
							</li>
							<li>
								<div class="icon">
									<img src="#" alt="연혁">
								</div>
								<h3>연혁</h3>
								<a class="more_btn" href="#">more</a>
							</li>
							<li>
								<div class="icon">
									<img src="#" alt="함께하는이들">
								</div>
								<h3>함께하는이들</h3>
								<a class="more_btn" href="#">more</a>
							</li>
						</ul>
	
					</div>
				</section>

			</div>
		</div>
		<jsp:include page="./inc/footer.jsp" flush="true"></jsp:include>
	</body>
</html>