<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
        }
        .login-container {
            max-width: 450px;
            width: 100%;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
        }
        .btn-primary {
            background-color: #4e73df;
            border: none;
            padding: 10px;
            font-weight: 600;
            border-radius: 8px;
        }
        .btn-primary:hover {
            background-color: #2e59d9;
        }
        .form-control {
            padding: 12px;
            border-radius: 8px;
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.25);
            border-color: #4e73df;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center">

<div class="login-container p-3">
    <div class="card p-4">
        <div class="card-body">
            <h3 class="text-center fw-bold mb-4 text-dark">로그인</h3>
            
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger text-center small p-2 mb-3" role="alert">
                    <c:out value="${errorMsg}" />
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/member/loginForm.do" method="POST">
                
                <div class="mb-3">
                    <label for="email" class="form-label small fw-semibold text-secondary">이메일 주소</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="example@email.com" required autofocus>
                </div>

                <div class="mb-4">
                    <label for="password" class="form-label small fw-semibold text-secondary">비밀번호</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
                </div>

                <div class="d-grid mb-3">
                    <button type="submit" class="btn btn-primary">로그인</button>
                </div>
                
                <div class="text-center mt-3">
    				<a href="${pageContext.request.contextPath}/member/reset-passwordForm.do" class="small text-decoration-none fw-semibold" style="color: #4e73df;">비밀번호 찾기</a>
    				<span class="text-muted small mx-2">|</span>
    				<span class="small text-muted">아직 계정이 없으신가요?</span>
    				<a href="${pageContext.request.contextPath}/member/registForm.do" class="small text-decoration-none fw-semibold ms-1" style="color: #4e73df;">회원가입</a>
				</div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>