<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지사항 작성</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="/js/jquery.min.js"></script>
	<link href="/css/egovframework/notice/notice.css" rel="stylesheet">
</head>
<body class="bg-light">
<main class="container mx-auto my-5">
	<div id="situation" class="d-flex align-items-center p-3 my-3 text-white rounded shadow-sm">
		<h2>공지사항 작성</h2>
	</div>    
	<div class="my-3 p-3 bg-body rounded shadow-sm">
	    <form class="needs-validation" action="/notice/insertNotice.do" method="POST" enctype="multipart/form-data" novalidate>
	    	<div class="row g-3">
	    		<div class="col-12">
	    			<label for="title" class="form-label">제목</label>
	    			<div class="input-group has-validation">
	        			<input class="form-control" type="text" id="title" name="noticeTitle" required>
	        			<div class="invalid-feedback">
							제목을 입력하세요
						</div>
					</div>
				</div>
				<div class="col-12">
					<label for="content" class="form-label">내용</label>
					<textarea class="form-control" name="noticeContent" id="content" rows="10" cols="50" required></textarea>
					<div class="invalid-feedback">
						내용을 입력하세요
					</div>
				</div>
				<div class="btn-box">
					<label for="file" class="form-label">파일을 선택하세요</label>
					<input class="form-control" type="file" id="file" name="files" multiple="multiple">	
				</div>
				<div class="btn-box">
	        		<button type="submit" class="w-20 btn btn-primary">등록</button>
	        		<a class="btn btn-outline-dark" href="/notice/noticeList.do">취소</a>
	        	</div>
	        	<input type="hidden" name="writeId" value="${loginMember.name}"required>
	    	</div>
	    </form>
    </div>
    
   	<script type="text/javascript">
        $(document).ready(function() {        
          	//유효성 검사
            $(".needs-validation").submit(function(){
				if($("#title").val() == ""){
					alert("제목을 입력하세요.");
					$("#title").focus();
					return false;
				}
				
				if($("#content").val() == ""){
					alert("내용을 입력하세요.");
					$("#content").focus();
					return false;
				}
        	})
        });
    </script>
	<script src="/js/Bootstrap/form-validation.js"></script>
</main>
</body>
</html>