<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>나의 투자 기록</title>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/investment/investment.css'/>">
    <style>
        /* 로그아웃 헤더 스타일 추가 */
        .user-header {
            max-width: 1200px;
            margin: 20px auto 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 15px;
        }
        .user-info {
            font-size: 14px;
            color: #4a5568;
            font-weight: 500;
        }
        .user-info strong {
            color: #2d3748;
        }
        .btn-logout {
            background-color: #fff;
            color: #e53e3e;
            border: 1px solid #e2e8f0;
            padding: 6px 12px;
            font-size: 13px;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-logout:hover {
            background-color: #fff5f5;
            border-color: #feb2b2;
        }
    </style>
</head>
<body>

<div class="user-header">
    <div class="user-info">
        👤 <strong>${loginMember.email}</strong>님 로그인 중
    </div>
   	<button type="button" class="btn-logout" onclick="if(confirm('로그아웃 하시겠습니까?')) location.href='<c:url value="/member/logout.do"/>';">
       	로그아웃
   	</button>
</div>
<div class="container">
    <section id="listSection">
        <h3>📜 전체 투자 내역</h3>
        <a onclick="location.href='<c:url value="/investment/regist.do"></c:url>';"style="cursor: pointer;">투자 작성</a>
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
                            <tr onclick="location.href='<c:url value="/investment/regist.do"><c:param name="id" value="${item.id}"/></c:url>';" 
    style="cursor: pointer;">
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
</body>
<script>
console.log('${loginMember.memberId}');
</script>
</html>