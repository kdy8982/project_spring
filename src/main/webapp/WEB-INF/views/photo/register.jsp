<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<jsp:include page="../inc/headTop.jsp" flush="true"></jsp:include>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<script type="text/javascript" src="/resources/js/board.js"></script>
<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

$(document).ready(function() {
	
	var formObj = $("form[role='form']");
	// var cloneObj = $(".uploadDiv").clone();
	
	$("button[type='submit']").on("click", function(e) {
		e.preventDefault();
		var str = "";
		
		console.log($(".write_box").html());
		
		$("textarea").html($(".write_box").html());
		
		// 각각의 첨부파일마다 서버로 저장할 정보들을 저장한다. 
		$(".uploadResult ul .file_li").each(function(i, obj) {
			var jobj = $(obj);
			
			str += "<input type='hidden' name='attachList[" + i + "].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList[" + i + "].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+ i +"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList[" + i + "].fileType' value='"+jobj.data("type")+"'>";
		})
		formObj.append(str);
		formObj.submit();
	})
	
	$("button[type='upload']").on("click", function(e) {
		e.preventDefault();
		$(".input_upload").click();
	})
	
	$(document).on("click", ".uploadResult .close_btn" ,function () {
		var thisBtn = $(this);
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url : '/deleteFile',
			data : {
				fileName : targetFile, type : type
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType : 'text',
			type : 'POST',
			success : function(result) {
				alert(result);
				targetLi.remove();
				console.log(thisBtn.data("file"));
				$("[data-info='" + thisBtn.data("file") + "']").remove();
				board.refreshFileUploadPreview($(".uploadResult ul"), "", 15, 5, $(".uploadResult").find(".file_li").length);
			}
		})	
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
	
	
	$("input[type='file']").change(function(e) { // 파일업로드의 input 값이 변하면 자동으로 실행 되게끔 처리
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
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
			},
			data : formData,
			type : "post",
			dataType : "json",
			success : function(result) {
				// $(".uploadDiv").html(cloneObj.html());
				showUploadedFile(result);
			},
			error : function (request,status,error) {
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}) // $.ajax()

	}) // $("input[type='file']").change
	
	function showUploadedFile(uploadResultArr) {
		if (!uploadResultArr || uploadResultArr.length == 0) {
			return;
		}
	
		var uploadResult = $(".uploadResult ul");
		var str = "";
	
		$(uploadResultArr).each(function(i, obj) {
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

				originPath = originPath.replace(new RegExp(/\\/g), "/");
				
				var onlyFilename = obj.fileName.split(".");
				
				$(".write_box").append("<img class=uploadImg " + "data-thumbpath='" + fileCallPath + "'" + " data-path= '" + obj.uploadPath + "'" + " data-uuid='" + obj.uuid + "'" + " data-filename='"+ obj.fileName + "'" + " data-type= '" + obj.image + "'" + " data-info='" + obj.uuid + "_" + onlyFilename[0] + "' src='/display?fileName=" + originPath + "'><div><br></div>");
				// oldVal = uploadResult.children(".file_li").length;
				
				str += "<li class='file_li' " + "data-thumbpath='" + fileCallPath + "'" + "' data-path='"+ obj.uploadPath +"' data-uuid='"+ obj.uuid + "' data-filename = '" + obj.fileName + "' data-type='" + obj.image + "' data-info='"+ obj.uuid + "_" + onlyFilename[0] +"'><div>";
				str += "<button type='button' class='close_btn' data-file=\'"+ obj.uuid + "_" + onlyFilename[0] +"\' data-type='image'><i class='fa fa-times'></i></button><br>";
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
				str += "class='file_li '"
				str += "data-path='"
						+ obj.uploadPath
						+ "' data-uuid= '"
						+ obj.uuid
						+ "' data-fileName"
			}
		});
		board.refreshFileUploadPreview(uploadResult, str, 15, 5, uploadResult.children(".file_li").length);
	} // showUploadedFile(uploadResultArr)
	
	  
	
	
	$(".write_box").on("keyup", function(e) {
		var writeBoxVal = $(".write_box").find(".uploadImg");
		var uploadBoxVal = $(".uploadResult").find(".file_li");
		var writeBoxArr = [];
		var uploadBoxArr = [];
		var removeFileIsArr = [];

		writeBoxVal.each(function(index, item) {
			writeBoxArr.push($(item).data());
		})
		
		uploadBoxVal.each(function(index, item) {
			uploadBoxArr.push($(item).data());
		})
		
		
		$(uploadBoxArr).each(function(index, item) {
			//console.log(item.uuid)
			// console.log($(writeBoxArr).get(index).uuid)
			
			// console.log(item.uuid == $(writeBoxArr).get(index).uuid)
			
			
			if(! item.uuid == $(writeBoxArr).get(index).uuid) {
				console.log("AAA")
				removeFileIsArr.push(item);
			} 
		})
		console.log(removeFileIsArr)
		
		
		if(e.keyCode == 8) {
			if(writeBoxVal.length < uploadBoxVal.length) {
				
				/* 
				removeFileIsArr = uploadBoxArr.filter(function(a) {
					
					return writeBoxArr.indexOf(a) === -1;
				}) */
				
				console.log(removeFileIsArr)
				return;
				
				$(removeFileIs).each(function(index, item) {
					// console.log($(item).data('info'))
					/* 
					$.ajax({
						url : '/deleteFile',
						data : {
							fileName : $(".uploadResult li." + item ).find(".close_btn").data("file"), type : $(".uploadResult li." + item ).find(".close_btn").data("type")
						},
						beforeSend : function(xhr) {
							xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
						},
						dataType : 'text',
						type : 'POST',
						success : function(result) {
							alert(result);
						}
					})
					 */
					 
					$(".uploadResult li").remove("[data-info='" + $(item).data('info') + "']")
					board.refreshFileUploadPreview($(".uploadResult ul"), "", 15, 5, $(".uploadResult").find(".file_li").length);
				})
			}
		}
		
		if( e.which === 90 && e.ctrlKey ){
			if(writeBoxVal.length > uploadBoxVal.length) {
				console.log("문제의 상황")
				removeFileIs = writeBoxArr.filter(function(a) {
					return uploadBoxArr.indexOf(a) === -1;
				})
				console.log(removeFileIs);
				
				var str = "";
				
				str += "<li class='file_li " + obj.uuid + "_" + onlyFilename[0] + "' data-path='"+ obj.uploadPath +"' data-uuid='"+ obj.uuid + "' data-filename = '" + obj.fileName + "' data-type='" + obj.image + "' data-info='"+ obj.uuid + "_" + onlyFilename[0] +"'><div>";
				str += "<button type='button' class='close_btn' data-file=\'"+ obj.uuid + "_" + onlyFilename[0] +"\' data-type='image'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName="
						+ fileCallPath
						+ "'>";
				// str += "<a href=\"javascript:showImage('" + originPath + "')\"><img src='/display?fileName=" + fileCallPath + "'></a>"; 
				// str += "<span data-file=\'" + fileCallPath + "\' data-type='image'> x </span>";
				str += "</div></li>";
					
					
			}
	      }       
	});
	 
})

