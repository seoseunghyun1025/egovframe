<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>나의 투자 기록</title>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/investment/investment.css'/>">
</head>
<body>

<div class="container">
    <section id="portfolioSection">
        <h3>📊 종목별 보유 현황</h3>
        <div id="portfolioList" style="display: flex; gap: 15px; flex-wrap: wrap;">
            <c:choose>
                <c:when test="${not empty summaryList}">
                    <c:forEach var="summary" items="${summaryList}">
                        <div class="summary-card" 
     onclick="location.href='<c:url value='/investments/regist.do?id=${summary.id}'/>';" 
     style="cursor: pointer;">
                            <div style="font-weight: bold;">${summary.assetName}</div>
                            <div>수량: ${summary.totalQuantity}주</div>
                            <div style="color: #007bff;">
                                평단: <fmt:formatNumber value="${summary.avgPrice}" pattern="#,###"/>원
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>보유 내역이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</div>

<div class="container">
    <section id="listSection">
        <h3>📜 전체 투자 내역</h3>
        
        <button type="button" onclick="location.href = '<c:url value='/investments/regist.do'/>';" class="btn-regist">
                ➕ 새로운 투자 등록
        </button>
        
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
                            <tr onclick="location.href='<c:url value="/investments/regist.do"><c:param name="id" value="${item.id}"/></c:url>';" 
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
</html>