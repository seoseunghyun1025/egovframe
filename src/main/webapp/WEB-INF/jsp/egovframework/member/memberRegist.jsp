<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f8f9fa; margin: 0; padding: 0; }
    .container { max-width: 450px; margin: 60px auto; background: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }
    h3 { text-align: center; color: #333; margin-bottom: 30px; font-size: 24px; }
    .form-group { margin-bottom: 20px; }
    .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: #495057; font-size: 14px; }
    .form-group input { width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #ced4da; border-radius: 4px; font-size: 14px; transition: border-color 0.15s ease-in-out; }
    .form-group input:focus { border-color: #007bff; outline: none; }
    .btn-submit { width: 100%; padding: 12px; background-color: #007bff; border: none; color: white; font-size: 16px; font-weight: bold; border-radius: 4px; cursor: pointer; transition: background-color 0.2s; margin-top: 10px; }
    .btn-submit:hover { background-color: #0056b3; }
</style>
<script>
    function validateForm() {
        var password = document.getElementById("password").value;
        var passwordConfirm = document.getElementById("confirmPassword").value;
        var name = document.getElementById("name").value;
        var email = document.getElementById("email").value;

        if (!name.trim()) { alert("이름을 입력해주세요."); return false; }
        if (!email.trim()) { alert("이메일을 입력해주세요."); return false; }
        if (!password.trim()) { alert("비밀번호를 입력해주세요."); return false; }
        if (password !== passwordConfirm) { alert("비밀번호가 일치하지 않습니다."); return false; }
        
        // 💡 주석: 조건이 맞으면 true를 리턴하여 <form action="..."> 흐름대로 서버에 전송(MVC)
        return true;
    }
</script>
</head>
<body>

<div class="container">
    <h3>📝 회원가입</h3>
    
    <form action="<c:url value='/member/regist.do'/>" method="POST" onsubmit="return validateForm();">
    	<input type="hidden" id="role" name="role" value="ROLE_USER">
        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" placeholder="example@email.com" required>
        </div>
        <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword">비밀번호 확인</label>
            <input type="password" id="confirmPassword" placeholder="비밀번호를 한 번 더 입력하세요" required>
        </div>
        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" placeholder="이름을 입력하세요" required>
        </div>
        <button type="submit" class="btn-submit">가입하기</button>
    </form>
</div>

</body>
</html>