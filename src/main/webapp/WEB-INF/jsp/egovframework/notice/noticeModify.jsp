<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 수정</title>
</head>
<body>
    <h2>공지사항 수정</h2>
    
    <form action="/notice/noticeUpdate.do" method="POST">
        <input type="hidden" name="noticeUuid" value="${noticeUuid}">
        
        <table border="1">
            <tr>
                <th>작성자 ID</th>
                <td><input type="text" name="writeId" value="${writeId}"></td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="noticeTitle" value="${noticeTitle}"></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="noticeContent" rows="10" cols="50">${noticeContent}</textarea></td>
            </tr>
            <tr>
                <th>최초 등록일</th>
                <td>${registryDate}</td>
            </tr>
        </table>
        <br>
        <button type="submit">수정 완료</button>
        <a href="/notice/noticeList.do">취소</a>
    </form>
</body>
</html>