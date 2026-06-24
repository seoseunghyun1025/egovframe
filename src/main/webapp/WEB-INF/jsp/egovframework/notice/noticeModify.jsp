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
    <form class="needs-validation" action="/notice/noticeUpdate.do" method="POST" novalidate>
        <input type="hidden" name="noticeUuid" value="${noticeUuid}">
        <div class="row g-3">
        <div class="col-12"></div>
	        <label for="title" class="form-label">제목</label>
	        <div class="input-group has-validation">
        		<input class="form-control" type="text" id="title" name="noticeTitle"  value="${noticeTitle}"required>
        		<div class="invalid-feedback">
					제목을 입력하세요
				</div>
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
    </main>
</body>
</html>