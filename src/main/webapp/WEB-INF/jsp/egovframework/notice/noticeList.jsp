<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
<script src="/js/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/css/egovframework/notice/notice.css" rel="stylesheet">
</head>
<body class="bg-light">
<main class="container mx-auto my-5">

<div class="my-3 p-2 bg-body rounded shadow-sm d-flex gap-2">
	<a class="btn btn-primary" href="/investment/list.do">투자 내역</a>
	<button type="button" id="logout" class="btn btn-light ms-auto" >
       	로그아웃
   	</button >
</div>
	<h2 class="d-flex align-items-center p-3 my-3 text-white bg-purple rounded shadow-sm" id="situation">
		공지사항 목록
		<c:if test="${loginMember.role.name() eq 'ADMIN'}">
       		<a class="btn btn-outline-light ms-auto" href="/notice/insertNoticeForm.do">글쓰기</a>
    	</c:if>
	</h2>
	<div class="my-3 p-2 bg-body rounded shadow-sm">
		<form action="/notice/noticeList.do" method="get" id="searchForm" name="search-form">
	        <select name="type" class="type-box">
				<option value="TITLE">제목</option>
				<option value="WRITER">작성자</option>
			</select>
	          <input class="inputId" type="text" name="keyword" placeholder="검색어 입력">
	          <input class="submitBtn" type="submit" value="검색하기">
		</form>
	</div>
	
<div class="my-3 p-3 bg-body rounded shadow-sm">    
    <table border="1" class="table">
        <thead class="table-light">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성일</th>
                <th>작성자</th>
            </tr>
        </thead>
        <tbody class="table-group-divider">
            <c:forEach var="notice" items="${noticeList}" varStatus="status">
                <tr>
                    <td>${(start + status.count) - 1}</td>
                    <td class="notice-link" data-uuid="${notice.noticeUuid}">
    					${notice.noticeTitle}
					</td>
                    <td>
                    	<fmt:parseDate value="${notice.registryDate}" pattern="yyyy-MM-dd" var="parsedDateTime" type="both"/>
        				<fmt:formatDate pattern="yyyy-MM-dd" value="${parsedDateTime}" />
                    </td>
                    <td>${notice.writeId}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty noticeList}">
                <tr>
                    <td colspan="4">등록된 공지사항이 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <br>
    <div class="paging">
	<c:forEach var="page" begin="1" end="${repeat}">
		<a href="/notice/noticeList.do?page=${page}&type=${type}&keyword=${keyword}">${page}</a>
	</c:forEach>
	</div>

    <br>
    <form id="uuidForm" method="post" action="/notice/noticeInfo.do">
    	<input type="hidden" id="uuid" name="noticeUuid" value="" />
	</form>
	<script>
		$(document).ready(function() {
	    	$(".notice-link").on("click", function() {
	       		var uuid = $(this).data("uuid");
	       		$("#uuid").val(uuid);
	        	$("#uuidForm").submit();
	    	});
	    	
	    	$("#logout").click(function() {
	    		window.location = "/member/logout.do";
	        })
		});
	</script>
</div>
</main>
</body>
</html>