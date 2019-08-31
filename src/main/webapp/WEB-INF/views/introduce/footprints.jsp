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
function showModal() {
	wrapWindowByMask();
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
	
	$('.modal').css("display", "block");
	//$(".modal").show();
	
	$('html, body').css({'overflow': 'hidden', 'height': '100%'}); // 모달팝업 중 html,body의 scroll을 hidden시킴
	$('.page_wrap').on('scroll touchmove mousewheel', function(e) { // 터치무브와 마우스휠 스크롤 방지     
		e.preventDefault();    
		e.stopPropagation();     
		return false; 
	});
	
}

$(document).ready(function() {
    var now = new Date();
    var nyear = now.getFullYear();
    var nmon = (now.getMonth()+1) > 9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);          
    
    //년도 selectbox만들기               
    for(var sy = 2002 ; sy <= nyear ; sy++) {
        $('#modal_year').append('<option value="' + sy + '">' + sy + '년</option>');    
    }
    
    // 월별 selectbox 만들기            
    for(var i=1; i <= 12; i++) {
        var sm = i > 9 ? i : "0"+i ;            
        $('#modal_month').append('<option value="' + sm + '">' + sm + '월</option>');    
     }          
    
    $("#modal_year  > option[value="+nyear+"]").attr("selected", "true");    
    $("#modal_month  > option[value="+nmon+"]").attr("selected", "true"); 
    
    $(".modal").find("button").on("click", function() {
    	$('html, body').css({'overflow': 'auto', 'height': '100%'}); //scroll hidden 해제
    	$('#element').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
    	$(".modal").css("display", "none");
    })
})
</script>

<title>Insert title here</title>
</head>
<body>
<jsp:include page="../inc/top.jsp" flush="true"></jsp:include>
	
<div class="page_wrap">
	<div class="container page_container">
		<div class="church_introduce_menubar">
			<div class="church_introduce_menu" OnClick="location.href ='/introduce/church'">교회 소개</div>
			<div class="church_introduce_menu" style="text-decoration: underline; text-underline-position: under;" OnClick="location.href ='/introduce/footprints'">발자취</div>
			<div class="church_introduce_menu" OnClick="location.href ='/introduce/seniorpastor'">담임목사</div>
			<div class="church_introduce_menu">사역</div>
			<div class="church_introduce_menu">예배 안내</div>
		</div>
		
		<div class="content footprints">
			<div class="history_box">
				<div class="hitory_bar"><div class="bar"></div></div>
				<ol class="history_line">
					<c:forEach items="${footprintsList}" var="footprint">
						<li class="year 2000year">
							<div class="title">
								${footprint.key}
							</div>
							<ol class="month monthLine">
								<c:forEach items="${footprint.value}" var="fpMonth">	
									<li>
										<p class="month">${fpMonth.month}</p>
										${fpMonth.title}
									</li>
								</c:forEach>
							</ol>
						</li>
					</c:forEach>
				</ol>
			</div>
		</div>
	</div>

	<div id="FootprintsModal" class="modal">
			<div class="modal_header row">
				<div class="modal_title">새로운 발자취 등록</div>
				<!-- <button class="close_btn"><i class="fa fa-times" aria-hidden="true"></i></button> -->
			</div>
			
			<div class="footprints_modal modal_body row ">
				<div class="date footprints_content">
					<p>날짜</p>
                    <select id="modal_year" name="modal_year" ></select>    
                    <select id="modal_month" name="modal_month" ></select> 
				</div>
				<div class="event footprints_content">
					<p>내용</p>
					<textarea row=3 cols=20></textarea>
				</div>
			</div>
			
			<div class="modal_footer row">
				<button class="btn normal_btn close">확인</button>
			</div>
	</div>
	<button OnClick="showModal()">버튼</button>
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