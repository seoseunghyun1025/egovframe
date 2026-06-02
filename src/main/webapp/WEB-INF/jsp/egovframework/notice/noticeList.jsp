<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
</head>
<body>
	<h2>공지사항 목록</h2>
    
    <p>총 게시글 수: ${totalRow} / 현재 페이지: ${pageNum}</p>
    
    <table border="1">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="notice" items="${noticeList}" varStatus="status">
                <tr>
                    <td>${status.count}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/notice/noticeInfo.do?uuid=${notice.noticeUuid}">
                            ${notice.noticeTitle}
                        </a>
                    </td>
                    <td>${notice.registryDate}</td>
                </tr>
            </c:forEach>
            <c:if var="isEmpty" test="${empty noticeList}">
                <tr>
                    <td colspan="3">등록된 공지사항이 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <br>
    <div>
        <a href="${pageContext.request.contextPath}/notice/noticeList.do?page=${pageNum - 1}">이전</a>
        <a href="${pageContext.request.contextPath}/notice/noticeList.do?page=${pageNum + 1}">다음</a>
    </div>

    <br>
    <a href="${pageContext.request.contextPath}/notice/insertNotice.do">글쓰기</a>
</body>
<script> 
	console.log("${notice.noticeTitle}")
	console.log("${notice.registryDate}")
</script>
</html>