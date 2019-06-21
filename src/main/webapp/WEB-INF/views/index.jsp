<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<style>
			.main_visual {
				border : 1px solid red;
				height : 100vh;
				position : relative;
			}

			.slider{
				position:fixed;
			}

			.section_wrap {
				position:relative;
				background-color: #fff;
			}

			.main_row2 {
				background-color: #f5f5f5;
			}
		</style>
	</head>

	<body>

		<div class="main_visual_wrap">
			<div class="main_visual">
				<div class="slider">
					메인 가려질 녀석
					<br>1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>0<br>
					<br><br><br><br><br><br><br><br><br><br>
				</div>
			</div>
		</div>

		<div class="section_wrap main_section">

			<section class="main_row1" id="section01">
				<div class="container">
					<h2>Photo</h2>
					<a class="view_btn" href="#">view more</a>
					<ul>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
					</ul>
				</div>
			</section>

			<section class="main_row2" id="section02">
				<div class="container">
					<h2>Board</h2>
					<a class="view_btn" href="#">view more</a>
					<ul>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
					</ul>
				</div>
			</section>

			<section class="main_row3" id="section03">
				<div class="container">
					<h2>About Us</h2>
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

	</body>
</html>