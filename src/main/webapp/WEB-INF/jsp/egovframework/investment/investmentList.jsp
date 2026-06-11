<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>나의 투자 기록</title>
    <!--favicon 404 방지-->
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
    <link rel="stylesheet" href="<c:url value='/css/egovframework/investment/investment.css'/>">
    <script src="/js/jquery.min.js"></script>
</head>
<body>

<div class="user-header">
    <div class="user-info">
        👤 <strong>${loginMember.email}</strong>님 로그인 중
    </div>
   	<button type="button" id="logout" class="btn-logout" >
       	로그아웃
   	</button>
</div>
<div class="container">
    <section id="listSection">
        <h3>📜 전체 투자 내역</h3>
        <button type="button" id="newRegistInvestment" class="btn-link" >투자 작성</button> 
        <button type="button" id="notice" class="btn-link" >공지 사항</button> <br> <br>
        <table>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>종목명</th>
                    <th>구분</th>
                    <th>단가</th>
                    <th>수량</th>
                    <th>날짜</th>
                    <th>메모</th>
                </tr>
            </thead>
            <tbody id="investmentTableBody">
                <c:choose>
                    <c:when test="${not empty list}">
                        <c:forEach var="item" items="${list}">
                            <tr id="registInvestment" name="id" value="${item.id}" class="btn-link">
                                <td>${item.id}</td>
                                <td><strong>${item.assetName}</strong></td>
                                <td>
                                    <span class="${item.txType == 'BUY' ? 'type-buy' : 'type-sell'}">
                                        ${item.txType}
                                    </span>	
                                </td>
                                <td><fmt:formatNumber value="${item.buyPrice}" pattern="#,###"/></td>
                                <td>${item.quantity}</td>
                                <td>${item.buyDate}</td>
                                <td><c:out value="${item.memo}" default="-"/></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="7" style="text-align:center;">투자 내역이 없습니다.</td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </section>
</div>
<script>
    $(document).ready(function(){
    	// 로그아웃
        $("#logout").click(function() {
    		window.location = "/member/loginForm.do";
        })
         
        // 투자 작성
        $("#newRegistInvestment").click(function() {
    		window.location = "/investment/registForm.do";
        })
        
        //공지사항
        $("#notice").click(function() {
    		window.location = "/notice/noticeList.do";
        })
        
        $("registInvestment").click(function() {
			$.ajax({
				url : "/investment/registFrom.do",
				type: "GET",
				data: ("#registInvestment").serialize(),
				dataType: 'JSON'
			});
    	})
    });
</script>
</body>
</html>