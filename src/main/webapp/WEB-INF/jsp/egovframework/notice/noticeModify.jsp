<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="/js/jquery.min.js"></script>
	<link href="/css/egovframework/notice/notice.css" rel="stylesheet">
	<script src="/js/Bootstrap/form-validation.js"></script>
</head>
<body class="bg-light">
<main class="container mx-auto my-5">
	<div id="situation" class="d-flex align-items-center p-3 my-3 text-white rounded shadow-sm">
	    <h2>공지사항 수정</h2>
	</div>
	<div class="my-3 p-3 bg-body rounded shadow-sm">
	    <form class="needs-validation" action="/notice/noticeUpdate.do" method="POST" novalidate>
	        <input type="hidden" name="noticeUuid" value="${noticeUuid}">
	        <div class="row g-3">
		        <div class="col-12">
			        <label for="title" class="form-label">제목</label>
			        <div class="input-group has-validation">
		        		<input class="form-control" type="text" id="title" name="noticeTitle"  value="${noticeTitle}" required>
		        		<div class="invalid-feedback">
							제목을 입력하세요
						</div>
					</div>
				</div>
				
				<c:if test="${not empty fileList}">
	                <div class="col-12">
	        		<c:forEach var="file" items="${fileList}">
	        			<div class="mb-2">
	        				<div class="input-group position-relative d-block">
	        					<div class="d-flex w-100 border rounded bg-white">
	        						<span class="input-group-text bg-light text0secondary border-0 border-end rounded-0 rounded-start px-3">
                            			파일 선택
                            		</span>
                            		<input type="text" class="form-control border-0 bg-transparent text-dark" 
                               			id="fakePath_${status.index}" value="${file.ORIGINAL_NAME}" readonly>
	        					</div>
	        					<input type="file" class="position-absolute top-0 start-0 w-100 h-100 opacity-0" 
	                           		id="realFile_${status.index}" name="file" 
	                           		onchange="changePath(this, ${status.index})" style="cursor: pointer;">
	        				</div>
	        			</div>
	        		</c:forEach>
	        	</div>
	            </c:if>
	            <c:if test="${empty fileList}">
	            <div class="col-12">
				<input class="form-control" type="file" id="file">
				</div>
				</c:if>
				
				<div id="fileIndex"></div>
	            <div class="btn-box">
	        		<button id="fileAdd_btn" class="w-20 btn btn-dark" type="button">파일추가+</button>
				</div>
				<div class="col-12">
					<label for="content" class="form-label">내용</label>
					<textarea class="form-control" name="noticeContent" id="content" required>${noticeContent}</textarea>
					<div class="invalid-feedback">
						내용을 입력하세요
					</div>
				</div><input type="hidden" name="writeId" value="${writeId}">
	        
	        
	        <div class="btn-box">
	        	<button class="btn btn-primary" type="submit">수정 완료</button>
	        	<a class="btn btn-outline-dark" href="/notice/noticeList.do">취소</a>
	        </div>
	        
	        </div>
	    </form>
	</div>
</main>
<script>
$(document).ready(function() {
    var fileIndex = 1;
    $("#fileAdd_btn").on("click", function(e) {
        e.preventDefault();
        var fileHtml = "<div class='file-item'>" +
                       "<input class='form-control' type='file' name='file_" + fileIndex + "' /> " +
                       "<button type='button' class='btn btn-danger' id='fileDel_btn'>삭제</button>" +
                       "</div>";
        $("#fileIndex").append(fileHtml);
        fileIndex++;
    });
    $(document).on("click", "#fileDel_btn", function(e) {
        e.preventDefault();
        $(this).parent().remove();
    });
});

function changePath(input) {
    if (input.files && input.files[0]) {
        document.getElementById('fakePath').value = input.files[0].name;
    }
}
</script>
</body>
</html>