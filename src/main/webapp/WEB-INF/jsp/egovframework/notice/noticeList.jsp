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
		<form class="d-flex" action="/notice/noticeListAjax.do" method="post" id="searchForm" name="search-form">
			<input type="hidden" id="page" name="page" value="1" />
	        <select name="type" class="type-box">
				<option value="TITLE" ${type eq 'TITLE' ? 'selected' : ''}>제목</option>
				<option value="WRITER" ${type eq 'WRITER' ? 'selected' : ''}>작성자</option>
			</select>
	          <input class="form-control me-2" id="keyword" aria-label="Search" type="text" name="keyword" placeholder="Search">
	          <input class="btn btn-outline-success" id="btnSearch" type="button" value="검색하기">
		</form>
	</div>
	
	<div id="listContainer" class="my-3 p-3 bg-body rounded shadow-sm">    
	</div>

    <form id="uuidForm" method="post" action="/notice/noticeInfo.do">
    	<input type="hidden" id="uuid" name="noticeUuid" value="" />
	</form>
	<script>
		function fn_go_page(pageNo) {
			$("#page").val(pageNo); 
			var formData = $("#searchForm").serialize();
						
			$.ajax({
				url: "/notice/noticeListAjax.do",
			 	type: "POST",
				data: formData,
				dataType: "html",
				success: function(response) {
					$("#listContainer").html(response);
				},
				error: function() {
					alert("목록을 불러오는 중 오류가 발생했습니다.");
				}
			});		
		}
		$(document).ready(function() {
			fn_go_page(1);
	    	$(document).on("click", ".notice-link",function() {
	       		var uuid = $(this).data("uuid");
	       		$("#uuid").val(uuid);
	        	$("#uuidForm").submit();
	    	});
	    	
	    	$("#logout").click(function() {
	    		window.location = "/member/logout.do";
	        })
	        
	        $("#btnSearch").on("click", function(){
				fn_go_page(1);
	        })
	        
	        $("#keyword").on("keypress", function(e){
				if(e.which == 13){
					e.preventDefault();
					fn_go_page(1);
				}
	        })
		});
		
		
	</script>
</main>
</body>
</html>