<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="<c:url value='/css/egovframework/account/regist.css'/>">
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