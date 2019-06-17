<%@ page contentType="text/html; charset=utf-8" %>
<script>
	$(function(){
		$("#gallery_pop .btn_add ").click(function(){
				$(".img_add").append('<div class="area_img clone"><label>이미지</label><input type="file" name="uploadFile"> <div class="filebox"><button>파일선택</button><div class="text">선택된 파일 없음</div></div> <label class="frontig_label">대표이미지<input type="radio" name="frontimg"/></label></div>');
		});
		$("#gallery_pop .btn_close").click(function(){
			$(".area_img.clone").hide();
			$("#gallery_upload #gallery_pop .filebox .text").text("");
			$("#gallery_upload #gallery_pop input[type=file]").val("");

			$(".gallery_pop_wrap").fadeOut();

		})
			
		$(document).on("click",".filebox button",function(){
			$(this).parent().parent().find("input[type=file]").click();
		})

		$(document).on("change",".area_img input[type=file]",function(){
			$(this).parent().find(" .filebox .text").text($(this).val());		
		})

		/* 파일을 첨부할 때 마다, 호출되는 이벤트 (로컬경로에 파일 저장)*/
		$(".img_add").change(function(e) {
			alert("!!!!")	
			var formData = new FormData();
 			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
				
			for (var i=0; i<inputFile.length; i++) {
				console.log (inputFile[i].files[0]);
				formData.append("uploadFile", inputFile[i].files[0]);
			}
			
			$.ajax({
				url : "/uploadAjaxAction",
				processData : false,
				contentType : false,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				},
				data : formData,
				dataType : 'json',
				type : 'post',
				success : function (result) {
					addFileInfoToTag(result)
				},
				error : function (request, status, error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			})
		})
		
		var formObj = $("form[role='form']");
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$(document).on("click", ".btn_upload", function (e) {
			e.preventDefault();
			
			var str = "";
			
			$(".img_add .area_img ").each(function(i, obj) {
				console.log($(obj));
				var jobj = $(obj);
				str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("fileName") + "'>";
			})
			
			formObj.append(str)
		}) 
		
		
		
		function addFileInfoToTag(resultArr) {
			
			$(".img_add .area_img ").each(function(i, obj) {
				$(this).attr("data-filename", resultArr[i].fileName);
				console.log(resultArr)
				
			})
			
			/* 
			$(resultArr).each(function(i, obj) {
				console.log(i);
			})
			 */
			
		}
		
		
	})
</script>
<div class="gallery_pop_wrap" id="gallery_upload"  style="display:none">
	<div id="gallery_pop">
		<div class="btn_close"><i class="fa fa-times" aria-hidden="true"></i></div>
		<img src="/resources/images/sub/shop_kitty.png" class="kitty_head">
		<h2>이미지 올리기</h2>
		
			<form role="form" action="/gallery/register" method="post">
				<div class="name_area">
					<div class="name_han"><label>한글이름</label><input type="text" placeholder="한글이름을 넣어주세요"></div>
					<div class="name_eng"><label>영문이름</label><input type="text" placeholder="영문이름을 넣어주세요."></div>
				</div>
			</form>
			
			<div class="img_add">
				<div class="area_img">
					<label>이미지</label>
					<input type="file" name="uploadFile">
					<div class="filebox">
						<button>파일선택</button>
						<div class="text">선택된 파일 없음</div>
					</div>
					<label class="frontig_label">대표이미지<input type="radio" name="frontimg" checked="checked"/></label>
				</div>
			</div>
			<div class="btn_add"><i class="fa fa-plus" aria-hidden="true"></i> <span>이미지추가</span></div>
			
			<div class="btn_wrap">
				<span class="btn_upload btn_normal">완 료</span>
			</div>
			
	</div>
</div>