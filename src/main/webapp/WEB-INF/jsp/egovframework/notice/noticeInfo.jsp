<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>공지사항 상세 보기</title>
    <script type="text/javascript">
        function deletePost() {
            if(confirm("정말 삭제하시겠습니까?")) {
                document.deleteForm.submit();
            }
        }
    </script>
    <script src="/js/jquery.min.js"></script>
</head>
<body>
	<h2>공지사항 상세 보기</h2>
    
    <table border="1">
        <tr>
            <th>작성자 ID</th>
            <td>${notice.writeId}</td>
        </tr>
        <tr>
            <th>제목</th>
            <td>${notice.noticeTitle}</td>
        </tr>
        <tr>
            <th>내용</th>
            <td>${notice.noticeContent}</td>
        </tr>
        <tr>
        	<th>등록일</th>
        	<td>${notice.registryDate}</td>
        </tr>
    </table>

    <br>
    <a href="/notice/noticeList.do">목록으로</a>
   	<c:if test="${loginMember.role.name() eq 'ADMIN'}">   	
	    <button type="button" class="notice-link" data-uuid="${notice.noticeUuid}">
	    	수정하기
		</button>
		
		<button type="button" class="notice-delete" data-uuid="${notice.noticeUuid}">
	        삭제하기
	    </button>
   	</c:if> 
            
    <form id="deleteForm" action="/notice/deleteNotice.do" method="POST">
        <input type="hidden" id="deleteNotice" name="noticeUuid" value="">
    </form>
    
    <form id="updateForm" method="post" action="/notice/noticeModify.do">
    	<input type="hidden" id="uuid" name="noticeUuid" value="" />
	</form>
	
</body>
<script>
	$(document).ready(function() {
		$(".notice-link").on("click", function() {
   			var uuid = $(this).data("uuid");
   			$("#uuid").val(uuid);
    		$("#updateForm").submit();
		});
		
		$(".notice-delete").on("click", function() {
			var uuid = $(this).data("uuid");
			$("#deleteNotice").val(uuid);
			$("#deleteForm").submit();
		});
	});
</script>
</html>