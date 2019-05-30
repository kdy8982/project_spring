<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->


<div class="row">
	<div class="col-lg-12">
		<div class="card">
		
			<div class="card-header">글 수정</div>
			<!-- /.panel-heading -->
			<div class="card-block">
				<form role="form" action="/board/modify" method="post">
					<div class="form-group">
						<label>Bno</label>
						<input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>제목</label>
						<input class="form-control" name='title' value='<c:out value="${board.title}"/>'>
					</div>					
					<div class="form-group">
						<label>글 내용</label>
						<textarea class="form-control" rows="3" name='content'><c:out value="${board.content}"/></textarea>
					</div>					
					<div class="form-group">
						<label>작성자</label>
						<input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
					</div>					
					<div class="form-group">
						<label>등록일</label>
						<input class="form-control" name='regDate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>' readonly="readonly">
					</div>							
					<div class="form-group">
						<label>수정일</label>
						<input class="form-control" name='updateDate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updatedate}"/>' readonly="readonly">
					</div>						
					<button type="submit" data-oper='modify' class="btn btn-secondary btn-sm">수정</button>
					<button type="submit" data-oper='remove' class="btn btn-secondary btn-danger btn-sm">삭제</button>
					<button type="submit" data-oper='list' class="btn btn-secondary btn-info btn-sm">목록으로</button>
					
					<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
					<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
					<input type="hidden" name="type" value="<c:out value='${cri.type}'/>"/>
					<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>"/>
				</form>
			</div>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>
<!-- Bootstrap core JavaScript-->
<!-- <script src="vendor/jquery/jquery.min.js"></script> -->
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="vendor/datatables/jquery.dataTables.min.js"></script>
<script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="js/demo/datatables-demo.js"></script>


<script type="text/javascript">
$(document).ready(function() {
	var formObj = $("form");
	
	$('button').on("click", function(e) {
		e.preventDefault();
		var operation = $(this).data("oper");
		console.log(operation)
		
		if(operation === 'remove') {
			formObj.attr("action", "/board/remove");
		} else if(operation === 'list') {
			formObj.attr("action", "/board/list").attr("method","get");
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var typeTag = $("input[name='type']").clone();
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
		}
		formObj.submit();
	})
})
</script>
</body>

</html>
