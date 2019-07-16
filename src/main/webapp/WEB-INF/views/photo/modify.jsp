<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../inc/headTop.jsp" flush="true"></jsp:include>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";

	$(document)
			.ready(
					function() {
						var formObj = $("form[role='form']");
						// var cloneObj = $(".uploadDiv").clone();

						$("button[data-oper='modify']")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											var str = "";
											str += "<input type='hidden' name='bno' value='"+${photo.bno}+"'>";
											$(".uploadResult ul li")
													.each(
															function(i, obj) {
																var jobj = $(obj);

																str += "<input type='hidden' name='attachList["
																		+ i
																		+ "].fileName' value='"
																		+ jobj
																				.data("filename")
																		+ "'>";
																str += "<input type='hidden' name='attachList["
																		+ i
																		+ "].uuid' value='"
																		+ jobj
																				.data("uuid")
																		+ "'>";
																str += "<input type='hidden' name='attachList["
																		+ i
																		+ "].uploadPath' value='"
																		+ jobj
																				.data("path")
																		+ "'>";
																str += "<input type='hidden' name='attachList["
																		+ i
																		+ "].fileType' value='"
																		+ jobj
																				.data("type")
																		+ "'>";
															});
											formObj.append(str).submit();
										})

						$("button[data-oper='delete']")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											formObj.attr("action",
													"/photo/delete");

											formObj
													.append("<input type='hidden' name='bno' value='"+ ${photo.bno}+"'>")
											formObj.submit();
										})
										
						$("button[data-oper='upload']").on("click", function(e) {
							e.preventDefault();
							$(".input_upload").click();
						})
						

						/* 첨부파일 추가 */
						var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
						var maxSize = 5242880;

						function checkExtension(fileName, fileSize) { // 파일 확장자 및 사이즈 체크 메서드.
							if (fileSize > maxSize) {
								alert("파일 사이즈 초과 !!");
								return false;
							}

							if (regex.test(fileName)) {
								alert("해당 종류의 파일은 업로드 할 수 없습니다.");
								return false;
							}
							return true;
						} // checkExtension(fileName, fileSize)

						$("input[type='file']")
								.change(function(e) { // 파일업로드의 input 값이 변하면 자동으로 실행 되게끔 처리
											
											var formData = new FormData();
											var inputFile = $("input[name='uploadFile']");
											var files = inputFile[0].files;

											for (var i = 0; i < files.length; i++) {
												if (!checkExtension(
														files[i].name,
														files[i].size)) {
													return false;
												}
												formData.append("uploadFile",
														files[i]);
											}

											$.ajax({
														url : "/uploadAjaxAction",
														processData : false,
														contentType : false,
														beforeSend : function(xhr) {
															xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
														},
														data : formData,
														type : "post",
														dataType : "json",
														success : function(result) {
															// $(".uploadDiv").html(cloneObj.html());
															showUploadedFile(result);
														},
														error : function(
																request,
																status, error) {
															alert("code:"
																	+ request.status
																	+ "\n"
																	+ "message:"
																	+ request.responseText
																	+ "\n"
																	+ "error:"
																	+ error);
														}
													}) // $.ajax()

										}) // $("input[type='file']").change

						function showUploadedFile(uploadResultArr) {

							if (!uploadResultArr || uploadResultArr.length == 0) {
								return;
							}

							var uploadResult = $(".uploadResult ul");
							var str = "";

							$(uploadResultArr)
									.each(
											function(i, obj) {
												if (obj.image) {

													var fileCallPath = encodeURIComponent(obj.uploadPath
															+ "/s_"
															+ obj.uuid
															+ "_"
															+ obj.fileName);
													var originPath = obj.uploadPath
															+ "\\"
															+ obj.uuid
															+ "_"
															+ obj.fileName;

													originPath = originPath
															.replace(
																	new RegExp(
																			/\\/g),
																	"/");

													str += "<li data-path='"+ obj.uploadPath +"' data-uuid='"+ obj.uuid + "' data-filename = '" + obj.fileName + "' data-type='" + obj.image + "'><div>";
													str += "<span>"
															+ obj.fileName
															+ "</span>";
													str += "<button type='button' class='btn btn-warning btn-circle' data-file=\'"+ fileCallPath +"\' data-type='image'><i class='fa fa-times'></i></button><br>";
													str += "<img src='/display?fileName="
															+ fileCallPath
															+ "'>";
													// str += "<a href=\"javascript:showImage('" + originPath + "')\"><img src='/display?fileName=" + fileCallPath + "'></a>"; 
													// str += "<span data-file=\'" + fileCallPath + "\' data-type='image'> x </span>";
													str += "</div></li>";

												} else {

													var fileCallPath = encodeURIComponent(obj.uploadPath
															+ "/"
															+ obj.uuid
															+ "_"
															+ obj.fileName);
													var fileLink = fileCallPath
															.replace(
																	new RegExp(
																			/\\/g),
																	"/");

													str += "<li";
													str += "data-path='"
															+ obj.uploadPath
															+ "' data-uuid= '"
															+ obj.uuid
															+ "' data-fileName"
												}
											});
							// alert(str);
							uploadResult.append(str);
						} // showUploadedFile(uploadResultArr)

						var bno = '<c:out value="${photo.bno}"/>';
						$.getJSON(
										"/board/getAttachList",
										{
											bno : bno
										},
										function(arr) {
											var str = "";
											$(arr)
													.each(
															function(i, attach) {
																//image type (썸네일)
																if (attach.fileType) {
																	var fileCallPath = encodeURIComponent(attach.uploadPath
																			+ "/s_"
																			+ attach.uuid
																			+ "_"
																			+ attach.fileName);

																	str += "<li class='image_li' data-path='"+ attach.uploadPath +"' data-uuid='"+ attach.uuid +"' data-filename='"+ attach.fileName +"' data-type='"+ attach.fileType +"' >";
																	str += "<div>";
																	str += "<span>"
																			+ attach.fileName
																			+ "</span>";
																	str += "<button class='close_btn' data-file=\'" + fileCallPath + "\' data-type='image'><i class='fa fa-times'></i></button><br>"
																	str += "<img src='/display?fileName="
																			+ fileCallPath
																			+ "'>";
																	str += "</div>"
																	str += "</li>";
																} else {
																	str += "<li data-path ='"+ attach.uploadPath +"' data-uuid='"+ attach.uuid +"' data-filename='"+ attach.fileName +"' data-type ='"+ attach.fileType + "'>";
																	str += "<div>"
																	str += "<img src='/resources/img/attach.png'>"
																	str += "</div>"
																	str += "</li>"
																}
															});
											$(".uploadResult ul").html(str);
										})

						$(".uploadResult").on(
								"click",
								"button",
								function(e) {
									var targetFile = $(this).data("file");
									var type = $(this).data("type");

									var targetLi = $(this).closest("li");

									$.ajax({
										url : '/deleteFile',
										data : {
											fileName : targetFile,
											type : type
										},
										beforeSend : function(xhr) {
											xhr.setRequestHeader(
													csrfHeaderName,
													csrfTokenValue);
										},
										dataType : 'text',
										type : 'POST',
										success : function(result) {
											alert(result);
											targetLi.remove();
										}
									})

								});

					})
