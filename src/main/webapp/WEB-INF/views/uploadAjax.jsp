<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	padding-right: 5px;
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rbga(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>
</head>
<body>
	<h1>Upload with Ajax</h1>

	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>

	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	<div class="uploadResult">
		<ul>
		</ul>
	</div>
	<button id="uploadBtn">Upload</button>

	<script src="https://code.jquery.com/jquery-3.4.1.js"
		integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
		crossorigin="anonymous"></script>

	<script>
		/* 
		 * showImage(fileCallPath) 
		 * 이미지 보여주기 위한 메서드
		 * document.ready 밖에서 선언한 이유는, <a>태그 내에서 바로 사용하기 위함이다. 
		 */
		function showImage(fileCallPath) {
			// alert(fileCallPath);
			$(".bigPictureWrapper").css("display", "flex").show();
			$(".bigPicture").html("<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>") // 섬네일 이미지가 아닌, 원래 이미지를 별도의 미리보기 DIV에 넣는다. 
			.animate({width : '100%', height : '100%'}, 1000);
		 }
		
		 $(".bigPictureWrapper").on("click", function(e){
			 $(".bigPicture").animate({width : '0%', height : '0%'}, 1000);
			 setTimeout(()=> {
				 $(this).hide();
			 }, 1000);
		 })
		 
		 $(".uploadResult").on("click", "span", function(e) {
			 var targetFile = $(this).data("file");
			 var type = $(this).data("type");
			 console.log(targetFile);
	
			 $.ajax({
				url : '/deleteFile',
				data : {fileName : targetFile, type : type},
				dataType : 'text',
				type : 'POST',
				success : function (result) {
					alert(result);	
				}
			 })
			 
		 })
	
		$(document).ready(function() {
			var cloneObj = $(".uploadDiv").clone();
			
			$("#uploadBtn").on("click", function(e) {
				var formData = new FormData();
				var inputFile = $("input[name='uploadFile']");
				var files = inputFile[0].files;
				console.log("inputFile[0].files : ")
				console.log(files);

				for (var i = 0; i < files.length; i++) {
					if(!checkExtension(files[i].name, files[i].size)) { // 파일 정합성 체크
						return false;
					}
					formData.append("uploadFile", files[i]);
				}

				$.ajax({
					url : "uploadAjaxAction",
					processData : false,
					contentType : false,
					data : formData,
					type : "post",
					dataType: "json",
					success : function(result) { // 파일 업로드가 성공 후, 수행할 익명함수
						console.log(result);
						$(".uploadDiv").html(cloneObj.html());
						showUploadedFile(result);
						
					}, error : function(xhr, status, er) {
						alert("error!")
					}
				}) // $.ajax()

			}) //$("#uploadBtn").on("click",)

			
			/* 파일명 및 확장자 정규식 처리 */
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880; // 5MB
			
			function checkExtension(fileName, fileSize) {
				if(fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}
				
				if(regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				return true;
			} // checkExtension(fileName, fileSize)
			
			
			/* 업로드한 파일 목록을 li리스트로 화면에 출력 */
			var uploadResult = $(".uploadResult ul");
			function showUploadedFile(uploadResultArr) {
				var str = "";
				
				$(uploadResultArr).each(function (i, obj) {
					if(!obj.image) { // 이미지파일이 아닐 경우 
						var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
						console.log(fileCallPath);
						
						var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/")
						
						// 누를 경우 다운로드로 처리 
						str+= "<li><div><a href='/download?fileName=" + fileCallPath +"'>" + "<img src='/resources/img/attach.png'>" + obj.fileName + "</a>" +
								"<span data-file=\'" + fileCallPath + "\' data-type='file'> x </span>"
								+"</div></li>"
					
					} else { // 이미지 파일일 경우 
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;

						originPath = originPath.replace(new RegExp(/\\/g), "/");
						
						// 누를 경우 <a>태그 내에서 javascript로 화면 확대 처리 
						str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\"><img src = '/display?fileName=" + fileCallPath + "'></a>" + 
								"<span data-file=\'" + fileCallPath+ "\' data-type='image'> x </span>" 
								+ "</li>";
					}
				});
				uploadResult.append(str);
			} // showUploadedFile(uploadResultArr); 
			
		}) // document.ready()
	</script>
</body>
</html>