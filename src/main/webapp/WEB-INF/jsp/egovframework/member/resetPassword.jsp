<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 재발급</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card p-4 shadow-sm" style="width: 400px;">
            <h3 class="text-center mb-4">비밀번호 찾기</h3>
            <p class="text-muted text-center small">가입하신 이메일 주소를 입력하시면<br>임시 비밀번호를 발송해 드립니다.</p>
            
            <form action="${pageContext.request.contextPath}/member/reset-password.do" method="POST">
                <div class="mb-3">
                    <label for="email" class="form-label">이메일 주소</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="example@gmail.com" required>
                </div>
                
                <c:if test="${param.error == 'notfound'}">
                    <div class="alert alert-danger small p-2 text-center" role="alert">
                        존재하지 않는 이메일 계정입니다.
                    </div>
                </c:if>
                
                <button type="submit" class="btn btn-primary w-100">임시 비밀번호 발송</button>
            </form>
        </div>
    </div>
</body>
</html>