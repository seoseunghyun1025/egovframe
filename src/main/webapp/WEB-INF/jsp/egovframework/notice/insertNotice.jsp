<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지사항 작성</title>
</head>
<body>
	<h2>공지사항 작성</h2>
    
    <form action="${pageContext.request.contextPath}/notice/insertNotice.do" method="POST">
        <table border="1">
            <tr>
                <th>작성자 ID</th>
                <td><input type="text" name="writeId" required></td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="noticeTitle" required></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="noticeContent" rows="10" cols="50" required></textarea></td>
            </tr>
        </table>
        <br>
        <button type="submit">등록</button>
        <a href="${pageContext.request.contextPath}/notice/noticeList.do">취소</a>
    </form>
</body>
</html>