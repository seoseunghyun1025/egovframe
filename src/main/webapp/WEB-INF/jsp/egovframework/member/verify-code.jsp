<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 인증</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; margin: 0; padding: 0; }
    .container { max-width: 450px; margin: 60px auto; background: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }
    h3 { text-align: center; color: #333; margin-bottom: 20px; font-size: 24px; }
    p { text-align: center; color: #666; font-size: 14px; margin-bottom: 30px; line-height: 1.4; }
    .form-group { margin-bottom: 20px; }
    .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: #495057; font-size: 14px; }
    .form-group input { width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #ced4da; border-radius: 4px; font-size: 14px; }
    .form-group input[readonly] { background-color: #e9ecef; color: #495057; cursor: not-allowed; }
    .btn-submit { width: 100%; padding: 12px; background-color: #28a745; border: none; color: white; font-size: 16px; font-weight: bold; border-radius: 4px; cursor: pointer; transition: background-color 0.2s; margin-top: 10px; }
    .btn-submit:hover { background-color: #218838; }
</style>
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