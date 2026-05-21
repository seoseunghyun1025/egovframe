<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>임시 비밀번호 인증</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card p-4 shadow-sm" style="width: 400px;">
            <h3 class="text-center mb-4">이메일 인증</h3>
            <p class="text-success text-center small">입력하신 이메일로 임시 비밀번호가 발송되었습니다.<br>메일함을 확인해 주세요.</p>
            
            <form action="${pageContext.request.contextPath}/member/verify.do" method="POST">
                <input type="hidden" name="email" value="${email}">
                
                <div class="mb-3">
                    <label class="form-label">대상 계정</label>
                    <input type="text" class="form-control bg-body-secondary" value="${email}" readonly>
                </div>
                
                <div class="mb-3">
                    <label for="tempPassword" class="form-label">임시 비밀번호 입력</label>
                    <input type="password" id="tempPassword" name="tempPassword" class="form-control" placeholder="메일로 받은 16자리 번호 입력" required>
                </div>
                
                <c:if test="${param.error == 'invalid'}">
                    <div class="alert alert-danger small p-2 text-center" role="alert">
                        임시 비밀번호가 일치하지 않습니다.
                    </div>
                </c:if>
                
                <button type="submit" class="btn btn-primary w-100">인증 및 비밀번호 변경</button>
            </form>
        </div>
    </div>
    
</body>
</html>