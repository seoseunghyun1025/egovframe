<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>나의 투자 기록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/egovframework/investment/investment.css">
    <style>
        .container + .container { margin-top: 30px; }
        .type-buy { color: #d9534f; font-weight: bold; }
        .type-sell { color: #0275d8; font-weight: bold; }
    </style>
</head>
<body>

<div class="container">
    <section id="portfolioSection">
        <h3>📊 종목별 보유 현황</h3>
        <div id="portfolioList" style="display: flex; gap: 15px; flex-wrap: wrap;">
            <p>데이터 로딩 중...</p>
        </div>
    </section>
</div>

<div class="container">
    <section id="listSection">
        <h3>📜 전체 투자 내역</h3>
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
                <tr><td colspan="7">데이터 로딩 중...</td></tr>
            </tbody>
        </table>
    </section>
</div>

<script>
    // JSP 변수는 여기서 딱 한 번만 사용!
    var ctx = '<%= request.getContextPath() %>';

    document.addEventListener('DOMContentLoaded', function() {
        loadInvestmentList();
        loadPortfolioSummary();
    });

    async function loadInvestmentList() {
        try {
            var response = await fetch(ctx + '/investments/selectInvestmentList.do');
            if (response.ok) {
                var data = await response.json();
                renderTable(data);
            }
        } catch (e) { console.error(e); }
    }

    async function loadPortfolioSummary() {
        try {
            var response = await fetch(ctx + '/investments/selectInvestmentSummary.do');
            if (response.ok) {
                var data = await response.json();
                renderPortfolio(data);
            }
        } catch (e) { console.error(e); }
    }

    function renderTable(list) {
        var tbody = document.getElementById('investmentTableBody');
        if (!list || list.length === 0) {
            tbody.innerHTML = '<tr><td colspan="7">데이터가 없습니다.</td></tr>';
            return;
        }

        var html = '';
        for (var i = 0; i < list.length; i++) {
            var item = list[i];
            var typeClass = (item.txType === 'BUY') ? 'type-buy' : 'type-sell';
            
            html += '<tr>';
            html += '<td>' + item.id + '</td>';
            html += '<td><strong>' + item.assetName + '</strong></td>';
            html += '<td><span class="' + typeClass + '">' + item.txType + '</span></td>';
            html += '<td>' + item.buyPrice.toLocaleString() + '</td>';
            html += '<td>' + item.quantity + '</td>';
            html += '<td>' + item.buyDate + '</td>';
            html += '<td>' + (item.memo || '-') + '</td>';
            html += '</tr>';
        }
        tbody.innerHTML = html;
    }

    function renderPortfolio(summaryList) {
        var container = document.getElementById('portfolioList');
        if (!summaryList || summaryList.length === 0) {
            container.innerHTML = '<p>보유 내역이 없습니다.</p>';
            return;
        }

        var html = '';
        for (var i = 0; i < summaryList.length; i++) {
            var item = summaryList[i];
            html += '<div style="border: 1px solid #ddd; padding: 15px; border-radius: 8px; background: #fdfdfd; min-width: 180px;">';
            html += '<div style="font-weight: bold;">' + item.assetName + '</div>';
            html += '<div>수량: ' + item.totalQuantity + '주</div>';
            html += '<div style="color: #007bff;">평단: ' + Math.round(item.avgPrice).toLocaleString() + '원</div>';
            html += '</div>';
        }
        container.innerHTML = html;
    }
</script>

</body>
</html>