</script>

<title>Insert title here</title>
</head>
<body>
<jsp:include page="../inc/top.jsp" flush="true"></jsp:include>
	
	<div class="page_wrap">
		<div class="container page_container">
			<div class="title_wrap">
				<h2 class="wrap-inner main_tit title-font">사진</h2>
			</div>
			
			<div class="sub_title title-font">
			<h3>
				"그래서 우리는 위로를 받았습니다.<br> 
				또한 우리가 받은 위로 위에 디도의 기쁨이 겹쳐서, 우리는 더욱 기뻐하게 되었습니다.<br>
				 그는 여러분 모두로부터 환대를 받고, 마음에 안정을 얻었던 것입니다."<br>
				고린도후서 7장 13절
			 </h3>
			</div>
			
			<div class="content">
				<div class="list_wrap notice_wrap">
					<form role="form" action="/photo/register" method="post">
						
						<div class="form-group uploadRow">
							<label>제목</label> <input class="form_title" name='title'>
						</div>
	
						<div class="form-group uploadRow">
							<label>글 내용</label>
							<textarea style="display:none" name="content"></textarea>
							<div class="write_box" contentEditable="true"></div>
						</div>
						
						<div class="form-group uploadRow">
							<label>작성자</label>
							<input class="form_writer" name='writer' readonly="readonly" value="<sec:authentication property="principal.member.userid"/>">
						</div>
						
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="boardType" value="photo" />
					</form>
					
					<div class="file_upload_wrap uploadRow">
						<div class="uploadDiv">
							<input class="input_upload" type="file" name="uploadFile" multiple>
						</div>
					</div>
					<button class="btn tab_btn middle" type="upload">이미지 첨부</button>
					<div class="uploadResult uploadLev">
						<ul></ul>
					</div>
					
					<div class="bottom_wrap">
						<button class="btn normal_btn middle" type="submit">작성완료</button>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../inc/footer.jsp" flush="true"></jsp:include>
	</div>
		
	<form id="actionForm" action="/notice/list" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name="type" value="${pageMaker.cri.type }">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
	</form>

</body>
</html>