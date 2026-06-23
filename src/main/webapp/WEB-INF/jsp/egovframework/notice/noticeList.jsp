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
</head>
<body>
	<h2>공지사항 목록</h2>
	<button type="button" id="logout" class="btn-logout" >
       	로그아웃
   	</button>
    
    <p>총 게시글 수: ${totalRow} / 현재 페이지: ${pageNum}</p>
    
    <table border="1">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성일</th>
                <th>작성자</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="notice" items="${noticeList}" varStatus="status">
                <tr>
                    <td>${status.count}</td>
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
    <div>
        <a href="/notice/noticeList.do?page=${pageNum - 1}">이전</a>
        <a href="/notice/noticeList.do?page=${pageNum + 1}">다음</a>
    </div>

    <br>
    <c:if test="${loginMember.role.name() eq 'ADMIN'}">
       <a href="/notice/insertNoticeForm.do">글쓰기</a>
    </c:if>
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
</body>
</html>