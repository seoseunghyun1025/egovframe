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
</head>
<body>
	<h2>공지사항 상세 보기</h2>
    
    <table border="1">
        <tr>
            <th>작성자 ID</th>
            <td>${writeId}</td>
        </tr>
        <tr>
            <th>제목</th>
            <td>${postTitle}</td>
        </tr>
        <tr>
            <th>내용/등록일</th>
            <td>${postContent}</td>
        </tr>
    </table>

    <br>
    <a href="${pageContext.request.contextPath}/notice/noticeList.do">목록으로</a>
    <a href="${pageContext.request.contextPath}/notice/noticeModify.do?uuid=${param.uuid}">수정하기</a>
    
    <form name="deleteForm" action="${pageContext.request.contextPath}/notice/deleteNotice.do" method="POST" style="display:inline;">
        <input type="hidden" name="uuid" value="${param.uuid}">
        <button type="button" onclick="deletePost()">삭제하기</button>
    </form>
</body>
</html>