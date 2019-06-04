<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../inc/headTop.jsp" flush="true"></jsp:include>


</head>


<script>
$(document).ready(function() {
	
	$.getJSON("/board/getPreviewImg", function (result) {
		
		
		$("[class^=preview]").each(function() {
			
			for(var i=0; i<result.length; i++) {
				var str = "";
				
				var fileCallPath = encodeURIComponent(result[i].uploadPath+"/s_"+result[i].uuid+"_"+result[i].fileName);
				
				if ($(this).data("bno") == result[i].bno) {
					console.log(result[i])
					console.log(fileCallPath)
					str += "<img src='/display?fileName=" + fileCallPath+ "'>";
					console.log($(this))
					$(this).html(str);
				} 
			}
			
		});
		
		
		
	})

})

</script>


<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp" flush="true"></jsp:include>
		<div id="container_index">
			<section class="cont1">
				<h2 class="title">GALLERY</h2>
				<ul class="character_col">
					
					<c:forEach items="${list}" var="board" varStatus="boardStatus">
							<li>
								<a href="#">
									<div class="preview" data-bno=${board.bno}>
										<img src="/resources/images/index/main_crt1.png">
									</div>
									<div>
										<h3><c:out value="${board.title}"/></h3>
										<p><c:out value="${board.writer}"/></p>
									</div>
								</a>
							</li>
					 </c:forEach> 
					
				</ul>
			</section>
		</div>
	</div>
	<jsp:include page="../inc/footer.jsp" flush="true"></jsp:include>
</body>
</html>
