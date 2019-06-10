<%@ page contentType="text/html; charset=utf-8" %>
<jsp:include page="../inc/headTop.jsp" flush="true"></jsp:include>
<script>
	var view_pop = "false";

	function open_pop(id){

			var type = $(id).parent().parent().find("li").attr("class");

			if( type=="yesupload"){
				$("#gallery_view").fadeIn("fast",function(){

					if( view_pop == "false"){		
							$('.chara_list').bxSlider({
								auto: true, 
								speed: 500, 
								pause: 2000, 
								mode:'horizontal', 
								minSlides: 1,
								maxSlides: 1,
								nextText: '',
								prevText:'',
								infiniteLoop: true,
								autoControls: true,
								pager: false
							});

							$(".bx-controls-direction .bx-prev").append("<i class='fa fa-chevron-left' aria-hidden='true'></i>");
							$(".bx-controls-direction .bx-next").append("<i class='fa fa-chevron-right' aria-hidden='true'></i>");
						}

						view_pop = 'true';
				});	
			}else{
				$("#gallery_upload").fadeIn("fast");
			}	
	}
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp" flush="true"></jsp:include>
		<jsp:include page="../inc/gallery_upload.jsp" flush="true"></jsp:include>
		<jsp:include page="../inc/gallery_view.jsp" flush="true"></jsp:include>
		<div id="container_index">
			<section class="cont1">
				<h2 class="title">GALLERY</h2>
				<ul class="character_col">
					<li class="yesupload"><!-- 업로드 완료 리스트 -->
						<a onclick="javascript:open_pop(this)">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li class="noupload"><!-- 업로드 전 리스트 -->
						<a onclick="javascript:open_pop()">
							<div>
								<img src="/resources/images/index/main_crt1.png">
								<i class="fa fa-exclamation alert" aria-hidden="true"></i>
								<i class="fa fa-plus add" aria-hidden="true"></i>
							</div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
					<li>
						<a onclick="javascript:open_pop()">
							<div><img src="/resources/images/index/main_crt1.png"></div>
							<div>
								<h3>헬로키티</h3>
								<p>HELLO KITTY</p>
							</div>
						</a>
					</li>
				</ul>
			</section>
		</div>
		<jsp:include page="../inc/footer.jsp" flush="true"></jsp:include>
	</div>
</body>
</html>
