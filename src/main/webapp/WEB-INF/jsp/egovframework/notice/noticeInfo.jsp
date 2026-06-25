<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>공지사항 상세 보기</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="/css/egovframework/notice/notice.css" rel="stylesheet">
    <script type="text/javascript">
        function deletePost() {
            if(confirm("정말 삭제하시겠습니까?")) {
                document.deleteForm.submit();
            }
        }
    </script>
    <script src="/js/jquery.min.js"></script>
</head>
<body class="bg-light">
<main class="container mx-auto my-5">
	<div id="situation" class="d-flex align-items-center p-3 my-3 text-white rounded shadow-sm">
		<h2>공지사항 상세 보기</h2>
	</div>
    
    <div class="my-3 p-3 bg-body rounded shadow-sm">
    	<div class="row g-3">
	    		<div class="col-12">
	    			<h4 class="pb-2 mb-0 border-bottom">
	    				<strong class="d-block text-gray-dark">
	    					${notice.noticeTitle}
	    				</strong>
	    			</h4>
	    		</div>
	    		<div class="col-sm-6 border-bottom">
	    				<strong class="d-block text-gray-dark">작성자:</strong>
	    				${notice.writeId} 
	    		</div>
	    		<div class="col-sm-6 border-bottom">
	        			<strong class="d-block text-gray-dark">등록일:</strong>
	        			${notice.registryDate}
	        	</div>
	        	<c:if test="${not empty fileList}">
	                <div class="col-12 border-bottom">
	        		<strong class="d-block text-gray-dark">첨부파일</strong>
	        		<c:forEach var="file" items="${fileList}">
	        			<a href="#" onclick="fn_fileDown('${file.FILE_ID}'); return false;">${file.ORIGINAL_NAME}</a>(${file.FILE_SIZE}kb)<br>
	        		</c:forEach>
	        	</div>
	            </c:if>
	        
	        	<div class="col-12 border-bottom">
	        		<p class="pb-3 mb-0 small lh-sm border-bottom board-content">
	            		${notice.noticeContent}
	            	</p>
	        	</div>
        </div>
    </div>
    
	<div class="my-3 p-3 bg-body rounded shadow-sm">
	<a class="w-20 btn btn-primary" href="/notice/noticeList.do">목록으로</a>
   	<c:if test="${loginMember.role.name() eq 'ADMIN'}">   	
	    <button class="w-20 btn btn-secondary" type="button" id="notice-link" data-uuid="${notice.noticeUuid}">
	    	수정하기
		</button>
		
		<button class="w-20 btn btn-danger" type="button" id="notice-delete" data-uuid="${notice.noticeUuid}">
	        삭제하기
	    </button>
   	</c:if> 
	</div>
            
    <form id="deleteForm" action="/notice/deleteNotice.do" method="POST">
        <input type="hidden" id="deleteNotice" name="noticeUuid" value="">
        <input type="hidden" id="deleteNoticeFile" name="fileId" value="">
    </form>
    
    <form id="updateForm" method="post" action="/notice/noticeModify.do">
    	<input type="hidden" id="uuid" name="noticeUuid" value="" />
	</form>
	<form name="readForm" method="post">
		<input type="hidden" id="FILE_ID" name="FILE_ID" value="">
	</form>
</main>
</body>
<script>
	$(document).ready(function() {
		$("#notice-link").on("click", function() {
   			var uuid = $(this).data("uuid");
   			$("#uuid").val(uuid);
    		$("#updateForm").submit();
		});
		
		$("#notice-delete").on("click", function() {
			var uuid = $(this).data("uuid");
			$("#deleteNotice").val(uuid);
			$("#deleteForm").submit();
		});
	});
	
	function fn_fileDown(fileId){
		var formObj = $("form[name='readForm']");
		$("#FILE_ID").attr("value", fileId);
		formObj.attr("action", "/notice/fileDown.do");
		formObj.submit();
	}
</script>
</html>