</script>

<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../inc/top.jsp" flush="true"></jsp:include>


	<div class="container page_container">
		<div class="title">
			<div class="title_wrap">
				<h2 class="wrap-inner main_tit">사진</h2>
			</div>
		</div>

		<div class="sub_title">
			<h3>
				"그래서 우리는 위로를 받았습니다.<br> 또한 우리가 받은 위로 위에 디도의 기쁨이 겹쳐서, 우리는 더욱
				기뻐하게 되었습니다.<br> 그는 여러분 모두로부터 환대를 받고, 마음에 안정을 얻었던 것입니다."<br>
				고린도후서 7장 13절
			</h3>
		</div>

		<div class="content">
			<div class="list_wrap notice_wrap">
				게시글 수정
				<form role="form" action="/photo/modify" method="post">

					<div class="form-group uploadRow">
						<label>제목</label> <input class="form_title" name='title'
							value="${photo.title}">
					</div>

					<div class="form-group uploadRow">
						<label>글 내용</label>
						<textarea class="" rows="3" name='content'>${photo.content }</textarea>
					</div>

					<div class="form-group uploadRow">
						<label>작성자</label> <input class="form_writer" name='writer'
							readonly="readonly" value="${photo.writer }">
					</div>
					<div class="row bottom_wrap">
						<div class="notice_btn">
							<button class="btn normal_btn middle" data-oper="modify" type="submit">수정 완료</button>
							<button class="btn normal_btn " data-oper="delete">삭제</button>
						</div>
					</div>

					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					<input type="hidden" name="type" value="photo" />
				</form>

				<div class="file_upload_wrap uploadRow">
					<button class="btn tab_btn" data-oper="upload" type="upload">사진 추가</button>
					<div class="uploadDiv">
						<input class="input_upload" type="file" name="uploadFile" multiple>
					</div>

					<div class="uploadResult uploadLev">
						<ul></ul>
					</div>
				</div>

			</div>
		</div>
	</div>

	<form id="actionForm" action="/photo/list" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name="type" value="${pageMaker.cri.type }">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
	</form>

	<jsp:include page="../inc/footer.jsp" flush="true"></jsp:include>
</body>
</html>