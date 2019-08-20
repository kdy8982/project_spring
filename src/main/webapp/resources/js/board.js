console.log("Board Module..................");

var board = (function() {
	
	/** 
	 * CSS display:flex속성의 justify-content: space-between 사용시,
	 * 가운데 정렬할 경우 의도치 않게 발생하는 마진을 조정하기 위해, 
	 * 가상의 <li></li>태그를 계산하여 덧붙여주는 function이다.
	 * makeAndAppendEmptyLi(한 페이지에 표현되는 전체 게시글 수, 한줄당 게시글 수, 실제 게시글 수) **/
	function makeEmptyLi(allPhotoCount, aRowCount, photoCount) {
	   	
		var row = Math.ceil(photoCount / aRowCount);   
	    var makeEmptyLiCount = (aRowCount * row) - photoCount;
	    var str = "";
	    
	   	for	(i=0; i<makeEmptyLiCount; i++) {
	   		str += "<li style='visibility: hidden'></li>";
	   	}
	   	
	   	return str;
	}
	
	function refreshFileUploadPreview(ulTag, str, allPhotoCount, aRowCount, photoCount) {
		
		var oldFileLi;
		var emptyLi;
		
		if(photoCount == 0 ) {
			ulTag.html("")
		}
		
		if(ulTag.children(".file_li").length != 0) {
			oldFileLi = ulTag.children(".file_li");
			ulTag.html("");
			ulTag.append(oldFileLi);
		}
		
		ulTag.append(str);
		photoCount = ulTag.find(".file_li").length;
		
		emptyLi = makeEmptyLi(allPhotoCount, aRowCount, photoCount);
		ulTag.append(emptyLi)
	}
	
	return {
		makeEmptyLi: makeEmptyLi,
		refreshFileUploadPreview: refreshFileUploadPreview
	};
	
})();