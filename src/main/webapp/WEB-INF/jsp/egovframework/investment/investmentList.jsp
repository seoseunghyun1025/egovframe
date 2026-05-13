<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>나의 투자 기록</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/investment/investment.css'/>">
</head>
<body>

<div class="container">
    <h2>📈 투자 내역 목록</h2>
    
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
        <tbody>
            <c:forEach var="result" items="${resultList}" varStatus="status">
                <tr>
                    <td>${result.id}</td>
                    <td><strong>${result.assetName}</strong></td>
                    <td>
                        <span class="${result.txType == 'BUY' ? 'type-buy' : 'type-sell'}">
                            ${result.txType}
                        </span>
                    </td>
                    <td><fmt:formatNumber value="${result.buyPrice}" pattern="#,###.##"/></td>
                    <td>${result.quantity}</td>
                    <td>${result.buyDate}</td>
                    <td>${result.memo}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty resultList}">
                <tr>
                    <td colspan="7">데이터가 없습니다. 첫 투자를 등록해보세요!</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

</body>
</html>