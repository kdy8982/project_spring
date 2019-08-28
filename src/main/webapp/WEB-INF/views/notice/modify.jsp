<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	var cloneObj = $(".uploadDiv").clone();
	
	$("button[data-oper='modify']").on("click", function(e) {
		e.preventDefault();
		var str = "";
		str += "<input type='hidden' name='bno' value='"+${notice.bno}+"'>";
		$(".uploadResult ul li").each(function(i, obj) {
			var jobj = $(obj);
			
			str += "<input type='hidden' name='attachList[" + i + "].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList[" + i + "].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+ i +"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList[" + i + "].fileType' value='"+jobj.data("type")+"'>";
		});
		formObj.append(str).submit();
	})
	
	$("button[data-oper='delete']").on("click", function(e) {
		e.preventDefault();
		formObj.attr("action", "/notice/delete");
		
		formObj.submit();
	})
	
	$(document).on("click", ".uploadResult .close_btn" ,function () {
		var thisBtn = $(this);
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var uploadPath = $(this).data("path")
		var targetLi = $(this).closest("li");
		if(type) {
			type = "image"; 
		}
		
		$.ajax({
			url : '/deleteFile',
			data : {
				fileName : targetFile, 
				type : type,
				uploadPath : uploadPath
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
	}) // $(document).on("click", ".uploadResult .close_btn" ,function () {}

	
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
	
	/** 파일 업로드 **/
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
				$(".uploadDiv").html(cloneObj.html());
				board.showUploadedFile(result);
				$("input[type='file']").val("");
			},
			error : function (request,status,error) {
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}) // $.ajax()

	}) // $("input[type='file']").change
	
	var bno = '<c:out value="${notice.bno}"/>';
	$.getJSON("/board/getAttachList", {bno : bno}, function(arr) {
		console.log(arr);
		var str="";
		$(arr).each(function(i, attach) {
			//image type (썸네일)
			if(attach.fileType) {
				var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+ "_" + attach.fileName);
				
				str += "<li class='image_li' data-path='"+ attach.uploadPath +"' data-uuid='"+ attach.uuid +"' data-filename='"+ attach.fileName +"' data-type='"+ attach.fileType +"' >";
				str += "<div>";
				str += "<span>" + attach.fileName +"</span>";
				str += "<button data-file=\'" + fileCallPath + "\' data-type='image'><i class='fa fa-times'></i></button><br>"
				str += "<img src='/display?fileName="+ fileCallPath +"'>";
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
	
	/** 이미지 복사 붙여넣기 막는 이벤트 **/
	$(".write_box").on("paste", function(e) {
		e.preventDefault();
		var pastedData = event.clipboardData ||  window.clipboardData;
		var textData = pastedData.getData('Text');
		window.document.execCommand('insertHTML', false,  textData);
	})
	
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
		
		if(writeBoxVal.length < uploadBoxVal.length) {
			removeFileIsArr = uploadBoxArr.filter(function(a) {
				return writeBoxArr.findIndex(i => i.info == a.info) === -1;
			}) 
			
			$(removeFileIsArr).each(function(index, item) {
				$(".uploadResult li").remove("[data-info='" + item.info + "']")
				board.refreshFileUploadPreview($(".uploadResult ul"), "", 15, 5, $(".uploadResult").find(".file_li").length);
			})
		} else if(writeBoxVal.length > uploadBoxVal.length) {
				removeFileIsArr = writeBoxArr.filter(function(a) {
					return uploadBoxArr.findIndex(i => i.info == a.info) === -1;
				}) 
				
				var str = "";
				$(removeFileIsArr).each(function(index, item) {
					str += "<li class='file_li' data-index='" + item.index + "' data-thumbpath='" + item.thumbpath + "' data-path='"+ item.path +"' data-uuid='"+ item.uuid + "' data-filename = '" + item.filename + "' data-type='" + item.type + "' data-info='"+ item.info +"'><div>";
					str += "<button type='button' class='close_btn' data-file='" + item.info + "' data-type='" + item.fileType+ "' data-path='" + item.path + "'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName="
							+ item.thumbpath
							+ "'>";
					str += "</div></li>";
				});
				$(".uploadResult ul").append(str);
				var sortData = $(".uploadResult ul").children(".file_li").sort(function(a, b) {
					return +a.dataset.index - +b.dataset.index;
				})
				
				$(".uploadResult ul").html("");
				$(".uploadResult ul").append(sortData);
						
				board.refreshFileUploadPreview($(".uploadResult ul"), "", 15, 5, $(".uploadResult").find(".file_li").length);
		}
	}); // $(".write_box").on("keyup", function(e) {}	
	
})
</script>

<title>Insert title here</title>
</head>
<body>
<jsp:include page="../inc/top.jsp" flush="true"></jsp:include>
	
<div class="page_wrap">
	<div class="container page_container">
		<div class="title">
			<div class="title_wrap">
				<h2 class="wrap-inner main_tit title-font">새소식</h2>
			</div>
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
				<form role="form" action="/notice/modifySubmit" method="post">
					
					<div class="form-group uploadRow">
						<label>제목</label> <input class="form_title" name='title' value="${notice.title}">
					</div>

					<div class="form-group uploadRow">
						<label>글 내용</label>
						<textarea class="" rows="3" name='content'>${notice.content }</textarea>
					</div>
					
					<div class="form-group uploadRow">
						<label>작성자</label> <input class="form_writer" name='writer' readonly="readonly" value="${notice.writer }">
					</div>
					<div class="row bottom_wrap">
						<div class="notice_btn">
							<button class="btn normal_btn middle" data-oper="modify" type="submit">수정 완료</button>
							<button class="btn normal_btn"data-oper="delete">삭제</button>
						</div>
					</div>
						
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="hidden" name="type" value="notice" />
				</form>
				
				<div class="file_upload_wrap uploadRow">
					<button class="btn tab_btn" data-oper="upload" type="upload">사진 추가</button>
					<div class="uploadDiv">
						<input class="input_upload" type="file" name="uploadFile" multiple>
					</div>

					<div class="uploadResult uploadLev">
						<div class="layer" style="display:none"></div>
						<div class="center_wrap" style="display:none"><img src="/resources/images/sub/ajax-loader.gif" /></div>
						<ul></ul>
					</div>
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="../inc/footer.jsp" flush="true"></jsp:include>
</div> <!-- page_wrap -->
		
	<form id="actionForm" action="/notice/list" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name="type" value="${pageMaker.cri.type }">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
	</form>


</body>
</html>