<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>새 비밀번호 설정</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script>
        // 프론트 단에서도 비밀번호 일치 여부를 가볍게 더블 체크하는 자바스크립트
        function checkPassword() {
            var pw = document.getElementById("newPassword").value;
            var confirmPw = document.getElementById("confirmPassword").value;
            if (pw !== confirmPw) {
                alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body class="bg-light">
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card p-4 shadow-sm" style="width: 400px;">
            <h3 class="text-center mb-4">비밀번호 재설정</h3>
            
            <form action="${pageContext.request.contextPath}/member/change-password.do" method="POST" onsubmit="return checkPassword()">
                <input type="hidden" name="email" value="${email}">
                
                <div class="mb-3">
                    <label for="newPassword" class="form-label">새 비밀번호</label>
                    <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="새 비밀번호 입력" required>
                </div>
                
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="새 비밀번호 다시 입력" required>
                </div>
                
                <c:if test="${param.error == 'fail'}">
                    <div class="alert alert-danger small p-2 text-center" role="alert">
                        비밀번호 변경 중 오류가 발생했습니다. 다시 시도해 주세요.
                    </div>
                </c:if>
                
                <button type="submit" class="btn btn-success w-100">비밀번호 변경 완료</button>
            </form>
        </div>
    </div>
    <script>console.log('${email}');</script>
</body>
</html>