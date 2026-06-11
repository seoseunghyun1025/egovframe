<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 인증</title>
<link rel="stylesheet" href="<c:url value='/css/egovframework/account/verify-code.css'/>">
</head>
<body>

<div class="container">
    <h3>📧 이메일 인증</h3>
    <p>회원가입이 접수되었습니다.<br>입력하신 이메일로 발송된 인증번호를 입력해 주세요.</p>
    
    <form action="<c:url value='/member/verify-code.do'/>" method="POST">
        
        <div class="form-group">
            <label for="email">인증 대상 이메일</label>
            <input type="email" id="email" name="email" value="${email}" readonly required>
        </div>

        <div class="form-group">
            <label for="code">인증번호 입력</label>
            <input type="text" id="code" name="code" placeholder="숫자 6자리 입력" pattern="[0-9]*" inputmode="numeric" required>
        </div>

        <button type="submit" class="btn-submit">인증 완료</button>
    </form>
</div>

</body>
</html>